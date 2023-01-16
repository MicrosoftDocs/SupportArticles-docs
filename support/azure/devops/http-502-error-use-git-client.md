---
title: HTTP 502 error when you use Git client
description: This article provides a resolution for the problem where you experience an HTTP 502 error when you connect to TFS 2013 by using Git client.
ms.date: 09/25/2020
ms.custom: sap:Repos
ms.reviewer: mmitrik
ms.service: azure-devops
ms.subservice: ts-repos
---
# HTTP 502 error when you connect to TFS 2013 by using Git clients

This article helps you resolve the problem where you experience an HTTP 502 error when you connect to TFS 2013 by using Git client.

_Original product version:_ &nbsp; Visual Studio Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2867441

## Symptoms

Consider the following scenario:

- Visual Studio Team Foundation Server 2013 Preview (TFS 2013) is running in Internet Information Services (IIS) 7.0 or IIS 7.5 on a computer, and the IIS Application Request Routing (ARR) 2.5 feature is enabled in IIS.
- You create a team project that uses Git as the source control engine in TFS 2013.
- You connect to this Git remote repository on the TFS server by using a third-party Git client.
- You try to execute a large request by using Git. For example, you clone many files.

In this scenario, you may receive an HTTP 502 error message from IIS that resembles the following:

> error: RPC failed; result=22, HTTP code = 502  
fatal: The remote end hung up unexpectedly  
fatal: recursion detected in die handler

## Cause

This issue occurs because of an issue in the ARR 2.5 feature.

## Resolution

To resolve this issue, install [the ARR 2.5 update](https://support.microsoft.com/help/2589179).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

## More information

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
