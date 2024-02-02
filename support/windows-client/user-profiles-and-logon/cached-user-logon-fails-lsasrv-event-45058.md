---
title: Cached user logon fails with LSASRV event 45058
description: Fixes an issue that occurs when logging on to a domain-joined Windows Vista or Windows 7 computer using cached credentials.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# Cached user logon fails when LSASRV event 45058 indicates FIFO deletion of cached credential

This article fixes a logon failure that occurs when logging on to a domain-joined Windows Vista or Windows 7 computer using cached credentials.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2555663

## Symptoms

1. Users receive the following error when logging on to a domain-joined Windows Vista or Windows 7 computer using cached credentials:

    > There are currently no logon servers available to service the logon request.

2. LsaSrv Event 45058, logged in the System event log of a domain-joined workstation, indicates that the operating system has deleted the cached credential for the user specified in the event:

    > Log Name: System  
    Source: LsaSrv  
    Date: \<date> \<time>  
    Event ID: 45058  
    Task Category: Logon Cache  
    Level: Information  
    Keywords: Classic  
    User: N/A  
    Computer: `computername.contoso.com`  
    Description:  
    A logon cache entry for user `USERNAME@CONTOSO.COM` was the oldest entry and was removed. The timestamp of this entry was MM/DD/YYYY HH:MM:SS.

## Cause

The user logon error occurs when a user's cached credentials have been purged from the local computer by more recent domain user logons.

Windows Vista and Windows 7 operating systems cache credentials for a finite number of user accounts (assuming cached credentials haven't been disabled).

Once the cached logon quota has been reached, the operating system will purge the oldest cached credential from the local computer so that the credentials for the next unique domain user successfully authenticated by a domain controller may be cached. The logging of the LsaSrv 45058 event indicates that the cached logon quota has been reached, triggering the deletion of the oldest user credential cached on the local machine.

## Resolution

1. Verify that cache credentials are allowed on the local computer.

    If the CachedLogonsCount registry value is 0, then the system will not cache domain user credentials. See the **More information** section below to determine the configurable range.  

2. If the user's credentials have been deleted OR cached credentials are disabled, establish network connectivity and name resolution with one or more domain controllers that can authenticate the user account's domain logon (VPN, and so on), then successfully authenticate the user's logon.

    If cached logons are enabled, a successful logon will cache that user's credentials while purging the oldest cached credentials.

    If establishing domain connectivity over a software VPN, you'll likely have to establish the VPN from another local or cached domain user, persist that connection while logging off, then logging on or switching to the domain user account whose credentials you want to cache.

3. Evaluate increasing the cache logon quota with a domain administrator.

## More information

By default, a Windows operating system will cache 10 domain user credentials locally. When the maximum number of credentials are cached and a new domain user logs on to the system, the oldest credential is purged from its slot to store the newest credential. This LsaSrv informational event simply records when this activity takes place. Once the cached credential is removed, it doesn't imply the account cannot be authenticated by a domain controller and cached again.

The number of slots available to store credentials is controlled by:

- Registry path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows` NT\CurrentVersion\Winlogon
- Setting Name: CachedLogonsCount
- Data Type: REG_SZ
- Value: Default value = 10 decimal, max value = 50 decimal, minimum value = 1

Cached credentials can also be managed with group policy by configuring:

Group Policy Setting path: Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\Security Options.

Group Policy Setting: Interactive logon: Number of previous logons to cache (in case domain controller is not available)

The workstation the user needs access to must have physical connectivity with the domain and the user must authenticate with a domain controller to cache their credentials again.
