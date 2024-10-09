---
title: Verify and activate the RegisterFlowMachine process
description: Resolves an error that occurs when you register a machine with Microsoft Power Automate for desktop.
ms.custom: sap:Desktop flows\Verify dataverse process RegisterFlowMachine 
ms.date: 10/09/2024
ms.reviewer: alarnaud, johndund, guco
ms.author: fredg
author: fredg
---
# "The registration failed because Dataverse solution has the process 'RegisterFlowMachine' deactivated" error

This article provides a resolution for an issue where you can't register your machine with Microsoft Power Automate for desktop.

## Symptoms

When you register your machine with Power Automate for desktop, the registration fails with the following error message:

> The registration failed because Dataverse solution has the process 'RegisterFlowMachine' deactivated.

## Cause

This issue occurs because the **RegisterFlowMachine** process is deactivated in Dataverse.

For more information, see [the processes](#processes-which-should-be-activated-for-power-automate) that need to be activated for Power Automate for desktop.

## Resolution

### Prerequites

You should have access to your organization endpoint like https://[org].crm.dynamics.com.

The organization endpoint could be found in [Environments](https://admin.powerplatform.microsoft.com/environments) by selecting your environment name where you want to register the machine.

### Steps

1. Open the following url in a web browser (replace [org] with your orgnization identifier) and sign in.

   https://[org].crm.dynamics.com

2. Select the gear icon in the upper-right corner and select **Advanced Settings**.

    :::image type="content" source="media/verify-dataverse-process-registerflowmachine/advanced-settings.png" alt-text="Screenshot of the Advanced Settings option that you can find it by selecting the gear icon.":::

3. Select **Settings** > **Customizations**.

    :::image type="content" source="media/verify-dataverse-process-registerflowmachine/customizations.png" alt-text="Screenshot of the Customizations setting that you can find it by selecting the Settings.":::

4. Select **Customize the System**.

    :::image type="content" source="media/verify-dataverse-process-registerflowmachine/customize-the-system.png" alt-text="Screenshot of the Customize the System option that you can open the feature by selecting it.":::

5. Go to **Components** > **Processes**, set the **View**  to **All**. Check the status of "RegisterFlowMachine" process. If the status is **Deactivated**, go to step 6.

    :::image type="content" source="media/verify-dataverse-process-registerflowmachine/registerflowmachine-process.png" alt-text="Screenshot that shows how to find the status of the RegisterFlowMachine process in Components.":::

6. Select the checkbox before the "RegisterFlowMachine" process name and then select **Activate**.

    :::image type="content" source="media/verify-dataverse-process-registerflowmachine/activate-process.png" alt-text="Screenshot that shows how to activate the RegisterFlowMachine process.":::

7. Open Machine runtime app and try to register again in the same environment.

## Processes which should be activated for Power Automate

- BatchGetFlowMachineStatus
- GetPublicKey
- LeaveGroup
- PowerAutomateProxy
- RegisterFlowMachine

## More information

For other registration issues, see [Machine registration failure in Power Automate](desktop-flow-machine-registration-troubleshooting.md).
