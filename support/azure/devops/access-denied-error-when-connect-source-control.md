---
title: Access denied when you connect to Source Control
description: This article discusses an access denied problem that occurs when you connect to Source Control or build components in Team Foundation Server.
ms.date: 08/14/2020
ms.custom: sap:Pipelines - Building your application
ms.reviewer: manojm, georgea, ccoop, davean
ms.service: azure-devops
---
# 'Access denied' error message for a different user when you connect to Source Control or build components in Team Foundation Server

This article shows an access denied problem that occurs when you connect to Source Control or build components in Team Foundation Server.

_Original product version:_ &nbsp; Team Foundation Server 2013  
_Original KB number:_ &nbsp; 3014137

## Symptoms

When you connect to Source Control or build components in Team Foundation Server, you may receive an unexpected **Access denied** error message. However, the **Access denied** is not related to the account that is connected, but someone different.

Assume that you use `domain\UserA` to log on the Team Foundation Server. When you build components, you may receive one of the following error messages:

> The build stopped unexpectedly because the "WorkflowCentralLogger" logger failed unexpectedly during initialization. Access Denied: domain\UserX needs the following permission(s) to perform this action: View collection-level information  
>TF270015: 'MSBuild.exe' returned an unexpected exit code. Expected '0'; actual '1'.

> TF215106: Access denied. domain\UserX needs Update build information permissions for build definition

> TF215106: Access denied. domain\UserX needs Queue builds permission from build definition QA in team project Quantum to perform the action.

When you connect to Source Control by using domain\UserA, you may receive the following error message:

> TF204017: The operation cannot be complete because the user (domain\UserX) does not have one or more required permission (Use) for workspace

In these error messages, a random user (`domain\UserX`) does not have access. This differs from the user who is connected to Team Foundation Server (`domain\UserA`). Usual behavior should only inform the currently connected user (`domain\UserA`) who does not have this permission. Also, these error messages can occur after a successful connection to Team Foundation Server by using `domain\UserA`.

## More information

You may experience this issue when you use Big-IP F5 load balancer together with the **OneConnect** option. Disable **OneConnect** to work around the problem in this scenario.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
