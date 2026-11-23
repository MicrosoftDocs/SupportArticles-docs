---
title: We couldn't add member error when adding users to Teams
ms.author: meerak
author: Cloud-Writer
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams External and Guest Access\Teams External Federation
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Describes a workaround for adding members to Teams if you see the We couldn't add member error.
---

# Error "We couldn't add member" when adding users to Teams

## Summary

When you add an internal or external user to Microsoft Teams, you might see “We couldn't add member. We ran into an issue. Please try again later,” even though you can add the user directly to a Microsoft 365 group. This happens when `UsersPermissionToReadOtherUsersEnabled` is set to `False` in Microsoft Entra ID. Set it to `True` to allow the user to be added in Teams.

## Symptoms

When you add an internal or external member to Teams, you see the following error:

> "We couldn't add member. We ran into an issue. Please try again later."

However, members can be added directly to Microsoft 365 groups.

## Resolution

This issue occurs when the value **UsersPermissionToReadOtherUsersEnabled** is set to **False** in Microsoft Entra ID. To correct the issue, change this setting to **True**.
