---
title: OpsMgr agent push installation fails with error 800706D3 
description: Fixes an issue in which you receive error 800706D3 and the installation fails when you try to push a System Center Operations Manager 2012 agent to a Windows Server 2012-based agent server.
ms.date: 04/15/2024
ms.reviewer: arku, adoyle, jchornbe
---
# Error 800706D3 and a push installation fails for an Operations Manager 2012 agent to Windows Server 2012

This article helps you fix an issue where you receive error 800706D3 when you try to push a System Center Operations Manager 2012 agent to a Windows Server 2012-based agent server.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3054347

## Symptoms

When you try to push a System Center 2012 Operations Manager agent from a Windows Server 2012-based management server to a Windows Server 2012-based agent server, the installation fails and you receive the following error message:

> The Operations Manager Server failed to open service control manager on computer *server2012agent.contoso.local*.  
> Therefore, the Server cannot complete configuration of agent on the computer.  
> Operation: Agent Install  
> Install account: *contoso\scom_admin*  
> Error Code: 800706D3 Error Description: The authentication service is unknown.

When you try to connect to the services console of the agent, the connection fails and you receive the following error message:

> Windows was unable to open service control manager database on server2012agent.  
> Error 1747: The authentication service is unknown

A network trace returns the following result:

> 6627 14:53:40 12-03-2015 192.168.1.11 192.168.1.12 MSRPC MSRPC:c/o Bind: scmr(SCMR)
> UUID{367ABB81-9844-35F1-AD32-98F038001003}  
> 6630 14:53:40 12-03-2015 192.168.1.12 192.168.1.11 MSRPC MSRPC:c/o Bind Nack: Call=0x2  
> Reject Reason: authentication_type_not_recognized

## Cause

This problem can occur if the agent server has the DNS Client service stopped and disabled. For example, you might stop the DNS Client service because the DNS cache frequently becomes corrupted.

## Resolution

To resolve this problem, turn on the DNS Client service. After the service is restored, you can successfully establish a remote connection to the service console and perform an agent push installation.

## More information

We recommend that you don't stop or disable the DNS Client service to avoid errors. Instead, you should troubleshoot the causes of the DNS cache corruption.

Microsoft has not tested the functionality of authentication and other system components when the DNS Client service is turned off. DNS is the primary name resolution method for any application, and the DNS Client service is responsible to maintain the client cache. If the service is turned off, it will no longer cache domain names. Even though this action might not break name resolution directly, other components that depend on the DNS Client service will fail.
