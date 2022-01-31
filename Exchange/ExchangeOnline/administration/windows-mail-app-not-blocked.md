---
title: Windows Mail app not blocked despite ActiveSync organization settings
description: The Exchange ActiveSync settings for your organization are set to block access to all devices, but you're still able to access mailboxes by using the Windows Mail app. 
author: kellybos
ms.author: v-matthamer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 160116
ms.reviewer: aruiz
appliesto:
- Exchange Online
search.appverid: MET150
---

# Windows Mail app not blocked despite ActiveSync organization settings

## Symptoms

The Exchange ActiveSync settings for your organization are set to block access to all devices, but you're still able to access mailboxes by using the Windows Mail app. This happens despite the mobile device details indicating that mailbox connections made using the Windows Mail app will be blocked.

To check your organization’s Exchange ActiveSync settings:

`Get-ActiveSyncOrganizationSettings | ft DefaultAccessLevel`

If ActiveSync is set to block devices, this command will return:

`DefaultAccessLevel : Block`

To check the details of the devices that are configured to sync with a specific mailbox:

`Get-MobileDeviceStatistics -Mailbox <MailboxID> | fl DeviceUserAgent,DeviceType,deviceos,deviceaccessstate`

This command will return:

```powershell
DeviceType        : UniversalOutlook
DeviceOS          : WINDOWS
DeviceAccessState : Unknown
```

To check the devices that are associated with a specific mailbox:

`Get-MobileDevice -Mailbox <MailboxID> | fl DeviceUserAgent,DeviceType,deviceos,deviceaccessstate`

This command will return:

```powershell
DeviceUserAgent   : microsoft.windowscommunicationsapps
DeviceType        : UniversalOutlook
DeviceOS          : WINDOWS
DeviceAccessState : Blocked
```

## Cause
The Windows Mail app uses a native Microsoft sync technology that isn’t blocked by ActiveSync device access rules. Your organization’s ActiveSync settings and device access rules are used to manage Outlook for mobile and ActiveSync connections only.

## Resolution

To block the Windows Mail app from accessing mailboxes, you can use [Client Access Rules](/exchange/clients-and-mobile-in-exchange-online/client-access-rules/client-access-rules) or the UniversalOutlookEnabled parameter of the [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) cmdlet.
