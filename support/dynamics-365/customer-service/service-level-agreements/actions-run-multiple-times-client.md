---
title: Success, warning, and failure actions run multiple times in web client
description: Provides a resolution for the issue where the success, warning, and failure actions are being run multiple times in the web client in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Success, warning, and failure actions are being run multiple times in the web client

This article provides a resolution for the issue that the success, warning, failure, or other actions you configured will be run multiple times in the web client if the **Applicable When** attribute is updated in Dynamics 365 Customer Service.

## Symptoms

When updates are made to the target record, the attributes present in the **Applicable When** condition of the service-level agreement (SLA) item are modified in the applied SLA.

Consider a scenario in which you've created an SLA in the web client with an SLA item that has the following **Applicable When** and **Success Criteria** and is set as the default.

:::image type="content" source="media/actions-run-multiple-times-client/troubleshoot-sla.png" alt-text="The screenshot shows the default settings of the SLA item that you create in the web client.":::

1. Create a case with the case type set as **question**. The SLA timer starts.

2. Add **Resolved** to the case title. The success condition is met, and the following events occur:

   - The SLA KPI instance status is updated to **Succeeded**.
   - A success action is run, such as "send mail," if configured.

3. Update the case type to **request**.

   - The SLA KPI instance that's in the **Succeeded** status is reevaluated because the **Applicable When** attribute is changed.
   - The SLA KPI instance moves from **Succeeded** to **In progress**.
   - Because the case title contains **Resolved** and the success condition is true, the SLA KPI instance status changes from **In progress** to **Succeeded** again and runs the success action again.

Based on the SLA KPI instance status, if any actions are configured, those actions will be run multiple times.

## Cause

When the **Applicable When** attribute is updated, the SLA is reevaluated, which results in multiple iterations of the actions.

## Resolution

This is the expected behavior for SLAs in the web client. It's recommended to define the **Applicable When** condition only on those attributes whose values don't change frequently.
