---
title: Schedule board errors due to version mismatches in Dynamics 365 Field Service
description: Resolve version mismatch errors on the Dynamics 365 Field Service schedule board caused by incompatible Field Service and Universal Resource Scheduling components.
ms.date: 04/27/2026
ms.reviewer: mkelleher, puneetsingh
ms.custom: sap:Schedule Board\Issues with usability
---

# Schedule board errors caused by version mismatches

## Summary

This article helps administrators resolve errors on the [schedule board](/dynamics365/field-service/work-with-schedule-board) in [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) that are caused by version mismatches between Field Service and Universal Resource Scheduling (URS) components.

These errors occur when the URS solution version doesn't support a setting or API that the installed Field Service version expects.

## Symptoms

When you open or interact with the schedule board, you experience one or more of the following issues:

- An error message that references unrecognized properties or unsupported settings.
- The schedule board fails to load or displays a script error.
- Schedule board features behave unexpectedly after a partial update of Field Service or URS.

## Cause

Dynamics 365 Field Service depends on Universal Resource Scheduling (URS) for its scheduling capabilities. Each Field Service release is designed to work with a specific minimum URS version. When the two components are out of sync - for example, after a partial update or a failed update - the schedule board can reference settings or APIs that the installed URS version doesn't recognize.

Common scenarios that lead to version mismatches include:

- **Partial solution update**: You updated Field Service but not URS, or vice versa.
- **Failed update**: An update started but didn't complete successfully, leaving one component at a newer version than the other.
- **Manual solution import**: You manually imported a solution at a version that's incompatible with the other installed components.

## Solution 1: Verify and align solution versions

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your environment.
    1. Go to **Manage**.
    1. Select **Environments**.
    1. Select your environment that has Field Service in it.
1. Go to **Resources** > **Dynamics 365 apps**.
1. Find the installed versions of these solutions:
   - **Dynamics 365 Field Service**
   - **Universal Resource Scheduling** (also listed as *msdyn_Scheduling*)
1. Compare the versions against the [Field Service version history](/dynamics365/field-service/version-history) to confirm they're compatible.
1. If the versions don't match, select **Update** next to the outdated solution to bring it to a compatible version.

> [!NOTE]
> Always update URS before or at the same time as Field Service to maintain compatibility. Don't update Field Service to a version that requires a newer URS than what's installed.

## Solution 2: Retry a failed update

If a previous update failed partway through:

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your environment.
    1. Go to **Manage**.
    1. Select **Environments**.
    1. Select your environment that has Field Service in it.
1. Go to **Resources** > **Dynamics 365 apps**.
1. Check for any solutions that show a status of **Install failed** or **Update failed**.
1. Select **Retry** to reattempt the installation.
1. After the update completes, refresh the schedule board and confirm the error no longer appears.

## Solution 3: Clear the browser cache

After updating solutions, cached assets from the previous version can cause errors.

1. Clear the browser cache and cookies for your Dynamics 365 domain.
1. Close all browser tabs that have Dynamics 365 open.
1. Reopen the schedule board in a new browser session.

## Related content

- [Update Field Service](/dynamics365/field-service/update-field-service)
- [Field Service version history](/dynamics365/field-service/version-history)
- [Schedule board is slow to load or experiences extreme latency](schedule-board-performance.md)
- [Schedule board shows a blank page or fails to load](schedule-board-not-loading.md)
