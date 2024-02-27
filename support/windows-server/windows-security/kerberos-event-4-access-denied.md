---
title: Kerberos SPN is on wrong account
description: Fixes an issue where users fail to access a resource and a System event log shows Kerberos event 4.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Kerberos Service Principal Name on Wrong Account

This article provides help to solve an issue where users fail to access a resource and a System event log shows Kerberos event 4.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2706695

## Symptoms

A System event log has shown at least one Kerberos event 4. This an event on a server indicating that a client has given the server a ticket for access to a resource that the server can't decrypt.

The true symptom is that a user failed to get access to a resource. The most likely error they received was an access denied or error 5.

## Cause

Kerberos service tickets are obtained by a client and passed to a server to gain access to resources on that server. They're signed using a secret which only that server that has the resource being requested can decrypt. When the SPN is on the wrong account in Active Directory the secret that is used is the one of the accounts the SPN is on instead of the one of the servers.

As a result, the server can't decrypt the ticket and gives back an error to the client.

## Resolution

To resolve this issue, the service principal name must be searched for and removed from the alternative account, and then it must be added to the correct account in Active Directory. To do that, follow these steps:

1. At an elevated command prompt and using Enterprise Administrator credentials, run the command `setspn -Q <SPN>`. This will return a computer name. SetSPN.exe is installed with the Active Directory Directory Services role or with RSAT.
2. Remove the incorrectly registered SPN by going to the command prompt and running the command `setspn -D <SPN> <computername>`.
3. Add the SPN to the correct account at the command prompt by running the command `setspn -A <SPN> <computername of computer which had the System event 4>`.

## More information

When a client requests a service ticket that it can pass along the DC issues it. The client then sends it to the remote host it's trying to authenticate to.

This problem may appear in a network trace with an error response from the resource server showing the error `KRB_AP_ERR_MODIFIED`.

In this scenario, the remote server can't decrypt the ticket the client sent to it since the password used to encrypt it isn't the right one. That, in turn, is the result of the SPN for that service and ticket being on the incorrect object in AD. It is that other objects password that is used instead. In this scenario, the server who can't decrypt the ticket responds to the client. The client then puts Kerberos event 4 (example below) in its System event log. Less commonly this is caused by network problems between client and server where the ticket is truncated.

KERBEROS Event ID 4

> Event Type: Error  
Event Source: Kerberos  
Event Category: None  
Event ID: 4  
Date: \<DateTime>  
Time: \<DateTime>  
User: N/A  
Computer: MACHINENAMEDescription:  
The kerberos client received a KRB_AP_ERR_MODIFIED error from the server
host/machinename.childdomain.rootdomain.com. The target name used was
cifs/machinename.domain.com. This indicates that the password used to encrypt the
kerberos service ticket is different than that on the target server. Commonly, this
is due to identically named machine accounts in the target realm
(`childdomain.rootdomain.COM`), and the client realm. Contact your system
administrator.  
