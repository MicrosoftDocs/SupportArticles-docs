---
title: Help desk operators can't perform remote tasks in Microsoft Intune
description: Describes an Initiating Factory reset failed error that occurs when Intune help desk operators perform remote tasks.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Device Actions\Remote Help
ms.reviewer: kaushika
---
# Initiating Factory reset failed error when help desk operators perform remote tasks in Intune

This article fixes an issue in which help desk operators can't perform remote tasks in Microsoft Intune.

## Symptom

When help desk operators perform remote tasks in Microsoft Intune, they receive the following error message:

> Initiating Factory reset failed

## Cause

The issue occurs if the **Help Desk Operator** role is assigned to dynamic device groups.

## Solution

To resolve the issue, assign the **Help Desk Operator** role to user groups. For more information about roles in Intune, see [Role-based access control (RBAC) with Microsoft Intune](/mem/intune/fundamentals/role-based-access-control).
