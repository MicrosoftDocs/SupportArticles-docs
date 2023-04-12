---
title: SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday
description: Provides a solution for when SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday

This article provides a solution for when the SLA timer doesn't pause when its state is changed from InProgress to OnHold on a holiday.

## Symptom

Once triggered, the SLA timer continues to run even when its state is changed from **InProgress** to **OnHold**.

## Cause

If a holiday is configured, the status of the case is updated to **OnHold** to pause the case SLA. However, the pause functionality associated with the **OnHold** status doesn't appear to function correctly. Therefore, the timer continues to run even on a holiday when it should be paused.

So, it includes the holiday hours, non-working hours, and pause time (only business hours) while projecting the SLA warning or failure time.

## Resolution

The functionality is intended. Your organization defines business hours while scheduling working days and holidays. SLA warning time and failure time adhere to those settings and are calculated based on the defined hours.

See the following scenarios to understand how the SLA **Warning** and **Failure** time is calculated:

- Create a case during non-working hours. Pause and resume the case before working hours start. Hold time between **Pause** and **Resume** won't be considered.
- Create a case during non-working hours. Pause and resume the case during working hours. Hold time will be considered and **Warning** and **Failure** time will be extended based on hold time.
- Create a case during working hours. Pause the case during working hours. Resume the case during non-working hours. Hold time won't be considered for **Warning** and **Failure** time.
- Create a case during working hours. Pause the case during non-working hours and resume it during working hours. **Warning** time and **Failure** time will be recalculated.
