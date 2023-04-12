---
title: SLA KPI instance status shows as canceled
description: Provides a solution for when the SLA KPI instance status shows as canceled in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# SLA KPI instance status shows as canceled

This article provides a solution for when an SLA KPI instance status shows as canceled.

## Symptom

When you update the target record so that **Applicable when** condition is no more applicable, the SLA KPI status moves from one of the existing states of **In progress**, **Succeeded**, **Nearing non compliance**, or **Expired** to the **Canceled** state. The SLA KPI instance is canceled on the second evaluation because the **Applicable when** condition is no longer met. Consider the following scenario in which you create an SLA with the following conditions and set it as the default SLA.

- **Applicable when:** Case status equals active
- **Success condition:** Case status equals resolved

1. Create a case. The case status is set to **Active** by default, the SLA is applied, and the SLA timer starts.

2. Resolve the case. The case status is set to **Resolved**, and the SLA is reevaluated for the **Applicable when** condition. The SLA KPI instance status will be set to **Canceled**.

## Cause

When you define the **Applicable when** and **Success condition** on the same attribute, such as **case status**, one of the criteria might not be met, and the SLA KPI instance status will be canceled.

> [!NOTE]
> When you define the conditions on the same attribute, a recommendation message is displayed that suggests you to not use the same attribute.

## Resolution

In such scenarios, we recommend that you don't define the **Applicable when** and **Success condition** on the same attribute.
