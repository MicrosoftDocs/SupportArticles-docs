---
title: A button in the command bar is not working correctly
description: Fixes an issue in which a button in the command bar is not working correctly.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/20/2021
---
# A button in the command bar is not working correctly

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button is not working correctly

There are several factors that can cause a button's action to not work correctly. These are due to invalid ribbon customizations in which the button's associated command definition is incorrectly declared.

> [!WARNING]
> Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

If a command is not properly declared, clicking on a button may either do nothing or display an error.

Please select one of the following options that best matches your situation to help us provide the best resolution. The first tab is selected by default.

### [The button does nothing when clicked](#tab/nothing)

#### Fix a button that does nothing when clicked

When a button is clicked and nothing happens, this is typically caused by an incorrect configuration of the [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) associated with the button.

The following command configuration mistakes when declaring the [action's](/powerapps/developer/model-driven-apps/define-ribbon-actions) `JavaScriptFunction` can result in a button to seem as though it does nothing when clicked:

- **Invalid FunctionName** - If the name of the JavaScript function does not match a valid function name in the JavaScript web resource that is assigned to the Library property, then the button will do nothing.
- **Invalid Library** - If this path is not referring to a valid JavaScript web resource or is not prefixed with "$webresource:", then the button will not work.
- **Missing parameters** - If the JavaScript function is expecting specific parameters and the command definition does not declare them, then the button won't function properly.
- **Incorrect parameter type or order** - If the parameters are declared with an incorrect type or are in a different order than how they are listed in the JavaScript function declaration, then the button may not work as expected.

Refer to [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions) for more configuration help.

If the above configurations are correct, it is possible that there is JavaScript code error. If the custom JavaScript function is coded incorrectly and simply does not invoke the expected behavior, then the button will fail to work as anticipated. If you identify one of the above configuration mistakes, fix the command definition to resolve the issue. Otherwise, you may need to debug and fix the JavaScript function code for the button to work correctly.

Let's identify what the button's command is and what solution installed the definition.

We will use an in-app tool called the **Command Checker** to inspect the ribbon component definitions to help us determine why click the button results in an error.

To enable the **Command Checker** tool, you must append a `&ribbondebug=true` parameter to your Dynamics 365 application URL. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`

:::image type="content" source="media/ribbon-issues-button-not-working-correctly/enable-command-checker.png" alt-text="Screenshot of the parameter.":::

> [!NOTE]
> Currently the **Command Checker** tool only works in a web browser and does not work in Android and iOS apps. A future update is planned to make this work in these mobile apps.

Once the **Command Checker** tool has been enabled, within the application in each of the various command bars (global, form, grid, subgrid), there will be a new special "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button to open the tool (it may be listed in the "More" overflow flyout menu).

1. Navigate to the page in the application where the button is displayed.
1. Locate the command bar that the button visible in.
1. Click the "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button (it may be listed in the "More" overflow flyout menu).
1. Find and click your button in the list of buttons displayed in the left-most pane of the **Command Checker** tool. Buttons that are not visible will be denoted by de-emphasized and italicized font along with the **(hidden)** term. Buttons that are visible will be displayed with the label in the normal font. Click the **Command Properties** tab to display the details of the command for this button.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/command-properties.png" alt-text="Command properties.":::

1. The **Command properties** tab will display the Actions and corresponding `JavaScriptFunction` configuration. Click the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers.png" alt-text="View command definition solution layers.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and are not used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged Active solution layer is present, it will always be the definition the application uses. If there is no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and click **Compare** to view a comparison of the definitions brought in by each solution.

    Clicking **Back** will return to the previous Command Checker window.

    > [!NOTE]
    > At the time of writing this guide, the Command Checker's Solution Layers pane has a bug that may list an unmanaged Active solution layer below other layers even though it is expected to always be on top. This same bug may also list custom managed solutions not published by Microsoft below other Microsoft published solution layers even though they are expected to be just below the unmanaged Active solution layer and above Microsoft solution layers, or if there is no unmanaged Active solution layer, then it would be expected to be the top layer. Regardless of the order placement in this list, when an unmanaged Active solution layer is present, it will always be the definition the application uses. Regardless of the order placement in this list, any custom managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers, if there is no unmanaged Active solution layer. This bug has been fixed and is expected to be deployed with release train 4.1 to online regions starting in April 2020.

    If there is only one solution layer, skip to step 8, otherwise, select the top two solution layers (If you have a layer in the Active solution, but it is not listed at the top, select the Active solution layer and then the top row) and click **Compare**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-solution.png" alt-text="Compare solution.":::

1. The comparison of the current active definition and the previous inactive definition will be displayed showing the differences, if any. The following example shows the unmanaged Active definition to have been customized by specifying the `FunctionName` value incorrectly as compared to the other inactive definition in the Microsoft published System solution layer. The `FunctionName` value is expected to be `XrmCore.Commands.Delete.deletePrimaryRecord`, but the custom definition has declared `FunctionName="deletePrimaryRecord"` which will result in nothing happening when the button is clicked since the function cannot be found.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison.png" alt-text="Comparison.":::

1. The approach needed to fix a button's action functionality will depend on the various customizations in your specific scenario. Considering our example, the command was customized by specifying an incorrect the `FunctionName` value. We could modify the custom version of the command and fix the `FunctionName` value. Since this is a custom override of a Microsoft published definition and there are no other intentional modifications, it is recommended that this custom version of the command be deleted to restore the default functionality.

Please select one of the following repair options:

##### Option 1: Delete the command with the incorrect JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

###### Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution

To delete a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **account** and the command that needs to be deleted is `Mscrm.DeletePrimaryRecord` and it is declared in the"Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** -> **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is account) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`, so we would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example.png" alt-text="commanddefinition example.":::

1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.DeletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-2.png" alt-text="Second command definition example.":::

1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Click **Client Extensions**.
1. Click **Add Existing**.
1. Click **Application Ribbons**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>` and remove the `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present.
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored</b></summary>

###### Delete a command from a custom-managed solution

To delete a command that was installed by a custom-managed solution that you created, you must complete the steps listed above for the "The command is in the unmanaged Active solution" option in your separate development organization that has the unmanaged source version of your custom solution used to create your custom-managed solution. Once you have completed those steps, then you will export a new managed version of your solution that can be imported into your target affected organization to fix the customizations.

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the "The command is in the unmanaged Active solution" option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-party/ISV)</b></summary>

