---
title: AKS agent installation/uninstallation not available
description: Resolve the issue in which the installation or uninstallation option isn't available.
author: agrimayadav
ms.author: jarrettr 
ms.service: partner-services 
ms.topic: troubleshooting-problem-resolution  
ms.date: 10/21/2025

#customer intent: As an Azure administrator or user, I want to enable the install or uninstall button for the AKS agent.

---

# AKS agent installation/uninstallation not available

This article helps you resolve the problem in which you want to install or uninstall the AKS Dynatrace extension and the **Install Extension** or **Uninstall Extension** button is inactive (dimmed).  

> [!note]
>
> - Any installation or uninstallation of the extension outside the Azure Native Dynatrace experience won't be supported during key rotation.  
> - For more information about AKS releases across various regions, see [AKA release tracker](/azure/aks/release-tracker). 

## Symptoms

The **Install Extension** and/or **Uninstall Extension** button on the **Azure Kubernetes Services** page for the Azure Native Dynatrace Service is inactive (dimmed).  

## Causes

- You might be trying to install the agent on an AKS instance where an agent is already running. 
- You might not have appropriate permissions to install or uninstall the agent. 

## Solution  

### If you're the subscription owner 

If you're the subscription owner and the install/uninstall buttons for AKS agent are inactive, you might be trying to install the agent on an AKS instance where an agent is already running. If that's not the case, contact Dynatrace support. 

### If you're not the subscription owner

If you're not the subscription owner, ensure that you have the Liftr Dynatrace Contributor role, and ask the subscription owner to complete the following steps. After that's done, the buttons should be enabled. 

These steps ensure that the Dynatrace extension has the required access. They must be completed before you install the extension by using the Azure portal or the CLI.  
  
1. On the page for the subscription, select **Access Control (IAM)**. 

1. Select **Add** > **Add role assignment**. 

1. On the **Role** tab, select the role **Azure Native Dynatrace Agent Management Role**.  

1. On the **Members** tab, select **User, group, or service principal**. 

1. Select **Select members** and search for and select **Azure-Dynatrace-Agent-Management**.  

1. Select **Select**, and then select **Review + assign**. 

 

