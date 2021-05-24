---
title: How to regenerate ribbon metadata
description: Describes how to start the regeneration ribbon metadata operation and check the status.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/19/2021
---
# How to regenerate ribbon metadata

_Applies to:_ &nbsp; Power Apps  

The following ribbon command bar issues are often caused by missing or incorrect ribbon metadata: 

- A button in the command bar is hidden when it should not be
- A button in the command bar is visible when it should not be
- A button in the command bar is not working correctly

You can use an in-app tool (**Command Checker**) to regenerate all ribbon metadata.

## How to start the regeneration operation

The **Command Checker** tool can be used to start the regeneration of ribbon metadata. To enable the **Command Checker** tool, you must append a parameter `&ribbondebug=true` to your Dynamics 365 application URL. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`

:::image type="content" source="media/regenerate-ribbon-metadata/enable-command-checker.png" alt-text="Screenshot of the parameter.":::

After the **Command Checker** tool has been enabled, within the application in each of the various command bars (global, form, grid, subgrid), there will be a new special "Command Checker" :::image type="icon" source="media/regenerate-ribbon-metadata/command-checker-button-icon.png" border="false"::: button to open the tool (it may be listed in the "More" overflow flyout menu). To open the **Command Checker** tool, click the button from any command bar.

:::image type="content" source="media/regenerate-ribbon-metadata/open-command-checker.png" alt-text="Open command checker.":::

After the **Command Checker** dialog has been displayed, click the **Regenerate ribbon metadata** button to start the regeneration of the entire ribbon metadata.

:::image type="content" source="media/regenerate-ribbon-metadata/regenerate-ribbon-metadata.png" alt-text="Regenerate ribbon metadata.":::

On the confirmation prompt with instructions, click **OK** to start the regeneration.

:::image type="content" source="media/regenerate-ribbon-metadata/confirmation-prompt.png" alt-text="Confirmation prompt.":::

## How to check the operation status

After the ribbon metadata regeneration is triggered, a background operation is started. You can check the status of the operation on the **Solutions History** page. (Open **Advanced Settings**, navigate to **Settings** > **Solutions** > **Solutions History**)

:::image type="content" source="media/regenerate-ribbon-metadata/advanced-settings.png" alt-text="Advanced settings.":::

In the **Ribbon Metadata Generation Operations** view, a **RibbonMetadataGeneration** operation with the **Started** status is added as follows:

:::image type="content" source="media/regenerate-ribbon-metadata/ribbonmetadatageneration.png" alt-text="Screenshot of the RibbonMetadataGeneration operation.":::

> [!NOTE]
> The operation will take several minutes to complete. When it is finished, the **Status** will be marked as **Completed**, with the Result marked as **Success** or **Failure**.

:::image type="content" source="media/regenerate-ribbon-metadata/ribbonmetadatageneration-status.png" alt-text="Screenshot of the RibbonMetadataGeneration operation status.":::

After the **RibbonMetadataGeneration** operation is completed successfully, clear your browser cache and reopen your application to verify the issue again. If issue isn't resolved, you can follow the [ribbon troubleshoot guidelines](ribbon-issues.md#identify-the-issue) for other mitigation.
