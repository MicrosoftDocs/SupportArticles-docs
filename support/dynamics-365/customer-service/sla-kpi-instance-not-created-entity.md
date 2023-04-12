---
title: SLA KPI instance isn't created on the entity
description: Provides a solution for when an SLA KPI instance isn't created on the entity in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# SLA KPI instance isn't created on the entity

This article provides a solution for when an SLA KPI instance isn't created on the entity.

## Symptom

SLA KPI instance isn't created on the entity on which the SLA is enabled.

## Cause

SLA KPI instances aren't created because of one of the following reasons:

- SLA isn't applied.

- No SLA Item is applicable.

- SLA KPI Applicable From is empty.

- Dependencies are disabled.

## Resolution 

- SLA isn't applied: Verify if SLA is being applied correctly on the entity. More information: [Apply SLAs](apply-slas.md#apply-slas)

- No SLA Item is applicable: Verify whether the entity satisfies the Applicable when condition for at least one of the SLA items of the applied SLA.

- SLA KPI Applicable From is empty: Verify whether the **Applicable From** Date Field of KPI is filled for that entity.

- Dependencies are disabled: In the SLA form, activate notifications about any out of the box component, if any.
