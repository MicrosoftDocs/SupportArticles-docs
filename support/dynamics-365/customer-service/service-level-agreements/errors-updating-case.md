---
title: Errors occur when updating a case
description: Provides a resolution for the errors that occur on the SLA form when updating a case in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Errors occur on the SLA form when you update a case

This article provides a resolution for the issue that occurs due to inactive action flows in Dynamics 365 Customer Service.

## Symptoms

When you update a case, errors occur on the service-level agreement (SLA) form.

## Cause

If the action flow associated with one or more SLA items is deleted or not in the **Published** state, errors might occur.

## Resolution

To resolve this issue, activate the draft flow from the SLA form. If your SLA is active but the dependent flow is inactive, you may see notifications on the SLA form. As an administrator, select **Activate** to enable all the dependencies.

An alternate resolution:

1. Make the SLA inactive and go to the SLA items where you have configured action flows and select **Configure actions**. The Power Automate portal will appear and show your action flow.
1. Turn on the action flow.
1. After activating action flows for SLA items, activate SLA again.
