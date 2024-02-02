---
title: A button on the command bar isn't working correctly
description: Fixes an issue in which a button on the command bar isn't working correctly in Microsoft Power Apps.
ms.reviewer: krgoldie, srihas, tahoon
ms.date: 09/25/2023
---
# A button on the command bar isn't working correctly in Power Apps

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button isn't working correctly

Several factors can cause a button action to fail. These include invalid ribbon customizations in which the button's associated command definition is incorrectly declared.

> [!WARNING]
> Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface. Therefore, they might not work correctly.

If a command isn't correctly declared, selecting a button might either do nothing or display an error message.

Select one of the following options that best matches your situation to help us provide the best resolution. The first tab is selected by default.

### [Button does nothing when selected](#tab/nothing)

#### Fix a button that does nothing when selected

When a button is selected and nothing occurs, this is typically caused by an incorrect configuration of the [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) that's associated with the button.

The following are typical command configuration mistakes that are made when declaring the `JavaScriptFunction` value for [the action](/powerapps/developer/model-driven-apps/define-ribbon-actions). These mistakes can cause a button to malfunction and seem as though it does nothing when selected.

- **Invalid FunctionName**: The name of the JavaScript function doesn't match a valid function name in the JavaScript web resource that's assigned to the Library property.
- **Invalid Library**: This path isn't referring to a valid JavaScript web resource or isn't prefixed with `$webresource:`.
- **Missing parameters**: The JavaScript function is expecting specific parameters, and the command definition doesn't declare them.
- **Incorrect parameter type or order**: The parameters are declared by using an incorrect type or are in a different order than the one in which they're listed in the JavaScript function declaration.

Refer to [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions) for more configuration help.

If these configurations are correct, a JavaScript code error might be the cause. If the custom JavaScript function is coded incorrectly and doesn't invoke the expected behavior, the button won't work as expected. If you find one of the listed configuration mistakes, fix the command definition to resolve the issue. Otherwise, you might have to debug and fix the JavaScript function code to make the button work correctly.

Identify what the button command is and which solution installed the bad definition.

1. [Enable Command checker and select the command button to inspect](ribbon-issues.md#use-command-checker).
1. Select the **Command Properties** tab to display the details of the command for this button.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/command-properties.png" alt-text="Screenshot of the Command Properties tab of a button.":::

1. The **Command properties** tab displays the actions and the corresponding `JavaScriptFunction` configuration. Select the **View command definition solution layers** link below the command name to view the solutions that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers.png" alt-text="Screenshot of the View command definition solution layers link below a command name.":::

1. The Solution Layers pane displays the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that's used by the application. The other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition that's used by the application. If an unmanaged **Active** solution layer is present, it will always be the definition that the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition that's used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft-published solution layers.

    The Entity context indicates the object that the ribbon customization is on. If "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific. Otherwise, the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions that are provided by each solution.

    Selecting **Back** returns you to the previous Command Checker window.

    If there's only one solution layer, go to step 8. Otherwise, select the top two solution layers. (If you have a layer in the Active solution, but it's not listed at the top, select the Active solution layer, and then the top row.) Then, select **Compare**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-solution.png" alt-text="Screenshot to select the top two solution layers and select the Compare option.":::

1. The comparison of the current active definition and the previous inactive definition are displayed and will show the differences, if any. The following example shows that the unmanaged Active definition was customized by specifying the `FunctionName` value incorrectly, as compared to the other inactive definition in the Microsoft-published System solution layer. The `FunctionName` value is expected to be `XrmCore.Commands.Delete.deletePrimaryRecord`, but the custom definition has declared `FunctionName="deletePrimaryRecord"`. In this case, nothing will occur when the button is selected because the function can't be found.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison.png" alt-text="Screenshot shows the comparison of the current active definition and the previous inactive definition." lightbox="media/ribbon-issues-button-not-working-correctly/comparison.png":::

1. The approach that's required to fix the action functionality of a button will depend on the various customizations in your specific scenario. Considering the example, the command was customized by specifying an incorrect `FunctionName` value. You could modify the custom version of the command, and fix the `FunctionName` value. Because this is a custom override of a Microsoft-published definition, and there are no other intentional modifications, we recommend that you delete this custom version of the command to restore the default functionality.

Select one of the following repair options.

##### Option 1: Delete the command that has the incorrect JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution.</b></summary>

<!-- ###### Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution -->

