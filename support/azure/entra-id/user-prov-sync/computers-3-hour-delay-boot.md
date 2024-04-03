---
title: Microsoft Entra joined computers experience a three hours delay during boot if the workgroup name is the same as the on-premises AD domain NetBIOS name
description: This article describes the three hours delay during boot if the workgroup name is the same as the on-premises AD domain NetBIOS name.
ms.date: 07/21/2020
ms.reviewer: maweeras, ntuttle, arpadg, takondo, cleng, hiyazawa, genli
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync
---
# Microsoft Entra joined computers experience a three hours delay during boot

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4565997

## Symptoms  

Consider the following scenario:

1. You are using Microsoft Entra Connect to federate (synchronize) users from an on-premises Active Directory domain to Microsoft Entra ID.
2. The computer is Microsoft Entra joined, and the workgroup name is the same as the on-premises domain's NetBIOS name.
3. You have logged on to this computer with a federated user at least once.

In this case, the computer takes approximately three hours to progress to the logon screen when you restart the OS. During this time, you will see a black screen that displays an activity icon (a spinning circle of dots). Approximately three hours after starting, the startup process finishes, and the interactive logon screen is displayed and the user can log in without issues.

This slow startup experience is not dependent on the hardware configuration. Computers that have "excellent" hardware specifications can also experience this problem.

## Cause

This issue occurs because Windows unexpectedly evaluates a condition in which a wait time of 10,000 seconds is initiated. This timeout condition is manifested as a three-hour startup delay.

> [!NOTE]
> For reference, 10,000 seconds = 167 minutes = 2 hours 47 minutes.

## Resolution

To resolve this issue, use a workgroup name that does not match the NetBIOS name of the on-premises domain.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
