---
title: Service using gMSA account doesn't start
description: Address an issue in which service cannot start and slow startup and user logon when the service is configured to use gMSA account on a Windows Server 2012 R2-based DC.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:boot-is-slow, csstroubleshoot
---
# Service configured to use gMSA account on a Windows Server 2012 R2-based DC doesn't start

This article provides workaround for an issue where service can't start when the service is configured to use gMSA account on a Windows Server 2012 R2-based domain controller (DC).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4294429

## Symptom

You have a computer that meets all the following conditions:  

- The computer is an Active Directory domain controller.  
- The computer is running one or more services that are configured to use a group managed service account (gMSA).  
- These services have a startup type of **Automatic** or **Delayed Start**.  
On this computer, you may experience one or more of the following symptoms:
- Services that uses the gMSA do not properly start.  
- Computer startup and user logon are slow or freeze.  
- Any application or service that runs on the computer that needs to interact with Service Control Manager (SCM) freezes.  

## Resolution

To work around this issue, use one of the following methods:  

- Configure the startup type of the Microsoft Key Distribution Service (KdsSvc) to **Automatic** instead of **Trigger Start**.  
- Change the trigger for the Microsoft Key Distribution Service (KdsSvc) to start the service as soon as the network is available by using the following command:  
    `sc triggerinfo kdssvc start/networkon`  

## More information

This issue is caused by a code defect in Microsoft components. The following explains how the issue occurs:  

1. During startup, Windows enumerates all automatic services and tries to start them.  
2. When Windows tries to start a service that is configured to use a group Managed Service Account (gMSA), the Service Control Manager (SCM) tries to log on by using the account information for the service.  
3. The logon request is sent to the Local Security Authority process (lsass.exe, LSASS) that is running on the computer.  
4. LSASS receives the request. While handling the request, LSASS tries to do a Lightweight Directory Access Protocol (LDAP) search for the msDS-ManagedPassword attribute.  
5. When the LDAP request is performed on a domain controller, the LDAP query can be sent back to the local server, where it is handled by a different thread in LSASS, which is the same process that issued the query.  
6. The LDAP server thread calls in to the Microsoft Key Distribution Service Provider (kdscli.dll), where it tries to find server components: Microsoft Key Distribution Service (KdsSvc), RPC endpoint from the RPC endpoint mapper (EPM).  
7. Because the KdsSvc service is set to be triggered as soon as one of these RPC queries occurs, the service should start (in theory). However, because the SCM is currently blocked from starting a service and it can only start one service at a time, KdsSvc never gets started, and SCM hangs.  
