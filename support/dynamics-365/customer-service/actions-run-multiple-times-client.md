---
title: Success, warning, and failure actions are being run multiple times in web client
description: Provides a solution for Success, warning, and failure actions are being run multiple times in the web client in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Success, warning, and failure actions are being run multiple times in web client

This article provides a solution for when uccess, warning, and failure actions are being run multiple times in web client

## Symptom

When updates are made to the target record, the attributes present in the **Applicable when** condition of the SLA item are modified in the applied SLA.

Consider a scenario in which you've created an SLA in the web client with an SLA item that has the following **Applicable when** and **Success condition**, and is set as the default.
> ![Scenario for troubleshooting SLAs.](media/troubleshoot-sla.png "Scenario for troubleshooting SLAs")

1. Create a case with case type set as question. The SLA timer starts.

2. Add **Resolved** to case title. The success condition is met and the following events occur:

   - The SLA KPI instance status is updated to succeeded.
   - A success action, such as send mail, is run, if configured.

3. Update the case type to request.

  - The SLA KPI instance that is in the succeeded status is reevaluated because the **Applicable when** attribute is changed.
  - The SLA KPI instance moves from **Succeeded** to **In progress**.
  - Because the case title contains **Resolved** and the success condition is true, the SLA KPI instance status changes from **In progress** to **Succeeded** again, and runs the success action again.

Based on the SLA KPI instance status, if any actions are configured, those actions will be run multiple times.

## Cause

When the **Applicable when** attribute is updated, the SLA is reevaluated that results in multiple iterations of the actions.

## Resolution

This is the expected behavior for SLAs in the web client. It is recommended to define the **Applicable when** condition on only those attributes whose values don't change frequently.