To delete a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on the example scenario, you determined that the entity is **account**, the command that has to be deleted is `Mscrm.DeletePrimaryRecord`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
1. Select **Entities** > **Add Existing**.
1. Select the entity that your command is defined on (in the example, this is "account"), and then select **OK**.
1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node that you want to edit, and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In the example, the ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`. Therefore, you would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-node.png" alt-text="Screenshot shows the location of the CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node to remove the specific `<CommandDefinition>` node that has the ID of the command that you want to delete. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present. (Based on the example, you would delete the `<CommandDefinition>` node in which the ID is `Mscrm.DeletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/delete-node.png" alt-text="Screenshot to delete the CommandDefinition node.":::

1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific but, instead, is applicable to "All Entities" that are declared in the Application Ribbon, then the steps will be slightly different, as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>`, and remove the `<CommandDefinition>` node that has the ID of the command that you want to delete. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present.
1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored.</b></summary>

<!-- ###### Delete a command from a custom-managed solution -->

To delete a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-part or ISV).</b></summary>

<!-- ###### Delete a command from a custom-managed solution from a third-party/ISV -->

To delete a command that was installed by a custom-managed solution that was created by a third-party or ISV, you'll have to contact the author of the solution to request a new version of the solution that has the specific command definition removed, and then install this new solution in your affected organization.

</details>

##### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution.</b></summary>

<!-- ###### Fix the command JavaScriptFunction declaration in the unmanaged Active solution -->

To fix a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution that contains the entity or Application ribbon, edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution that contains the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

> [!WARNING]
> Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and might not work correctly.

###### The command is entity-specific

Based on the example scenario, you determined that the entity is **account**, the command that has to be fixed is `Mscrm.DeletePrimaryRecord`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
1. Select **Entities** > **Add Existing**.
1. Select the entity that your command is defined on (In the example, this is **account**), and then select **OK**.
1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node that you want to edit, and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In the example, the ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`. Therefore, you would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-example-node.png" alt-text="Screenshot shows the location of the example CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node, and make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on the example, you would modify the `<CommandDefinition>` node's `JavaScriptFunction` by setting the `FunctionName` value to `XrmCore.Commands.Delete.deletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/modify-node.png" alt-text="Screenshot to modify the CommandDefinition node's JavaScriptFunction by setting the FunctionName value.":::

1. Restore the modified _customizations.xml_ file to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific but, instead, is applicable to "All Entities" that are declared in the Application Ribbon, then the steps will be slightly different, as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit the `<RibbonDiffXml>` node to make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored.</b></summary>

<!-- ###### Fix a command from a custom-managed solution -->

To fix a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or that my organization does not own (from a third-party/ISV).</b></summary>

<!-- ###### Fix a command from a custom-managed solution from a third-party/ISV -->

To fix a command that was installed by a custom-managed solution that was created by a third-party or ISV, you'll have to contact the author of the solution to request a new version of the solution that contains the fixed command definition, and install this new solution in your affected organization.

</details>

### I receive script error message: "Invalid JavaScript Action Library"](#tab/error)

#### Fix a button that displays an error when selected

If a ribbon command bar button is selected and an error occurs, the error is typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix Script Error "Invalid JavaScript Action Library"

You might receive a script error message that resembles the following:

> Invalid JavaScript Action Library: [script name] is not a web resource and is not supported.

:::image type="content" source="media/ribbon-issues-button-not-working-correctly/script-error.png" alt-text="Screenshot shows an example of the script error message.":::

This is caused by an invalid ribbon command customization that has declared an incorrect Library on the command's `JavaScriptFunction`.

