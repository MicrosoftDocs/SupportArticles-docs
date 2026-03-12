---
title: Schedule board shows a blank page or fails to load
description: Resolves issues where the Dynamics 365 Field Service schedule board displays a blank page or fails to load.
author: mkelleher-msft
ms.author: mkelleher
ms.reviewer: puneetsingh
ms.date: 03/12/2026
ms.custom: sap:Schedule Board
---

# Schedule board shows a blank page or fails to load

This article helps dispatchers and administrators resolve issues where the schedule board in Microsoft Dynamics 365 Field Service displays a blank page, doesn't load, or shows incomplete content.

## Symptoms

When you open the schedule board in Dynamics 365 Field Service, you experience one or more of the following issues:

- The schedule board area displays a blank white page with no resources or bookings.
- When you select **Open in new window** from the schedule board, a blank page appears instead of the board content.
- The schedule board partially loads but then shows an error or remains incomplete.
- The following error message may appear in the browser console:

  > Something went wrong. Please try again or contact your administrator.

## Cause

### Cause 1: Browser cache or cookies are corrupted

Outdated or corrupted cached data can prevent the schedule board control from loading correctly. This is the most common cause, especially after a solution update.

### Cause 2: Unsupported or outdated browser

The schedule board requires a modern Chromium-based browser. Internet Explorer and older Microsoft Edge versions aren't supported.

### Cause 3: Missing or incorrect security roles

The user doesn't have the required privileges to access schedule board entities (`BookableResource`, `BookableResourceBooking`, `Resource Requirements`).

### Cause 4: Third-party browser extensions

Browser extensions such as ad blockers or privacy tools can interfere with the schedule board's JavaScript resources.

## Resolution

### Resolution for Cause 1: Clear browser cache

1. Close all Dynamics 365 tabs in your browser.
2. Press **Ctrl+Shift+Delete** to open the browser's **Clear browsing data** dialog.
3. Select **Cached images and files** and **Cookies and other site data**.
4. Select **Clear data**, then reopen the Dynamics 365 Field Service app (for example, `https://<your-org>.crm.dynamics.com`) and go to **Scheduling** > **Schedule Board**.

> [!NOTE]
> If you're using the schedule board embedded in a model-driven app, also try pressing **Ctrl+F5** on the schedule board page to force a hard refresh.

### Resolution for Cause 2: Use a supported browser

Ensure you're using one of the following supported browsers:

- Microsoft Edge (Chromium-based, version 79 or later)
- Google Chrome (latest version)

For more information, see the [web browser requirements](/power-platform/admin/web-application-requirements) for Dynamics 365.

### Resolution for Cause 3: Verify security roles

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select **Manage**, and then, select your environment.
2. Select **Settings** (gear icon) > **Users + permissions** > **Users**.
3. Select the affected user and review their security roles.
4. Ensure the user has at least the **Field Service - Dispatcher** or **Field Service - Administrator** role, which includes the required schedule board privileges.

If you use custom security roles, verify the user has **Read** privilege on the following tables:

- Bookable Resource (`bookableresource`)
- Bookable Resource Booking (`bookableresourcebooking`)
- Resource Requirement (`msdyn_resourcerequirement`)
- Schedule Board Setting (`msdyn_scheduleboardsetting`)

### Resolution for Cause 4: Disable browser extensions

1. Open the schedule board in a private or incognito browser window.
2. If the schedule board loads correctly, a browser extension is likely interfering.
3. Disable extensions one by one to identify the problematic extension.

## More information

- [Use the schedule board in Field Service](/dynamics365/field-service/work-with-schedule-board)
- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
