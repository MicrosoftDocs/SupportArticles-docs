---
title: Warning occurs on SLA KPI instances
description: Provides a resolution for the issue where a warning message occurs on the SLA KPI instances in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# A warning message appears on the SLA KPI instances

This article provides a resolution for the warning message that occurs on the service-level agreement (SLA) KPI instances in Dynamics 365 Customer Service.

## Symptoms

The following warning message is displayed on entity records:

> The SLA instances may be incorrect because workflow <*workflow ID*> is turned off. Please contact your admin to turn the workflow on.

The *workflow ID* varies from system to system.

## Cause

The **SLAInstanceMonitoringWarningAndExpiryFlow** isn't enabled.

## Resolution

If none of the Unified Interface SLAs are activated, you must activate one to activate the **SLAInstanceMonitoringWarningAndExpiryFlow**. The flow must only be turned off and on by a user with the SLA KPI privileges at a global level for `prvReadSLAKPIInstance` and `prvWriteSLAKPIInstance`.

However, if all the SLAs are active, but the flow is still deactivated, take the following steps:

1. In [Power Automate](https://powerautomate.microsoft.com), navigate to **My flows** > **Cloud flows**.
2. In **Cloud flows**, select **SLAInstanceMonitoringWarningAndExpiryFlow**.
3. Select **Turn on**.
