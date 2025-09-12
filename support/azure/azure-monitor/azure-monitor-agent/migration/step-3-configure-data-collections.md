---
title: Step 3 - Configure data collections for Azure Monitor Agent
description: Learn how to configure data collections for Azure Monitor Agent so that you can migrate from the legacy Log Analytics agent.
ms.date: 08/19/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to configure data collections for Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 3: Configure data collections

Data collection rule (DCR) represents a modern method for setting up data streams for the Azure Monitor Agent. The Azure Monitor DCR Config Generator is a PowerShell script designed to facilitate the transition from older agents to the Azure Monitor Agent by using existing Log Analytics workspace data to automatically generate and implement data collection rules (DCRs). However, it's important to link these rules to the virtual machines (VMs) to initiate data collection.

The DCR Config Generator tool produces DCRs that are linked to the Log Analytics workspace. To avoid potential issues with duplicate data and disruptions to your production environment, we suggest creating a new, isolated development or staging workspace after running the generator. This allows you to safely test and validate that data flows correctly through the DCRs before deploying them to your production environment. After validation passes in the new workspace, you have the following two options. Select the option that best fits your requirements.

- Reconnect the DCRs to the original workspace
  
  If you select this option while the legacy agent is still connected, data duplication is likely to occur until the legacy agent is removed.
- Retire the old workspace and collect data in a new workspace
  
  This option allows you to seamlessly transition to the updated configuration without disrupting your production environment.

## Prerequisites to run the DCR Config Generator tool

- PowerShell version 7.1.3 or later is recommended (the minimum version is 5.1).

  To determine which version of PowerShell is installed on your machine, run the following command:
  
  ```powershell
  $PSVersionTable
  ```
- Az PowerShell module to pull the workspace agent configuration information. To install the Az PowerShell module, see [Install Azure PowerShell on Windows](/powershell/azure/install-azps-windows).
- Read/Write access to the specified workspace resource.

## How to use the DCR Config Generator tool

To use the DCR Config Generator, follow these steps:

1. Open the [DCR Config Generator GitHub page](https://github.com/microsoft/AzureMonitorCommunity/tree/master/Azure%20Services/Azure%20Monitor/Agents/Migration%20Tools/DCR%20Config%20Generator).

1. Select **WorkspaceConfigToDCRMigrationTool.ps1**.

   :::image type="content" source="media/step-3-configure-data-collections/dcr-config-generator-github-page.png" alt-text="Screenshot that shows users where the 'WorkspaceConfigToDCRMigrationTool.ps' file is."  lightbox="media/step-3-configure-data-collections/dcr-config-generator-github-page.png":::

1. Select the download button to download the *WorkspaceConfigToDCRMigrationTool.ps1* file.

   :::image type="content" source="media/step-3-configure-data-collections/download-workspaceconfigtodcrmigrationtool-script.png" alt-text="Screenshot that shows where the download button is."  lightbox="media/step-3-configure-data-collections/download-workspaceconfigtodcrmigrationtool-script.png":::

1. After you download the file, create a *migration* folder on your C drive and move the file there.

1. Run the file with the required parameters:

   - `SubscriptionID` (Source Subscription ID)
   - `ResourceGroupName` (Source Resource group name)
   - `WorkspaceName` (Source Workspace Name)
   - `DcrName` (DCR Naming Prefix)
   
   See the following screenshot for an example:
   
   :::image type="content" source="media/step-3-configure-data-collections/run-workspaceconfigtodcrmigrationtool-script.png" alt-text="Screenshot that shows how to run the 'WorkspaceConfigToDCRMigrationTool.ps1' file."  lightbox="media/step-3-configure-data-collections/run-workspaceconfigtodcrmigrationtool-script.png":::

   The tool establishes a connection with your Log Analytics workspace, retrieves the settings from the existing source workspace, and then generates DCR ARM template files in JSON format. These files are subsequently saved in a local directory for your review.

1. Select a template file to deploy one of the created DCR ARM templates to your subscription.

The DCRs are now published and available in the Azure portal.

## Next steps

> [!div class="nextstepaction"]
> [Step 4: Test data collections in Azure Monitor Agent](step-4-test-data-collections-azure-monitor-agent.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
