---
title: Fix schedule board version mismatch errors
description: Resolve schedule board version mismatch errors in Dynamics 365 Field Service caused by incompatible Field Service and Universal Resource Scheduling versions.
ms.date: 04/27/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood
ms.custom: sap:Schedule Board\Issues with usability
---

# Schedule board errors because of version mismatches

## Summary

This article helps administrators resolve errors on the [schedule board](/dynamics365/field-service/work-with-schedule-board) in [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) that are caused by version mismatches between Field Service and [Universal Resource Scheduling (URS)](/dynamics365/field-service/universal-resource-scheduling-for-field-service) components.

These errors occur if the Universal Resource Scheduling (URS) solution version doesn't support a setting or API that the installed Field Service version expects.

## Symptoms

When you open or interact with the schedule board, you experience one or more of the following issues:

- You receive an error message that references unrecognized properties or unsupported settings.
- The schedule board doesn't load, or shows a script error.
- Schedule board features behave unexpectedly after a partial update of Field Service or URS.

## Cause

Dynamics 365 Field Service depends on URS for its scheduling capabilities. Each Field Service release is designed to work together with a specific minimum URS version. If the two components are out of sync, for example after a partial update or a failed update, the schedule board might reference settings or APIs that the installed URS version doesn't recognize.

Common scenarios that cause version mismatches include:

- **Partial solution update**: You update Field Service but not URS, or vice versa.
- **Failed update**: An update started but didn't finish successfully. This condition pushes one component to a newer version than the other.
- **Manual solution import**: You manually import a solution at a version that's incompatible with the other installed components.

## Solution

To fix the error, complete the following sections in the given order. Check the schedule board after each section to see whether the error is resolved.

### Verify and align solution versions

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Select **Manage** > **Environments**.
1. Select your Field Service environment.
1. Go to **Resources** > **Dynamics 365 apps**.
1. Find the installed versions of these solutions:
   - **Dynamics 365 Field Service**
   - **Universal Resource Scheduling** (also listed as **msdyn_Scheduling**)
1. Compare the versions against the [Field Service version history](/dynamics365/field-service/version-history) to verify that they're compatible.
1. If the versions don't match, select **Update** next to the outdated solution to bring it to a compatible version.

> [!NOTE]
> Always update URS before or at the same time as Field Service to maintain compatibility. Don't update Field Service to a version that requires a newer URS than what's installed.

### Retry a failed update

If a previous update failed partway through:

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Select **Manage** > **Environments**.
1. Select your Field Service environment.
1. Go to **Resources** > **Dynamics 365 apps**.
1. Check for any solutions that show a status of **Install failed** or **Update failed**.
1. Select **Retry**.
1. After the update finishes, refresh the schedule board, and check whether the error no longer appears.

### Clear the browser cache

After you update the solutions, cached assets from the previous version can cause errors. To prevent this issue, follow these steps:

1. Clear the browser cache and cookies for your Dynamics 365 domain.
1. Close all browser tabs that have Dynamics 365 open.
1. Reopen the schedule board in a new browser session.

## Related content

- [Update Field Service](/dynamics365/field-service/update-field-service)
- [Manage Dynamics 365 apps in the Power Platform admin center](/power-platform/admin/manage-apps)
- [Schedule board is slow to load or experiences extreme latency](schedule-board-performance.md)
- [Schedule board shows a blank page or fails to load](schedule-board-not-loading.md)
