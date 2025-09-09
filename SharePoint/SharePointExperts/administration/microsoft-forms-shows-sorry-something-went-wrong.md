---
title: Microsoft Forms shows Sorry, something went wrong
description: This article explains how to resolve the Microsoft Forms error "Sorry, something went wrong".
author: Cloud-Writer
ms.author: meerak
ms.reviewer: remcgurk
ms.date: 12/17/2023
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\InfoPath Forms Service
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - Microsoft Forms
---

# Microsoft Forms shows "Sorry, something went wrong"

## Symptoms

- Microsoft Forms shows the following error for all users in a Microsoft 365 tenant:  
  > **Sorry, something went wrong.**
- Forms within Teams shows the following error for all users in a Microsoft 365 tenant:  
  > **Contact the form owner’s administrator to let them know there’s an issue in the Forms product configuration.**
- Polls in Team meetings show the following error for all users in a Microsoft 365 tenant:  
  > **An error has occurred. Please try again.**

You may see the following error in a web traffic trace captured when the error occurs:

> **Required resource is disabled. Inner Message: AADSTS500014: The service principal for resource 'https://lists.office.com' is disabled. This indicates that a subscription within the tenant has lapsed, or that the administrator for this tenant has disabled the application, preventing tokens from being issued for it.**

## Resolution

To resolve this issue, enable the **Office Hive / CollabDBService** service for Microsoft Forms with the following steps:

1. Sign in to [Microsoft Azure](https://portal.azure.com/).
2. In the left pane, select **Microsoft Entra ID**.
3. Select **Enterprise Applications**.
4. Select the **X** next to the **Application Type == EnterpriseApplications** option to remove the filter.
5. In the **Search** field, type **Office Hive**.
6. Select **Office Hive** in the result list.
7. Under **MANAGE**, select **Properties**.
8. For the **Enabled for users to sign-in** option, select **Yes**, and then click **Save**.

For more information, see [Turn off or turn on Microsoft Forms](https://support.office.com/article/turn-off-or-turn-on-microsoft-forms-8dcbf3ab-f2d6-459a-b8be-8d9892132a43).
