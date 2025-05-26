---
title: Known issues for Windows 365 Business Cloud PC
description: Learn about known issues for Windows 365 Business.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: ivivano, erikje
ms.custom:
- pcy:Onboarding issues
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---
# Known issues: Windows 365 Business

The following items are known issues for Windows 365 Business.

## Microsoft 365 Business Standard not activating on Cloud PCs

If a user tries to use a Microsoft 365 Business Standard license on their Cloud PC, they might see the following error:

> Account Issue: The products we found in your account cannot be used to activate Office in shared computer scenarios.

### Solution

The user should uninstall the version of Office installed on their Cloud PC and install a new copy from Office.com.

## Some websites might display the wrong language

Some websites that are accessed from a Cloud PC use its IP address to determine how content is displayed. Therefore, users might see content based on where the Cloud PC was created, instead of content based on where the user is located.  

### Workaround

There are two workarounds for this issue:

#### Workaround 1: Change the language/locale in URLs

Users can manually change their language/locale in the URL for most websites.

For example, in the following URL, change the language/locale from `en-us` to `fr-fr` to get the French version:

Before: `https://learn.microsoft.com/en-us/microsoft-365/admin/setup/get-started-windows-365-business`

After: `https://learn.microsoft.com/fr-fr/microsoft-365/admin/setup/get-started-windows-365-business`

#### Workaround 2: Set the search engine location

Users can manually set their internet search engine's location. For example, on Bing.com users can visit the **Settings** menu (in the top-right corner of the site) to manually set the language, country/region, and location.

## Microsoft Narrator screen reader not turned on

When users sign in to their Cloud PCs from [Windows 365](https://windows365.microsoft.com/), the Microsoft Narrator screen reader isn't turned on.

### Solution

To turn on Narrator when accessing your Cloud PC from the web interface:

1. Go to [Windows 365](https://windows365.microsoft.com/).
2. Sign in to your Cloud PC.
3. On your keyboard, press <kbd>Alt</kbd>+<kbd>F3</kbd>+<kbd>Ctrl</kbd>, and then press <kbd>Enter</kbd>.

## Sending outbound email messages using port 25 isn't supported

Sending outbound email messages directly on port 25 from a Windows 365 Business Cloud PC isn't supported. Communication over port TCP/25 is blocked at the Windows 365 Business network layer for security reasons.

### Solution

If your email service uses Simple Mail Transfer Protocol (SMTP) for your email client application, you can use its web interface, if available.

Or you can ask your email service provider to help configure their email client app to use secure SMTP over Transport Layer Security (TLS), which uses a different port.

## Virtual Private Network support<!--38270291-->

Because there are many Virtual Private Network (VPN) solutions available, Microsoft can't confirm which services work with Windows 365 Business. If you need more information, consult your VPN provider. For organizations that have advanced networking needs, Windows 365 Enterprise is recommended. For more information, see [Network requirements](/windows-365/business/../enterprise/requirements-network).

[!INCLUDE [Missing Start menu and taskbar when using iPad and the Remote Desktop app to access a Cloud PC](includes/known-issues.md)]

## Next steps

[Troubleshoot Windows 365 Business Cloud PC setup issues](/windows-365/business/troubleshoot-windows-365-business)
