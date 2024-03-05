---
title: SLA KPI instance isn't created on the entity
description: Provides a resolution for the issue where an SLA KPI instance isn't created on the entity in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta, v-psuraty
ms.author: mpanduranga
ms.date: 03/05/2024
---
# An SLA KPI instance isn't created on the entity

This article provides a resolution for an issue where a service-level agreement (SLA) KPI instance isn't created on the entity in Microsoft Dynamics 365 Customer Service.

## Symptoms

An SLA KPI instance isn't created on the entity on which the SLA is enabled.

## Resolution

Based on the specific reason for the issue, you can select the most appropriate solution.

- SLA isn't applied.

  If SLA isn't applied, verify that the SLA is being applied correctly on the entity. For more information, see [Apply SLAs](/dynamics365/customer-service/apply-slas).
- No SLA item is applicable.

  If no SLA item is applicable, verify that the entity satisfies the **Applicable when** condition for at least one of the SLA items of the applied SLA.
- **SLA KPI Applicable From** is empty.

  If the **SLA KPI Applicable From** is empty, verify that the **Applicable From** date field of the KPI is filled for that entity.
- Dependencies are disabled.

  If dependencies are disabled, in the SLA form, activate notifications about any out-of-the-box component, if any.
- The contact record on the regarding record has same text but a different GUID.

  If the condition used in **Applicable When** uses a lookup field, verify that the GUID of the lookup field matches with the GUID of the contact in the **Applicable When** condition.