###### Delete a command from a custom-managed solution from a third-party/ISV

To delete a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that has removed the specific command definition and then install this new solution into your affected organization.

</details>

##### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

###### Fix the command JavaScriptFunction declaration in the unmanaged Active solution

To fix a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

> [!WARNING]
> Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

###### The command is entity-specific

Based on our example scenario, we identified the entity is account and the command that needs to be fixed is `Mscrm.DeletePrimaryRecord` and it is declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **account**) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-3.png" alt-text="Third command definition example.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on our example, we would modify the `<CommandDefinition>` node's `JavaScriptFunction` by setting the `FunctionName` value to `XrmCore.Commands.Delete.deletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-4.png" alt-text="Fourth command definition example.":::

1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Click **Client Extensions**.
1. Click **Add Existing**.
1. Click **Application Ribbons**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored</b></summary>

###### Fix a command from a custom-managed solution

To fix a command that was installed by a custom-managed solution that you created, you must complete the steps listed above for the "The command is in the unmanaged Active solution" option in your separate development organization that has the unmanaged source version of your custom solution used to create your custom-managed solution. Once you have completed those steps, then you will export a new managed version of your solution that can be imported into your target affected organization to fix the customizations.

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the "The command is in the unmanaged Active solution" option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

###### Fix a command from a custom-managed solution from a third-party/ISV

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

### [I get a Script Error "Invalid JavaScript Action Library"](#tab/error)

#### Fix a button that displays an error when clicked

When a ribbon command bar button is clicked and an error occurs, it is typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix Script Error "Invalid JavaScript Action Library"

If you are getting a Script Error that is similar to the following:

