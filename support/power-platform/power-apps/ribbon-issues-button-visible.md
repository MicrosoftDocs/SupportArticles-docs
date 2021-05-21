---
title: A button in the command bar is visible
description: Fixes an issue in which a button in the command bar is visible when it should not be.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/19/2021
---
# A button in the command bar is visible when it should not be

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button is visible

A button will be made visible if all the [enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules) and [display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules) on the [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) associated with the button evaluate to true. If this is unexpected, it is possible that the command definition has been overridden and is missing enable rules or display rules or the rule definitions themselves are overridden and causing the button to be visible when you expect it to be hidden.

> [!WARNING]
> Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

The in-app tool called **Command Checker** will be used to inspect the ribbon component definitions to help us determine why the button is visible unexpectedly.

To enable the **Command Checker** tool, you must append a `&ribbondebug=true` parameter to your Dynamics 365 application URL. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`.

:::image type="content" source="media/ribbon-issues-button-visible/enable-command-checker.png" alt-text="Screenshot of the parameter.":::

> [!NOTE]
> Currently the **Command Checker** tool only works in a web browser and does not work in Android and iOS apps. A future update is planned to make this work in these mobile apps.

Once the **Command Checker** tool has been enabled, within the application in each of the various command bars (global, form, grid, subgrid), there will be a new special "Command checker" :::image type="icon" source="media/ribbon-issues-button-visible/command-checker-button-icon.png" border="false"::: button to open the tool (it may be listed in the "More" overflow flyout menu).

1. Navigate to the page in the application where the button is displayed.
1. Locate the command bar that the button is visible in.
1. Click the "Command checker" :::image type="icon" source="media/ribbon-issues-button-visible/command-checker-button-icon.png" border="false"::: button (it may be listed in the "More" overflow flyout menu).
1. Find and click your button in the list of buttons displayed in the left-most pane of the **Command Checker** tool. Buttons that are not visible will be denoted by de-emphasized and italicized font along with the **(hidden)** term. Buttons that are visible will be displayed with the label in the normal font. The following example shows there are two **Appointment** buttons on the activities grid page, and one is expected to be hidden.

    :::image type="content" source="media/ribbon-issues-button-visible/appointment.png" alt-text="Appointment example.":::

1. Click the **Command Properties** tab to display the details of the command for this button. This will display the actions, enable rules, and display rules, along with the result (**True**, **False**, **Skipped**) of each rule evaluation. Review the enable rules and display rules, if you expect a particular rule should be evaluating to false, then it is possible the rule is incorrectly customized or the necessary circumstances to return a false result are not met. If so, skip to step 9, otherwise it is possible then that the command is missing a rule or rules and we will view the command solution layers for further analysis.

    :::image type="content" source="media/ribbon-issues-button-visible/command-properties.png" alt-text="Screenshot of command properties.":::

1. Click the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-visible/view-command-definition-solution-layers.png" alt-text="View command definition solution layers.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and are not used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there is no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and click **Compare** to view a comparison of the definitions brought in by each solution.

    Clicking **Back** will return to the previous Command Checker window.

    > [!NOTE]
    > At the time of writing this guide, the Command Checker's Solution Layers pane has a bug that may list an unmanaged **Active** solution layer below other layers even though it is expected to always be on top. This same bug may also list custom managed solutions not published by Microsoft below other Microsoft published solution layers even though they are expected to be just below the unmanaged **Active** solution layer and above Microsoft solution layers, or if there is no unmanaged **Active** solution layer, then it would be expected to be the top layer. Regardless of the order placement in this list, when an unmanaged **Active** solution layer is present, it will always be the definition the application uses. Regardless of the order placement in this list, any custom managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers, if there is no unmanaged **Active** solution layer. This bug has been fixed and is expected to be deployed with release train 4.1 to online regions starting in April 2020.

    If there is only one solution layer, skip to step 9, otherwise, select the top two solution layers (If you have a layer in the Active solution, but it is not listed at the top, select the Active solution layer and then the top row) and click **Compare**.

    :::image type="content" source="media/ribbon-issues-button-visible/compare-solution.png" alt-text="Compare solution.":::

1. The comparison of the current active definition and the previous inactive definition will be displayed showing the differences, if any. The following example shows the unmanaged Active definition to have been customized with the removal of a display rule `Mscrm.HideOnModern` that is included in the inactive `msdynce_ActivitiesPatch` Microsoft published solution layer.

    :::image type="content" source="media/ribbon-issues-button-visible/comparison.png" alt-text="Comparison.":::

1. The approach needed to fix a button's visibility will depend on the various customizations in your specific scenario. If you determined that a rule is incorrectly evaluating to false, and if the rule definition is incorrectly defined, then you should modify the rule definition and make changes that would permit the rule to evaluate to false under the proper circumstances. If the rule definition is correct, then it is possible that the requirements that would make the rule return false are not met, such as a field value or security privilege is not correctly assigned. Depending on your rule definition, the requirements can vary greatly, please refer to [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). Considering our example, the command was customized with the removal of a `Mscrm.HideOnModern` display rule. This display rule is intended to hide this particular button from being displayed in Unified Interface applications and only be visible in the legacy Web Client interface. We could modify the custom version of the command and add the missing the `Mscrm.HideOnModern` display rule to the command definition. Since this is a custom override of a Microsoft published definition and there are no other intentional modifications, it is recommended that this custom version of the command be deleted to restore the default functionality.

## Repair Options

Select a repair option from one of the tabs below. The first tab is selected by default.

### [Delete the command](#tab/delete)

#### How to delete a command

If there is another solution layer that contains a working definition of this command, then you can delete this definition to restore the next inactive working definition.

If this is the only layer and you no longer need the command, then you can remove it from your solution if no other button is referencing the command.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Delete a command from an unmanaged Active solution layer -->

To delete a command in the **Active** unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **activitypointer** and the command that needs to be deleted is `Mscrm.CreateAppointment` and it is declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** -> **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**).
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **activitypointer**) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **uncheck Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate it's child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node (In our example, ID of the `<CommandDefinition>` node is `Mscrm.CreateAppointment`, so we would locate the following node).

    :::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example.png" alt-text="commanddefinition example.":::

1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.CreateAppointment`.)

    :::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example-2.png" alt-text="Second command definition example.":::

