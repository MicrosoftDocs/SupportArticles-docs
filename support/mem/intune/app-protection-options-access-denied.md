---
title: Access denied error in Intune App Protection tool
description: Describes an issue in which an Intune Service Administrator has no permission to access the Exchange Online and SharePoint Online options in the Intune mobile application management tool. Provides a resolution to grant the administrator Contributor permissions.
ms.date: 05/11/2020
ms.prod-support-area-path: App management
ms.reviewer: cbrito, mcopm
---
# Access Denied error when accessing Exchange Online and SharePoint Online options in Intune MAM tool

This article fixes an issue in which an Intune Service Administrator has no permission to access the **Exchange Online** and **SharePoint Online** options in the Intune mobile application management (MAM) tool.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4024708

## Symptoms

When an Intune Service Administrator tries to select the **Exchange Online** or **SharePoint Online** option under **Conditional Access** in the Intune mobile application management (Intune App Protection) tool, they receive an **Access Denied** error message.

## Cause

This issue occurs because the Intune Service Administrator lacks the **Contributor** permission to access the **Exchange Online** and **SharePoint Online** options.

## Resolution

To resolve this issue, the Global Administrator must grant the Intune Service Administrator **Contributor** permissions. To do this, follow these steps:

1. Sign in to [https://portal.azure.com](https://portal.azure.com), and then go to the **Intune App Protection** tool.
2. In the **Settings** pane under **Conditional Access**, click **Exchange Online**.
3. Under **Resource management**, click **Users**, and then click **Add**.
4. Under **Role**, click **Contributor**, select the user or group that you want to grant the **Contributor** permission to, and then click **Save**.
5. Have the Intune Service Administrator sign in to [https://portal.azure.com](https://portal.azure.com/) and confirm that they now have access to the **Exchange Online** and **SharePoint Online** options.
