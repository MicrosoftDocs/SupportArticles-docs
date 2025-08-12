---
title: Incorrect default project administrator permissions
description: This article introduces that when Team Foundation Server creates a new project, a set of default permissions is applied. Certain versions of Team Foundation Server 2015 incorrectly set the permissions to bypass branch policy for Git repos on project administrators.
ms.date: 08/14/2020
ms.custom: sap:Server Administration
ms.service: azure-devops-server
---
# Incorrect default project administrator permissions in Team Foundation Server 2015

This article shows that when Team Foundation Server creates a new project, a set of default permissions is applied.

_Original product version:_ &nbsp; Team Foundation Server 2015  
_Original KB number:_ &nbsp; 3191968

## Summary

When Team Foundation Server creates a new project, a set of default permissions is applied. Team Foundation Server 2015 updates (but not the RTM version) have an incorrect default setting for project administrators. This means that, by default for projects that are created after Update 1 is installed, project administrators can bypass Git branch policies. For projects that are created before Update 1 is installed or by future versions of Team Foundation Server, the correct default setting of **not set** is configured.

## More information

This permissions configuration may be intentional, and there is no automated way to detect whether it was incorrectly configured as the default setting or else set that way intentionally. Team Foundation Server upgrades will not change the setting for projects that already exist. If you want to prevent project administrators from bypassing Git branch policies, reset that group's permissions to **not set**. For more information, see the [Permissions, users, and groups in Azure DevOps](/azure/devops/organizations/security/permissions).

Future versions of Team Foundation Server will apply the correct default setting to new projects.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
