---
title: Users outside the Copilot Studio authors security group can access Copilot Studio
description: Learn how to identify, troubleshoot, and resolve issues with user access for users outside the Copilot Studio authors setting in Microsoft Copilot Studio.
ms.date: 09/09/2025
ms.reviewer: 
  - camogas
  - erickinser
  - v-shaywood
ms.custom: sap:Licensing
---

# Users outside the Copilot Studio authors security group can access Copilot Studio

This article provides clarification on the "Copilot Studio authors" setting and how to restrict user access to Copilot Studio.

## Issue

Customers often expect that assigning a security group to the "Copilot Studio authors" setting in the Power Platform Admin Center (PPAC) restricts access to only those users in that group. However, users outside the group continue to access
[copilotstudio.microsoft.com](https://copilotstudio.microsoft.com/) if they meet specific licensing conditions.

## Cause

The "Copilot Studio authors" setting is designed to grant access to users in the specified security group in a pay-as-you-go licensing scenario. It doesn't automatically revoke access from other users. 

## Solution

If you want to block user access to Copilot Studio, all the following conditions must be met: 

1.  The user isn't in the security group assigned to the "Copilot Studio authors" setting.

1.  The user doesn't have a Copilot Studio per-user license or trial license.

1.  The user doesn't have a Microsoft 365 Copilot license.

## Related information

- [Tenant settings](/power-platform/admin/tenant-settings)
