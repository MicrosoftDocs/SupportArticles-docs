---
title: Error occurs when saving folder-level tracking mapping
description: An error occurs when trying to save a folder-level tracking mapping in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# An error occurs when trying to save a folder-level tracking mapping in Microsoft Dynamics 365

This article provides a resolution for the issue that you may receive an error when trying to save a folder-level tracking mapping in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4510948

## Symptoms

When you try to save a folder-level tracking mapping in Microsoft Dynamics 365, you encounter the following error:

> An error occurred while saving the Exchange folder and Dynamics 365 mappings.

## Cause

This error can occur if the user does not have sufficient privileges for the Mailbox Auto Tracking Folder entity.

## Resolution

To fix this issue, follow these steps:

1. Access the Microsoft Dynamics 365 web application as a user with the System Administrator security role.
2. Navigate to **Settings**, **Security**, **Security Roles**.
3. Open the security role assigned to the user encountering this issue.
4. Select the **Business Management** tab.
5. Verify the role includes User level access for **Create**, **Read**, **Write**, and **Append** on the **Mailbox Auto Tracking Folder** entity.
6. Select the **Save** button.
