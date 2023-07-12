---
title: SLA Timer keeps running or expired prior to the failure time on Timer
description: Provides a resolution a resolution for the issue where SLA Timer keeps running or expired prior to the failure time on Timer.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 07/12/2023
---
# Updating SLA KPI instance's Failure and Warning time in the workflow is not a supported 

This article provides a resolution for an issue where SLA Timer keeps running or expired prior to the failure time on Timer.

## Symptoms

SLA Timer keeps running or expired prior to the failure time on Timer

## Cause

Updating SLA KPI instance's Failure and Warning time in the workflow is not a supported scenario.
Static flow (SLAInstanceMonitoringWarningAndExpiryFlow) is triggered only on the creation of SLA KPI instances, when failure and warning time updated for already existing KPI instances, static flow can't process as expected and it leads to unexpected behaviors.

## Resolution

To solve this issue, take the following step:

Custom Workflow and plugins can be used to cancel the existing KPI and triggering new KPI instead of updating Failure and Warning time.