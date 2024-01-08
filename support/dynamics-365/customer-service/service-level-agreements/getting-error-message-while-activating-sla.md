---
title: Error while activating SLA
description: Provides a resolution for the issue that occurs while activating SLAs.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/05/2023
---
# Error while activating SLA

This article provides a resolution for the issue that occurs while activating service-level agreements (SLAs).

## Symptoms

Error message "String or binary data would be truncated in table '{0}', column '{1}'. Truncated value: {2}" appears while activating an SLA.

## Cause

The attribute "changedAttributeList" of an SLA entity reaches the limit of field MAXLENGTH based on the number or name of the field configured in the SLA conditions. MAXLENGTH of changedAttributeList is 4000.

## Resolution

Simplify your existing SLA structure. Here's an example:

SLA 1 includes 10 SLA items. Create a new SLA 2. From SLA 1, transfer 5 SLA items to the new SLA 2. You now have two SLAs, each containing 5 SLA items. This approach helps streamline and manage SLAs more effectively based on specific requirements.
