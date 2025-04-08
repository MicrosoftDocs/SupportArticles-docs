---
title: Inspection flows aren’t triggered
description: Resolves an issue where an inspection flow isn't triggered in a Field Service environment.
author: josephshum-msft
ms.author: jshum
ms.reviewer: v-wendysmith
ms.date: 04/08/2025
ms.custom: sap:Administration
---
# Inspection flows aren't triggered

This article helps resolve an issue where the Power Automate **Deserialization of Inspection Definition Flow** or the **Deserialization of Inspection Response Flow** for Dynamics 365 Field Service isn't triggered as expected.

## Symptoms

An inspection is published, but the **Deserialization of Inspection Definition Flow** didn't populate inspection questions into the msfp_question table. Or the **Deserialization of Inspection Response Flow** didn't parse inspection responses and the **Analytics frequency** is set to *Immediately*.

## Resolution

You need administrator permissions in Dynamics 365 Field Service to perform the steps.

1. Enable the [Analytics enabled setting for inspections](/dynamics365/field-service/inspections-reporting#enable-analysis-on-inspection-responses).
1. If it's enabled, try turning it off and on again and change the **Analytics frequency** to *Immediately*. If the problem persists, try the next step.
1. If the "Modern flow {flow ID} isn't valid for ExecuteWorkflow" appears when trying to enable analytics in Field Service, the Power Automate flows might not be registered properly. To reregister, sign in to [Power Automate](https://make.powerautomate.com/) for your environment. Based on the flow with the error, disable the flows, wait a moment, and then enable the flows. For more information, go to [Flow isn't valid for ExecuteWorkflow error](/dynamics365/customer-service/service-level-agreements/sla-modern-flow-not-valid).


|Flow with error  |Flows to disable and enable  |
|---------|---------|
|Deserialization of Inspection Definition Flow (msfp_question table)     |- Deserialization of Inspection Definition Flow<br/>- Deserialization of Inspection Definition - Matrix Dynamics Child Flow |
|Deserialization of Inspection Response Flow (msfp_surveyresponse tables)     |- Deserialization of Inspection Response<br/>- Deserialization of Inspection Response - Matrix Dynamics<br/>- Deserialization of Inspection Response - Recurrent |

