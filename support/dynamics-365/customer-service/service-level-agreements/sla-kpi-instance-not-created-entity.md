---
title: SLA KPI instance isn't created on the entity
description: Provides a resolution for the issue where an SLA KPI instance isn't created on the entity in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# An SLA KPI instance isn't created on the entity

This article provides a resolution for the issue where a service-level agreement (SLA) KPI instance isn't created on the entity in Dynamics 365 Customer Service.

## Symptoms

An SLA KPI instance isn't created on the entity on which the SLA is enabled.

## Cause

SLA KPI instances aren't created because of one of the following reasons:

- SLA isn't applied.
- No SLA item is applicable.
- **SLA KPI Applicable From** is empty.
- Dependencies are disabled.

## Resolution

To solve this issue, use one of the following resolutions:

- If SLA isn't applied, verify that the SLA is being applied correctly on the entity. For more information, see [Apply SLAs](/dynamics365/customer-service/apply-slas).
- If no SLA item is applicable, verify that the entity satisfies the **Applicable when** condition for at least one of the SLA items of the applied SLA.
- If the **SLA KPI Applicable From** is empty, verify that the **Applicable From** date field of the KPI is filled for that entity.
- If dependencies are disabled, in the SLA form, activate notifications about any out-of-the-box component, if any.
