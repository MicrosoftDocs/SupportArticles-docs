---
title: Save legacy calendars in UCI
description: Provides a resolution for an issue where a service-level agreement (SLA) legacy calendar fails to configured to UCI after migration.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/09/2024
---
# Save legacy calendar in UCI

This article provides a resolution for an issue where a service-level agreement (SLA) legacy calendar fails to configured to UCI after migration.

## Symptoms

You receive the following error message

`Error Code:0x10000003 Calendar 649bf685-aa40-e911-a95c-000d3ab3f13b dates are corrputed. Try to create a new Calendar. at Microsoft.Dynamics.SLAManagement.TimeCalculationHelper.GetUpdatedRemainingMinutes(TimeInfo[] workingDays, DateTime& endDate, Double remainingMinutes, DateTime startTime) at Microsoft.Dynamics.SLAManagement.TimeCalculationHelper.GetEndTime(Guid calendarId, DateTime start, Double minutes, String& outputLogs) at Microsoft.Dynamics.`

## Cause

This issue occurs because the legacy calendar was not configured properly to UCI after migration.

## Resolution

Ask user to either create the calendar in UCI and change that in SLA Item. Or he can open the same legacy calendar in UCI interface and "Save and Close".

