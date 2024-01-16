---
title: Create all-inclusive deployment package for Internet Explorer 11
description: Describes how to create a one-restart installation package for Internet Explorer 11.
ms.date: 04/26/2020
---
# How to create an all-inclusive deployment package for Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes how to create an installation package for Internet Explorer 11. The installation package can apply all the prerequisite updates, language packs, and spelling dictionaries and also the latest cumulative security updates in a single restart.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3061428

## Summary

The following custom solution is provided as-is. It may provide a functional workaround for customers who require this functionality. Given the uniqueness of each customer environment, Microsoft provides no assurances that these procedures will satisfy the customer's objective. Those who implement these procedures are highly encouraged to thoroughly test the procedures before they deploy them to a production environment.

The procedures in this article require the customer to be familiar with creating batch (.bat) files, the command-line interface, and working with 32-bit and 64-bit Windows operating systems.

> [!TIP]
> All required resource packages can be obtained from the [Microsoft Update Catalog website](https://catalog.update.microsoft.com).

Complete each section fully before you continue.

## Internet Explorer 11 prerequisite packages

1. Create a temporary folder that is named _Temp_ at the root of drive C, and make sure that at least 500 megabytes (MB) of disk space are available.

2. By using [KB 2847882](https://support.microsoft.com/help/2847882) as a reference, download the individual packages for the appropriate Windows CPU platform (x64 or x86) on which Internet Explorer 11 will be deployed. Save these packages to the temporary directory that you created in step 1.

3. In the _Temp_ folder, create a new folder that is named `Cabfiles`.
4. At an administrative command prompt, change to the _C:Temp_ folder.
5. Extract the contents of each prerequisite .msu package to the `Cabfiles` folder by using the following syntax:

    ```cmd
    C:\temp>expand "Windows6.1-KB2731771-x64.msu" -f:* c:\temp\cabfiles
    ```

> [!NOTE]
> The following command-line example would be used to extract the x64 version of the Internet Explorer 11 prerequisite updates. (To process the x86 version of the component, replace the x64 (.msu) package name with the x86 (.msu) package name.)

:::image type="content" source="media/create-all-inclusive-deploy-package/extract-prerequisites.png" alt-text="Screenshot shows the command output of extracting Internet Explorer 11 prerequisites updates.":::

Repeat these steps to extract all the prerequisites for Internet Explorer 11, and save the _.cab_ files in the `C:\Temp\Cabfiles` folder.

## Internet Explorer 11 core installation package

1. Download the core Internet Explorer 11 installation packages that are needed for the target Windows platform, and save the packages to the _C:\Temp_ folder.

2. At an administrative command prompt, change to the _C:\Temp_ folder.
3. Extract the contents of the core Internet Explorer 11 packages to the `Cabfiles` folder by using the following syntax:

    ```cmd
    C:\temp>IE 11-windows6.1-x64-en-us.exe /x:c:\temp\cabfiles
    ```

> [!NOTE]
> The following command-line example would be used to extract an x64 version of the Internet Explorer 11 core installation package. (To process the x86 version of the component, replace the x64 package name with the x86 package name.)
>
> :::image type="content" source="media/create-all-inclusive-deploy-package/extract-core-installation-package.png" alt-text="Screenshot shows the command to extract Internet Explorer 11 core installation package.":::
>
> _IE-Win7.cab_ is the name of the .cab file that is extracted from the Internet Explorer 11 setup file (IE11-Windows6.1-x64-en-us.exe). It is saved in the `C:\Temp\Cabfiles` folder.

## Internet Explorer 11 language packs

> [!NOTE]
> Before you install the Internet Explorer 11 language packs, you must install the operating system language pack for the corresponding Internet Explorer 11 language. You can download and install this through Windows Updates or manually.

For Example, to install French Language pack for Internet Explorer 11, we must have French OS language pack already installed on the computer. For more information, see [Language packs for Windows](https://support.microsoft.com/help/14236).

1. Download the Internet Explorer 11 language pack packages, and save them to the _C:\temp_ folder.
2. At an administrative command prompt, change to the _C:\Temp_ folder.
3. Extract the contents of the Internet Explorer 11 language pack packages to the `Cabfiles` folder by using the following syntax:

    ```cmd
    C:\temp>Expand "IE11-windows6.1-LanguagePack-x64.af-za.msu" -f:* c:\temp\cabfiles
    ```

> [!NOTE]
> The name of the downloaded language pack for Internet Explorer 11 is IE11-Windows6.1-LanguagePack-x64-af-za.msu.  
> Output .cab file: 'Windows6.1-KB2841134-X64.cab.'
>
> All the extracted language pack files will be have the same name (for example, Windows6.1-KB2841134-X64.cab). Therefore, you must make sure that you rename the .cab files so that they are not overwritten if you are extracting more than one language pack to the same location.
>
> For example, rename the extracted .cab files as follows:
>
> |Language pack|Old name|New name|
> |---|---|---|
> |Language pack 1|Windows6.1-KB2841134-X64.cab|Windows6.1-KB2841134-X64-Af-za.cab|
> |Language pack 2|Windows6.1-KB2841134-X64.cab|Windows6.1-KB2841134-X64-fr-fr.cab|
>
> : From 'Windows6.1-KB2841134-X64.cab' to 'Windows6.1-KB2841134-X64-Af-za.cab'  
> : From 'Windows6.1-KB2841134-X64.cab' to 'Windows6.1-KB2841134-X64-fr-fr.cab'
>
> The following command-line example would be used for extracting an x64 version of the Afrikaans language pack. (To process the x86 version of the component, replace the x64 package name with the x86 package name.)
>
> :::image type="content" source="media/create-all-inclusive-deploy-package/extract-language-pack.png" alt-text="Screenshot shows the command output of extracting Internet Explorer 11 language pack.":::

## Internet Explorer 11 spelling dictionaries

1. Download the Internet Explorer 11 Spelling Dictionary packages, and save them to the _C:\Temp_ folder.
2. At an administrative command prompt, change to the _C:\Temp_ folder.
3. Extract the contents of the Spelling Dictionary packages to the `Cabfiles` folder by using the following syntax:

    ```cmd
    C:\temp>Expand "IE-Spelling-fr.msu" -f:* c:\temp\cabfiles
    ```

> [!NOTE]
> The following command-line example would be used to extract the x64 or x86 version of the Spelling Dictionaries package.
>
> :::image type="content" source="media/create-all-inclusive-deploy-package/extract-spelling-dictionary.png" alt-text="Screenshot shows the command output of extracting Internet Explorer 11 Spelling Dictionary package.":::

## Internet Explorer 11 cumulative security update

1. Download the latest Internet Explorer 11 Cumulative Security Update (CSU) packages, and save them to the _C:\Temp_ folder.
2. At an administrative command prompt, change to the _C:\Temp_ folder.
3. Extract the contents of the Internet Explorer 11 Cumulative Security Update packages to the `Cabfiles` folder by using the following syntax:

    ```cmd
    C:\temp>Expand "IE11-Windows6.1-KB3049563-x64.msu" -f:* c:\temp\cabfiles
    ```

> [!NOTE]
> The following command-line example would be used to extract the x64 version of Internet Explorer 11 Cumulative Security Updates. (To process the x86 version of the component, replace the x64 package name with the x86 package name.)
>
> :::image type="content" source="media/create-all-inclusive-deploy-package/extract-ie-csu.png" alt-text="Screenshot shows the command output of extracting Internet Explorer 11 CSU.":::

## Complete the package

After you follow all the previous steps, you can use the `C:\Temp\Cabfiles` folder as the source for the installation of the Internet Explorer 11 prerequisites, the Internet Explorer 11 core installation files, the language packs, the spelling dictionaries, and the latest cumulative security update. You can then use a batch file to start the installation of each component in sequence.

Copy the following sample script to Notepad, and customize it based on the package requirements. Package requirements include the following:

- Internet Explorer (x86 or x64) core installation package
- Language package
- Spelling Dictionary package
- Cumulative security updates

Then, save the script file as _SampleScript.bat_ in the `C:\Temp\Cabfiles` folder so that it has access to all the files in that folder.

For Example: `C:\Temp\Cabfiles\SampleScript.bat`

As soon as you customize and save the script file, you should double-click _Samplescript.bat_ to execute it. A command prompt window displays the commands that are being executed by the script. The output resembles the following:

:::image type="content" source="media/create-all-inclusive-deploy-package/script-output.png" alt-text="Screenshot shows the Samplescript.bat script output.":::

This script will install all the extracted .cab files without a prompt to restart. These files include prerequisites for Internet Explorer 11, the Internet Explorer 11 setup file, the Internet Explorer 11 language pack, the Internet Explorer 11 spelling package, and the Internet Explorer 11 cumulative security update.

As soon as the _Samplescript.bat_ file installs all the cab files, restart the computer manually.

### Sample script to install the x64 version of the .cab files

> [!NOTE]
> The syntax in the following script remains basically the same for installing x86 (32-bit) Internet Explorer 11. The only change that is required is to replace all x64bit cab file names with x86 cab file names.

```console
ECHO OFF
ECHO Installing IE 11 prerequisite: KB2834140
dism /online /add-package /packagepath:Windows6.1-KB2834140-v2-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2670838
dism /online /add-package /packagepath:Windows6.1-KB2670838-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2639308
dism /online /add-package /packagepath:Windows6.1-KB2639308-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2533623
dism /online /add-package /packagepath:Windows6.1-KB2533623-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2731771
dism /online /add-package /packagepath:Windows6.1-KB2731771-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2729094
dism /online /add-package /packagepath:Windows6.1-KB2729094-v2-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2786081
dism /online /add-package /packagepath:Windows6.1-KB2786081-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2888049
dism /online /add-package /packagepath:Windows6.1-KB2888049-x64.cab /quiet /norestart
ECHO Installing IE 11 prerequisite: KB2882822
dism /online /add-package /packagepath:Windows6.1-KB2882822-x64.cab /quiet /norestart
ECHO Installing IE 11 Main Application
dism /online /add-package /packagepath:IE-Win7.cab /quiet /norestart
ECHO Installing IE 11 Spanish language Pack
dism /online /add-package /packagepath:Windows6.1-KB2841134-x64-es.cab /quiet /norestart
ECHO Installing IE 11 language French pack
dism /online /add-package /packagepath:Windows6.1-KB2841134-x64-fr-fr.cab /quiet /norestart
ECHO Installing IE 11 French Spelling Dictionaries Pack
dism /online /add-package /packagepath:Windows6.3-KB2849696-x86.cab /quiet /norestart
ECHO Installing IE cumulative security update
dism /online /add-package /package path: IE11-Windows6.1-KB3049563-x64.cab /quiet /norestart
```

> [!IMPORTANT]
> This is a sample script file that is provided as a demonstration to achieve the scenario that was discussed earlier. We provide no warranties or support for this script file. You should thoroughly test the script file before you try it in production environments.

## More information

These procedures can be applied only to the following operating systems:

- Windows 7 (32-bit and 64-bit versions) Service Pack 1
- Windows Server 2008 R2 (64-bit version) Service Pack 1

For more information about the minimum operating system requirements for Internet Explorer 11, see [System requirements and language support for Internet Explorer 11 (IE11)](/internet-explorer/ie11-deploy-guide/system-requirements-and-language-support-for-ie11).
