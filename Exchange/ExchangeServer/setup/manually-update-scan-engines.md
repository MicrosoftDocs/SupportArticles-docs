---
title: Manually update scan engines
description: Describes how to manually update the scan engines in Microsoft Exchange Server.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
- Exchange Server 2010
---
# Manually update scan engines in Exchange Server

_Original KB number:_ &nbsp; 2292741

## Summary

Follow the steps given below to manually update the scan engines in Exchange Server. You may need to do this if you experience issues with accessing anti-malware updates online and want to download those definitions to a central location.

The manual update involves running the Update-Engines.ps1 PowerShell script. This script can be changed according to your needs. The update path, list of engines, and list of platforms can be changed in the script, or passed as parameters when the script is executed.

When defining a specific engine(s), you must use the following naming conventions:

- X86: Microsoft, Command, VBuster, Kaspersky, Norman, Wormlist
- AMD64: Microsoft, Command, VBuster, Kaspersky, Norman, Wormlist, Cloudmark

> [!NOTE]
> The script will default the engine update path to `https://forefrontdl.microsoft.com/server/scanengineupdate/`. By default, all engines will be downloaded for 64-bit platforms.

## Steps to update scan engines

1. Create a local directory structure on the computer on which you want to download the scan engine updates.

    1. Create a directory. For example, create a directory named *ScanEngineUpdates*.

        > [!NOTE]
        > This directory must be passed as a parameter to the script.
  
    2. Set the NTFS file system and share permissions on the directory so that the target Exchange servers have access to it.

