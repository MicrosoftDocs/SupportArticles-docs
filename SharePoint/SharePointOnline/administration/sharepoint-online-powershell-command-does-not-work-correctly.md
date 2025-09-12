---
title: SharePoint Online PowerShell Command doesn't Work Correctly
description: Resolves an issue in which a SharePoint PowerShell command doesn't run as expected and returns no results or the command isn't recognized.
ms.date: 03/23/2025
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Management Tools\PowerShell
  - CSSTroubleshoot
  - CI 4062
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
ms.reviewer: salarson
appliesto: 
  - SharePoint Online
---

# SharePoint Online PowerShell command doesn't work correctly

## Symptoms

When you run a command in SharePoint Online Management Shell, the command doesn't run as expected and doesn't return any results. Or, you receive the following error message:

> The term '\<command\>' is not recognized as the name of the cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

## Cause

This issue occurs in one of the following situations:

- Multiple older versions of the SharePoint Online PowerShell module are installed on your computer.
- The SharePoint Online PowerShell module isn't installed on your computer.

## Resolution

To resolve this issue, follow these steps:

1. Run the following command to get a list of all the versions of the SharePoint Online PowerShell module that are installed on your computer:

   ```powershell
    Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable
   ```

   If the command doesn't return a result, go to step 4. Otherwise, go to step 2.
1. [Uninstall](https://support.microsoft.com/windows/uninstall-or-remove-apps-and-programs-in-windows-4b55f974-2cc6-2d2b-d092-5905080eaf98) SharePoint Online Management Shell in Settings or Control Panel.
1. Uninstall all previous versions of the SharePoint Online Management Shell module that were installed by using PowerShell:

   1. Open an elevated PowerShell window. To open the window, enter *powershell* in the search box. In the results, right-click **Windows PowerShell**, and then select **Run as administrator**.
   1. Run the following command:

       ```powershell
       Uninstall-Module Microsoft.Online.SharePoint.PowerShell -Force -AllVersions
       ```

1. Install [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

   > [!NOTE]
   > Make sure that you review the system requirements and installation instructions before you install the module.
