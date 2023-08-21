---
title: Deleting SLAs or SLA items shows an error during solution upgrade or manual deletion
description: Provides a resolution for the issue where the deletion of SLAs or SLA items shows error messages in Unified Interface during a solution upgrade or manual deletion in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Deleting SLAs or SLA items shows an error in Unified Interface during a solution upgrade or manual deletion

This article provides a resolution for the issue where deleting service-level agreements (SLAs) or SLA items shows an error message in Unified Interface during a solution upgrade or manual deletion.

## Symptoms

When you try to delete SLAs or SLA items during a solution upgrade or manual deletion, one of the following error messages occurs:

> The object you tried to delete is associated with another object and cannot be deleted.

> SLAItem delete operation encountered some errors. The process is part of a managed solution and cannot be individually deleted. Uninstall the parent solution to remove the process. See log for more details.

## Cause

The first error message occurs because, in Unified Interface SLA, the relationship between the SLA item and SLA KPI instances is set to "Restrict to Delete." The second error message occurs because processes that are part of a managed solution can't be deleted. If you try to manually delete an SLA that is part of a managed solution and has flows configured, the error message appears.

## Resolution 1

Instead of deleting the SLA, deactivate the SLA in your organization. If it's part of a managed solution, then take the following steps:

1. Deactivate the SLA in the source instance and add it to the solution.
1. Deactivate the same SLA in the target instance and then apply the solution upgrade.

## Resolution 2

You can first manually delete all the SLA-related entity records and SLA KPI instances and then remove the SLA. Here are the steps:

1. In your organization, go to **Advanced Find**, search for *SLA KPI Instances*, and then select **SLAItem**.
1. Select **Result**. The SLA KPI instances will be listed.
1. Select the required SLA KPI instances, and then select **Delete SLAKPIInstances**. This will also nullify the SLA KPI instances on the related records.

Even after deleting the reference records, if the error message "SLAItem delete operation encountered some errors. The process is part of a managed solution and can't be individually deleted. Uninstall the parent solution to remove the process. See log for more details" shows, then apply the solution upgrade with the SLA deleted from the upgrade solution.

## Resolution 3

If the above resolution doesn’t work, contact Microsoft Support to request the deletion of the SLA or SLA items.
