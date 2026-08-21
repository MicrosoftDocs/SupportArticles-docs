---
title: Known issues for Windows 365 Business Cloud PC
description: Learn about known issues for Windows 365 Business. This information helps you quickly troubleshoot and resolve Cloud PC issues.
manager: dcscontentpm
ms.date: 08/21/2026
ms.topic: troubleshooting
ms.reviewer: ivivano, erikje
ai-usage: ai-assisted
ms.custom:
- sap:Onboarding issues
- pcy:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---
# Known issues: Windows 365 Business

The following items are known issues for Windows 365 Business. This article describes causes and solutions for these issues, and provides links to resources that provide more information.

## Microsoft 365 Business Standard not activating on Cloud PCs

If a user tries to use a Microsoft 365 Business Standard license on their Cloud PC, they might see the following error:

> Account Issue: The products we found in your account cannot be used to activate Office in shared computer scenarios.

### Solution

The user should uninstall the version of Office installed on their Cloud PC and install a new copy from Office.com.

## Some websites might display the wrong language

Some websites that users access from a Cloud PC use their IP addresses to determine how content is displayed. Therefore, users might see content based on where the Cloud PC was created, instead of content based on where the user is located.  

### Workaround

Try these workarounds for this issue:

#### Workaround 1: Change the language or locale in the URL

For most websites, users can manually change their language or locale in the URL.

For example, in the following URL, the user can change the language or locale from `en-us` to `fr-fr` to get the French version:

Before: `https://learn.microsoft.com/en-us/microsoft-365/admin/setup/get-started-windows-365-business`

After: `https://learn.microsoft.com/fr-fr/microsoft-365/admin/setup/get-started-windows-365-business`

#### Workaround 2: Set the search engine location

Users can manually set their internet search engine's location. For example, on Bing.com users can visit the **Settings** menu (in the top-right corner of the site) to manually set the language, country or region, and location.

## Microsoft Narrator screen reader isn't turned on

When users sign in to their Cloud PCs from [Windows 365](https://windows365.microsoft.com/), the Microsoft Narrator screen reader isn't turned on.

### Solution

To turn on Narrator when accessing your Cloud PC from the web interface:

1. Go to [Windows 365](https://windows365.microsoft.com/).
1. Sign in to your Cloud PC.
1. On your keyboard, press <kbd>Alt</kbd>+<kbd>F3</kbd>+<kbd>Ctrl</kbd>, and then press <kbd>Enter</kbd>.

## Outbound email messages using port 25 aren't supported

Users can't send outbound email messages directly on port 25 from a Windows 365 Business Cloud PC. For security reasons, the Windows 365 Business network layer blocks communication over port TCP/25.

### Solution

If your email service uses Simple Mail Transfer Protocol (SMTP) for your email client application, use its web interface, if available.

Or, ask your email service provider to help you configure their email client app to use secure SMTP over Transport Layer Security (TLS), which uses a different port.

## Virtual private network support<!--38270291-->

Because many virtual private network (VPN) solutions are available, Microsoft can't confirm which services work with Windows 365 Business. For more information, consult your VPN provider. For organizations that have advanced networking needs, use Windows 365 Enterprise. For more information, see [Network requirements](/windows-365/business/../enterprise/requirements-network).

## Administrator protection isn't supported on Cloud PCs

Windows 365 Business Cloud PCs don't support Administrator protection. If you turn it on, users might see an unexpected authentication prompt when they sign in, extra approval prompts for tasks that require elevation, and elevation failures.

The sign-in prompt affects all users. The elevation prompts and failures affect users who have local administrator rights. By default, users aren't administrators of their Cloud PCs.

### Solution

To turn off Administrator protection on a Cloud PC, set **User Account Control: Configure type of Admin Approval Mode** to **Legacy Admin Approval Mode**, then restart the Cloud PC. You need local administrator rights to change this setting.

To control whether users have local administrator rights, change the account type in the Microsoft 365 admin center. For more information, see [Change your organization's default settings](/windows-365/business/change-organization-default-settings).

Windows 365 Business Cloud PCs aren't enrolled in Microsoft Intune by default. If you enrolled yours, use an assignment filter to exclude them from any policy that enables Administrator protection.

For more information, see [Administrator protection](/windows/security/application-security/application-control/administrator-protection/).

[!INCLUDE [Missing Start menu and taskbar when using iPad and the Remote Desktop app to access a Cloud PC](includes/known-issues.md)]

## Next steps

[Troubleshoot Windows 365 Business Cloud PC setup issues](/windows-365/business/troubleshoot-windows-365-business)