1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**
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
1. Edit the `<RibbonDiffXml>` node and remove the `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present.
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored</b></summary>

<!-- ##### Delete a command from a custom-managed solution-->

To delete a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-party/ISV)</b></summary>

<!-- ##### Delete a command from a custom-managed solution from a third-party/ISV -->

To delete a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that has removed the specific command definition and then install this new solution into your affected organization.

</details>

### [Add missing enable/display rules to the command](#tab/add)

#### How to add missing enable/display rules to the command

If there are modifications to the command that you need to retain, but you still want the button to be hidden under the appropriate circumstances, then you can add the missing enable/display rules to the command instead of deleting the custom definition.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Add missing enable/display rules to a command in the unmanaged Active solution layer -->

If you determined that enable/display rules are missing from your command definition, then you can modify the `<CommandDefinition>` node and add the rules to achieve the desired behavior. To fix a command in the **Active** unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **activitypointer** and the command that needs to be fixed is `Mscrm.CreateAppointment` and it is declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **activitypointer**) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate it's child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.CreateAppointment`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example-3.png" alt-text="Third command definition example.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands). (Based on our example, we would modify the `<CommandDefinition>` node by adding the `Mscrm.HideOnModern` display rule that will correctly hide this button.)

    :::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example-4.png" alt-text="Fourth command definition example.":::

1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

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
1. Locate the `<CommandDefinition>`.
1. Edit `<RibbonDiffXml>` and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands).
1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored</b></summary>

<!-- ##### Fix a command from a custom-managed solution -->

To fix a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (i.e. from a third-party/ISV)</b></summary>

<!-- #### Fix a command from a custom-managed solution from a third-party/ISV -->

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix a command from a Microsoft published managed solution -->

To fix a command that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It is possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

### [Fix an enable/display rule](#tab/fix)

#### How to fix an enable/display rule

