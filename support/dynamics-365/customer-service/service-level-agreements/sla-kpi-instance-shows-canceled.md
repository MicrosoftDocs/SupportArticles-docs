---
title: SLA KPI instance status shows as Canceled
description: Provides a resolution for the issue that occurs when you define the Applicable when or Applicable from changes and Success condition on the same attribute.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/28/2023
---
# The SLA KPI instance status shows as Canceled

This article provides a resolution for the issue where the service-level agreements (SLA) KPI instance status shows as **Canceled**.

## Symptoms

When you update the target record, so that the **Applicable when/from changes** condition is no more applicable, the SLA KPI status moves from one of the existing states of **In progress**, **Succeeded**, **Nearing Non-compliance**, or **Expired** to the **Canceled** state. The SLA KPI instance is canceled on the second evaluation because the **Applicable when** condition is no longer met. Consider the following scenario in which you create an SLA with the following conditions and set it as the default SLA.

- **Applicable when/from changes**: The case status equals active.
- **Success condition**: The case status equals resolved.

1. Create a case. The case status is set to **Active** by default, the SLA is applied and the SLA timer starts.
2. Resolve the case. The case status is set to **Resolved**, and the SLA is reevaluated for the **Applicable when/from changes** condition. The SLA KPI instance status will be set to **Canceled**.

## Cause

When you define the **Applicable when/from changes** and **Success condition** on the same attribute, such as **case status**, one of the criteria might not be met, and the SLA KPI instance status will be **Canceled**.

> [!NOTE]
> When you define the conditions on the same attribute, a recommendation message is displayed that suggests you don't use the same attribute.

## Resolution

In such scenarios, it's recommended that you don't define the **Applicable when/from changes** and **Success condition** on the same attribute.