> Invalid JavaScript Action Library: [script name] is not a web resource and is not supported.

:::image type="content" source="media/ribbon-issues-button-not-working-correctly/script-error.png" alt-text="Script error.":::

This is caused by an invalid ribbon command customization that has declared an incorrect Library on the command's `JavaScriptFunction`.

We will use an in-app tool called the **Command Checker** tool to inspect the ribbon component definitions to help us determine how to fix this issue.

To enable the **Command Checker** tool, you must append a `&ribbondebug=true` parameter to your Dynamics 365 application URL. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`

:::image type="content" source="media/ribbon-issues-button-not-working-correctly/enable-command-checker.png" alt-text="Screenshot of the parameter.":::

> [!NOTE]
> Currently the **Command Checker** tool only works in a web browser and does not work in Android and iOS apps. A future update is planned to make this work in these mobile apps.

Once the **Command Checker** tool has been enabled, within the application in each of the various command bars (global, form, grid, subgrid), there will be a new special "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button to open the tool (it may be listed in the "More" overflow flyout menu).

1. Navigate to the page in the application where the button is displayed.
1. Locate the command bar that the button visible in.
1. Click the "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button (it may be listed in the "More" overflow flyout menu).
1. Find and click your button in the list of buttons displayed in the left-most pane of the **Command Checker** tool to show the button and command properties. The following example shows the **New** button on the account entity's form page is visible and is represented by an item labeled **New**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/new-button.png" alt-text="New button.":::

1. Click the **Command Properties** tab to display the details of the command for this button. This will display the Actions and JavaScriptFunction declaration, and any enable/display rules, along with the result (**True**, **False**, **Skipped**) of each rule evaluation.

    Expand **JavaScriptFunction**, by clicking on the "chevron" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/chevron-icon.png"::: icon to view the details of the function declaration. The Library property must be a JavaScript web resource and be prefixed with `$webresource:`. The following example shows that the Library property is */_static/_common/scripts/RibbonActions.js*. It is not a path to a valid JavaScript web resource. We should next review the solution layers of the command to attempt to identify the correct value to fix the issue.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/library-property.png" alt-text="Library property.":::

1. Click the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers-2.png" alt-text="View command definition solution layers.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and are not used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged Active solution layer is present, it will always be the definition the application uses. If there is no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and click **Compare** to view a comparison of the definitions brought in by each solution.

    Clicking **Back** will return to the previous Command Checker window.

    > [!NOTE]
    > At the time of writing this guide, the Command Checker's Solution Layers pane has a bug that may list an unmanaged Active solution layer below other layers even though it is expected to always be on top. This same bug may also list custom managed solutions not published by Microsoft below other Microsoft published solution layers even though they are expected to be just below the unmanaged Active solution layer and above Microsoft solution layers, or if there is no unmanaged Active solution layer, then it would be expected to be the top layer. Regardless of the order placement in this list, when an unmanaged Active solution layer is present, it will always be the definition the application uses. Regardless of the order placement in this list, any custom managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers, if there is no unmanaged Active solution layer. This bug has been fixed and is expected to be deployed with release train 4.1 to online regions starting in April 2020.

    The following image shows the solution layers for the command in our example, and indicates that there is two solution layers, and one is an unmanaged customization as denoted by the solution titled Active and the other is from the System solution published by Microsoft. Your actual scenario may differ, you may not have an Active solution layer, you may have a managed solution and the name of that solution will be listed here.

    Select the top two rows and click **Compare** to view a comparison of the definitions brought in by each solution. If you only have one solution layer, then you will skip this step.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-solution-2.png" alt-text="Compare solution.":::

1. The comparison between command definitions will show any differences that may exist between the two layers. The following example clearly shows that the Library value is different. The unmanaged entry from the Active solution is set to an incorrect path */_static/_common/scripts/RibbonActions.js* (your specific path may be slightly different) and the default definition from Microsoft has set the Library to `$webresoure:Main_system_library.js`, which is a supported path for this particular command (this value may be different depending on your particular command). The only supported path is one that begins with `$webresource:` and ends with the name of a valid JavaScript web resource.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison-2.png" alt-text="Comparison.":::

1. Now that we have reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

The approach to fix the command will vary depending if your definition is the only one, or if there are other inactive definitions, and whether or not the changes were intentional.

Please select the option that reflects your scenario:

- <details>
  <summary><b>The command does not have any intentional modifications and I would like to remove this custom layer</b></summary>

  **Fix Script Error Invalid JavaScript Action Library from the unmanaged Active solution - Delete Layer**

    To delete a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

    **The command is entity-specific**

    Based on our example scenario, we identified the entity is **account** and the command that needs to be deleted is `Mscrm.NewRecordFromForm` and it is declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
    1. Click **Entities**.
    1. Click **Add Existing**.
    1. Select the entity your command is defined on (In our example, this is **account**) and click **OK**.
    1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
    1. Click **Save**.
    1. Click **Export Solution** and export unmanaged solution.
    1. Extract the .zip file.
    1. Open the *customizations.xml* file.
    1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node (In our example, ID of the `<CommandDefinition>` is `Mscrm.NewRecordFromForm`, so we would locate the following node.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-5.png" alt-text="Fifth command definition example. ":::

    1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node. Make sure you don't unintentionally delete other `<CommandDefinition>` node that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.NewRecordFromForm`.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-6.png" alt-text="Sixth command definition example. ":::

    1. Save the *customizations.xml* file.
    1. Add the modified *customizations.xml* file back to the solution .zip file.
    1. Import the solution file.
    1. Click **Publish All Customizations**.

    **The command is in the Application Ribbon (applies to "All entities")**

    If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
    1. Click **Client Extensions**.
    1. Click **Add Existing**.
    1. Click **Application Ribbons**.
    1. Click **Save**.
    1. Click **Export Solution** and export unmanaged solution.
    1. Extract the .zip file.
    1. Open the *customizations.xml* file.
    1. Locate the root `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node.
    1. Edit the `<RibbonDiffXml>` and remove the `<CommandDefinition>` node that has the matching ID of the command we wish to be deleted. Make sure you don't unintentionally delete other `<CommandDefinition>` node that may be present.
    1. Save the *customizations.xml* file.
    1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
    1. Import the solution file.
    1. Click **Publish All Customizations**.

  </details>

- <details>
  <summary><b>The command has additional modifications that I would like to retain and want to fix this solution layer</b></summary>

  **Fix Script Error "Invalid JavaScript Action Library" from the unmanaged Active solution**

    To fix a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution containing the fixed command definition. See Export, prepare to edit, and import the ribbon

    > [!WARNING]
    > Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

    **The command is entity-specific**

    Based on our example scenario, we identified the entity is **account** and the command that needs to be fixed is `Mscrm.NewRecordFromForm` and it is declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
    1. Click **Entities**.
    1. Click **Add Existing**.
    1. Select the entity your command is defined on (In our example, this is **account**) and click **OK**.
    1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
    1. Click **Save**.
    1. Click **Export Solution** and export unmanaged solution.
    1. Extract the .zip file.
    1. Open the *customizations.xml* file
    1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.NewRecordFromForm`, so we would locate the following node.)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-7.png" alt-text="Seventh command definition example. ":::

    1. Edit the `<RibbonDiffXml>` and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands) and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on our example, we would modify the `<CommandDefinition>` node by setting `Library="$webresoure:Main_system_library.js"` and make sure the `FunctionName` value matches. In our example, `FunctionName="XrmCore.Commands.Open.openNewRecord"`)

        :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-8.png" alt-text="Eighth command definition example. ":::

    1. Save the *customizations.xml* file.
    1. Add the modified *customizations.xml* file back to the solution .zip file.
    1. Import the solution file.
    1. Click **Publish All Customizations**.

    **The command is in the Application Ribbon (applies to "All entities")**

    If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

    1. Open **Advanced Settings**.
    1. Navigate to **Settings** > **Solutions**.
    1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
    1. Click **Client Extensions**.
    1. Click **Add Existing**.
    1. Click **Application Ribbons**.
    1. Click **Save**.
    1. Click **Export Solution** and export unmanaged solution.
    1. Extract the .zip file.
    1. Open the *customizations.xml* file.
    1. Locate the root `<RibbonDiffXml>` node.
    1. Locate the `<CommandDefinition>` node.
    1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
    1. Save the *customizations.xml* file.
    1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
    1. Import the solution file.
    1. Click **Publish All Customizations**.

  </details>

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored</b></summary>

