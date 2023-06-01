---
title: Case updation fails due to no SLA KPI instance exist if it is associated with active SLA.
description: Provides a resolution for the issue where case updating fails due to no SLA KPI instance exist.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# SLA KPI instance does not exist error when updating a Case

This article provides a resolution for the issue where case updating fails due to no SLAKPI instance exist.

## Symptoms

Error occur during case update when SLA KPI instance does not exist.

## Cause

This issue happens when active SLA is there, but no SLAItem’s ChangeAttributeList is not defined or NULL.

## Resolution

- If SLA is having SLAItems then Admin can self resolve this issue by reactivating SLA which should calculate ChangeAttributeList again.
- If SLA is not having any SLAItem then Admin can self resolve this issue by defining SLAItems and reactivating the SLA again.
