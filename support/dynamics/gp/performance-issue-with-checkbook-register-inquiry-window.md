---
title: Performance issue with Checkbook Register Inquiry window
description: Provides a resolution for the performance issue with Checkbook Register Inquiry window in Microsoft Dynamics GP 2016 R2.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Performance issue with Checkbook Register Inquiry window in Microsoft Dynamics GP 2016 R2

This article provides a resolution for the performance issue that occurs when you select a Checkbook ID in the Checkbook Register Inquiry window in Microsoft Dynamics GP 2016 R2.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 4018103

## Symptoms

In Microsoft Dynamics GP 2016 R2, when you go to the Checkbook Register Inquiry window (**Inquiry** > **Financial** > **Checkbook Register**) and select a Checkbook ID, the systems stops responding.

## Workaround

The workaround is to enter a DATE RANGE in the **To** and **From** fields, before you select a Checkbook ID.
