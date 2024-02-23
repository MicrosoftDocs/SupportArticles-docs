---
title: The connection to your mail server timed out error in Outlook for iOS or Outlook for Android
description: You get the error The connection to your mail server timed out when you use Outlook for iOS or Outlook for Android to sign in to Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 146711
  - CI 147050
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: taruns, daweiler, jeffkalv
appliesto: 
  - Outlook for iOS
  - Outlook for Android
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---

# "The connection to your mail server timed out" error in Outlook for iOS or Outlook for Android

## Symptoms

When you try to sign in to your Exchange on-premises account in Outlook for iOS or Outlook for Android, you receive the following error message:

>The connection to your mail server timed out.

Also, mailbox synchronization might stop unexpectedly if your Exchange account is already added to Outlook.

## Cause

This issue occurs if either of the following conditions is true:

- The version of Exchange Server that you're running uses TLS 1.1 or 1.0.
- The version of Windows Server that's hosting the on-premises Exchange Server is version 2008 or an earlier version, and is using TLS 1.1 or 1.0.

[Both TLS 1.0 and 1.1 are deprecated](/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365).

Outlook for iOS and Outlook for Android now block users from signing in to an environment that uses TLS 1.1 or 1.0. They support only versions of Exchange Server and operating system environments that use TLS 1.2 or later versions.

If your operating system currently uses TLS 1.2, the issue might be caused by an expired TLS certificate.

## Resolution

Use the following guidance to enable TLS 1.2 for the Exchange Server and Windows Server in your environment.

- [Exchange Server TLS guidance, part 1: Getting Ready for TLS 1.2](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-1-getting-ready-for-tls-1-2/ba-p/607649)
- [Exchange Server TLS guidance, part 2: Enabling TLS 1.2 and Identifying Clients Not Using It](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761)

Although Exchange Server version 2010 and later versions can be updated to enable TLS 1.2, earlier versions of Exchange Server have only the option to upgrade to a later version to be able to use Outlook for iOS or Outlook for Android.

If your environment already uses TLS 1.2 or later versions, do the following:

- Check whether you're using a valid TLS certificate, and whether it's installed correctly. For more information, see [Certificate procedures in Exchange Server](/exchange/architecture/client-access/certificate-procedures).
- If the TLS certificate is expired, renew the certificate by following the steps that are provided in [Renew an Exchange Server certificate](/exchange/architecture/client-access/renew-certificates).