###### Fix a command from a custom-managed solution

To fix a command that was installed by a custom-managed solution that you created, you must complete the steps listed above for the "The command is in the unmanaged Active solution" option in your separate development organization that has the unmanaged source version of your custom solution used to create your custom-managed solution. Once you have completed those steps, then you will export a new managed version of your solution that can be imported into your target affected organization to fix the customizations.

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the "The command is in the unmanaged Active solution" option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

###### Fix a command from a custom-managed solution from a third-party/ISV

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

###### Fix a command from a Microsoft published managed solution

To fix a command that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It is possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

### [I get a different error](#tab/different-error)

#### Fix a button that displays an error when clicked

When a ribbon command bar button is clicked and an error occurs, it is typically caused by incorrect ribbon [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) customizations.

##### Fix other types of errors

When a button is clicked and an error occurs, it may be caused by an incorrect configuration of the command associated with the button or by incorrectly coded JavaScript.

Let's identify what the button's command is and what solution installed the definition.

We will use an in-app tool called the **Command Checker** tool to inspect the ribbon component definitions to help us determine why clicking the button results in an error.

:::image type="content" source="media/ribbon-issues-button-not-working-correctly/enable-command-checker.png" alt-text="Screenshot of the parameter.":::

> [!NOTE]
> Currently the **Command Checker** tool only works in a web browser and does not work in Android and iOS apps. A future update is planned to make this work in these mobile apps.

