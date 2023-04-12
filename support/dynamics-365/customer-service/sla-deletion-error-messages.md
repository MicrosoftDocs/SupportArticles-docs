---
title: Deletion of SLAs or SLA Items shows error messages in Unified Interface during solution upgrade or manual deletion
description: Provides a solution for when the deletion of SLAs or SLA Items shows error messages in Unified Interface during a solution upgrade or manual deletion in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Deletion of SLAs or SLA Items show error messages in Unified Interface during solution upgrade or manual deletion

This article provides a solution for when the deletion of SLAs or SLA Items shows error messages in Unified Interface during a solution upgrade or manual deletion.

## Symptom

The following two error messages are displayed:

Error message 1: "The object you tried to delete is associated with another object and cannot be deleted."

Error message 2: "SLAItem delete operation encountered some errors. The process is part of a managed solution and cannot be individually deleted. Uninstall the parent solution to remove the process. See log for more details."

## Cause

The first error occurs because in UCI SLA, the relationship between the SLA item and SLA KPI instances is set to "Restrict to Delete". The second error occurs because processes that are part of a managed solution can't be deleted. If you try to manually delete an SLA that is part of a managed solution and has flows configured, the error message appears.

## Resolution

There are a few resolution options.

### Resolution 1:

Instead of deleting the SLA, deactivate the SLA in your organization. If it's a part of a managed solution, then perform the following steps:

1. Deactivate the SLA in the source instance and add it to the solution.
1. Deactivate the same SLA in the target instance, and then apply the solution upgrade.

### Resolution 2:

You can first manually delete all the SLA-related entity records and SLA KPI instances, and then remove the SLA. Perform the following steps:

1. In your organization, go to **Advanced Find**, search **SLA KPI Instances**, and then select the **SLAItem.**
1. Select **Result**. The SLA KPI instances will be listed.
1. Select the required SLA KPI instances, and then select **Delete SLAKPIInstances**. This will also nullify the SLA KPI instances on the related records.

Even after deleting the reference records, if the error message, "SLAItem delete operation encountered some errors. The process is part of a managed solution and cannot be individually deleted. Uninstall the parent solution to remove the process; see log for more detail." appears, then apply the solution upgrade with SLA deleted from the upgrade solution.

### Resolution 3:

If the above resolution doesn’t work, contact Microsoft Support to request deletion of the SLA or SLA items.
