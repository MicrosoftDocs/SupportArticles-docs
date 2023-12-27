---
title: A button on the command bar is visible
description: Fixes an issue in which a button on the command bar is visible when it should be hidden.
ms.reviewer: krgoldie, srihas, brflood, tahoon
ms.date: 09/25/2023
---
# A button on the command bar is visible when it should be hidden

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button is visible

A button will be made visible if all the [enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules) and [display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules) on the [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) associated with the button evaluate to true. If this is unexpected, it's possible that the command definition has been overridden and is missing enable rules or display rules, or the rule definitions themselves are overridden and causing the button to be visible when you expect it to be hidden.

> [!NOTE]
> Some buttons are not customizable. For more information, see [Non-customizable buttons in ribbon](ribbon-non-customizable-buttons.md).

> [!WARNING]
> Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

1. [Enable Command checker and select the command button to inspect](ribbon-issues.md#use-command-checker).
1. The following example shows two **Appointment** buttons on the activities grid page, and one is expected to be hidden.

    :::image type="content" source="media/ribbon-issues-button-visible/appointment-button.png" alt-text="Screenshot shows there are two Appointment buttons on the activities grid page.":::

1. Select the **Command Properties** tab to display the details of the command for this button. This will display the actions, enable rules, and display rules, along with the result (**True**, **False**, **Skipped**) of each rule evaluation. Review the enable rules and display rules, if you expect a particular rule should be evaluating to false, then it's possible the rule is incorrectly customized or the necessary circumstances to return a false result aren't met. If so, skip to step 9, otherwise it's possible then that the command is missing a rule or rules and we'll view the command solution layers for further analysis.

    :::image type="content" source="media/ribbon-issues-button-visible/command-properties.png" alt-text="Screenshot to select the Command Properties tab to display the details of the command for this button.":::

1. Select the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-visible/view-command-definition-solution-layers.png" alt-text="Screenshot of the View command definition solution layers link below the command name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    If there's only one solution layer, skip to step 9, otherwise, select the top two solution layers (If you have a layer in the Active solution, but it isn't listed at the top, select the Active solution layer and then the top row) and select **Compare**.

    :::image type="content" source="media/ribbon-issues-button-visible/compare-solution.png" alt-text="Screenshot to select the top two solution layers and select the Compare option.":::

1. The comparison of the current active definition and the previous inactive definition will be displayed showing the differences, if any. The following example shows the unmanaged Active definition to have been customized with the removal of a display rule `Mscrm.HideOnModern` that is included in the inactive `msdynce_ActivitiesPatch` Microsoft published solution layer.

    :::image type="content" source="media/ribbon-issues-button-visible/comparison.png" alt-text="Screenshot shows the comparison of the current active definition and the previous inactive definition.":::

1. The approach needed to fix a button's visibility will depend on the various customizations in your specific scenario. If you determined that a rule is incorrectly evaluating to false, and if the rule definition is incorrectly defined, then you should modify the rule definition and make changes that would permit the rule to evaluate to false under the proper circumstances. If the rule definition is correct, then it's possible that the requirements that would make the rule return false aren't met, such as a field value or security privilege isn't correctly assigned. Depending on your rule definition, the requirements can vary greatly, refer to [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). Considering our example, the command was customized with the removal of a `Mscrm.HideOnModern` display rule. This display rule is intended to hide this particular button from being displayed in Unified Interface applications and only be visible in the legacy Web Client interface. We could modify the custom version of the command and add the missing the `Mscrm.HideOnModern` display rule to the command definition. Since this is a custom override of a Microsoft published definition and there are no other intentional modifications, it's recommended that this custom version of the command be deleted to restore the default functionality.

## Repair Options

Select a repair option from one of the tabs below. The first tab is selected by default.

### [Delete the command](#tab/delete)

#### How to delete a command

If there's another solution layer that contains a working definition of this command, then you can delete this definition to restore the next inactive working definition.

If this is the only layer and you no longer need the command, then you can remove it from your solution if no other button is referencing the command.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Delete a command from an unmanaged Active solution layer -->

To delete a command in the **Active** unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **activitypointer** and the command that needs to be deleted is `Mscrm.CreateAppointment` and it's declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** -> **Solutions**.
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**).
1. Select **Entities** > **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **activitypointer**) and select **OK**.
1. Make sure you uncheck the **Include entity metadata** and **uncheck Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node (In our example, ID of the `<CommandDefinition>` node is `Mscrm.CreateAppointment`, so we would locate the following node).

    :::image type="content" source="media/ribbon-issues-button-visible/locate-node.png" alt-text="Screenshot shows the location of the CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.CreateAppointment`.)

    :::image type="content" source="media/ribbon-issues-button-visible/delete-node.png" alt-text="Screenshot shows an example to delete the CommandDefinition node.":::

