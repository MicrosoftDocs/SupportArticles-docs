---
title: EAS still syncs with disabled account or password
description: Describes an issue in which EAS devices still sync after an account is disabled or a password is changed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: austinmc, pabbott, v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# EAS devices still sync after an account is disabled or a password is changed

_Original KB number:_ &nbsp; 2612821

## Symptoms

EAS devices continue to synchronize after their account has been disabled. Devices also connect using an old password, after the password has been changed.

## Cause

When an EAS device is set to synchronize items as they arrive (Direct Push), any changes made to the user's account in Active Directory can require 8 to 24 hours before the device recognizes those changes.

When using Direct Push, devices maintain an open connection to the server. Any changes made after the connection is established will not take effect immediately.

## Resolution 1 - Reset Internet Information Services (IIS)

1. On the Client Access Server(s) that the device connects to, select **Start**, select **Run**, type *CMD*, and then press ENTER.
2. Type *iisreset* and press ENTER.

This will restart IIS services. You can also use the Services.msc snap-in to manually restart the IIS Admin service.

## Resolution 2 - Recycle the Application Pool used by ActiveSync

1. Select **Start**, select **Administrative Tools**, select **Internet Information Services (IIS) Manager**.
2. Expand the server name.
3. Select **Application Pools**.
4. Right-click the **MSExchangeSyncAppPool** and select **Recycle**.

> [!NOTE]
> In Exchange 2003, EAS shares the same Application Pool with Outlook Web Access.

## Resolution 3 - Configure the device to use a manual sync mode

Depending on the device type, modify the synchronization settings to use a manual sync and then wait a few minutes for the connection to be reset. On the next manual sync attempt, a new connection is established.

## Resolution 4 - Shut down the device

Power off the device and wait a few moments, then turn it back on.

## More information

For more information, including other services impacted in this scenario, see [Exchange Best Practices for untrusted mailbox](https://social.technet.microsoft.com/wiki/contents/articles/3406.exchange-best-practices-for-untrusted-mailbox-users.aspx).
