---
title: The remote server returned an error (401) Rbac check failed when you manage disposition of data
description: Fixes an issue in which you can't manage disposition reviews from Records Management because you don't have sufficient permission.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 157046
ms.reviewer: subansal; lindabr; meerak
appliesto:
- Microsoft 365
search.appverid: MET150
---

# "The remote server returned an error: (401) Rbac check failed" error when trying to manage disposition reviews

## Symptoms

When you use the Disposition tab from Records Management in the Microsoft 365 compliance center to manage [disposition reviews](/microsoft-365/compliance/disposition?view=o365-worldwide), you receive the following error message:

> The remote server returned an error: (401) Rbac check failed.

## Cause

This issue occurs because you don't have sufficient permission for disposition reviews, and the role-based access control (RBAC) check fails. Permissions in the compliance center are based on the RBAC permissions model. 

## Resolution

You can [capture the network activity logs](/microsoft-edge/devtools-guide-chromium/network/#log-network-activity) from Microsoft Edge while reproducing this issue. Then, check and make sure the log contains the RBAC (401) related error message.

To fix this issue, make sure you have the **Disposition Management** role (included in the **Records Management** default role group), and you're a member of the following role groups:

- Content Explorer Content Viewer
- Content Explorer List Viewer
