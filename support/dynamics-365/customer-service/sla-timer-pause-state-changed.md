---
title: SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday
description: Provides more information for a by design behavior that the SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday in Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday

This article provides more information about how the SLA **Warning** and **Failure** time is calculated if your organization defines business hours while scheduling working days and holidays.

## Symptoms

Once triggered, the SLA timer continues to run even when its state is changed from **InProgress** to **OnHold**.

## Cause

If a holiday is configured, the status of the case is updated to **OnHold** to pause the case's SLA. However, the pause functionality associated with the **OnHold** status doesn't appear to function correctly. Therefore, the timer continues to run even on a holiday when it should be paused.

So, it includes the holiday hours, nonworking hours, and pause time (only business hours) while projecting the SLA warning or failure time.

## More information

The functionality is by design. Your organization defines business hours while scheduling working days and holidays. The SLA **Warning** time and **Failure** time adhere to those settings are calculated based on the defined hours.

See the following scenarios to understand how the SLA **Warning** and **Failure** time is calculated:

- Create a case during nonworking hours. Pause and resume the case before working hours start. Hold time between **Pause** and **Resume** won't be considered.
- Create a case during nonworking hours. Pause and resume the case during working hours. Hold time will be considered and the **Warning** and **Failure** time will be extended based on hold time.
- Create a case during working hours. Pause the case during working hours. Resume the case during nonworking hours. Hold time won't be considered for the **Warning** and **Failure** time.
- Create a case during working hours. Pause the case during nonworking hours and resume it during working hours. The **Warning** time and **Failure** time will be recalculated.
