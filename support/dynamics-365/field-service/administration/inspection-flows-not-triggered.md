---
title: Inspection flows aren't triggered
description: Resolves an issue where an inspection flow isn't triggered in a Microsoft Dynamics 365 Field Service environment.
author: josephshum-msft
ms.author: jshum
ms.reviewer: v-wendysmith
ms.date: 04/14/2025
ms.custom: sap:Administration
---
# Inspection flows aren't triggered in Dynamics 365 Field Service

This article helps resolve an issue where the Power Automate **Deserialization of Inspection Definition Flow** or the **Deserialization of Inspection Response Flow** for Dynamics 365 Field Service isn't triggered as expected.

## Symptoms

After [publishing an inspection](/dynamics365/field-service/inspections#create-inspection), you might encounter one of the following issues:

- The **Deserialization of Inspection Definition Flow** doesn't populate inspection questions into the `msfp_question` table.
- The **Deserialization of Inspection Response Flow** doesn't parse inspection responses, even when the **Analytics frequency** is set to **Immediately**.

## Resolution

> [!NOTE]
> You must have administrator permissions in Dynamics 365 Field Service to perform the following steps.

1. [Enable analysis on inspection responses](/dynamics365/field-service/inspections-reporting#enable-analysis-on-inspection-responses).

1. If the analysis feature is already enabled,

   1. Turn the setting off and back on.
   2. Change the **Analytics frequency** to **Immediately**.
   3. Check if the issue persists. If it does, proceed to the next step.

1. If the "Modern flow {flow ID} isn't valid for ExecuteWorkflow" error message occurs when you enable analytics in Dynamics 365 Field Service, it indicates that the related Power Automate flows may not be properly registered. To resolve this issue:

   1. Sign in to [Power Automate](https://make.powerautomate.com/) for your environment.
   2. Locate the flows associated with the error.
   3. Disable the flows, wait a moment, and then re-enable them.

   For more information, see [Flow isn't valid for ExecuteWorkflow error](../../customer-service/service-level-agreements/sla-modern-flow-not-valid.md).

|Flow with error  |Related flows to disable and enable  |
|---------|---------|
|Deserialization of Inspection Definition Flow (the [msfp_question](/dynamics365/developer/reference/entities/msfp_question) table)     |- Deserialization of Inspection Definition Flow<br/>- Deserialization of Inspection Definition - Matrix Dynamics Child Flow |
|Deserialization of Inspection Response Flow (the [msfp_surveyresponse](/dynamics365/developer/reference/entities/msfp_surveyresponse) table)     |- Deserialization of Inspection Response<br/>- Deserialization of Inspection Response - Matrix Dynamics<br/>- Deserialization of Inspection Response - Recurrent |
