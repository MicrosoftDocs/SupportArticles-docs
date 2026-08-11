---
title: Details of private appointments not shown
description: Fixes an issue in which the full details of private appointments on shared calendars may not appear in Outlook or OWA.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 08/11/2026
---
# Outlook or OWA doesn't display full details of private appointments on shared calendars

_Original KB number:_ &nbsp; 4021947

## Symptom

Microsoft Outlook or the Outlook Web App (OWA) doesn't display full details of private appointments on shared calendars.

This issue occurs if you have the default permissions on a shared mailbox calendar, and it occurs even if you create the private appointment.

> [!NOTE]
> You may experience different symptoms that depend on the version of Outlook and Exchange that you are using. For example, Outlook Web App in Exchange Server 2010 doesn't display the full details, but Outlook Web App in Exchange Server 2013 does.

## Resolution

To fix this issue, use one of the following methods:

- Grant the user full access to the target mailbox.
- Grant the user delegate access to the target mailbox and access to see private items.

## Client and permission model behavior
Private item visibility differs depending on the client access path and permission model:

- In Outlook Classic for Windows when using the legacy MAPI access path (Cached Mode and Online Mode), private items remain hidden unless the delegate is explicitly granted permission to view private items.
- In clients that use the Exchange Online REST access path, such as Outlook on the web (OWA), new Outlook for Windows, Outlook Mobile, and Outlook Classic when operating in the REST-based shared calendar model, access granted through Full Mailbox Access can result in private items being visible.
- Administrators who want to prevent delegates from seeing private items should use the mailbox folder-level sharing permission model. Under this model, private items (for example, IPM.Note and IPM.Appointment items) remain hidden unless the CanViewPrivateItems permission is explicitly granted.

## More information

This issue doesn't occur in Outlook Web App in Exchange Server 2013, Exchange Server 2016, and Exchange Online (Microsoft 365). This issue may occur in some older versions of Outlook.
