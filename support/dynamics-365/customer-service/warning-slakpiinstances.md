---
title: Warning message appears on slakpiinstances
description: Provides a solution for when a warning message appears on slakpiinstances in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Warning message appears on slakpiinstances

This article provides a solution for when a warning message appears on slakpiinstances in Customer Service.

## Symptom

The following warning message is displayed on entity records: "The SLA instances may be incorrect because workflow <*workflow ID*> is turned off. Please contact your admin to turn the workflow on."

The workflow ID varies from system to system.

## Cause

The **SLAInstanceMonitoringWarningAndExpiryFlow** must be enabled.

## Resolution

If none of the Unified Interface SLAs are activated, then you must activate one of the SLAs to activate the **SLAInstanceMonitoringWarningAndExpiryFlow**. The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for **prvReadSLAKPIInstance** and **prvWriteSLAKPIInstance**.

However, if all the SLAs are active but the flow is still deactivated, perform the following steps:

1. In https://powerautomate.microsoft.com, navigate to **My flows > Cloud flows**.
2. In **Cloud flows**, select **SLAInstanceMonitoringWarningAndExpiryFlow**.
3. Select **Turn on**.
