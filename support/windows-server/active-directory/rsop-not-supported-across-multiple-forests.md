---
title: Resultant Set of Policy (RSoP) planning mode is not supported in a cross-forest scenario
description: Discusses a limitation to RSoP planning mode in a multiple-forest scenario.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
---
# Resultant Set of Policy (RSoP) planning mode is not supported in a cross-forest scenario

This article describes limitations to the resultant set of policy (RSoP) planning mode when you try to use it across multiple forests.

_Original KB number:_ &nbsp; 910206

## Symptoms

You cannot use the RSoP planning mode to plan for scenarios that span forests in Windows Server 2003 and later versions. For example, you cannot plan for a scenario in which a user logs on to a workstation in Forest 1 from Forest 2. When you try to run RSoP planning mode in a cross-forest environment, you receive the following Group Policy error message:

> Cross forest planning mode scenarios are not currently supported.

## Cause

This issue occurs because RSoP planning mode does not support cross-forest scenarios. In many scenarios, RSoP cannot validate the information that is returned from a domain controller that is located in another forest. The Authenticated Users group must have read permissions for relevant policies to successfully read a particular policy in a cross-forest environment.
