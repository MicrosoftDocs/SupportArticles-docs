---
title: Release Management component doesn't work
description: This article provides a workaround for the problem that the other component does not work after you uninstall Release Management Client or Release Management Server.
ms.date: 08/14/2020
ms.custom: sap:Pipelines
ms.reviewer: achand, daleche
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# The other Release Management component does not work after you uninstall the client or server

This article helps you work around the problem that the other component does not work after you uninstall Release Management Client or Release Management Server.

_Original product version:_ &nbsp; Release Management Visual Studio 2013, Release Management Client for Visual Studio 2013, Release Management for Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2905740

## Symptoms

Consider the following scenario:

- You install Microsoft Release Management Server for Visual Studio 2013.
- You install Release Management Client for Visual Studio 2013 on the same computer.
- You uninstall Release Management Client or Release Management Server.

In this scenario, you experience one of the following issues:

- If you uninstall Release Management Server, Release Management Client does not work.
- If you uninstall Release Management Client, Release Management Server does not work.

## Workaround

To work around this issue, do one of the following:

- Uninstall and then reinstall the Release Management component that stopped working.
- Reinstall the Release Management component that you uninstalled.

> [!NOTE]
> You may have to restart the computer after you reinstall both components.

## References

Check out [Known issues when you install Release Management for Visual Studio 2013](../../developer/visualstudio/installation/release-management-installation-issues.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
