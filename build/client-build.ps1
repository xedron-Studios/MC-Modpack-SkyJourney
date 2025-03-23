<# 
.NAME
    client-build
.SYNOPSIS
    Build script for generating the client pack of the modpack
#>

# Add parameter for Modrinth API Key
param(
    [Parameter(Mandatory=$true)]
    [string]$ModrinthApiKey
)

if(-not $ModrinthApiKey) {
    Write-Error "Modrinth API Key is required"
    exit 1
}

# Load build config
$build_config = Get-Content -Path "build/client-build.json" -Encoding utf8 | ConvertFrom-Json -Depth 100

# Custom Hash function for getting mod hashes, because Get-FileHash does not support weird file names, e. g. "[" or "]"
# Thank you to https://stackoverflow.com/a/44539638
function Get-ModHash {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [ValidateSet("SHA1", "SHA512")]
        [string]$Algorithm
    )
    $Stream = New-Object System.IO.FileStream($Path, "Open", "Read", "ReadWrite")
    if($Stream){
        switch ($Algorithm) {
            "SHA1" {
                $SHA = New-Object -TypeName System.Security.Cryptography.SHA1Managed
            }
            "SHA512" {
                $SHA = New-Object -TypeName System.Security.Cryptography.SHA512Managed
            }
        }
        $Bytes = $SHA.ComputeHash($Stream)
        $Stream.Dispose()
        $Stream.Close()
        $SHA.Dispose()
        $Checksum = [System.BitConverter]::ToString($Bytes).Replace("-", [String]::Empty).ToLower()
    }
    return $Checksum
}

# Try to create directory or delete and recreate it if it already exists
if(Test-Path -Path "build/client") {
    Remove-Item -Path "build/client" -Recurse -Force | Out-Null
    Write-Host "Deleted existing build directory"
}
New-Item -ItemType Directory -Path "build/client" | Out-Null
Write-Host "Created build directory"

# Delete existing build/temp_client_pack.zip if it exists
if(Test-Path -Path "build/temp_client_pack.zip") {
    Remove-Item -Path "build/temp_client_pack.zip" -Force | Out-Null
    Write-Host "Deleted existing temp_client_pack.zip"
}

# Generate modrinth.index.json
Write-Host "Generating modrinth.index.json..."

$mp_files = New-Object -TypeName System.Collections.ArrayList

$mp_mods = Get-ChildItem -Path "mods" -Recurse -Include "*.jar"
$mp_mods | ForEach-Object {
    Write-Host -NoNewLine "Processing mod "
    try {
        $mp_mod_sha1 = Get-ModHash -Path $_.FullName -Algorithm "SHA1"
    } catch {
        Write-Host "Error while hashing mod, full error:"
        Write-Host $_.Exception.Message
        exit 1
    }
    try {
        $mp_mod_sha512 = Get-ModHash -Path $_.FullName -Algorithm "SHA512"
    } catch {
        Write-Host "Error while hashing mod, full error:"
        Write-Host $_.Exception.Message
        exit 1
    }
    $mp_mod = [PSCustomObject]@{
        path = ("mods/"+$_.Name)
        hashes = [PSCustomObject]@{
            sha1 = $mp_mod_sha1
            sha512 = $mp_mod_sha512
        }
        env = [PSCustomObject]@{
            client = "required"
            server = "required"
        }
        downloads = New-Object -TypeName System.Collections.ArrayList
        fileSize = $_.Length
    }
    try {
        $mp_mod_index = $mp_files.Add($mp_mod)
    } catch {
        Write-Host "Error while processing mod, full error:"
        Write-Host ($mp_mod | ConvertTo-Json -Depth 100)
        exit 1
    }
    Write-Host ([string]('{0:d3}' -f ([int]$mp_mod_index+1))+"/"+$mp_mods.Count+": "+$_.BaseName)
}

try {
    Write-Host "Getting version files from Modrinth API..."
    $mr_files = Invoke-WebRequest -Uri "https://api.modrinth.com/v2/version_files" -Headers @{
        "Authorization" = $ModrinthApiKey
        "Content-Type" = "application/json"
    } -Method Post -Body (@{
        hashes = $mp_files | ForEach-Object { $_.hashes.sha1 }
        algorithm = "sha1"
    } | ConvertTo-Json -Depth 100) | ConvertFrom-Json -Depth 100
    Write-Host "Got version files from Modrinth API"
} catch {
    Write-Error "Failed to get version files from Modrinth API"
    exit 1
}

Write-Host "Mapping mod files to Modrinth files..."
Write-Host "--------------------------------------------------|"

for($i=0; $i -lt $mp_files.Count; $i++) {
    Write-Host (
        ('{0:d3}' -f ($i+1))+"/"+$mp_files.Count+": "+$mp_files[$i].hashes.sha1+" | "+$mr_files.($mp_files[$i].hashes.sha1).files[0].url
    )
    $mp_files[$i].downloads.Add($mr_files.($mp_files[$i].hashes.sha1).files[0].url) | Out-Null
}

$mp_dependencies = [PSCustomObject]::new()
$mp_dependencies | Add-Member -MemberType NoteProperty -Name "fabric-loader" -Value $build_config.fabric_loader_version
$mp_dependencies | Add-Member -MemberType NoteProperty -Name "minecraft" -Value $build_config.minecraft_version

$mr_index_json = [PSCustomObject]::new()
$mr_index_json | Add-Member -MemberType NoteProperty -Name "game" -Value "minecraft"
$mr_index_json | Add-Member -MemberType NoteProperty -Name "formatVersion" -Value "1"
$mr_index_json | Add-Member -MemberType NoteProperty -Name "versionId" -Value $build_config.versionId
$mr_index_json | Add-Member -MemberType NoteProperty -Name "name" -Value $build_config.name
$mr_index_json | Add-Member -MemberType NoteProperty -Name "summary" -Value $build_config.summary
$mr_index_json | Add-Member -MemberType NoteProperty -Name "dependencies" -Value $mp_dependencies
$mr_index_json | Add-Member -MemberType NoteProperty -Name "files" -Value $mp_files

$mr_index_json | ConvertTo-Json -Depth 100 | Set-Content -Path "build/client/modrinth.index.json"

Write-Host "--------------------------------------------------|"
Write-Host "Generated modrinth.index.json"

Write-Host "Creating overrides directory..."
try {
    New-Item -ItemType Directory -Path "build/client/overrides" | Out-Null
} catch {
    Write-Error "Failed to create overrides directory"
    exit 1
}

Write-Host "Copying overrides dynamically..."
foreach($override in $build_config.overrides) {
    Write-Host ("Copying override "+$override)
    Copy-Item -Path $override -Destination "build/client/overrides" -Recurse -Force
}
Write-Host "Copied overrides"

Write-Host "Creating modpack.zip..."
try {
    Compress-Archive -Path "build/client/*" -DestinationPath "build/temp_client_pack.zip" -Force -CompressionLevel Optimal
} catch {
    Write-Error "Failed to create modpack.zip"
    exit 1
}
Write-Host "Created temp_client_pack.zip"