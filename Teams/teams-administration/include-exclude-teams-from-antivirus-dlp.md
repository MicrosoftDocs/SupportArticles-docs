---
title: Exclude antivirus and DLP applications from blocking Teams
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
ms.date: 10/30/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid:
  - SPO160
  - MET150
ms.assetid:
appliesto:
  - New Microsoft Teams
  - Classic Microsoft Teams
ms.custom:
  - sap:Teams Clients\Windows Desktop
  - CI 106370
  - CSSTroubleshoot
ms.reviewer: davidsle
description: Provides instructions to add Teams to antivirus and DLP applications so that it can start correctly.
---

# Exclude antivirus and DLP applications from blocking Teams

Third-party antivirus and data loss prevention (DLP) applications can interfere with the Microsoft Teams app and prevent it from starting correctly. When you use non-Microsoft antivirus or DLP applications in PCs, you can include or approve the use of the Teams app on the computers. This action helps to enhance the performance of the PCs and mitigate the effect of the antivirus and DLP applications on security.

## Classic Teams

To prevent issues with starting the classic Teams app, add the following processes to the exclusion list in the antivirus software that you’re using:

- `C:\Users\*\AppData\Local\Microsoft\Teams\current\teams.exe`
- `C:\Users\*\AppData\Local\Microsoft\Teams\update.exe`
- `C:\Users\*\AppData\Local\Microsoft\Teams\current\squirrel.exe`
- `C:\Users\*\AppData\Local\Microsoft\TeamsMeetingAddin`

Alternatively, you can add the processes to the allowlist for programs in your DLP application. The method to accomplish this addition varies. For specific instructions, contact your DLP application’s manufacturer.

## New Teams

The MSIX installer installs the new Teams app in the WindowsApps folder instead of the user profile folder, where the classic Teams app is installed. Because users can’t write to the WindowsApps folder, this location adds better protection against attacks that try to alter the installation of the Teams app.

**Note**: The MSIX installer and all files in the same directory are signed with a Microsoft certificate.

The name of the folder where the new Teams app is installed is dynamic and it changes when the app’s version is updated. The folder name begins with MSTeams_, ends with _8wekyb3d8bbwe, and includes the app’s version number in between.  For example, MSTeams_23247.1112.2396.409_x64_8wekyb3d8bbwe.

To prevent issues with starting or using the new Teams app, add the following processes to the exclusion list in the antivirus software that you’re using:

- `ms-teams.exe`
- `ms-teamsupdate.exe`
- `msedgewebview2.exe`

Alternatively, you can add the processes to the allowlist for programs in your DLP application. The method to accomplish this addition varies. For specific instructions, contact your DLP application’s manufacturer.

### Common external DDL or applications which interfer with new teams Desktop client reliability

- Umppc*.dll: Crowdstrike
- Trellix
- ControlUp
- zscaler
- Aternity
- Beyond Trust, Avecto, PGHook.dll

### Location of the Teams installation folder

To add the Teams processes to either the exclusion list or the Safe list/Allow list, you can find their location by using the following steps:

1. Open Windows PowerShell and type the following cmdlet to determine the location of the installation files:
   `Get-AppPackage -name "msteams"`

   The output includes the value of the **InstallLocation** parameter such as C:\Program Files\WindowsApps\ MSTeams_23247.1112.2396.409_x64_8wekyb3d8bbwe.
1. To view the individual files, open **Task Manager** and select **More details**.
1. On the **Details** tab, locate and right-click **ms-teams.exe** and select **Open file location**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

### Disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Third-party contact disclaimer

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.

Third-party information and solution disclaimer

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These conditions include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, regarding any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
