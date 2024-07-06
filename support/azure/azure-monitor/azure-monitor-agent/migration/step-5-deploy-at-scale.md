---
title: Step 5 - Deploy Azure Monitor Agent at scale
description: Learn how to use Azure Policy to deploy Azure Monitor Agent at scale so that you can migrate from the legacy Log Analytics agent.
ms.date: 07/08/2024
author: neilghuman
ms.author: neghuman
ms.reviewer: jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to learn how to use Azure Policy to deploy Azure Monitor Agent at scale so that I can migrate from the legacy Log Analytics agent.
---
# Step 5: Deploy at scale

Azure Policy is a service that allows you to define and enforce rules for your Azure resources. You can use Azure Policy to associate virtual machines (VMs) to a data collection rule (DCR)&mdash;a configuration that specifies what data to collect from Azure Monitor Agent. By using Azure Policy to associate VMs to DCRs, you can ensure consistent and compliant data collection across your VMs.

To use Azure Policy to associate VMs to a DCR, follow these steps:

- Create a DCR in the Azure portal, or by using PowerShell or Azure CLI. You can choose what data sources to collect, such as performance counters, logs, or custom metrics. You can also specify where to send the collected data, such as a Log Analytics workspace, Application Insights, or Azure Storage.

- Create a policy definition that assigns the DCR to the target VMs. You can use the built-in policy definition "Deploy if not exists: Deploy Data Collection Rule association to Windows VMs," or you can create your own custom policy definition. You also can use parameters to specify the DCR ID and the scope of the assignment. For more information, see the [Monitoring section of Azure Policy built-in initiative definitions](/azure/governance/policy/samples/built-in-initiatives#monitoring).

- Assign the policy definition to the scope where your VMs are located, such as a subscription, resource group, or management group. You can also set the policy enforcement mode to either Default or DoNotEnforce. The default mode automatically deploys the DCR association to the existing and new VMs that match the policy criteria. The DoNotEnforce mode only reports compliance; it allows you to remediate manually or by using Azure Automation.

- Review the policy compliance status and the DCR association status in the Azure portal. You can see how many VMs are compliant or non-compliant with the policy, and how many VMs successfully associated or failed to associate with the DCR. You also can drill down to the details of each VM and the data sources that are being collected.

By using Azure Policy to associate VMs to a DCR, you can simplify and automate the data collection process for Azure Monitor Agent, and ensure consistent and compliant monitoring across your Azure environment.

## Next steps

> [!div class="nextstepaction"]
> [Step 6: Configure other services](step-6-configure-other-services.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
