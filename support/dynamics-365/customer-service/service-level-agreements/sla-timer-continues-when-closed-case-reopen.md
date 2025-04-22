---
title: SLA Timer Not Restarting from the Beginning When a Closed Case Is Reopened 
description: Provides guidance on how to ensure the SLA timer restarts from the beginning when a closed case is reopened in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/22/2025
ms.custom: sap:Service Level Agreements, DFM
---
# SLA timer continues instead of restarting when a closed case is reopened

This article provides guidance on how to restart the service-level agreement (SLA) timer when a closed case is reopened in Dynamics 365 Customer Service. By default, the SLA timer continues from the last time instead of restarting.

## Symptoms

When a case is closed and then reopened in Dynamics 365 Customer Service, the [SLA timer](/dynamics365/customer-service/administer/add-timer-control-case-form-track-time-against-sla) continues from the last time instead of restarting from the beginning. You expect the SLA timer to reset and start again upon reopening the case.

## Cause

The SLA timer doesn't automatically restart upon reopening a closed case. By default, it continues to run, accounting for holiday hours, nonbusiness hours, and pause time, while projecting the SLA warning or failure time.

## Resolution

To ensure the SLA timer restarts when a closed case is reopened, you need to enable SLA recalculation in the system. Follow these steps:

1. Navigate to the [Copilot Service admin center (previously known as the Customer Service admin center)](/dynamics365/customer-service/implement/cs-admin-center).
1. Go to **Service Terms** in **Operations**.
1. In the **Other SLA Settings** section, select **Manage**. The **Service Configuration Settings** view is displayed.
1. Locate the **Recalculate SLA on terminal status** setting.
1. Set the option to **Yes** to enable SLA recalculation.

## More information

- [Understand SLAs](/dynamics365/customer-service/use/customer-service-hub-user-guide-case-sla)
- [Recalculate service-level agreements](/dynamics365/customer-service/administer/enable-sla-recalculation)
