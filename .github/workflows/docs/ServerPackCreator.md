# ServerPackCreator CLI Documentation for Version 7.2.4

```
How to use ServerPackCreator:

 java -jar ServerPackCreator.jar
   Simply running the JAR without extra arguments runs ServerPackCreator in GUI mode unless
   you are running in a headless environment. In the case of a headless environment, the CLI
   mode will automatically be used.

 Extra arguments to use ServerPackCreator with: #
-lang:
    Allows you to use one of the available languages for ServerPackCreator. I can not
    guarantee that each of the following available languages is 100% translated.
    You best choice is en_us, or not specifying any as that is the default, because
    I write ServerPackCreator with english in mind.

-cgen:
    Generates a basic server pack configuration from the specified modpack.
    Examples:
        -cgen "/path/to/modpack"
        -cgen "C:/users/<YOUR_USER>/CurseForge/instances/modpack"

-update:
    Check whether a new version of ServerPackCreator is available for download.
    If an update is available, the version and link to the release of said update are
    written to the console so you can from work with it from there.
    Note: When you installed ServerPackCreator using the official installers, this will try and attempt
    updating your current installation if an update is available.

-cli:
    Run ServerPackCreator in an interactive commandline-mode.

-withallinconfigdir:
    Runs generations for all configurations present in ServerPackCreator's configs-directory.

-config:
    Generate a server pack from a specific server pack configuration from the commandline.
    Examples:
        -config "/path/to/serverpack.conf"
        -config "C:/users/<YOUR_USER>/serverpack.conf"

-feelinglucky:
    Feeling lucky, Punk? This will generate a server pack config from a passed modpack-directory and generate
    a server pack in one go. No warranty. No guarantees.
    Examples:
        -feelinglucky "/path/to/modpack"
        -feelinglucky "C:/users/<YOUR_USER>/CurseForge/instances/modpack"

--destination:
    Only effective in combination with -config or -feelinglucky. Sets the destination in which the server pack
    will be generated in.
    Examples:
        -config "/path/to/serverpack.conf" --destination "/path/to/desired/location"
        -config "C:/users/<YOUR_USER>/serverpack.conf" --destination "C:/users/<YOUR_USER>/serverpack"
        -feelinglucky "/path/to/modpack" --destination "/path/to/desired/location"
        -feelinglucky "C:/users/<YOUR_USER>/CurseForge/instances/modpack" --destination "C:/users/<YOUR_USER>/serverpack"

-web:
    Run ServerPackCreator as a webservice available at http://localhost:8080. The webservice
    provides the same functionality as running ServerPackCreator in GUI mode (so no Commandline
    arguments and a non-headless environment) as well as a REST API which can be used in different ways.
    For more information about the REST API, please see the Java documentation:
        - GitHub Pages: https://griefed.github.io/ServerPackCreator/
        - GitLab Pages: https://griefed.pages.griefed.de/ServerPackCreator/

-gui:
    Run ServerPackCreator using the graphical user interface. If your environment supports
    graphics, i.e. is not headless, then this is the default mode in which ServerPackCreator
    started as when no arguments are used.

--setup:
    Set up and prepare the environment for subsequent runs of ServerPackCreator.
    This will create/copy all files needed for ServerPackCreator to function
    properly from inside its JAR-file and setup everything else, too. You can pass a properties-file, too
    if you so desire.
    Examples:
        --setup "/path/to/custom.properties"
        --setup "C:\path\to\custom.properties"

--home:
    Override the home-directory setting for your user. Can be used in combination with other arguments.
    Examples:
        --home "/path/to/directory"
        --home "C:\users\<YOUR_USER>\SPC"
```
