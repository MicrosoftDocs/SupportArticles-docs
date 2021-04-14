---
title: Hangs with Junk Email Reporting add-in and large archive
description: Describes an issue where Outlook 2016 hangs when the Junk Email Reporting add-in is installed and there's a large Archive mailbox. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: tasitae
appliesto:
- Outlook 2016
search.appverid: MET150
---
# Outlook 2016 hangs with Junk Email Reporting add-in and large archive

_Original KB number:_ &nbsp; 3171036

## Symptoms

Consider the following scenario:

- You run Microsoft Outlook 2016.
- You have a large online archive mailbox open in Outlook.
- You have the Microsoft Junk E-mail Reporting Add-In for Microsoft Office Outlook installed.

In this scenario, Outlook may stop responding.

## Workaround

To work around this issue, uninstall the Microsoft Junk E-mail Reporting Add-In for Microsoft Office Outlook by following these steps.

1. Exit Outlook.
2. Open **Control Panel**.
3. Select **Programs and Features**.
4. Select **Microsoft Junk E-mail Reporting Add-In for Microsoft Office Outlook**.
5. Select **Uninstall**.
6. Start Outlook.

For more information about the Junk Email Reporting Add-in for Microsoft Office Outlook, see [Junk email reporting add-in for Microsoft Outlook](/microsoft-365/security/office-365-security/enable-the-report-message-add-in).

## Resolution

To fix this issue, install the latest version of the [Microsoft Junk E-mail Reporting Add-in for Microsoft Outlook](https://www.microsoft.com/download/details.aspx?id=18275).
