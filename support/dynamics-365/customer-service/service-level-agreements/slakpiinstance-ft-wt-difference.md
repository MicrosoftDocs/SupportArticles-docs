---
title: SLA KPI instance shows a difference in Failure Time and Warning Time
description: Provides a resolution for an issue where an SLA KPI instance shows a difference in Failure Time and Warning Time.
ms.reviewer: sdas
ms.author: ankugupta
ms.date: 08/04/2023
---
# An SLA KPI instance shows a difference in Failure Time and Warning Time

This article provides a resolution for an issue where a service-level agreement (SLA) KPI instance shows a difference in **Failure Time** and **Warning Time**.

## Symptoms

By default, SLAs in the **Succeeded** and **Non-compliance** terminal statuses aren't reevaluated when the success condition changes, and they can't be paused or resumed.

## Cause

The **Failure Time** and **Warning Time** of the `slakpiinstance` are calculated based on the time zone used in the SLA calendar.

If the calendar time zone differs from the end user's time zone, the calculation is made based on the calendar time zone, and the user may see a difference.

:::image type="content" source="media/slakpiinstance-ft-wt-difference/sla-kpi-instance-different-ft-wt.png" alt-text="Screenshot that shows the Set local time zone option in Set Personal Options.":::

:::image type="content" source="media/slakpiinstance-ft-wt-difference/sla-customer-service-schedule.png" alt-text="Screenshot that shows an SLA customer service schedule.":::

## Resolution

Make sure the end user's time zone matches the calendar time zone. For more information, see [Understand time calculation of SLA KPIs](/dynamics365/customer-service/change-schedules#understand-time-calculation-of-sla-kpis).