1. Click the **View rule definition solution layers** link below the rule name to view the solution(s) that installed a definition of the rule.

    :::image type="content" source="media/ribbon-issues-button-visible/view-rule-definition-solution-layers.png" alt-text="Link of view rule definition solution layers.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and are not used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there is no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and click "Compare' to view a comparison of the definitions brought in by each solution.

    Clicking **Back** will return to the previous Command Checker window.

    > [!NOTE]
    > At the time of writing this guide, the Command Checker's Solution Layers pane has a bug that may list an unmanaged **Active** solution layer below other layers even though it is expected to always be on top. This same bug may also list custom managed solutions not published by Microsoft below other Microsoft published solution layers even though they are expected to be just below the unmanaged **Active** solution layer and above Microsoft solution layers, or if there is no unmanaged **Active** solution layer, then it would be expected to be the top layer. Regardless of the order placement in this list, when an unmanaged **Active** solution layer is present, it will always be the definition the application uses. Regardless of the order placement in this list, any custom managed solutions that are not published by Microsoft will also take precedence over Microsoft published solution layers, if there is no unmanaged **Active** solution layer. This bug has been fixed and is expected to be deployed with release train 4.1 to online regions starting in April 2020.

    The following image shows the solution layers for the enable rule in our example, and indicates that there is one solution layer in this case, and that it is an unmanaged customization as denoted by the solution titled **Active**. Your actual scenario may differ, you may not an Active solution layer, you may have a managed solution and the name of that solution will be listed here.

    :::image type="content" source="media/ribbon-issues-button-visible/solution-layer-example.png" alt-text="Example of solution layer.":::

1. Now that we have reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The enable/display rule is in the unmanaged Active solution</b></summary>

<!-- ##### Fix an enable/display rule from an unmanaged Active solution layer -->

To fix an enable/display rule in the **Active** unmanaged solution layer, we will export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import the new version of this solution containing the fixed enable/display rule definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The enable/display rule is entity-specific

Based on our example scenario, we identified the entity is **contact** and the enable rule that needs to be fixed is `new.contact.EnableRule.EntityRule` and it is declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the enable rule and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Click **Entities**.
1. Click **Add Existing**.
1. Select the entity your enable/display rule is defined on (In our example, this is **contact**) and click **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before clicking **Finish**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the enable/display rule. (In our example, ID of the enable rule is `new.contact.EnableRule.EntityRule`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example-5.png" alt-text="Fifth example of command definition.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the enable/display rule that will permit the rule to evaluate to True under the correct circumstances to fix the rule. For more help about declaring rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). (Based on our example, we would change the rule definition to the following)

:::image type="content" source="media/ribbon-issues-button-visible/commanddefinition-example-6.png" alt-text="Sixth example of command definition.":::

1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

###### The enable/display rule is in the Application Ribbon (applies to "All entities")

If the enable/display rule is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Click **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the enable/display rule and the Active solution layer.
1. Click **Client Extensions**.
1. Click **Add Existing**.
1. Click **Application Ribbons**.
1. Click **Save**.
1. Click **Export Solution** and export unmanaged solution.
1. Extract the .zip file.
1. Open the *customizations.xml* file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the enable/display rule.
1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the enable/display rule that will permit the rule to evaluate to True under the correct circumstances to fix the rule. For more help about declaring rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules).
1. Add the modified *customizations.xml* file back to the solution .zip file.
1. Import the solution file.
1. Click **Publish All Customizations**.

</details>

<details>
<summary><b>The enable/display rule is from a custom-managed solution that I authored</b></summary>

<!-- ##### Fix an enable/display rule from a custom-managed solution -->

To fix an enable/display rule that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The enable/display rule is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The enable/display rule is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

<!-- ##### Fix an enable/display rule from a custom-managed solution from a third-party/ISV -->

To fix an enable/display rule that was installed by a custom-managed solution that was created by a third-party/ISV, you will need to contact the author of the solution and request a new version of the solution that contains the fixed enable/display rule definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The enable/display rule is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix an enable/display rule from a Microsoft published managed solution -->

To fix an enable/display rule that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It is possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>
