---
title: OneDrive for Business installation fails
description: Describes how to create and use an internal OneDrive for Business installation package for a silent installation for users who are confined to an internal network.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: fselkirk
appliesto: 
  - OneDrive for Business
  - SharePoint Online
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# A OneDrive for Business installation fails for users confined to an internal network

_Original KB number:_ &nbsp; 2976863

## Symptoms

This article contains information that applies when you use the OneDrive for Business sync client (groove.exe).

> [!NOTE]
> To determine which OneDrive sync client you're using, see [Which OneDrive app?](https://support.microsoft.com/office/which-onedrive-app-19246eae-8a51-490a-8d97-a645c151f2ba).

Assume that you download a setup file for a stand-alone installation of Microsoft Office OneDrive for Business from [Install the previous OneDrive sync client with Office and SharePoint](https://support.microsoft.com/office/install-the-previous-onedrive-sync-client-with-office-and-sharepoint-37b3dddd-30af-4294-aba8-c290cea01b5d). When you provide the file to users who don't have Internet access, the installation fails.

## Cause

The stand-alone version of OneDrive for Business is available only as a Click-to-Run installation. The Click-to-Run process streams data from Microsoft servers for product installation and updates.

## Resolution

To provide OneDrive for Business to users who do not have Internet access, or to perform a silent installation of OneDrive, use either of the following methods:

- License an Office 2013 product that includes OneDrive for Business in an MSI (conventional) installation.
- Create an installation package by using the Office Deployment Tool for Click-to-Run.

This article discusses how to use the Office Deployment Tool (ODT) for Click-to-Run to provide OneDrive for Business to restricted users or perform a silent installation.

### Create an installation package

1. Download the ODT for Click-to-Run from the following Microsoft Download Center website, and then click **Run**:

    [Office 2013 Deployment Tool for Click-to-Run](https://www.microsoft.com/download/details.aspx?id=36778)

2. Save the files (Setup.exe and Configuration.xml) to a local folder. You will access this location from a command line. Therefore, you might want to create a short path. This example uses *C:\swsetup\c2r*.
3. Open Configuration.xml file in Notepad.
4. Replace the contents of the file by using the following:

    ```xml
    <Configuration>

    <Add SourcePath="C:\swsetup\c2r" OfficeClientEdition="32" >
     <Product ID="GrooveRetail">
     <Language ID="en-us" />
     </Product>
     </Add>

    <Display Level="None" AcceptEULA="TRUE" />
    <Logging Path="%temp%" />

    </Configuration>
    ```

5. Customize the values of the `SourcePath`, `OfficeClientEdition`, and Language ID parameters for your environment. SourcePath must be set to the location of the Setup.exe and Configuration.xml files.
6. Open a Command Prompt window as an administrator.
7. At the command prompt, move to the local storage folder. For example, run the following command:

    ```console
    cd \swsetup\c2r
    ```  

8. Run the following command:

    ```console
    setup /download configuration.xml
    ```  

The Setup program uses the information in the Configuration.xml file to locate the OneDrive for Business ("Groove") files. Then, it creates an Office\Data subdirectory that contains the cab files for the installation. This process takes about 20 minutes to complete over a fast network connection. However, if you share out the folder, you should have to create the installation package only one time.

### Test the installation

After you have obtained the cab files, perform a silent installation as a test by running the following command:

```console
setup /configure configuration.xml
```  

> [!NOTE]
> The installation can last from 10 minutes to an hour.

### Distribute the installation

To distribute the installation, follow these steps:

1. Copy the folder that you selected in step 2 of the [Create an installation package](#create-an-installation-package) procedure to a location that your users can access.
2. In the new location, open the Configuration.xml file in Notepad.
3. Edit the value of the SourcePath parameter to match the new folder location.
4. Have the users run the `setup /configure configuration.xml` command by making whatever changes are appropriate for the location. For example, have users run the following command:

    ```console
    \\server\share\Setup.exe /configure \\server\share\CustomConfiguration.xml
    ```  

To use System Center Configuration Manager to deploy the installation, run the wizard to create a package. When you are prompted, provide the command from step 4.

## More information

For more information about the Office Deployment Tool for Click-to-Run, see [Overview of the Office Deployment Tool](/deployoffice/overview-office-deployment-tool).
