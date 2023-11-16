---
title: Resultant Set of Policy (RSoP) planning mode is not supported in a cross-forest scenario
description: Discusses a limitation to RSoP planning mode in a multiple-forest scenario.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Resultant Set of Policy (RSoP) planning mode is not supported in a cross-forest scenario

This article describes limitations to the resultant set of policy (RSoP) planning mode when you try to use it across multiple forests.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 910206

## Symptoms

You cannot use the RSoP planning mode to plan for scenarios that span forests in Windows Server 2003 and later versions. For example, you cannot plan for a scenario in which a user logs on to a workstation in Forest 1 from Forest 2. When you try to run RSoP planning mode in a cross-forest environment, you receive the following Group Policy error message:

> Cross forest planning mode scenarios are not currently supported.

## Cause

This issue occurs because RSoP planning mode does not support cross-forest scenarios. In many scenarios, RSoP cannot validate the information that is returned from a domain controller that is located in another forest. The Authenticated Users group must have read permissions for relevant policies to successfully read a particular policy in a cross-forest environment.