1. [Enable Command checker and select the command button to inspect](ribbon-issues.md#use-command-checker).
1. The following example shows the **New** button on the account entity's form page is visible and is represented by an item labeled **New**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/new-button.png" alt-text="Screenshot shows the New button on the account entity's form page.":::

1. Select the **Command Properties** tab to display the details of the command for this button. This will display the **Actions** and JavaScriptFunction declaration, and any enable or display the rules together with the result (**True**, **False**, **Skipped**) of each rule evaluation.

    Expand **JavaScriptFunction**, by selecting the "chevron" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/chevron-icon.png"::: icon to view the details of the function declaration. The Library property must be a JavaScript web resource and be prefixed with `$webresource:`. The following example shows that the Library property is _/_static/_common/scripts/RibbonActions.js_. This isn't a path to a valid JavaScript web resource. You should next review the solution layers of the command to try to identify the correct value to fix the issue.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/library-property.png" alt-text="Screenshot shows an example of the Library property.":::

1. Select the **View command definition solution layers** link below the command name to view the solutions that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers-link.png" alt-text="Screenshot of the View command definition solution layers link below the command name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that's used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft-published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    The following image shows the solution layers for the command in the example, and indicates that there's two solution layers, and one is an unmanaged customization as denoted by the solution titled Active and the other is from the System solution published by Microsoft. Your actual scenario might differ, you might not have an Active solution layer, you might have a managed solution and the name of that solution will be listed here.

    Select the top two rows and select **Compare** to view a comparison of the definitions brought in by each solution. If you only have one solution layer, then you'll skip this step.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-comparison.png" alt-text="Screenshot to select the top two rows and select the Compare option to view a comparison of the definitions.":::

1. The comparison between command definitions will show any differences that might exist between the two layers. The following example clearly shows that the Library value is different. The unmanaged entry from the Active solution is set to an incorrect path _/_static/_common/scripts/RibbonActions.js_ (your specific path might be slightly different), and the default definition from Microsoft has set the library to `$webresoure:Main_system_library.js`. This is a supported path for this particular command (this value might be different, depending on your particular command). The only supported path is one that begins with `$webresource:` and ends with the name of a valid JavaScript web resource.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison-library-value.png" alt-text="Screenshot shows an example where the Library value is different.":::

1. Now that you have reviewed the solution layers and determined the solution that installed the customization, you must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution.</b></summary>

The approach to fix the command will vary depending on whether your definition is the only one, or if there are other inactive definitions, and whether the changes were intentional.

Select the option that reflects your scenario:

- <details>
  <summary><b>The command does not have any intentional modifications, and I want to remove this custom layer.</b></summary>

  <!-- **Fix Script Error Invalid JavaScript Action Library from the unmanaged Active solution - Delete Layer** -->

    To delete a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution that contains the entity or Application Ribbon, edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

    **The command is entity-specific**

    Based on the example scenario, you determined that the entity is **account**, the command that has to be deleted is `Mscrm.NewRecordFromForm`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
    1. Select **Entities** > **Add Existing**.
    1. Select the entity that your command is defined on. (In the example, this is **account**), and then select **OK**.
    1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
    1. Select **Save**.
    1. Select **Export Solution**, and export the unmanaged solution.
    1. Extract the .zip file.
    1. Open the _customizations.xml_ file.
    1. Locate the `<Entity>` node child of the entity node that you want to edit, and locate its child `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node (In the example, ID of the `<CommandDefinition>` is `Mscrm.NewRecordFromForm`. Therefore, you would locate the following node.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-command-definition-node.png" alt-text="Screenshot of the location of the CommandDefinition node.":::

    1. Edit the `<RibbonDiffXml>` node to remove the specific `<CommandDefinition>` node. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present. (Based on the example, you would delete the `<CommandDefinition>` node in which the ID is `Mscrm.NewRecordFromForm`.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/delete-node-example.png" alt-text="Screenshot shows an example to delete the CommandDefinition node.":::

    1. Save the _customizations.xml_ file.
    1. Restore the modified _customizations.xml_ file to the solution .zip file.
    1. Import the solution file.
    1. Select **Publish All Customizations**.

    **The command is in the Application Ribbon (applies to "All entities")**

    If the command isn't entity-specific but, instead, is applicable to "All Entities" that are declared in the Application Ribbon, then the steps will be slightly different, as follows:

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
    1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
    1. Select **Save**.
    1. Select **Export Solution**, and export the unmanaged solution.
    1. Extract the .zip file.
    1. Open the _customizations.xml_ file.
    1. Locate the root `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node.
    1. Edit `<RibbonDiffXml>` to remove the `<CommandDefinition>` node that has the matching ID of the command that you want to delete. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present.
    1. Save the _customizations.xml_ file.
    1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
    1. Import the solution file.
    1. Select **Publish All Customizations**.

  </details>

- <details>
  <summary><b>The command has additional modifications that I want to retain, and I want to fix this solution layer.</b></summary>

  <!-- **Fix Script Error "Invalid JavaScript Action Library" from the unmanaged Active solution** -->

    To fix a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

    > [!WARNING]
    > Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and might not work correctly.

    **The command is entity-specific**

    Based on the example scenario, you determined that the entity is **account**, the command that has to be fixed is `Mscrm.NewRecordFromForm`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Select **New** to create a new solution, and set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
    1. Select **Entities** > **Add Existing**.
    1. Select the entity that your command is defined on (In the example, this is **account**), and then select **OK**.
    1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
    1. Select **Save**.
    1. Select **Export Solution**, and export the unmanaged solution.
    1. Extract the .zip file.
    1. Open the _customizations.xml_ file
    1. Locate the `<Entity>` node child of the entity node you want to edit, and locate its child `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node. (In the example, the ID of the `<CommandDefinition>` node is `Mscrm.NewRecordFromForm`. Therefore, you would locate the following node.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-node-id.png" alt-text="Screenshot shows the location of the CommandDefinition node whose ID is Mscrm.NewRecordFromForm.":::

    1. Edit `<RibbonDiffXml>` to make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands) and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on the example, you would modify the `<CommandDefinition>` node by setting `Library="$webresoure:Main_system_library.js"`, and then make sure that the `FunctionName` value matches. In the example, that would be `FunctionName="XrmCore.Commands.Open.openNewRecord"`.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/modify-node-value-match.png" alt-text="Screenshot to modify the CommandDefinition node, and then make sure that the FunctionName value matches.":::

    1. Save the _customizations.xml_ file.
    1. Restore the modified _customizations.xml_ file to the solution .zip file.
    1. Import the solution file.
    1. Select **Publish All Customizations**.

    **The command is in the Application Ribbon (applies to "All entities")**

    If the command isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
    1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
    1. Select **Save**.
    1. Select **Export Solution**, and export the unmanaged solution.
    1. Extract the .zip file.
    1. Open the _customizations.xml_ file.
    1. Locate the root `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node.
    1. Edit the `<RibbonDiffXml>` node to make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
    1. Save the _customizations.xml_ file.
    1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
    1. Import the solution file.
    1. Select **Publish All Customizations**.

  </details>

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored.</b></summary>

<!-- ###### Fix a command from a custom-managed solution -->

To fix a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or that my organization does not own (from a third-party or ISV).</b></summary>

<!-- ###### Fix a command from a custom-managed solution from a third-party/ISV -->

To fix a command that was installed by a custom-managed solution that was created by a third-party or ISV, you'll have to contact the author of the solution to request a new version of the solution that contains the fixed command definition, and then install this new solution in your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft-published managed solution.</b></summary>

<!-- ###### Fix a command from a Microsoft-published managed solution -->

To fix a command that was installed by a Microsoft-published managed solution, you might need to have a newer version of the solution be installed. This would typically be done during a release update. It's possible that you have identified a bug that still has to be fixed. Contact Customer Support for assistance.

</details>

### [I receive a different error message](#tab/different-error)

#### Fix a button that displays an error when selected

When a ribbon command bar button is selected and an error occurs, it's typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix other types of errors

When a button is selected and an error occurs, it might be caused by an incorrect configuration of the command associated with the button or by incorrectly coded JavaScript.

Let's identify what the button's command is and what solution installed the definition.

1. [Enable Command checker and select the command button to inspect](ribbon-issues.md#use-command-checker).
1. Select the **Command Properties** tab to display the details of the command for this button.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/command-properties.png" alt-text="Screenshot of the Command Properties tab of the Delete button.":::

1. The **Command properties** tab will display the **Actions** and corresponding JavaScriptFunction configuration. Select the **View command definition solution layers** link below the command name to view the solutions that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers.png" alt-text="Screenshot highlights the View command definition solution layers link below the command name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that's used by the application. The other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft-published solution layers.

    The Entity context indicates the object that the ribbon customization is on. If "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity-specific. Otherwise, the logical name of the entity will be listed.

    If there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions that are provided by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    If there's only one solution layer, skip to step 9. Otherwise, select the top two solution layers. (If you have a layer in the Active solution, but it's not listed at the top, select the Active solution layer and then the top row.) Then, select **Compare**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-solution.png" alt-text="Screenshot to select the top two solution layers and then select the Compare option.":::

1. The comparison of the current active definition and the previous inactive definition will be displayed and show the differences, if any. The following example shows the unmanaged Active definition to have been customized by specifying the first parameter incorrectly as compared to the other inactive definition in the Microsoft-published System solution layer. The function is expecting a single ID of the primary record, as declared by the CrmParameter that's named **FirstPrimaryItemId**. However, the custom definition has declared the `PrimaryItemIds` value of the `<CrmParameter>` node. This will cause the script to throw an error because the parameters don't match the function signature.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison-two-definition.png" alt-text="Screenshot shows the differences of the comparison of the current active definition and the previous inactive definition.":::

1. The approach that's required to fix a button action functionality will depend on the various customizations in your specific scenario. Considering the example, the command was customized by specifying the first parameter incorrectly. You could modify the custom version of the command and fix the parameter. Because this is a custom override of a Microsoft-published definition, and there are no other intentional modifications, we recommend that you delete this custom version of the command to restore the default functionality.

Select one of the following repair options.

###### Option 1: Delete the command with the invalid JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution.</b></summary>

<!-- **Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution** -->

To delete a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

**The command is entity-specific**

Based on the example scenario, you determined that the entity is **account**, the command that has to be deleted is `Mscrm.DeletePrimaryRecord`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
1. Select **Entities** > **Add Existing**.
1. Select the entity that your command is defined on (in the example, this is **account**) and then select **OK**.
1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node that you want to edit, and then locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In the example, the ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`. Therefore, you would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-node.png" alt-text="Screenshot shows the location of an example CommandDefinition node with an ID of Mscrm.DeletePrimaryRecord.":::

1. Edit the `<RibbonDiffXml>` node to remove the specific `<CommandDefinition>` node that has the ID of the command that you want to delete. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present. (Based on the example, you would delete the `<CommandDefinition>` node in which the ID is `Mscrm.DeletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/delete-node.png" alt-text="Screenshot to delete the CommandDefinition node in which the ID is Mscrm.DeletePrimaryRecord.":::

1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

**The command is in the Application Ribbon (applies to "All entities")**

If the command isn't entity-specific but, instead, is applicable to "All entities" that are declared in the Application Ribbon, then the steps will be slightly different, as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>` and remove the `<CommandDefinition>` node that has the ID of the command that you want to delete. Make sure that you don't unintentionally delete other `<CommandDefinition>` nodes that might be present.
1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored.</b></summary>

<!-- **Delete a command from a custom-managed solution** -->

To delete a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-party or ISV).</b></summary>

