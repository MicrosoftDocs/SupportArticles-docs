---
title: "Inspection Flows Aren't Triggered in Field Service"
description: "Learn how to fix inspection flows that aren't triggered in Dynamics 365 Field Service. Follow these steps to resolve deserialization flow issues quickly."
ms.reviewer: v-wendysmith, v-shaywood
ms.date: 04/20/2026
ms.custom: sap:Administration
---
# Inspection flows don't trigger in Dynamics 365 Field Service

## Summary

This article helps you resolve an issue where the Power Automate **Deserialization of Inspection Definition Flow** or the **Deserialization of Inspection Response Flow** for Dynamics 365 Field Service doesn't trigger as expected.

## Symptoms

After [publishing an inspection](/dynamics365/field-service/inspections#create-inspection), you might encounter one of the following issues:

- The **Deserialization of Inspection Definition Flow** doesn't populate inspection questions into the `msfp_question` table.
- The **Deserialization of Inspection Response Flow** doesn't parse inspection responses, even when the **Analytics frequency** is set to **Immediately**.

## Solution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform these steps.

1. In Field Service, [enable analysis on inspection responses](/dynamics365/field-service/inspections-reporting#enable-analysis-on-inspection-responses).

1. If the analysis feature is already enabled:

   1. Turn the setting off and back on.
   1. Change the **Analytics frequency** to **Immediately**.
   1. Check whether the issue persists. If it does, go to the next step.

1. If you see the "Modern flow {flow ID} isn't valid for ExecuteWorkflow" error when you enable analytics, the related Power Automate flows might not be registered correctly. To fix this problem:

   1. Sign in to [Power Automate](https://make.powerautomate.com/) for your environment.
   1. Locate the flows associated with the error.
   1. Disable the flows in the following table, wait a moment, and then enable them again.

   |Flow with error  |Related flows to disable and enable  |
   |---------|---------|
   |Deserialization of Inspection Definition Flow (the [msfp_question](/dynamics365/developer/reference/entities/msfp_question) table)     |- Deserialization of Inspection Definition Flow<br/>- Deserialization of Inspection Definition - Matrix Dynamics Child Flow |
   |Deserialization of Inspection Response Flow (the [msfp_surveyresponse](/dynamics365/developer/reference/entities/msfp_surveyresponse) table)     |- Deserialization of Inspection Response<br/>- Deserialization of Inspection Response - Matrix Dynamics<br/>- Deserialization of Inspection Response - Recurrent |

   For more information, see [Flow isn't valid for ExecuteWorkflow error](../../customer-service/service-level-agreements/sla-modern-flow-not-valid.md).

## Related content

- [Inspections overview](/dynamics365/field-service/inspections-overview)
