---
title: Server specified can't be reached error occurs
description: This article provides resolutions for the problem in which you can't connect to a computer that's running Release Management Server from Release Management Client.
ms.date: 08/14/2020
ms.custom: sap:Client Connectivity
ms.reviewer: achand, daleche, muthuk, sriramb, ronai, ans, leov
ms.service: azure-devops
ms.subservice: ts-client-connectivity
---
# 'The server specified could not be reached' error when you try to connect through Release Management Client

This article helps you resolve the problem in which you can't connect to a computer that's running Release Management Server from Release Management Client.

_Original product version:_ &nbsp; Release Management Client for Visual Studio 2013, Release Management Visual Studio 2013, Release Management for Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2907777

## Symptoms

You try to connect to a computer that's running Release Management Server for Team Foundation Server 2013 by using Release Management Client for Visual Studio 2013. However, you receive an error message that resembles the following:

> The server specified could not be reached

Additionally, when you try to connect to the server that's running Release Management Server from the Release Management web client, you receive an error message that resembles the following:

> Forbidden 403

When this issue occurs, a `MissingSatelliteAssemblyException` warning from the Release Management service is logged in Event Viewer on the server that's running Release Management Server.

## Resolution

To resolve this issue, follow these steps:

1. Download and install the Microsoft Visual Studio 2013 Shell (Isolated) Redistributable Package.
2. Recycle the Release Management Application pool in Internet Information Services (IIS).
3. Restart the Release Management Monitor Service.

## References

Check out [Known issues when you install Release Management for Visual Studio 2013](../../developer/visualstudio/installation/release-management-installation-issues.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
