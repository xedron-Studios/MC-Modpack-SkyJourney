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

# Try to create directory or delete and recreate it if it already exists
if(Test-Path -Path "build/client") {
    Remove-Item -Path "build/client" -Recurse -Force
    Write-Host "Deleted existing build directory"
}
New-Item -ItemType Directory -Path "build/client"
Write-Host "Created build directory"

# Generate modrinth.index.json

$mp_files = New-Object -TypeName System.Collections.ArrayList

Get-ChildItem -Path "mods" -Recurse -Include "*.jar" | ForEach-Object {
    Write-Host -NoNewLine "Processing mod "
    $mp_files.Add([PSCustomObject]@{
        path = ("mods/"+$_.Name)
        hashes = [PSCustomObject]@{
            sha1 = (Get-FileHash -Path $_.FullName -Algorithm SHA1 | Select-Object -ExpandProperty Hash).ToLower()
            sha512 = (Get-FileHash -Path $_.FullName -Algorithm SHA512 | Select-Object -ExpandProperty Hash).ToLower()
        }
        env = [PSCustomObject]@{
            client = "required"
            server = "required"
        }
        downloads = New-Object -TypeName System.Collections.ArrayList
        fileSize = $_.Length
    })
    Write-Host ("- "+$_.BaseName)
}



try {
    $mr_files = Invoke-WebRequest -Uri "https://api.modrinth.com/v2/version_files" -Headers @{
        "Authorization" = $ModrinthApiKey
        "Content-Type" = "application/json"
    } -Method Post -Body (@{
        hashes = $mp_files | ForEach-Object { $_.hashes.sha1 }
        algorithm = "sha1"
    } | ConvertTo-Json -Depth 100) | ConvertFrom-Json -Depth 100
} catch {
    Write-Error "Failed to get version files from Modrinth API"
    exit 1
}

$mp_files | ForEach-Object {
    Write-Host ($_.hashes.sha1 + " | " + $mr_files.($_.hashes.sha1).files.url)
    $_.downloads.Add($mr_files.($_.hashes.sha1).files[0].url) | Out-Null
}

$mp_dependencies = [PSCustomObject]::new()
$mp_dependencies | Add-Member -MemberType NoteProperty -Name "fabric-loader" -Value $mp_fabric_loader_version
$mp_dependencies | Add-Member -MemberType NoteProperty -Name "minecraft" -Value $mp_minecraft_version

$mr_index_json = [PSCustomObject]::new()
$mr_index_json | Add-Member -MemberType NoteProperty -Name "game" -Value "minecraft"
$mr_index_json | Add-Member -MemberType NoteProperty -Name "formatVersion" -Value "1"
$mr_index_json | Add-Member -MemberType NoteProperty -Name "versionId" -Value $mp_version
$mr_index_json | Add-Member -MemberType NoteProperty -Name "name" -Value $mp_name
$mr_index_json | Add-Member -MemberType NoteProperty -Name "summary" -Value $mp_summary
$mr_index_json | Add-Member -MemberType NoteProperty -Name "dependencies" -Value $mp_dependencies
$mr_index_json | Add-Member -MemberType NoteProperty -Name "files" -Value $mp_files

$mr_index_json | ConvertTo-Json -Depth 100 | Set-Content -Path "build/client/modrinth.index.json"
