---
title: String or binary data would be truncated error when activating SLA
description: Resolves an error message that occurs when you activate an SLA in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/09/2024
---
# "String or binary data would be truncated" error when activating an SLA

This article provides a resolution for an error that occurs when you [activate a service-level agreements (SLA)](/dynamics365/customer-service/administer/define-service-level-agreements?tabs=customerserviceadmincenter#configure-actions-for-the-sla-item) in Microsoft Dynamics 365 Customer Service.

## Symptoms

When you activate an SLA, you receive the following error message:

> String or binary data would be truncated in table '{0}', column '{1}'. Truncated value: {2}" appears.

## Cause

Based on the number or name of the field configured in the SLA conditions, the [changedAttributeList](/power-apps/developer/data-platform/reference/entities/slaitem#BKMK_ChangedAttributeList) attribute of an SLA entity reaches the limit of the `MaxLength` property. The value of the `MaxLength` property of the `changedAttributeList` is **4000**.

## Resolution

To solve this issue, simplify your existing SLA structure. Here's an example:

SLA 1 includes 10 SLA items. Create a new SLA 2. From SLA 1, and transfer five SLA items to the new SLA 2. You now have two SLAs, each containing five SLA items. This approach helps streamline and manage SLAs more effectively based on specific requirements.
