---
title: The remote server returned an error (401) RBAC check failed when you manage disposition of data
description: Fixes an issue in which you can't manage disposition reviews from Microsoft Purview Records Management. 
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Records Management
  - CSSTroubleshoot
  - CI 157046
ms.reviewer: subansal; lindabr; meerak
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 05/05/2025
---

# "(401) RBAC check failed" error when trying to manage disposition reviews

## Symptoms

When you use the **Disposition** tab in **Microsoft Purview Records Management** in the Microsoft Purview portal to manage [disposition reviews](/microsoft-365/compliance/disposition), you receive the following error message:

> The remote server returned an error: (401) Rbac check failed.

## Cause

This error occurs if you don't have sufficient permission for disposition reviews, and the role-based access control (RBAC) check fails. Permissions in the Microsoft Purview portal are based on the RBAC permissions model.

## Resolution

Verify that the failure of the RBAC check causes the error. Reproduce the issue, and [capture the associated network activity logs](/microsoft-edge/devtools-guide-chromium/network/#log-network-activity) from Microsoft Edge. Then, check the network logs for the RBAC "401" error message.

If you see the error message, make sure that either you or the group that you belong to is part of the following role groups:

- Content Explorer Content Viewer
- Content Explorer List Viewer
- Microsoft Purview Records Management with the Disposition Management role
