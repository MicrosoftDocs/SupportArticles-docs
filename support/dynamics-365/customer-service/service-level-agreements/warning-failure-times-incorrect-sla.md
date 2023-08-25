---
title: Warning and failure duration times are wrong for SLA in Dynamics 365 Customer Service
description: Provides a resolution for the issue where the SLA warning and failure duration times are incorrect in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 08/18/2023
---
# Warning and failure duration times are incorrect for the SLA

This article provides a resolution for the issue where the warning and failure timing calculations are incorrect.

## Scenario 1: Some SLAs don't take into account daylight saving time for the warning and failure duration

This issue may occur when warning and failure duration times don't consider daylight saving time for the service-level agreement (SLA) in Omnichannel for Customer Service.

#### Cause

If your SLA was created in the web client that's now deprecated, the business schedule calendar doesn't support daylight saving time.

#### Resolution

To use the daylight saving time functionality and many other new features, migrate your SLAs created in the web client to Unified Interface. For more information, see [Migrate automatic record creation rules and service-level agreements](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements).

## Scenario 2: An SLA KPI instance shows a difference in Failure Time and Warning Time

By default, SLAs in the **Succeeded** and **Non-compliance** terminal statuses aren't reevaluated when the success condition changes, and they can't be paused or resumed.

#### Cause

The **Failure Time** and **Warning Time** of the `slakpiinstance` are calculated based on the time zone used in the SLA calendar.

If the calendar time zone differs from the end user's time zone, the calculation is made based on the calendar time zone, and the user may see a difference.

:::image type="content" source="media/warning-failure-times-incorrect-sla/sla-kpi-instance-different-ft-wt.png" alt-text="Screenshot that shows the Set local time zone option in Set Personal Options.":::

:::image type="content" source="media/warning-failure-times-incorrect-sla/sla-customer-service-schedule.png" alt-text="Screenshot that shows an SLA customer service schedule.":::

#### Resolution

Make sure the end user's time zone matches the calendar time zone. For more information, see [Understand time calculation of SLA KPIs](/dynamics365/customer-service/change-schedules#understand-time-calculation-of-sla-kpis).
