---
title: Desktop app option is missing when trying to edit files in Teams
description: Fixes an issue in which you can't find the default desktop app option to edit an Office file in Teams.
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

# Desktop app option is missing when trying to edit Office files in Teams

## Symptoms

When you try to edit a Microsoft Office file directly in Microsoft Teams, the file's desktop app option is missing.

The following screenshot is an example of opening a word document without the **Word desktop app** option:

:::image type="content" source="media/desktop-app-option-missing/no-desktop-app-option.png" alt-text="Screenshot of opening a word document without the Word desktop app option.":::

The following screenshot is an example of opening a word document with the **Word desktop app** option:

:::image type="content" source="media/desktop-app-option-missing/open-in-desktop-app.png" alt-text="Screenshot of the Word desktop app option.":::

The **Desktop app** option is also missing from the **File open preference** setting in Teams.

## Cause

To edit an Office file in its desktop app, you must meet the following prerequisites:

- Be using the Teams desktop app for Windows or Mac.

- Download the desktop apps for PowerPoint, Word, and Excel (Microsoft Office 2016 or a later version).

- Have an [Office 365 E3 or E5 license](https://www.microsoft.com/microsoft-365/enterprise/compare-office-365-plans).

If any of these prerequisites isn't meet, the file's desktop app option is missing.

## Resolution

To fix this issue, try the following resolutions:

- Make sure Teams desktop app is installed. You can download and install [Teams](https://www.microsoft.com/microsoft-teams/group-chat-software) for Windows or Mac.

- Make sure the Office desktop apps are installed. You can download and install the apps from the [Microsoft 365 portal](https://portal.office.com/account#installs).

- Make sure you have an Office 365 E3 or E5 license assigned from the [Microsoft 365 admin center](https://portal.office.com/adminportal/home?#/users).

    An administrator can verify if a user has an Office 365 E3 or E5 license assigned. To get a list of the product IDs of the assigned license, run the following PowerShell cmdlet:

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
