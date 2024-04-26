---
title: Deployment agents that rely on shadow don't work
description: This article provides resolutions for the problem that occurs when you try to use deployment agents that rely on shadow accounts in Release Management.
ms.date: 08/14/2020
ms.custom: sap:Server Administration
ms.reviewer: achand, daleche, muthuk, sriramb, ronai, ans, leov
ms.service: azure-devops-server
---
# Deployment agents that rely on shadow accounts do not work with Release Management Server for Visual Studio 2013

This article helps you resolve the problem that occurs when you try to use deployment agents that rely on shadow accounts in Release Management.

_Original product version:_ &nbsp; Release Management Client for Visual Studio 2013, Release Management Visual Studio 2013, Release Management for Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2905742

## Symptoms

Assume that you have three deployment agents. These deployment agents rely on the following shadow accounts:

- Server1/LocalAccount1
- Server2/LocalAccount1
- Server3/LocalAccount1

In this scenario, you cannot configure the deployment agents in Microsoft Release Management Server for Visual Studio 2013.

## Cause

This issue occurs because the deployment agents cannot be configured if they rely on shadow accounts.

## Resolution

To resolve this issue, add the Service User accounts in Release Management. To do this, follow these steps:

1. Create a Service User account for each deployment agent in Release Management. For example, create the following:

    - Server1/LocalAccount1
    - Server2/LocalAccount1
    - Server3/LocalAccount1

2. Create an account in Release Management, and then assign to that account the Service User and Release Manager user rights. For example, create **Release_Management_server**\\**LocalAccount1**.
3. Run the deployment agent configuration on each deployment computer.

## References

Check out [Known issues when you install Release Management for Visual Studio 2013](../../developer/visualstudio/installation/release-management-installation-issues.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
