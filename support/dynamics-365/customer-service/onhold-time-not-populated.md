---
title: OnHold Time attribute isn't populated for Case for Unified Interface SLA
description: Provides a solution for when the OnHold Time attribute isn't populated for Case for Unified Interface SLA in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# OnHold Time attribute isn't populated for Case for Unified Interface SLA

This article provides a solution for when the OnHold Time attribute isn't populated for Case for Unified Interface SLA in Customer Service.

## Symptom

The **onholdtime** attribute to track the onHold duration for case at a case entity level doesn't get populated.

## Cause

In the Legacy SLA, the **onholdtime** attribute tracks the on-hold duration for the case at the case entity level. In the Unified Interface SLA, **Elapsed time** tracks the on-hold duration at the KPI instance level, since one case can have multiple KPIs with different pause conditions, and each SLA KPI instance might have a different calendar associated with it.

## Resolution

For Unified Interface SLAs, use the elapsedtime attribute to track onHold Duration at SLA KPI instance level.
