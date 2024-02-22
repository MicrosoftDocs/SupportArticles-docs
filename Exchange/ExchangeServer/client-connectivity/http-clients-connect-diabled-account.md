---
title: HTTP clients are connected after account is disabled
description: Describes an issue in which an Exchange HTTP client can continue to connect to its mailbox after its account has been disabled or its password has been reset. A fix is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: robevans, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# HTTP clients can still connect to Exchange after account is disabled or password is changed

_Original KB number:_ &nbsp; 3035228

## Symptoms

An HTTP client such as Exchange ActiveSync (EAS), Outlook Anywhere, or Exchange Web Services (EWS) may still be able to connect to its mailbox after its account has been disabled. Clients may also be able to connect by using an old password after the password has been changed.

## Cause

When you're using Basic authentication and Forms-based Authentication (FBA), Microsoft Internet Information Services (IIS) caches the user's token so that Windows logon occurs only during the initial logon or after the token has been flushed. (This flushing occurs when the TTL [default setting of 15 minutes] for the token expires.) If the user reconnects before the TTL has expired, the TTL will be reset. It may require 8-24 hours before the changes are recognized.

To clear the token cache and to force the client to authenticate, use one of the following methods.

## Resolution 1: Reset IIS

1. On the Client Access server or servers that the device connects to, click **Start**, click **Run**, type *CMD*, and then press ENTER.
2. Type *iisreset*, and then press ENTER. This restarts IIS services. You can also use the Services.msc snap-in to manually restart the IIS Admin service.

## Resolution 2: Recycle the App pools

1. Click **Start**, click **Administrative Tools**, and then click **Internet Information Services (IIS) Manager**.
2. Expand the server name.
3. Click **Application Pools**.
4. Right-click **MSExchangeSyncAppPool**, and then click **Recycle**.
5. Right-click **MSExchangeServicesAppPool**, and then click **Recycle**.
6. Right-click **MSExchangeOWAAppPool**, and then click **Recycle**.
7. Right-click **DefaultAppPool**, and then click **Recycle**. (Exchange 2010 and Exchange 2007 only)
8. Right-click **MSExchangeRPCProxyFrontEndAppPool**, and then click **Recycle**.
9. Right-click **MSExchangeMAPIFrontEndAppPool**, and then click **Recycle**.

## More information

For more information about the IIS token cache, see [Token cache](/previous-versions/windows/it-pro/windows-server-2003/cc783800(v=ws.10)).

For more information about this topic, including other services that are affected in this scenario, see [Exchange Best Practices for Untrusted Mailbox Users](https://social.technet.microsoft.com/wiki/contents/articles/exchange-best-practices-for-untrusted-mailbox-users.aspx).

For information about EAS device synchronization, see [EAS devices still sync after an account is disabled or a password is changed](https://support.microsoft.com/help/2612821?wa=wsignin1.0).
