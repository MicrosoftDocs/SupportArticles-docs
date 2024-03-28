---
title: Cannot save when creating user in User Setup
description: The Save button is unavailable when you try to create a user in the User Setup window in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# The Save button is unavailable when you try to create a user in the User Setup window

This article provides a resolution for the issue that you can't save a new user in the User Setup window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860797

## Symptoms

When you try to create a user in the User Setup window in Microsoft Dynamics GP, the **Save** button is unavailable.

## Cause

This problem occurs if you sign in to Microsoft Dynamics GP by using a user ID that does not have rights to create a new user.

## Resolution

To resolve this problem, sign in  to Microsoft Dynamics GP by using the **sa** user ID or the **DYNSA** user ID.
