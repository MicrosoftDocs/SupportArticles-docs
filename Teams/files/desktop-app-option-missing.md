---
title: Desktop app option is missing when trying to open files in Teams
description: Fixes an issue in which you can't find the default desktop app option to open an Office file in Teams.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 159208
- CSSTroubleshoot
ms.reviewer: prbalusu; meerak
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Desktop app option is missing when trying to open Office files in Teams

## Symptoms

When you try to open a Microsoft Office file in Microsoft Teams, the desktop app option is missing. The following is an example of opening a Microsoft Word file by using the **Word desktop app** option:

:::image type="content" source="media/desktop-app-option-missing/open-in-word-desktop-app.png" alt-text="Screenshot of the Word desktop app option.":::

Additionally, the **Desktop app** option is also missing on the **Files** tab in Teams **Settings**.

:::image type="content" source="media/desktop-app-option-missing/desktop-app-in-files-setting.png" alt-text="Screenshot of the Desktop app option in Files tab in settings.":::

## Cause

This issue can have any of the following causes.

**Cause 1**: Teams for Windows or Mac isn't installed correctly.

**Cause 2**: Microsoft Office 2016 or a later version isn't installed.

**Cause 3**: You don't have an [Office 365 E3 or E5 license](https://www.microsoft.com/microsoft-365/enterprise/compare-office-365-plans) assigned.

## Resolution

To fix this issue, try the following resolutions.

**Resolution 1**: Download and reinstall [Teams](https://www.microsoft.com/microsoft-teams/group-chat-software) for Windows or Mac.

**Resolution 2**: Download and install Office desktop apps (Office 2016 or a later version) in the [Microsoft 365 portal](https://portal.office.com/account#installs).

**Resolution 3**: Assign an Office 365 E3 or E5 license in the [Microsoft 365 admin center](https://portal.office.com/adminportal/home?#/users) as an administrator.

The administrator can verify if a user has an Office 365 E3 or E5 license assigned. To get a list of the product IDs of the assigned license, run the following PowerShell cmdlet:

```powershell
$officeLicenseRoot = New-Object -TypeName PSObject

$officeLicenseRoot | Add-Member -MemberType NoteProperty -Name License -Value $(Get-ItemPropertyValue -Path 'HKLM:\Software\Microsoft\Office\ClickToRun\Configuration' -Name ProductReleaseIds)

Write-Host $officeLicenseRoot
```

If the user has a license assigned, the cmdlet output displays the **O365ProPlusRetail** product ID.

The cmdlet output is similar to the following:

```output
@{License=OneNoteFreeRetail,ProjectProRetail,VisioProRetail,O365ProPlusRetail}
```
