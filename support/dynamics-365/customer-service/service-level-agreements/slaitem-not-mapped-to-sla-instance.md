---
title: SLA instances associated with a case don't have mapped SLA item in Dynamics 365 Customer Service
description: Solves the errors that occur when updating legacy cases and entities in Microsoft Dynamics 365 Customer Service.
ms.date: 06/05/2024
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.custom: sap:Service Level Agreements
---
# Can't fill an SLA item for the SLA instances associated with the entity or case

This article provides a resolution for an issue where the service-level agreement (SLA) instances associated with the entity or case records don't have an SLA item ID filled in Microsoft Dynamics 365 Customer Service.

## Symptoms

You can't update cases and entities associated with a legacy SLA in a Unified Interface SLA, and you receive one of the following error messages:

- > System.NullReferenceException: Object reference not set to an instance of an object.  
  > at Microsoft.Dynamics.SLAManagement.Plugins.SLAInstanceService.GetSLAInstance(String regardingId, Guid slaItemId).

- > Exception occured in SLAInstance management custom action:  
  > Microsoft.Xrm.Sdk.InvalidPluginExecutionException: The SLA KPI instance associated with this entity record does not have the SLA item linked to it.

## Cause

This issue occurs because the legacy SLA instances are still applied to the case but aren't in the **Cancelled** status.

## Resolution 1

The related legacy SLAs can be set to the **Active** state and then deactivated after all the related `slakpiinstances` reach a terminal state that is either succeeded or expired.

Make sure that new entity records use the new Unified Interface SLAs. For custom logic, for example, workflows or plugins, refer to Unified Interface SLAs. Set the default SLAs option to Unified Interface SLAs, so that legacy SLAs aren't applied to the new entity records.

For more information, see [Apply SLAs](/dynamics365/customer-service/administer/apply-slas).

## Resolution 2

To solve this issue, take the following steps:

1. Check in test CRM instance whether the record updates that get the error have SLA instances with no SLA item filled.

    You can search for `slakpiinstances` records in **Advanced Find** by applying the filter for *SLA item is null*.

2. If the SLA items are no longer present on `slakpiinstances`, the current mitigation would be either to update the status of `slakpiinstances` to **Cancelled** or to delete `slakpiinstances`. You can also update the SLA item ID.

3. Follow the mitigation steps on test or lower environments where the issue is reproduced, and after confirmation, try them on the affected environment.

> [!NOTE]
> This resolution applies only to legacy records that are getting errors. If newly created records also get this error, contact [Microsoft support](https://dynamics.microsoft.com/support/) for further assistance.