2. Open Notepad. Paste the following script into the file. Choose **File** and **Save As**. Under **Save as type**, select **All Files** and save it as Update-Engines.ps1.

    ```powershell
    #---------------------------------------------------------------------------------------
    # The UpdateEngines script demonstrates how to download engine packages for use
    # by the Forefront Protection for Exchange and Sharepoint products.
    #
    # What the script does:
    #
    # * Downloads copies of the UniversalManifest, EngineInfo.
    # * Downloads and extracts the full update package for the
    # specified engines for each specified platforms. This script
    # automatically creates directories under this root (metadata, x86, amd64)
    # and a script specific temp directory used during the processing. #---------------------------------------------------------------------------------------
    param(
    [string]$EngineDirPath,
    [string]$UpdatePathUrl = "http://forefrontdl.microsoft.com/server/scanengineupdate/",
    [string[]]$Engines = ("Microsoft", "Norman", "Command", "VBuster", "Kaspersky", "WormList", "Cloudmark"),
    [string[]]$Platforms = ("amd64")
    )

    # Display Help
    if (($Args[0] -eq "-?") -or ($Args[0] -eq "-help")) {
    ""
    "Usage: Update-Engines.ps1 [-EngineDirPath <string>] [[-UpdatePathUrl] <update url>] [[-Engines] <engine names>] [[-Platforms] <platform names> "
    "       [-EngineDirPath <string>]           The directory to serve as the root engines directory"
    "       [-UpdatePathUrl <update url]        The update path used to pull the updates from"
    "       [[-Engines] <engine names>[]]       The list of names of engines to update"
    "       [[-Platforms] <platform names>[]]   The list of names of platforms to update"
    ""
    "Examples: "
    "     Update-Engines.ps1 -EngineDirPath C:\Engines\"
    "     Update-Engines.ps1 -EngineDirPath C:\Engines\ -UpdatePathUrl http://forefrontdl.microsoft.com/server/scanengineupdate/ -Engines Microsoft -Platforms amd64"
    ""
    exit
    }

    if ($EngineDirPath.Length -eq 0)
    {
        $(throw "The EngineDirPath is not set. Please set the EngineDirPath parameter to a valid directory.")
    }

    # The directory to store the engines with needs to contain
    # a trailing slash.
    if (!$EngineDirPath.EndsWith("\"))
    {
        $EngineDirPath += "\"
    }

    # Constants used in the script
    $ShellProgId = "Shell.Application"
    $DoNotDisplayProgress = 4
    $YesAll = 16
    $NoConfirmDirectory = 512
    $NoUI = 1024

    $UmFileName = "UniversalManifest.cab"
    $EliFileName = "EngineInfo.cab"

    # Checks if the specified path exists.
    # If not the directory is created.
    function CreatePath($path)
    {
        if ((Test-Path $path) -ne $true)
        {
            New-Item -type Directory $path
            Write-Host "Created: " $path
        }
    }

    # Use the Shell.Application COM object to extract the
    # contents of the sourceCabPath and put the contents into
    # the destinationDirectory. Support is included for cab
    # files with sub directory hierarchies.
    function ExtractCab($sourceCabPath, $destinationDirectory)
    {
        # Determine if we can call the expand.exe utility
        # if so use it, otherwise, use the Shell.Application
        # COM object to perform the expansion of the CAB
        & "expand.exe"

        if($?)
        {

            & "expand.exe" "-R" $sourceCabPath "-F:*" $destinationDirectory
        }
        else
        {

            $shell = new-object -comobject $ShellProgId

            if(!$?)
            {
                $(throw "unable to create $ShellProgId object")
            }

            $source = $shell.Namespace($sourceCabPath).items()

            $destination = $shell.Namespace($destinationDirectory)

            $flags = $DoNotDisplayProgress + $YesAll + $NoConfirmDirectory + $NoUI
            $itemCount = $source.Count
            $cabNameLength = $sourceCabPath.Length

            $cachedDestDir = ""
            $relativeDest = ""

            # Process each item in the cab. Determine if the destination
            # is a sub directory and create if necessary.
            for($i=0; $i -lt $itemCount; $i++)
            {
                $lastPathIndex = $source.item($i).Path.LastIndexOf("\");

                # If the file inside the zip file should be extracted
                # to a subfolder, then we need to reset the destination
                if ($lastPathIndex -gt $cabNameLength)
                {
                    $relativePath = $source.item($i).Path.SubString(($cabNameLength + 1), ($lastPathIndex - $cabNameLength))
                    $relativeDestDir = $destinationDirectory + $relativePath

                    if ($relativeDestDir -ne $cachedDestDir)
                    {
                        $relativeDest = $shell.Namespace($relativeDestDir)
                        $cachedDestDir = $relativeDestDir
                    }

                    $relativeDest.CopyHere($source.item($i), $flags)
                }
                else
                {
                    $destination.CopyHere($source.item($i), $flags)
                }
            }
        }
    }

    #--------------------------------------------------------------------------------------- 
    # Main Script
    #--------------------------------------------------------------------------------------- 

    Write-Host "Update Path: " $UpdatePathUrl
    Write-Host "Engine Directory: " $EngineDirPath
    Write-Host "Engines: " $Engines
    Write-Host "Platforms: " $Platforms

    if ((Test-Path $EngineDirPath) -ne $true)
    {
    $(throw "The directory specified to store the engines does not exist or the user this script is running as does not have permissions to access it. " + $EngineDirPath)
    }

    $tempFilePath = $EngineDirPath + "temp\"

    $wc = new-object System.Net.WebClient

    # Download the Universal Manifest file
    $url = ($UpdatePathUrl + "metadata/UniversalManifest.cab")
    $umFilePath = $EngineDirPath + "metadata\UniversalManifest.cab"

    $metaDataDir = $EngineDirPath + "metadata\"

    CreatePath $metaDataDir

    $wc.DownloadFile($url, $umFilePath)

    CreatePath $tempFilePath

    # Delete any temporary files left over from
    # any previous runs of the script
    Remove-Item ($tempFilePath + "*.*")

    # Extract the xml file from the cab
    # so we can parse and read the data
    ExtractCab $umFilePath $tempFilePath

    # Read in and process the contents of the 
    # Universal Manifest file. 
    [xml]$umFile = Get-Content($tempFilePath + "UniversalManifest.xml")

    # Check if we need to download a new Engine License Info file
    $engineInfoVersion = $umFile.UniversalManifest.licenseInfoVersion
    Write-Host "The current Engine License Info version: " $engineInfoVersion

    $engineInfoFilePath = $EngineDirPath + "metadata\" + $engineInfoVersion

    CreatePath $engineInfoFilePath

    $engineInfoFilePath += "\" + $EliFileName

    # If the versioned directory does not exists
    # download the new version of the Engine License Info
    if ((Test-Path $engineInfoFilePath) -ne $true)
    {
        Write-Host "The current version of the Engine License Info needs to be downloaded."

        $engineInfoURL = ($UpdatePathUrl + "\metadata\" + $engineInfoVersion + "/" + $EliFileName)
        $wc.DownloadFile($engineInfoURL, $engineInfoFilePath)

        Write-Host "The Engine License Info download is complete."
    }

    Write-Host "Begin Processing Engine Updates"

    # Process each engine in the Universal Manifest
    # and download all applicable engines
    foreach ($p in $Platforms)
    {
        $platform = $umFile.UniversalManifest.EngineVersions.SelectSingleNode(("Platform[@id='" + $p + "']"))

        if ($platform -isnot [System.Xml.XmlElement])
        {
            $(throw "The Platform '" + $p + "' is not valid.") 
        }

        Write-Host "Platform: " $platform.id

    foreach ($e in $Engines)
    {
        $engine = $platform.SelectSingleNode(("Category/Engine[@name='" + $e + "']"))

        if ($engine -isnot [System.Xml.XmlElement])
        {
            $errMsg = "The engine name '" + $e + "' is not valid." 
            Write-Error $errMsg -Category InvalidArgument
        }
        else
        {
            Write-Host "Engine: " $engine.Name "UpdateVersion: " $engine.Package.version   

            $manifestFileNameRoot = "manifest." + $engine.Default
            $manifestFileName = $manifestFileNameRoot + ".cab"
            $engineUrl = $UpdatePathUrl + $platform.id + "/" + $engine.Name + "/" + "Package/"
            $manifestUrl =  ($engineUrl + $manifestFileName)
            $enginePath = $EngineDirPath + $platform.id + "\" + $engine.Name + "\Package\"

            Write-Host "Begin download: " $engine.Name " Url: " $manifestUrl

            CreatePath $enginePath

            $manifestPath = $enginePath + $manifestFileName

            $wc.DownloadFile($manifestUrl, $manifestPath)

            # Delete any temporary files left over from
            # any previous runs of the script
            Remove-Item ($tempFilePath + "*.*")

            ExtractCab $manifestPath $tempFilePath

            [xml]$manifest = Get-Content($tempFilePath + "manifest.xml")

            $fullPkgDir = $enginePath + $manifest.ManifestFile.Package.version + "\"

            CreatePath $fullPkgDir

            $fullPkgUrl = $engineUrl + $manifest.ManifestFile.Package.version + "/" + $manifest.ManifestFile.Package.FullPackage.name
            $fullPkgPath = ($fullPkgDir + $manifest.ManifestFile.Package.FullPackage.name)

            $wc.DownloadFile($fullPkgUrl, $fullPkgPath)

            # Detect if there are any subdirectories
            # needed for this engine
            $subDirCount = $manifest.ManifestFile.Package.Files.Dir.Count

            for($i=0; $i -lt $subDirCount; $i++)
            {
                CreatePath ($fullPkgDir + $manifest.ManifestFile.Package.Files.Dir[$i].name)
            }

            ExtractCab $fullPkgPath $fullPkgDir

            # Copy the downloaded manifest to the package directory
            Copy-Item $manifestPath -Destination $fullPkgDir

            Write-Host "Download Complete: " $engine.Name
        }
      }
    }

    Write-Host "Engine Update processing completed."

    # Clean up the temporary directory
    # that is used during the update
    Remove-Item $tempFilePath -recurse
    ```

3. Execute the Update-Engines.ps1 Powershell script, providing any necessary parameters. The format of the command to use is:

    ```powershell
    Update-Engines.ps1 -EngineDirPath <string> -UpdatePathUrl <update url> -Engines <engine names> -Platforms <platform names>
    ```

   - `EngineDirPath <string>` - The directory to serve as the root engine's directory (created in step 1). This is a required parameter.
   - `UpdatePathUrl <update url>` - The update path used to download the updates.
   - `Engines <engine names>` - The list of engine names to update.

      > [!NOTE]
      > Multiple engine names should be separated by commas, with or without spaces.

   - `Platforms <platform names>` - The list of platform names to update.

    Examples:

    ```powershell
    Update-Engines.ps1 -EngineDirPath C:\ScanEngineUpdates\
    ```

    ```powershell
    Update-Engines.ps1 -EngineDirPath C:\ScanEngineUpdates\ -UpdatePathUrl http://forefrontdl.microsoft.com/server/scanengineupdate/ -Engines Microsoft -Platforms amd64
    ```

4. You can now configure the servers to download updates from the directory created in step 1 by using the UNC path of a share name, such as `\\server_name\share_name`.