**Delete a command from a custom-managed solution from a third-party/ISV**

To delete a command that was installed by a custom-managed solution that was created by a third-party or ISV, you'll have to contact the author of the solution to request a new version of the solution that has the specific command definition removed, and then install this new solution in your affected organization.

</details>

###### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution.</b></summary>

<!-- **Fix the command JavaScriptFunction declaration in the unmanaged Active solution** -->

To fix a command in the **Active** unmanaged solution layer, you'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

> [!WARNING]
> Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and might not work correctly.

**The command is entity-specific**

Based on the example scenario, you determined that the entity is **account**, the command that has to be fixed is `Mscrm.DeletePrimaryRecord`, and it's declared in the **Active** unmanaged solution layer from a publisher that's named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In the example, this is **DefaultPublisherCITTest**.)
1. Select **Entities** > **Add Existing**.
1. Select the entity that your command is defined on (in the example, this is **account**), and select **OK**.
1. Make sure that you clear the **Include entity metadata** and **Add all assets** options before you select **Finish**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node that you want to edit, and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In the example, the ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`. Therefore, you would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/locate-example-node.png" alt-text="Screenshot shows the location of the CommandDefinition node with an ID of Mscrm.DeletePrimaryRecord.":::

1. Edit the `<RibbonDiffXml>` node to make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on the example, you would modify the `<CommandDefinition>` node's `JavaScriptFunction` by setting the `FunctionName` value to `XrmCore.Commands.Delete.deletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/modify-node.png" alt-text="Screenshot to modify the CommandDefinition node's JavaScriptFunction by setting the FunctionName value.":::

