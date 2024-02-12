---
title: Can't sign in to the domain
description: Provides a solution to an issue where users can't sign in to the domain after password changes on a Remote Domain Controller.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, PATCH
ms.custom: sap:active-directory-fsmo, csstroubleshoot
---
# Users can't sign in to the domain after password changes on a Remote Domain Controller

This article provides a solution to an issue where users can't sign in to the domain after password changes on a Remote Domain Controller.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 318364

## Symptoms

After you change a user account password on a remote domain controller that holds the primary domain controller (PDC) Flexible Single Master Operation (FSMO) role, the user may not be able to sign in to a local domain controller by entering the new password. However, the user may still be able to sign in to the domain by using their previous password.

## Cause

This behavior may occur when the following conditions are true:

- The remote domain controller hasn‘t yet replicated with the local domain controller.
- Kerberos is configured to use User Datagram Protocol (UDP) protocol (the default configuration).
- The user's security token is too large to fit in a UDP Kerberos message.

    > [!NOTE]
    > The user's security token may be large if that user is a member of many groups.

This problem is caused by the anti-replay feature of Kerberos authentication on the local domain controller. The following steps illustrate this behavior:

1. The user account password is changed on the remote domain controller, but that change hasn’t yet been replicated to the local domain controller.
2. The user tries to sign in to the domain by using the new password. The Kerberos Authentication Service Exchange message (KRB_AS_REQ) is sent to the local domain controller by using UDP.
3. The local domain controller fails the authentication because it doesn't yet have the new password information.
4. The local domain controller forwards the request to the remote PDC (`KDCSVC!FailedLogon`).
5. In the `FailedLogon` function, an entry for the request is entered into the replay-detection table, and the KRB_AS_REQ message is sent to the remote PDC.
6. The remote PDC successfully authenticates the request, and then returns a positive reply to the local domain controller.
7. The local domain controller detects that the reply is too large for a UDP packet, and that's why sends a request to the client computer to resend the request by using Transmission Control Protocol (TCP).
8. The client computer resubmits the authentication request by using TCP.
9. The local domain controller fails the authentication because it doesn't yet have the new password information (as in step 3).
10. The local domain controller forwards the request to the remote PDC domain controller (`KDCSVC!FailedLogon`) (as in step 4).
11. The replay detection check in the `FailedLogon` function returns a KRB_AP_ERR_REPEAT message because an entry for this request is already present in the replay detection table. This is the entry that was created in step 5.

The authentication attempt fails.

## Resolution

To resolve this problem, obtain the latest service pack for Windows 2000.

The English version of this fix has the file attributes (or later) that are listed in the following table. The dates and times for these files are listed in coordinated universal time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the Time Zone tab in the Date and Time tool in Control Panel.

```console
Date Time Version Size File name
-----------------------------------------------------------
22-Mar-2002 23:55 5.0.2195.4959 123,664 Adsldp.dll
30-Jan-2002 00:52 5.0.2195.4851 130,832 Adsldpc.dll
30-Jan-2002 00:52 5.0.2195.4016 62,736 Adsmsext.dll
22-Mar-2002 23:55 5.0.2195.5201 356,624 Advapi32.dll
22-Mar-2002 23:55 5.0.2195.4985 135,952 Dnsapi.dll
22-Mar-2002 23:55 5.0.2195.4985 95,504 Dnsrslvr.dll
22-Mar-2002 23:56 5.0.2195.5013 521,488 Instlsa5.dll
22-Mar-2002 23:55 5.0.2195.5246 145,680 Kdcsvc.dll
22-Mar-2002 23:50 5.0.2195.5246 199,952 Kerberos.dll
07-Feb-2002 19:35 5.0.2195.4914 71,024 Ksecdd.sys
02-Mar-2002 21:32 5.0.2195.5013 503,568 Lsasrv.dll
02-Mar-2002 21:32 5.0.2195.5013 33,552 Lsass.exe
08-Dec-2001 00:05 5.0.2195.4745 107,280 Msv1_0.dll
22-Mar-2002 23:55 5.0.2195.4917 306,960 Netapi32.dll
22-Mar-2002 23:55 5.0.2195.4979 360,208 Netlogon.dll
22-Mar-2002 23:55 5.0.2195.5221 917,264 Ntdsa.dll
22-Mar-2002 23:55 5.0.2195.5201 386,832 Samsrv.dll
30-Jan-2002 00:52 5.0.2195.4874 128,784 Scecli.dll
22-Mar-2002 23:55 5.0.2195.4968 299,792 Scesrv.dll
30-Jan-2002 00:52 5.0.2195.4600 48,400 W32time.dll
06-Nov-2001 19:43 5.0.2195.4600 56,592 W32tm.exe
22-Mar-2002 23:55 5.0.2195.5011 125,712 Wldap32.dll
```  

## Workaround

To work around this issue, do user account password changes on the local domain controller or force Kerberos to use TCP (Transmission Control Protocol) instead of UDP (User Datagram Protocol).

For more information, see [How to force Kerberos to use TCP instead of UDP in Windows](https://support.microsoft.com/help/260729).

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows 2000 Service Pack 3.

## More information

The Kerberos anti-replay feature prevents the same packet from being received two times by the authenticating server. A replay attack is an attack in which a valid data transmission is maliciously or fraudulently repeated, either by the originator or by an adversary who intercepts the data and retransmits it. An attacker may attempt to "replay" a valid user's user name and password in an attempt to authenticate by using that user's credentials.
