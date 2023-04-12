---
title: Errors occur while updating a case
description: Provides a solution for errors that occur on the SLA form when updating a case in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Errors occur while updating a case

## Symptom

Errors appear on the SLA form while updating a case.

## Cause 

If the action flow associated with one or more SLA items are deleted or aren't in **Published** state, errors might occur.

## Resolution 

- Activate the draft flow from the SLA form. If your SLA is active but the dependent flow is inactive, then you may see notifications on the SLA form. As an administrator, select **Activate** to enable all the dependencies.

- Alternate resolution:

    1. Make the SLA inactive and go to the SLA items where you have configured action flows and select **Configure actions**. The Power Automate portal will appear and show your action flow.
    1. Turn on action flow.
    1. After activating action flows for SLA items, activate SLA again. 
