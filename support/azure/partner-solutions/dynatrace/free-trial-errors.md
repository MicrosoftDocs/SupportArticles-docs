---
title: Dynatrace free trial errors and limitations in Azure
description: "Resolve errors and limitations when creating or managing Dynatrace free trial resources in Azure."
author: v-albemi
ms.author: v-albemi
ms.service: Dynatrace integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/23/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Dynatrace free trial errors and limitations in Azure

This article helps you resolve common errors and limitations encountered when creating or managing Dynatrace free trial resources in Azure, including resource creation limits and resource deletion after trial expiry.

## Prerequisites

- Access to the Azure portal and the Dynatrace integration blade.
- Access to the Dynatrace account used for the free trial.
- Contact information for Dynatrace sales (if requesting a trial extension).

## Symptoms

- Error when attempting to create another Dynatrace free trial resource: "Unable to create another free trial resource on Azure".
- Dynatrace free trial resource is missing or deleted after the trial period ends.

## Cause

- During free trials, Dynatrace accounts can only have one environment. You can only create one Dynatrace resource during the trial period.
- With the free trial plan, your Dynatrace resource on Azure will be deleted automatically after the trial expires.

## Solution 1: Unable to create another free trial resource

1. Confirm you are using a Dynatrace free trial account.
2. Only one environment/resource can be created during the trial period. You cannot create additional resources until you upgrade to a paid plan or the trial expires.
3. If you need additional environments, upgrade to a paid Dynatrace plan or wait until the trial expires and start a new trial (if eligible).

## Solution 2: Dynatrace free trial resource is deleted

1. Free trial resources are deleted automatically after the trial period ends.
2. If you require more time, [contact Dynatrace sales](mailto:sales@dynatrace.com) to request a trial extension or discuss upgrade options.
3. If you upgrade to a paid plan before expiry, your resource will not be deleted.

## Verify

- After following the steps above, confirm your Dynatrace resource status in the Azure portal and Dynatrace UI.
- If you contact Dynatrace sales, verify receipt of extension confirmation or upgrade instructions.

## Advanced troubleshooting and data collection

- Collect the following information if you need to escalate to Dynatrace or Azure support:
  - Azure subscription ID and resource group
  - Dynatrace account email and environment ID
  - Timestamps of resource creation and deletion attempts
  - Error messages or portal screenshots

## Related content

- [Dynatrace free trial documentation](https://www.dynatrace.com/support/help/get-started/your-dynatrace-free-trial/)
- [Dynatrace Azure integration documentation](https://learn.microsoft.com/azure/marketplace/dynatrace-azure-integration)
- [Contact Dynatrace sales](mailto:sales@dynatrace.com)