Once the **Command Checker** tool has been enabled, within the application in each of the various command bars (global, form, grid, subgrid), there will be a new special "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button to open the tool (it may be listed in the "More" overflow flyout menu).

1. Navigate to the page in the application where the button is displayed.
1. Locate the command bar that the button visible in.
1. Click the "Command checker" :::image type="icon" source="media/ribbon-issues-button-not-working-correctly/command-checker-button-icon.png" border="false"::: button (it may be listed in the "More" overflow flyout menu).
1. Find and click your button in the list of buttons displayed in the left-most pane of the **Command Checker** tool. Buttons that are not visible will be denoted by de-emphasized and italicized font along with the **(hidden)** term. Buttons that are visible will be displayed with the label in the normal font. Click the **Command Properties** tab to display the details of the command for this button.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/command-properties.png" alt-text="Command properties.":::

1. The **Command properties** tab will display the Actions and corresponding JavaScriptFunction configuration. Click the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/view-command-definition-solution-layers.png" alt-text="View command definition solution layers.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and are not used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged Active solution layer is present, it will always be the definition the application uses. If there is no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and click **Compare** to view a comparison of the definitions brought in by each solution.

    Clicking **Back** will return to the previous Command Checker window.

    > [!NOTE]
    > At the time of writing this guide, the Command Checker's Solution Layers pane has a bug that may list an unmanaged Active solution layer below other layers even though it is expected to always be on top. This same bug may also list custom managed solutions not published by Microsoft below other Microsoft published solution layers even though they are expected to be just below the unmanaged Active solution layer and above Microsoft solution layers, or if there is no unmanaged Active solution layer, then it would be expected to be the top layer. Regardless of the order placement in this list, when an unmanaged Active solution layer is present, it will always be the definition the application uses. Regardless of the order placement in this list, any custom managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers, if there is no unmanaged Active solution layer. This bug has been fixed and is expected to be deployed with release train 4.1 to online regions starting in April 2020.

    If there is only one solution layer, skip to step 9, otherwise, select the top two solution layers (If you have a layer in the Active solution, but it is not listed at the top, select the Active solution layer and then the top row.) and click **Compare**.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/compare-solution.png" alt-text="Compare solution.":::

