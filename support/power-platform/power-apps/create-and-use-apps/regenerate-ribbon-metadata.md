---
title: How to regenerate ribbon metadata
description: Describes how to start the regeneration ribbon metadata operation and check the status.
ms.reviewer: krgoldie, srihas, tahoon
ms.date: 09/25/2023
---
# How to regenerate ribbon metadata

_Applies to:_ &nbsp; Power Apps  

The following ribbon command bar issues are often caused by missing or incorrect ribbon metadata:

- A button on the command bar is hidden when it should be visible.
- A button on the command bar is visible when it should be hidden.
- A button on the command bar is not working correctly.

An in-app tool, Command Checker, is available to help you regenerate all ribbon metadata. Only system administrators, system customizers, and makers have the permissions to regenerate metadata.

## How to start the regeneration operation

You can use the Command Checker tool to start the regeneration of ribbon metadata. To enable Command Checker, append the `&ribbondebug=true` parameter to your Dynamics 365 application URL. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`.

:::image type="content" source="media/regenerate-ribbon-metadata/enable-command-checker.png" alt-text="Screenshot shows the parameter is appended to a Dynamics 365 application U R L." lightbox="media/regenerate-ribbon-metadata/enable-command-checker.png":::

After Command Checker is enabled, a new special "Command Checker" :::image type="icon" source="media/regenerate-ribbon-metadata/command-checker-button-icon.png" border="false"::: program button is available within the application on each of the various command bars (global, form, grid, and subgrid). (The button might be included on the **More** overflow flyout menu). To open Command Checker, select the button on any command bar.

:::image type="content" source="media/regenerate-ribbon-metadata/open-command-checker.png" alt-text="Screenshot of the Command Checker program button on a command bar.":::

After the **Command Checker** dialog box opens, select the **Regenerate ribbon metadata** button to start regenerating all the ribbon metadata.

:::image type="content" source="media/regenerate-ribbon-metadata/regenerate-ribbon-metadata.png" alt-text="Screenshot to select the Regenerate ribbon metadata button.":::

On the confirmation prompt with instructions, select **OK** to start the regeneration.

:::image type="content" source="media/regenerate-ribbon-metadata/confirmation-prompt.png" alt-text="Screenshot of the confirmation prompt with instructions.":::

## How to check the operation status

After the ribbon metadata regeneration is triggered, a background operation begins. You can check the status of the operation on the **Solutions History** page. (Open **Advanced Settings**, and then navigate to **Settings** > **Solutions** > **Solutions History**.)

:::image type="content" source="media/regenerate-ribbon-metadata/advanced-settings.png" alt-text="Screenshot to select the Advanced Settings item.":::

In **Ribbon Metadata Generation Operations** view, a **RibbonMetadataGeneration** operation with the **Started** status is added, as follows.

:::image type="content" source="media/regenerate-ribbon-metadata/ribbon-metadata-generation.png" alt-text="Screenshot shows that a RibbonMetadataGeneration operation with the Started status is added." lightbox="media/regenerate-ribbon-metadata/ribbon-metadata-generation.png":::

> [!NOTE]
> The operation will take several minutes to finish. After it finishes, the **Status** value will change to **Completed**, and the **Result** value will be set to **Success** or **Failure**, as appropriate.

:::image type="content" source="media/regenerate-ribbon-metadata/ribbon-metadata-generation-status.png" alt-text="Screenshot of the RibbonMetadataGeneration operation status." lightbox="media/regenerate-ribbon-metadata/ribbon-metadata-generation-status.png":::

After the **RibbonMetadataGeneration** operation is completed successfully, clear your browser cache, and then reopen your application to check for the issue again. If the issue isn't resolved, you can follow the steps that are provided in [ribbon troubleshoot guidelines](ribbon-issues.md) for additional mitigation information.

## Reference

[Command checker for model-driven app ribbons](https://powerapps.microsoft.com/blog/introducing-command-checker-for-model-app-ribbons/)
