---
title: String or binary data would be truncated error when activating SLA
description: Resolves an error message that occurs when you activate an SLA in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta, mpanduranga
ms.author: sdas
ms.date: 01/10/2024
---
# "String or binary data would be truncated" error when activating an SLA

This article provides a resolution for an error that occurs when you [activate a service-level agreement (SLA)](/dynamics365/customer-service/administer/define-service-level-agreements?tabs=customerserviceadmincenter#configure-actions-for-the-sla-item) in Microsoft Dynamics 365 Customer Service.

## Symptoms

When you activate an SLA, you receive the following error message:

> String or binary data would be truncated in table '{0}', column '{1}'. Truncated value: {2}" appears.

## Cause

The `MaxLength` property of the [ChangedAttributeList](/power-apps/developer/data-platform/reference/entities/slaitem#BKMK_ChangedAttributeList) attribute of an SLA entity has reached its limit of 4000. This might occur based on the number or name of the fields configured in the SLA conditions.

## Resolution

To solve this issue, simplify your existing SLA structure. Here's an example:

SLA 1 includes 10 SLA items. Create a new SLA named SLA 2. Transfer five SLA items from SLA 1 to SLA 2. You now have two SLAs, each containing five SLA items. This approach helps streamline and manage SLAs more effectively based on specific requirements.
