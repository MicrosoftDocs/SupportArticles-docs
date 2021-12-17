---
title: Desktop app option is missing when editing Office files in Teams
description: When you try to edit an Office file by using its corresponding desktop app in Teams, the desktop app option is unavailable.
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

# The "Desktop app" option is missing when trying to edit an Office file in Teams

You can edit an Office file directly in Teams, or the file's corresponding desktop app. However, when you try to edit an Office file in its desktop app, the **Desktop app** option is missing.

For example, when you select a Word document, then select **Open in**, the **Word desktop app** option is missing. Below is a screenshot:

:::image type="content" source="media/desktop-app-option-missing/no-desktop-app-option.png" alt-text="Screenshot of opening a word document without the Word desktop app option.":::

The **Desktop app** option is also missing from the **File open preference** setting in Teams.

:::image type="content" source="media/desktop-app-option-missing/desktop-app-in-files-setting.png" alt-text="Screenshot of the File open preference setting where Desktop app option is missing.":::

## Cause

To edit an Office file in its desktop app, you must meet the following prerequisites:

- Use the Teams desktop app for Windows or Mac.

- Download the corresponding Office desktop apps (Microsoft Office 2016 or a later version).

- Have an [Office 365 E3 or E5 license](https://www.microsoft.com/microsoft-365/enterprise/compare-office-365-plans) that includes the `O365ProPlusRetail` product ID.

This issue occurs if any of these prerequisites aren't met.

## Resolution

To fix this issue:

- Make sure that you're using the [Teams desktop app for Windows or Mac](https://www.microsoft.com/microsoft-teams/download-app).

- Make sure that the corresponding Office desktop apps (Microsoft Office 2016 or a later version) are installed. You can download and install the apps from the [Microsoft 365 portal](https://portal.office.com/account#installs).

- Make sure that you have an Office 365 E3 or E5 license that includes the `O365ProPlusRetail` product ID.

    Administrators can assign the license from the [Microsoft 365 admin center](https://portal.office.com/adminportal/home?#/users).

    To verify that you have the required license (product ID `O365ProPlusRetail`) assigned, run the following PowerShell cmdlets on your device:

    ```powershell
    $officeLicenseRoot = New-Object -TypeName PSObject
    
    $officeLicenseRoot | Add-Member -MemberType NoteProperty -Name License -Value $(Get-ItemPropertyValue -Path 'HKLM:\Software\Microsoft\Office\ClickToRun\Configuration' -Name ProductReleaseIds)
    
    Write-Host $officeLicenseRoot
    ```

    Make sure that the returned output contains `O365ProPlusRetail`. Below is an example:

    ```output
    @{License=OneNoteFreeRetail,ProjectProRetail,VisioProRetail,O365ProPlusRetail}
    ```
