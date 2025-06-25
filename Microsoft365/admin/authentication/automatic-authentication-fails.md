---
title: Authentication automatically fails in Microsoft 365 services
description: Learn how to reinstall packages for ADAL and Live ID to troubleshoot authentication issues and Outlook issues that may go into the Need Password state.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 109229
  - CSSTroubleshoot
ms.reviewer: dthayer
appliesto: 
  - Microsoft 365
  - Outlook for Microsoft 365
  - Word for Microsoft 365
  - Excel for Microsoft 365
  - PowerPoint for Microsoft 365
  - OneNote for Microsoft 365
search.appverid: MET150
ms.date: 02/25/2025
---

# Fix authentication issues in Microsoft 365 apps when you try to connect to a Microsoft 365 service

## Symptoms

Authentication automatically fails in some Microsoft 365 applications and Outlook may go into the "Need Password" state without any interaction. Additionally, when you make a Web Account Manager API call to [FindAllAccountsAsync](/uwp/api/windows.security.authentication.web.core.webauthenticationcoremanager.findallaccountsasync), you may see error code "-2147024809" in the Microsoft Entra logs or Microsoft 365 Client logs.

> [!IMPORTANT]
> This issue occurs only on computers that are running Windows 10, version 1703 or later, and Microsoft 365 version 1807 or later.

## Cause

The authentication issue occurs because of missing package information about either the Active Directory Authentication Library (ADAL) or Live ID.

## Resolution

> [!TIP]
> To diagnose and automatically fix several common Microsoft 365 sign-in issues, run the [Microsoft 365 Sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome).

To fix this issue, use PowerShell to reinstall the packages for Microsoft Entra WAM plugin (for organizational or work accounts) and Live ID (for personal accounts such as @outlook.com, @hotmail.com, and so on). To do this, follow these steps:

1. Right-click the Windows icon in your task bar, and then select **Windows PowerShell (Admin)**.
2. If you're prompted by a User Account Control ([UAC](/windows/security/identity-protection/user-account-control/user-account-control-overview)) window, select **Yes** to start PowerShell.
3. If your issue is about a work account, you have to fix the Microsoft Entra WAM plugin package. Run the following command in the command console:

   ```powershell
   if (-not (Get-AppxPackage Microsoft.AAD.BrokerPlugin)) { Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown } Get-AppxPackage Microsoft.AAD.BrokerPlugin
   ```

4. If your issue is about a personal account, you have to fix the Live ID package. Run the following command in the command console:

   ```powershell
   if (-not (Get-AppxPackage Microsoft.Windows.CloudExperienceHost)) { Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown } Get-AppxPackage Microsoft.Windows.CloudExperienceHost
   ```

After you run the commands, and if they completed without errors, you may see a quick progress indicator or a status result that contains information about the package installation.