1. Save the _customizations.xml_ file.
1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit the `<RibbonDiffXml>` node and remove the `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present.
1. Save the _customizations.xml_ file.
1. Add the modified _customizations.xml_ file back to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored</b></summary>

<!-- ##### Delete a command from a custom-managed solution-->

To delete a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company did not author (from third-party/ISV)</b></summary>

<!-- ##### Delete a command from a custom-managed solution from a third-party/ISV -->

To delete a command that was installed by a custom-managed solution that was created by a third-party/ISV, you'll need to contact the author of the solution and request a new version of the solution that has removed the specific command definition and then install this new solution into your affected organization.

</details>

### [Add missing enable/display rules to the command](#tab/add)

#### How to add missing enable/display rules to the command

If there are modifications to the command that you need to retain, but you still want the button to be hidden under the appropriate circumstances, then you can add the missing enable/display rules to the command instead of deleting the custom definition.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Add missing enable/display rules to a command in the unmanaged Active solution layer -->

If you determined that enable/display rules are missing from your command definition, then you can modify the `<CommandDefinition>` node and add the rules to achieve the desired behavior. To fix a command in the **Active** unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **activitypointer** and the command that needs to be fixed is `Mscrm.CreateAppointment` and it's declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Select **Entities** > **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **activitypointer**) and select **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node that you want to edit, and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. In the example, the ID of the `<CommandDefinition>` node is `Mscrm.CreateAppointment`. Therefore, you would locate the following node:

    :::image type="content" source="media/ribbon-issues-button-visible/locate-example-node.png" alt-text="Screenshot shows the location of the example CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node, and make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands). (Based on our example, we would modify the `<CommandDefinition>` node by adding the `Mscrm.HideOnModern` display rule that will correctly hide this button.)

    :::image type="content" source="media/ribbon-issues-button-visible/modify-node.png" alt-text="Screenshot to modify the CommandDefinition node by adding the Mscrm.HideOnModern display rule.":::

1. Restore the modified _customizations.xml_ file to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific, rather it's applicable to "All entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>`.
1. Edit `<RibbonDiffXml>` and make the necessary changes to the `<CommandDefinition>` node that will enable the command to function correctly under the correct circumstances to fix the command. For more information about how to declare commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands).
1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I authored</b></summary>

<!-- ##### Fix a command from a custom-managed solution -->

To fix a command that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The command is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (i.e. from a third-party/ISV)</b></summary>

<!-- #### Fix a command from a custom-managed solution from a third-party/ISV -->

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you'll need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix a command from a Microsoft published managed solution -->

To fix a command that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It's possible that you've identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

### [Fix an enable/display rule](#tab/fix)

#### How to fix an enable/display rule

1. Select the **View rule definition solution layers** link below the rule name to view the solution(s) that installed a definition of the rule.

    :::image type="content" source="media/ribbon-issues-button-visible/view-rule-definition-solution-layers.png" alt-text="Screenshot shows the View rule definition solution layers link below the rule name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    The following image shows the solution layers for the enable rule in our example, and indicates that there's one solution layer in this case, and that it's an unmanaged customization as denoted by the solution titled **Active**. Your actual scenario may differ, you may not an Active solution layer, you may have a managed solution and the name of that solution will be listed here.

    :::image type="content" source="media/ribbon-issues-button-visible/solution-layer-example.png" alt-text="Screenshot shows an example of the solution layer.":::

1. Now that we've reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The enable/display rule is in the unmanaged Active solution</b></summary>

<!-- ##### Fix an enable/display rule from an unmanaged Active solution layer -->

To fix an enable/display rule in the **Active** unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import the new version of this solution containing the fixed enable/display rule definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The enable/display rule is entity-specific

Based on our example scenario, we identified the entity is **contact** and the enable rule that needs to be fixed is `new.contact.EnableRule.EntityRule` and it's declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker solution layers listing for the enable rule and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Select **Entities** > **Add Existing**.
1. Select the entity your enable/display rule is defined on (In our example, this is **contact**) and select **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the enable/display rule. In the example, the ID of the enable rule is `new.contact.EnableRule.EntityRule`. Therefore, you would locate the following node:

    :::image type="content" source="media/ribbon-issues-button-visible/locate-enable-display-rule.png" alt-text="Screenshot shows the location of the enable/display rule.":::

1. Edit the `<RibbonDiffXml>` node, and make the necessary changes to the enable/display rule that will enable the rule to evaluate to True under the correct circumstances to fix the rule. For more information about how to declare rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). (Based on our example, we would change the rule definition to the following)

    :::image type="content" source="media/ribbon-issues-button-visible/rule-definition.png" alt-text="Screenshot shows an example of the rule definition.":::

1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The enable/display rule is in the Application Ribbon (applies to "All entities")

If the enable/display rule isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set Publisher to the value shown in the Command Checker's solution layers listing for the enable/display rule and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the enable/display rule.
1. Edit the `<RibbonDiffXml>` node, and make the necessary changes to the enable/display rule that will enable the rule to evaluate to True under the correct circumstances to fix the rule. For more information about how to declare rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules).
1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The enable/display rule is from a custom-managed solution that I authored</b></summary>

<!-- ##### Fix an enable/display rule from a custom-managed solution -->

To fix an enable/display rule that was installed by a custom-managed solution that you created, follow these steps:

1. In your separate development organization that has the unmanaged source version of your custom solution, complete the steps listed above for the **The enable/display rule is in the unmanaged Active solution** option.
1. Increment the Version of your custom solution.
1. Export solution as managed.
1. In your separate affected organization, import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The enable/display rule is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

<!-- ##### Fix an enable/display rule from a custom-managed solution from a third-party/ISV -->

To fix an enable/display rule that was installed by a custom-managed solution that was created by a third-party/ISV, you'll need to contact the author of the solution and request a new version of the solution that contains the fixed enable/display rule definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The enable/display rule is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix an enable/display rule from a Microsoft published managed solution -->

To fix an enable/display rule that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It's possible that you've identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

## Reference

[Command checker for model-driven app ribbons](https://powerapps.microsoft.com/blog/introducing-command-checker-for-model-app-ribbons/)
