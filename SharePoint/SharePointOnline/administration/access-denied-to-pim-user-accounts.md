---
title: Error when accessing SharePoint or OneDrive after role activation in PIM
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 02/24/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Sharing, Permissions, and Authorization\Access Denied
  - CI 119405
  - CI 4072
  - CSSTroubleshoot
ms.reviewer: prbalusu; ilyal; meerak
description: Provides a resolution to an Access denied error when you try to access SharePoint or OneDrive after activating a role.
---

# Error when accessing SharePoint or OneDrive after role activation in PIM

## Symptoms

You receive an "Access denied" error message when you try to access SharePoint or OneDrive after you activate your SharePoint Administrator role assignment by using Microsoft Entra Privileged Identity Management (PIM).

## Cause

This issue might occur if you were provided just-in-time access to the SharePoint Administrator role by using [PIM for groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups). In this scenario, the role is assigned to a group, and you’re made eligible to activate membership to the group. If this method is used, permissions can take up to 24 hours to propagate. Therefore, you can expect to experience a delay before you can use SharePoint or OneDrive.

## Resolution

To make sure that you have access to SharePoint and OneDrive as soon as possible after you activate your role assignment, a Privileged Role Administrator should use one of the following methods that use [PIM for Microsoft Entra](/entra/id-governance/privileged-identity-management/pim-how-to-activate-role) roles:

- [Make you eligible for the role](/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user#assign-a-role) without using a group.
- [Add you to a group](/entra/fundamentals/how-to-manage-groups#create-a-basic-group-and-add-members), and then make the group eligible for the role.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
