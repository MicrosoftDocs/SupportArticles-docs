---
title: Cannot find the Viva Connections app in the Teams admin center
description: Describes how to determine why the Viva Connections app can't be found in the Teams admin center and provide solutions.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting
ms.service: viva-connections
ms.custom: 
  - sap:Teams Admin Setup and Configuration
  - CI 169239
  - CSSTroubleshoot
ms.reviewer: bpeterse
ms.date: 06/06/2024
search.appverid: 
- MET150
---

# Can't find the Viva Connections app in the Teams admin center

## Symptoms

Your organization tries to [set up and launch Viva Connections](/viva/connections/guide-to-setting-up-viva-connections) on desktop and mobile devices. However, Teams administrators can't find the Viva Connections app by using the following steps:

1. Sign in to the [Microsoft Teams admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339).
1. Select **Teams apps** > **Manage apps**.
1. Search for *Viva Connections*.

## Cause

This issue may occur in the following situations:

- The display name (short name) of the Viva Connections app was changed by using the **Customize** option.
- There's an app provisioning issue that causes the app not to be found when searching.

## Resolution

To fix this issue, Teams administrators should use the following steps:

1. Open a new browser tab or window.
1. Browse to the following URL:  
   [https://admin.teams.microsoft.com/policies/manage-apps/d2c6f111-ffad-42a0-b65e-ee00425598aa](https://admin.teams.microsoft.com/policies/manage-apps/d2c6f111-ffad-42a0-b65e-ee00425598aa).
1. Verify that this URL takes you to the Viva Connections app overview page. If not, check whether Viva Connections is included in your Microsoft subscription. For more information, see the [full subscription comparison table](https://go.microsoft.com/fwlink/?linkid=2139145).

   **Note:** A SharePoint license is required.
1. On the Viva Connections app overview page, check the following settings in the **Details** section:

   - **Short name**: This is the display name of the Viva Connections app in your tenant. In the following example, it's **Contoso App**.
  
     :::image type="content" source="media/cant-find-app-in-teams-admin-center/app-details.png" alt-text="Screenshot of the app details.":::
   - **Short name from publisher**: This value should be **Viva Connections**.
   - **Publisher**: This value should be **Microsoft Corporation**.
1. In the Teams admin center, return to **Teams apps** > **Manage apps**.
1. Search for the Viva Connections app by using the short name that's identified in step 4.

   :::image type="content" source="media/cant-find-app-in-teams-admin-center/search-short-name.png" alt-text="Screenshot of the app search results.":::
