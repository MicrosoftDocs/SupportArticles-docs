---
title: Schedule Board not loading in Dynamics 365 Field Service
description: Resolve problems that affect the Dynamics 365 Field Service schedule board displaying a blank page or not loading. Learn troubleshooting steps to fix the problems.
ms.date: 03/16/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood
ms.custom: sap:Schedule Board\Issues with usability
---

# Schedule board shows a blank page or doesn't load

## Summary

This article helps dispatchers and administrators resolve problems in which the [schedule board](/dynamics365/field-service/work-with-schedule-board) in Microsoft [Dynamics 365 Field Service](/dynamics365/field-service/overview) displays a blank page, doesn't load, or shows incomplete content. Common causes include corrupted browser cache or cookies, an unsupported or outdated browser, missing [security role](/dynamics365/field-service/security-permissions) privileges, and third-party browser extensions that block JavaScript resources. The troubleshooting steps in this article cover clearing cached data, verifying browser compatibility, checking user security roles in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), and isolating extension conflicts.

## Symptoms

When you open the schedule board in Dynamics 365 Field Service, you experience one or more of the following problems:

- The schedule board area displays a blank white page without any resources or bookings.
- When you select **Open in new window** from the schedule board, a blank page appears instead of the board content.
- The schedule board partially loads but then shows an error or remains incomplete.
- The following error message might appear in the browser console:

  > Something went wrong. Please try again or contact your administrator.

## Cause: Browser cache or cookies are corrupted

Outdated or corrupted cached data can prevent the schedule board control from loading correctly. This problem is especially common after a solution update.

### Solution

1. Close all Dynamics 365 tabs in your browser.
1. Select <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Delete</kbd> to open the browser's **Clear browsing data** dialog box.
1. Select **Cached images and files** and **Cookies and other site data**.
1. Select **Clear data**.
1. Reopen the Dynamics 365 Field Service app (for example, `https://<YourOrg>.crm.dynamics.com`), and go to **Scheduling** > **Schedule Board**.

> [!NOTE]
> If you use the schedule board embedded in a model-driven app, also try selecting <kbd>Ctrl</kbd>+<kbd>F5</kbd> on the schedule board page to force a hard refresh.

## Cause: Unsupported or outdated browser

The schedule board requires a modern Chromium-based browser. Internet Explorer and older Microsoft Edge versions aren't supported.

### Solution

Make sure that you use one of the following supported browsers:

- Microsoft Edge (Chromium-based, version 79 or later)
- Google Chrome (latest version)

## Cause: Missing or incorrect security roles

The user doesn't have the required [security role](/dynamics365/field-service/security-permissions) privileges to access schedule board entities (`BookableResource`, `BookableResourceBooking`, or `Resource Requirements`).

### Solution

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select **Manage**, and then select your environment.
1. Select **Settings** > **Users + permissions** > **Users**.
1. Select the affected user, and review their security roles.
1. Make sure that the user has at least the _Field Service - Dispatcher_ or _Field Service - Administrator_ role. The Administrator role includes the required schedule board privileges.

If you use [custom security roles](/power-platform/admin/security-roles-privileges), check that the user has _Read_ privilege on the following tables:

- Bookable Resource (`bookableresource`)
- Bookable Resource Booking (`bookableresourcebooking`)
- Resource Requirement (`msdyn_resourcerequirement`)
- Schedule Board Setting (`msdyn_scheduleboardsetting`)

## Cause: Third-party browser extensions

Browser extensions such as ad blockers or privacy tools can interfere with the schedule board's JavaScript resources.

### Solution

1. Open the schedule board in an InPrivate or incognito browser window.
1. If the schedule board loads correctly, a browser extension is likely interfering.
1. Disable extensions one by one to identify the problematic extension.

## Related content

- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
