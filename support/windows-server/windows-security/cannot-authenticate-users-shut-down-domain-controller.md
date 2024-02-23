---
title: Domain members fail authentication when DC is shut down
description: This article fixes an issue where the application can't authenticate users when you shut down a Domain Controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# Domain members fail authentication when domain controller is shut down

This article fixes an issue where the application can't authenticate users when you shut down a Domain Controller (DC).

_Applies to:_ &nbsp; Window 10 – all editions, Windows Server 2012 R2

_Original KB number:_ &nbsp; 2683606

## Symptoms

The applications on the domain use **NT Local Area Network Manager (NTLM)** or **Kerberos** to authenticate users. Some applications have a pattern where the clients often reconnect to the application server.

Applications are mostly affected when they use NTLM. Applications that use Kerberos may also be affected if Kerberos privilege attribute certificate (PAC) verification is used for authentications accepted by the application. It's not possible to turn these verifications off in all cases.

In this situation, when you shut down a DC, the application might not authenticate users until both the DC isn't responding on the network, and the Domain Member has selected a different DC for authentication.

In the diagnostic logs and network traces, you may see user logon errors **logon failure**, or the error **0xc0000064 STATUS_NO_SUCH_USER**, which displays **The specified account does not exist.**. If you are using Kerberos, you may see Error 6, **KDC_ERR_C_PRINCIPAL_UNKNOWN**.

## Cause

There are two problems that may happen:

1. When the DC is in shutdown phase, it will normally tell current clients to use another DC for authentication using the error code 0xc00000dc **(STATUS_INVALID_SERVER_STATE)**. There is a code path where this issue doesn't happen.

2. The server won't avoid responding to new clients on Netlogon **User Datagram Protocol (UDP)** queries. Also, the clients that received the error that the DC is in shutdown, won't avoid selecting the same DC on the later DC search.

When a client selects the DC while in shutdown, NTLM or Kerberos requests will fail again. At this point, the client will go into a negative cache mode, and will fail later authentication requests.

In the case of NTLM, the client is the application server, so it can't accept new clients until a working DC is selected.

## Resolution

To avoid the problem, stop the Netlogon service on the DC before you initiate the shutdown or restart. To automate this action, enter the stop task in a local shutdown script for the DC. To get to the local group Policy, follow these steps:

1. Start **Gpedit.msc**

2. Open the **Settings** tree, and navigate to: Computer Configuration > Windows Settings > Scripts > Shutdown.

3. At the new script command line, enter `net stop netlogon && net stop kdc`.

Though you can set the registry parameter **NegativeCachePeriod** to a low value, this change won't completely avoid the problem, as the client will look for an alternate DC more often.

## More information

In the Netlogon.log of the client, you will see it receive the error code **STATUS_INVALID_SERVER_STATE** from the DC:

> \<Date>\<Time> [CRITICAL] NlPrintRpcDebug: Couldn't get EEInfo for I_NetLogonSamLogonEx: 1761 (may be legitimate for 0xc00000dc)  
\<Date>\<Time> [CRITICAL] \<domain>: NlpUserValidateHigher: denying access after status: 0xc00000dc 0  
\<Date>\<Time> [SESSION] \<domain>: NlSetStatusClientSession: Set connection status to c00000dc  
\<Date>\<Time> [SESSION] \<domain>: NlSetStatusClientSession: Unbind from server \\\\\<dc-name1>.\<domain FQDN> (TCP) 1.  

The results when the client tries the DC in shutdown as one of the DCs:

> \<Date>\<Time> [SESSION] \<domain>: NlSessionSetup: Try Session setup  
\<Date>\<Time> [SESSION] \<domain>: NlDiscoverDc: Start Synchronous Discovery  
\<Date>\<Time> [MISC] NetpDcInitializeContext: DSGETDC_VALID_FLAGS is c01ffff1  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.87  
\<Date>\<Time> [SESSION] NETLOGON_CONTROL_TC_QUERY function received.  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.93  
\<Date>\<Time> [MAILSLOT] NetpDcPingListIp: \<domain>: Sent UDP ping to 10.10.103.92  

The second ping is sent to the DC in shutdown.

The DC will respond, though it already returned the error to the client:

> \<Date>\<Time> [LOGON] HM-REBOOT: SamLogon: Transitive Network logon of \<domain>\test1 from HM-REBOOT-SRV1 (via HM-REBOOT-SRV1) Entered  
\<Date>\<Time> [LOGON] HM-REBOOT: SamLogon: Transitive Network logon of \<domain>\test1 from HM-REBOOT-SRV1 (via HM-REBOOT-SRV1) Returns 0xC00000DC  
...  
\<Date>\<Time> [MAILSLOT] Received ping from HM-REBOOT-SRV1 <\domain> (null) on UDP LDAP  
\<Date>\<Time> [MAILSLOT] \<domain>: Ping response 'Sam Logon Response Ex' (null) to \\\\\<member server> Site: Default-First-Site-Name on UDP LDAP  
\<Date>\<Time> [MAILSLOT] \<domain>: Ping response 'Sam Logon Response Ex' (null) to \\\\\<member server> Site: Default-First-Site-Name on UDP LDAP  

## Next Steps

Reference for "NegativeCachePeriod":

- [819108 - Settings for minimizing periodic WAN traffic](https://support.microsoft.com/help/819108)
