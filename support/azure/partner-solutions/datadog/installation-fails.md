---
title: Troubleshoot Default API Key Problems in Datadog
description: Resolve Datadog agent installation failures caused by a missing default API key, or change an incorrect default API key. 
author: agrimayadav
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/22/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to resolve an installation failure that's caused by a missing default API key, or I want to change a default API key.

---

# Datadaog agent installation fails, or default API key is incorrect

## Summary

The Azure Datadog integration enables you to install a Datadog agent on a virtual machine or app service. This article helps you troubleshoot Datadog agent installation failures that are caused by a missing default API key. It also describes how to change the default key.

## Prerequisites

- Access to the [Azure portal](https://portal.azure.com) with permissions to view or configure the Datadog integration and to restart virutal machines (VMs) or app services if required.
 
## Problems and solutions

### Problem: Datadog installation fails

If a default API key isn't selected, the Datadog agent installation fails.

#### Solution

1. In the Azure portal, go to the Datadog resource. 
1. Select **Settings** > **Keys**.
1. In **API Keys**, change the default key.
1. Try again to install the agent. 

### Problem: Incorrect API key configured on the resource

The API key for the resource is incorrect.

#### Solution

1. In the Azure portal, go to the Datadog resource. 
1. Select **Settings** > **Keys**.
1. In **API Keys**, change the default key.
1. Uninstall the Datadog agent and reinstall it.

## Related content

- [Datadog agent installation docs](https://docs.datadoghq.com/agent/)
- [Datadog Azure integration documentation](https://docs.datadoghq.com/integrations/azure/)
- [Manage extensions on Azure virtual machines](/azure/virtual-machines/extensions/overview)