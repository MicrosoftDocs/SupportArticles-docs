---
title: Verify dataverse process RegisterFlowMachine 
description: Instruction to verify that the process RegisterFlowMachine is activated.
ms.custom: sap:Desktop flows\erify dataverse process RegisterFlowMachine 
ms.date: 10/03/2024
ms.reviewer: alarnaud, johndund, guco
ms.author: fredg
author: fredg
---

# Verify dataverse process RegisterFlowMachine 
This article provides a resolution for an issue where you can't register your machine with Microsoft Power Automate for desktop.

## Symptoms

When you want to register your machine with Power Automate for desktop and it fails with the error _'The registration failed because Dataverse solution has the process 'RegisterFlowMachine' deactivated.'_, the instruction below could solve the issue.

## Cause

This issue is caused by a specific process deactivated in Dataverse which is needed for machine registration.
([see list of processes which needs to be activated for Power Automate for desktop]("#processes-which-should-be-activated-for-Power-Automate"))

## Resolution

### Requirements:
You should have access to your organization endpoint like https://[org].crm.dynamics.com.

The organization endpoint could be found in https://admin.powerplatform.microsoft.com/environments by selecting your environment name where you want to register the machine.

### Steps

1. Open in a browser the following url (replace [org] by your org identifier) and sign in: https://[org].crm.dynamics.com

1. Click on icon settings on top right and select item "_Advanced Settings_".

:::image type="content" source="media/verify-dataverse-process-registerflowmachine/1.Dynamics-AdvancedSettings.png" alt-text="Click on icon settings on top right and select item 'Advanced Settings'.":::

3. Click on the dropdown on the right of "_Settings_" and the select "_Customizations_".

:::image type="content" source="media/verify-dataverse-process-registerflowmachine/2.Dynamics-Customizations.png" alt-text="Click on the dropdown on the right of 'Settings' and the select 'Customizations'.":::

4. Click on "_Customize the System_", this will open a popup.

:::image type="content" source="media/verify-dataverse-process-registerflowmachine/3.Dynamics-CustomizeSystem.png" alt-text="Click on 'Customize the System' this will open a popup.":::

5. Under "_Components_", select the "_Processes_" item, and select view "_All_" in the dropdown. Check the status of the process name "_RegisterFlowMachine_". If the status is "_Deactivated_", go to step 6.

:::image type="content" source="media/verify-dataverse-process-registerflowmachine/4.Dynamics-Process.png" alt-text="Under Components, select the Processes item, and select view 'All' in the dropdown. Check the status of the process name 'RegisterFlowMachine'":::

6. Check the checkbox on "_RegisterFlowMachine_" line and then click on "_Activate_"

:::image type="content" source="media/verify-dataverse-process-registerflowmachine/5.Dynamics-Activate.png" alt-text="Check the checkbox on 'RegisterFlowMachine' line and then click on 'Activate'":::

7. Open Machine runtime app and try to register again in the same environment.


## Processes which should be activated for Power Automate

- BatchGetFlowMachineStatus
- GetPublicKey
- LeaveGroup
- PowerAutomateProxy
- RegisterFlowMachine