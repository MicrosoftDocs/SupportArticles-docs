---
title: Desktop App Option is Missing When Editing Office Files in Teams
description: When you try to edit an Office file by using its corresponding desktop app in Teams, the desktop app option is unavailable.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Files\
  - CI 159208
  - CI 5835
  - CSSTroubleshoot
ms.reviewer: prbalusu; meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 05/19/2025
---

# The "Desktop app" option is missing when trying to edit an Office file in Teams

A Microsoft Office file can be edited directly in Microsoft Teams or in the file's corresponding desktop app. However, when you try to edit an Office file in its desktop app, the **\<Office application name\> desktop app** option is missing.

For example, when you select a Word document, and then you select **Open in**, the **Word desktop app** option is missing, as shown in the following screenshot.

:::image type="content" source="media/desktop-app-option-missing/no-desktop-app-option.png" alt-text="Screenshot of opening a word document without the Word desktop app option.":::

The **Desktop app** option is also missing from the **File open preference** setting in Teams.

:::image type="content" source="media/desktop-app-option-missing/desktop-app-in-files-setting.png" alt-text="Screenshot of the File open preference setting in which the desktop app option is missing.":::

The most likely reason that these options are missing is because at least one of three prerequisites isn't met.

To fix this issue, make sure that the following prerequisite items are true:

- You're using the [Teams desktop app for Windows or Mac](https://www.microsoft.com/microsoft-teams/download-app).

- You [download and install]((https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658)) the corresponding Office desktop apps (Microsoft Office 2016 or a later version).

- You have an [Office 365 E3 or E5 license](https://www.microsoft.com/microsoft-365/enterprise/compare-office-365-plans) that includes the `O365ProPlusRetail` product ID.

    Administrators can assign the license from the [Microsoft 365 admin center](https://portal.office.com/adminportal/home?#/users).

    To verify that you have the required license (product ID `O365ProPlusRetail`) assigned, run the following PowerShell cmdlets on your device:

    ```powershell
    $officeLicenseRoot = New-Object -TypeName PSObject
    
    $officeLicenseRoot | Add-Member -MemberType NoteProperty -Name License -Value $(Get-ItemPropertyValue -Path 'HKLM:\Software\Microsoft\Office\ClickToRun\Configuration' -Name ProductReleaseIds)
    
    Write-Host $officeLicenseRoot
    ```

    Make sure that the returned output contains `O365ProPlusRetail`, as in the following example:

    ```output
    @{License=OneNoteFreeRetail,ProjectProRetail,VisioProRetail,O365ProPlusRetail}
    ```
