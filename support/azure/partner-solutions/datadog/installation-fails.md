---
title: Troubleshoot Datadog Agent Installation Failures in Azure
description: Resolve Datadog agent installation failures caused by a missing or incorrect default API key.
author: 
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/22/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to resolve an installation failure that's caused by a missing or incorrect default API key.

---

# Datadog agent installation fails

This article helps you troubleshoot Datadog agent installation failures on Azure virtual machines and app services when the installation fails because the Datadog API key isn't configured as the default key.

## Prerequisites

- Access to the Azure portal with permissions to view or configure the Datadog integration and to restart VMs or app services, if required.
 
## Causes and solutions

### Cause: No Default API key is selected 

#### Solution

1. In the Azure portal, go to the Datadog resource. 
1. In the left pane, select **Keys** under **Settings**.
1. Under **API Keys**, select or create a default key.
1. Try again to install the agent. 

### Cause: Incorrect API key configured on the resource

#### Solution

1. In the Azure portal, go to the Datadog resource. 
1. In the left pane, select, select **Keys** under **Settings**.
1. Under **API Keys**, change the default key.
1. Uninstall the Datadog agent and reinstall it.

## Related content

- [Datadog agent installation docs](https://docs.datadoghq.com/agent/)
- [Datadog Azure integration documentation](https://docs.datadoghq.com/integrations/azure/)
- [Manage extensions on Azure virtual machines](/azure/virtual-machines/extensions/overview)