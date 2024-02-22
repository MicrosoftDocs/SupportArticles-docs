---
title: Windows Mail app not blocked despite ActiveSync organization settings
description: The Exchange ActiveSync settings for your organization are set to block access to all devices, but you can still access mailboxes in Windows Mail.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 160116
  - CI 160572
ms.reviewer: aruiz, kellybos
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Windows Mail app not blocked despite ActiveSync organization settings

## Symptoms

The Exchange ActiveSync settings for your organization are set to block access to all devices. However, you can still access mailboxes by using the Windows Mail app. This occurs even though the mobile device details indicate that mailbox connections that are made by using Windows Mail will be blocked.

Use the following methods to verify that Exchange ActiveSync is configured correctly.

- To check your organization's ActiveSync settings:

   `Get-ActiveSyncOrganizationSettings | ft DefaultAccessLevel`

   If ActiveSync is set to block devices, this command returns the following output:

   `DefaultAccessLevel : Block`

- To check devices that are configured to sync with a specific mailbox:

   `Get-MobileDeviceStatistics -Mailbox <MailboxID> | fl DeviceUserAgent,DeviceType,deviceos,deviceaccessstate`

   This command returns the following output:

   ```output
   DeviceType        : UniversalOutlook
   DeviceOS          : WINDOWS
   DeviceAccessState : Unknown
   ```

- To check devices that are associated with a specific mailbox:

   `Get-MobileDevice -Mailbox <MailboxID> | fl DeviceUserAgent,DeviceType,deviceos,deviceaccessstate`

   This command returns the following output:

   ```output
   DeviceUserAgent   : microsoft.windowscommunicationsapps
   DeviceType        : UniversalOutlook
   DeviceOS          : WINDOWS
   DeviceAccessState : Blocked
   ```

## Cause
The Windows Mail app uses a native Microsoft sync technology that isn't blocked by ActiveSync device access rules. Your organization's ActiveSync settings and device access rules are used to manage Microsoft Outlook for mobile and ActiveSync connections only.

## Resolution

To block the Windows Mail app from accessing mailboxes, use [Client Access Rules](/exchange/clients-and-mobile-in-exchange-online/client-access-rules/client-access-rules) or the **UniversalOutlookEnabled** parameter of the [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) cmdlet.
