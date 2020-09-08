---
title: Domain members fail authentication when domain controller is shut down
description: Fixes an issue where the application can't authenticate users when you shut down a Domain Controller.
ms.date: 09/08/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Legacy authentication (NTLM)
ms.technology: WindowsSecurity
---
# Domain members fail authentication when domain controller is shut down

This article helps fix an issue where the application can't authenticate users when you shut down a Domain Controller.

_Original product version:_ &nbsp;Window 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;2683606

## Symptoms

You have a domain with applications that use NTLM or Kerberos to authenticate users. Some applications have a pattern that the clients reconnect to the application server often.

Applications are mostly affected when they use NTLM. Applications using Kerberos may also be affected if Kerberos PAC verification is used for authentications accepted by the application. It's not possible to turn these off in all cases:

 [906736](https://support.microsoft.com/default.aspx?scid=kb;EN-US;906736)  You experience a delay in the user-authentication process when you run a high-volume server program on a domain member in Windows 2000 or Windows Server 2003

In this situation, when you shut down a Domain Controller, it may happen that the application can't authenticate users until the Domain Controller isn't responding on the network and the Domain Member has selected a different Domain Controller for authentication.

In the diagnostic logs and network traces, you may see user logon errors "logon failure", or the error 0xc0000064 "STATUS_NO_SUCH_USER with text "The specified account does not exist." is shown. With Kerberos, you may see error 6 "KDC_ERR_C_PRINCIPAL_UNKNOWN".

## Cause

There are two problems that may happen:

1. When the DC is in shutdown phase, it will normally tell current clients to use another DC for authentication using the error code 0xc00000dc (STATUS_INVALID_SERVER_STATE). There's however a code path where this doesn't happen.
2. The server won't avoid responding to new clients on Netlogon UDP queries. Also, the clients that received the error that the DC is in shutdown won't avoid selecting the same DC on the later DC search.

When a client selects the DC while in shutdown, NTLM or Kerberos requests will fail again. At this point, the client will go into a negative cache mode and fails later authentication requests.

Note in the case of NTLM the client is application server so it can't accept new clients until a working DC is selected.

## Resolution

You can avoid the problem if you stop the Netlogon service on the Domain Controller before you initiate the shutdown or restart. You can automate this by entering the stop task in a local shutdown script for the Domain Controller. To get to the local group Policy, follow these steps:
1. Start Gpedit.msc

2. Navigate the Settings tree down to: Computer Configuration->Windows Settings->Scripts->Shutdown

3. As the new script command line, enter 'net stop netlogon'.

You can also set the registry parameter "NegativeCachePeriod" to a low value. But this won't completely avoid the problem, but just make the client look for an alternate DC more often.

## More information

In the Netlogon.log of the client, you would see it receives the error code STATUS_INVALID_SERVER_STATE from the DC:

> \<Date>\<Time> [CRITICAL] NlPrintRpcDebug: Couldn't get EEInfo for I_NetLogonSamLogonEx: 1761 (may be legitimate for 0xc00000dc)  
\<Date>\<Time> [CRITICAL] \<domain>: NlpUserValidateHigher: denying access after status: 0xc00000dc 0  
\<Date>\<Time> [SESSION] \<domain>: NlSetStatusClientSession: Set connection status to c00000dc  
\<Date>\<Time> [SESSION] \<domain>: NlSetStatusClientSession: Unbind from server \\\\\<dc-name1>.\<domain FQDN> (TCP) 1.  


This is how it looks when the client tries the DC in shutdown as one of the DCs:

> \<Date>\<Time> [SESSION] \<domain>: NlSessionSetup: Try Session setup  
\<Date>\<Time> [SESSION] \<domain>: NlDiscoverDc: Start Synchronous Discovery  
\<Date>\<Time> [MISC] NetpDcInitializeContext: DSGETDC_VALID_FLAGS is c01ffff1  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.87  
\<Date>\<Time> [SESSION] NETLOGON_CONTROL_TC_QUERY function received.  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.93  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.92  


The second ping is sent to the DC in shutdown.

On the DC, you see it respond even though it already returned the error to the client:

> \<Date>\<Time> [LOGON] HM-REBOOT: SamLogon: Transitive Network logon of \<domain>\test1 from HM-REBOOT-SRV1 (via HM-REBOOT-SRV1) Entered  
\<Date>\<Time> [LOGON] HM-REBOOT: SamLogon: Transitive Network logon of \<domain>\test1 from HM-REBOOT-SRV1 (via HM-REBOOT-SRV1) Returns 0xC00000DC  
...  
\<Date>\<Time> [MAILSLOT] Received ping from HM-REBOOT-SRV1 <\domain> (null) on UDP LDAP  
\<Date>\<Time> [MAILSLOT] \<domain>: Ping response 'Sam Logon Response Ex' (null) to \\\\\<member server> Site: Default-First-Site-Name on UDP LDAP  
\<Date>\<Time> [MAILSLOT] \<domain>: Ping response 'Sam Logon Response Ex' (null) to \\\\\<member server> Site: Default-First-Site-Name on UDP LDAP  

Reference for "NegativeCachePeriod":

 [819108](https://support.microsoft.com/help/819108)  Settings for minimizing periodic WAN traffic
