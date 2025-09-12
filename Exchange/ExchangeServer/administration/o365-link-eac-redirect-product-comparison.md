---
title: Microsoft 365 link in on-premises EAC goes to product comparison
description: Describes a scenario where the Microsoft 365 link in the on-premises Exchange admin center takes you to a page that compares plans and pricing for Microsoft 365 instead of to the Exchange admin center in Microsoft 365. Provides a solution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Permissions\Need help with RBAC, Role Groups, Role Assignment policy
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---

# Microsoft 365 link in on-premises EAC goes to product comparison, not Exchange admin center

## Problem

When a user clicks the Microsoft 365 link in the Exchange admin center (EAC) in Exchange Server 2016 or Exchange Server 2013, the user isn't routed to the Exchange admin center in Microsoft 365. Instead, they are redirected to [https://go.microsoft.com/fwlink/p/?LinkId=258351](https://go.microsoft.com/fwlink/p/?linkid=258351), which is a page that compares plans and pricing for Microsoft 365 services.

## Cause

The on-premises Exchange user account that was used to sign in to the EAC doesn't have sufficient permissions. For example, this occurs if the user is a member of the Recipient Management role group.

## Solution

Add the user to at least the View-Only Organization Management role group or the Organization Management role group. For more information, see [Manage role group members](/Exchange/permissions/role-group-members).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
