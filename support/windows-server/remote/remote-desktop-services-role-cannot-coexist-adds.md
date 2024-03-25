---
title: RDS role cannot coexist with AD DS role
description: Provides a resolution for the issue that Remote Desktop Services role cannot coexist with AD DS role.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Connection Broker and load balancing, csstroubleshoot
---
# Remote Desktop Services role cannot coexist with AD DS role

This article provides a resolution for the issue that Remote Desktop Services role cannot coexist with AD DS role.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2799605

## Symptoms

Consider the following scenarios:  
 **Scenario 1**:  

- You have a computer that is running Windows Server 2012 with Active Directory Domain Services role installed
- You try to install Remote Desktop Connection Broker role  

In this scenario, the installation of Remote Desktop Connection Broker may fail and you may receive the following error message:  
>RD Connection Broker Role Service: Failed  
Unable to install RD Connection Broker role service on Server \<Servername>  

Additionally, the following Event ID is logged in the System Event Log:  
>Log Name: System  
Source: Service Control Manager  
Date: \<Date>\<Time>  
Event ID: 7024  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: Servername  
Description:  
The Remote Desktop Management service terminated with the following service-specific error:  
%%2284126209  

 **Scenario 2**:  

- You have a computer that is running Windows Server 2012 with Remote Desktop Connection Broker role installed
- You try to install Active Directory Domain Services role  

In this scenario, the installation of Active Directory Domain Services role is successful, however the Remote Desktop Connection Broker may fail and you may receive the following error message:  
>The server pool does not match the RD Connection Broker that are in it. Errors:  
Cannot connect to any of the specified RD Connection Broker servers. Ensure that at least one server is available and the Remote Desktop Management (rdms), RD Connection Broker (tssdis), or RemoteApp and Desktop Connection (tscpubrpc) services are running.  

## Cause

It was not supported to combine Remote Desktop Services role services and Active Directory Domain Services role on Windows Server 2012 RTM.

## Resolution

This configuration is supported following install of Servicing Stack Update of September 2013:  
 [2871777](https://support.microsoft.com/kb/2871777) A servicing stack update is available for Windows RT, Windows 8, and Windows Server 2012: September 2013