1. The comparison of the current active definition and the previous inactive definition will be displayed showing the differences, if any. The following example shows the unmanaged Active definition to have been customized by specifying the first parameter incorrectly as compared to the other inactive definition in the Microsoft published System solution layer. The function is expecting a single ID of the primary record as declared by the CrmParameter named **FirstPrimaryItemId**, but the custom definition has declared the `PrimaryItemIds` value of the `<CrmParameter>` node, which will cause the script to throw an error because the parameters do not match the function signature.

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/comparison-3.png" alt-text="comparison.":::

1. The approach needed to fix a button's action functionality will depend on the various customizations in your specific scenario. Considering our example, the command was customized by specifying the first parameter incorrectly. We could modify the custom version of the command and fix the parameter. Since this is a custom override of a Microsoft published definition and there are no other intentional modifications, it is recommended that this custom version of the command be deleted to restore the default functionality.

Please select one of the following repair options:

###### Option 1: Delete the command with the invalid JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

**Delete the command with the invalid JavaScriptFunction declaration in the unmanaged Active solution**

To delete a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

**The command is entity-specific**

Based on our example scenario, we identified the entity is **account** and the command that needs to be deleted is `Mscrm.DeletePrimaryRecord` and it is declared in the"Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** -> **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is account) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`, so we would locate the following node.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example.png" alt-text="commanddefinition example.":::

1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.DeletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-2.png" alt-text="Second command definition example.":::

1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

**The command is in the Application Ribbon (applies to "All entities")**

If the command is not entity-specific, rather it is applicable to "All entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Click **Client Extensions**.
1. Click **Add Existing**.
1. Click **Application Ribbons**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>` and remove the `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present.
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored</b></summary>

**Delete a command from a custom-managed solution**

To delete a command that was installed by a custom-managed solution that you created, you must complete the steps listed above for the "The command is in the unmanaged Active solution" option in your separate development organization that has the unmanaged source version of your custom solution used to create your custom-managed solution. Once you have completed those steps, then you will export a new managed version of your solution that can be imported into your target affected organization to fix the customizations.

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the "The command is in the unmanaged Active solution" option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-party/ISV)</b></summary>

**Delete a command from a custom-managed solution from a third-party/ISV**

To delete a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that has removed the specific command definition and then install this new solution into your affected organization.

</details>

###### Option 2: Fix the command JavaScriptFunction declaration

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

**Fix the command JavaScriptFunction declaration in the unmanaged Active solution**

To fix a command in the Active unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

> [!WARNING]
> Do not remove `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

**The command is entity-specific**

Based on our example scenario, we identified the entity is account and the command that needs to be fixed is `Mscrm.DeletePrimaryRecord` and it is declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**.)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **account**) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.DeletePrimaryRecord`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-3.png" alt-text="Third command definition example.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions). (Based on our example, we would modify the `<CommandDefinition>` node's `JavaScriptFunction` by setting the `FunctionName` value to `XrmCore.Commands.Delete.deletePrimaryRecord`.)

    :::image type="content" source="media/ribbon-issues-button-not-working-correctly/commanddefinition-example-4.png" alt-text="Fourth command definition example.":::

1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

**The command is in the Application Ribbon (applies to "All entities")**

If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Click **Client Extensions**.
1. Click **Add Existing**.
1. Click **Application Ribbons**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands), and [Define ribbon actions](/powerapps/developer/model-driven-apps/define-ribbon-actions).
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored</b></summary>

**Fix a command from a custom-managed solution**

To fix a command that was installed by a custom-managed solution that you created, you must complete the steps listed above for the "The command is in the unmanaged Active solution" option in your separate development organization that has the unmanaged source version of your custom solution used to create your custom-managed solution. Once you have completed those steps, then you will export a new managed version of your solution that can be imported into your target affected organization to fix the customizations.

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the "The command is in the unmanaged Active solution" option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

**Fix a command from a custom-managed solution from a third-party/ISV**

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

**Fix a command from a Microsoft published managed solution**

To fix a command that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It is possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>
