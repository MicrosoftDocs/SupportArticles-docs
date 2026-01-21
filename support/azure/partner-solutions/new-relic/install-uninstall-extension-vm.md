---
title: Can't Install or Uninstall the Agent on a Virtual Machine
description: Resolve problems with installing or uninstalling the New Relic agent on a virtual machine. 
author: shijojoy
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Native New Relic Service
ms.date: 09/18/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve problems with installing or uninstalling the New Relic agent on virtual machines.

---

# Can't install or uninstall the agent on a virtual machine

This article explains how to resolve problems with installing or uninstalling the New Relic agent on a virtual machine (VM). Specifically, it describes what to do if you select VMs and the **Install Extension** or **Uninstall Extension** button is unavailable.

## Prerequisites

- An Azure account with permissions to manage VM extensions (Contributor or Owner on the subscription or resource group, or a role with explicit extension management permissions).
- The target VMs must be visible in the Azure portal on the **Virtual machines** page.

## Symptoms

- On the **Virtual Machines** page of the New Relic resource, the **Install Extension** button is unavailable (dimmed) after you select one or more VMs.
- On the **Virtual Machines** page of the New Relic resource, the **Uninstall Extension** button is unavailable (dimmed) after you select one or more VMs.

## Cause

The portal enables the **Install Extension** or **Uninstall Extension** button only when the entire selection of VMs matches the required state for that action:

- **Install Extension** is enabled only when none of the selected VMs has the New Relic agent installed.
- **Uninstall Extension** is enabled only when every selected VM already has the New Relic agent installed.

The Azure portal displays the agent/extension state in the **Agent status** column:

- VMs on which the New Relic agent is installed show **Running** or **Shutdown**.
- VMs on which the New Relic agent isn't installed show **Not Installed**.

If your selection includes VMs in different states (some that have the agent and some that don't), neither **Install Extension** nor **Uninstall Extension** will be enabled.

## Solution 

1. In the Azure portal, go to the **Virtual Machines** page of the New Relic resource.
1. To install the New Relic agent:
   1. Select only VMs that show an **Agent status** of **Not Installed**.
   1. Deselect any VMs that show a status of **Running** or **Shutdown**. (These VMs already have the agent.)
   1. Confirm that the **Install Extension** button is active and then proceed.
1. To uninstall the New Relic agent:
   1. Select only VMs that show an **Agent status** of **Running** or **Shutdown**. (These VMs have the agent installed.)
   1. Deselect any VMs that show a status of **Not Installed**.
   1. Confirm that the **Uninstall Extension** button is active and then proceed.

## Related content

- [Manage extensions on Azure virtual machines](/azure/virtual-machines/extensions/overview)
- [Troubleshoot VM Agent issues](../../virtual-machines/windows/windows-azure-guest-agent.md)
- [Introduction to the Azure Native New Relic Service](https://docs.newrelic.com/docs/infrastructure/microsoft-azure-integrations/get-started/azure-native/)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]