1. Restore the modified _customizations.xml_ file to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

**The command is in the Application Ribbon (applies to "All entities")**

If the command isn't entity-specific but, instead, applicable to "All Entities" that are declared in the Application Ribbon, then the steps will be slightly different, as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, and set **Publisher** to the value that's shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution**, and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit the `<RibbonDiffXml>` node to make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
1. Save the _customizations.xml_ file.
1. Restore the modified _customizations.xml_ file to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored.</b></summary>

<!-- **Fix a command from a custom-managed solution** -->

To fix a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the previous steps for the **The command is in the unmanaged Active solution** option.
1. Increment the **Version** of your custom solution.
1. Export the solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or that my organization does not own (from a third-party or ISV).</b></summary>

<!-- **Fix a command from a custom-managed solution from a third-party/ISV** -->

To fix a command that was installed by a custom-managed solution that was created by a third-party or ISV, you'll have to contact the author of the solution to request a new version of the solution that contains the fixed command definition, and then install this new solution in your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft-published managed solution.</b></summary>

<!-- **Fix a command from a Microsoft-published managed solution** -->

To fix a command that was installed by a Microsoft-published managed solution, you might need to have a newer version of the solution be installed. This would typically be done during a release update. It's possible that you have identified a bug that still has to be fixed. Contact Customer Support for assistance.

</details>

## Reference

[Command checker for model-driven app ribbons](https://powerapps.microsoft.com/blog/introducing-command-checker-for-model-app-ribbons/)
