---
title: A button on the command bar is hidden
description: Fixes an issue in which a button on the command bar is hidden when it should be visible in Microsoft Power Apps.
ms.reviewer: krgoldie, srihas, tahoon
ms.date: 09/25/2023
---
# A button on the command bar is hidden when it should be visible in Power Apps

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Determine why a button is hidden

A button can be hidden due to an [enable rule](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules) or [display rule](/powerapps/developer/model-driven-apps/define-ribbon-display-rules) on the [command](/powerapps/developer/model-driven-apps/define-ribbon-commands) associated with the button evaluating to false. It could be that the associated command has a `Mscrm.HideOnModern` display rule that would hide the button in Unified Interface applications. A [HideCustomAction](/powerapps/developer/model-driven-apps/define-custom-actions-modify-ribbon#hide-custom-actions) could also have been created that would force the button to be hidden. If the user is offline, custom commands and default commands without the `Mscrm.IsEntityAvailableForUserInMocaOffline` enable rule won't be displayed.

> [!WARNING]
>
> - Any display rule of the **EntityPrivilegeRule** type with a **PrivilegeType** value of one of the following (**Create**, **Write**, **Delete**, **Assign**, **Share**) will evaluate to false if the entity has the **Read-Only in Mobile** option enabled, which will force the entity to only permit **Read** privilege. Examples of some of the most common default system rules that will evaluate to false when the **Read-Only in Mobile** flag is enabled on the entity, are as follows, but not limited only to this list (`Mscrm.CreateSelectedEntityPermission`, `Mscrm.CanSavePrimary`, `Mscrm.CanWritePrimary`, `Mscrm.CanWriteSelected`, `Mscrm.WritePrimaryEntityPermission`, `Mscrm.WriteSelectedEntityPermission`, `Mscrm.CanDeletePrimary`, `Mscrm.DeletePrimaryEntityPermission`, `Mscrm.DeleteSelectedEntityPermission`, `Mscrm.AssignSelectedEntityPermission`, `Mscrm.SharePrimaryPermission`, `Mscrm.ShareSelectedEntityPermission`). You can edit the entity and uncheck the **Read-Only in Mobile** option to permit these rules to evaluate to true, provided the privilege being tested by the rule is also granted to the user.
> - Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

1. [Enable Command checker and select the command button to inspect](ribbon-issues.md#use-command-checker).
1. The following example shows the **New** button on the contact entity's grid page isn't visible and is represented by an item labeled **New (hidden)**.

    > [!NOTE]
    > If your button isn't listed, it could be due to a [HideCustomAction](/powerapps/developer/model-driven-apps/define-custom-actions-modify-ribbon#hide-custom-actions) customization that may have been installed, or the associated command has a `Mscrm.HideOnModern` display rule. At the time of writing this guide, the Command Checker tool does not list buttons that have been hidden by a `HideCustomAction` or `Mscrm.HideOnModern` display rule. We are currently working to augment this listing to include this information in a future update.

    :::image type="content" source="media/ribbon-issues-button-hidden/new-hidden.png" alt-text="Screenshot shows the New button on the contact entity's grid page isn't visible and is represented by an item labeled New (hidden).":::

    > [!NOTE]
    > If the button is still hidden when all rules evaluate to **True**, it may be due to [context sensitive commands in grids](https://support.microsoft.com/topic/1100b6b5-ab64-6047-82c5-924a2b38296a). When records are selected on a grid, all buttons without a `SelectionCountRule` element will be considered not relevant to the selected record(s). And they're hidden even if their rule evaluation is **True**. Note that flyouts aren't affected since flyout children might still have record based commands.

1. Select the **Command Properties** tab to display the details of the command for this button. This will show the enable rules and display rules, along with the result (**True**, **False**, **Skipped**) of each rule evaluation. The following example shows the **New (hidden)** button's command to be `Mscrm.NewRecordFromGrid` and there's an enable rule named `new.contact.EnableRule.EntityRule` that has evaluated to **False**, as a result the button will be hidden.

    :::image type="content" source="media/ribbon-issues-button-hidden/command-properties-new-hidden.png" alt-text="Screenshot shows the Command properties details of the command for the New (hidden) button.":::

1. Expand the `new.contact.EnableRule.EntityRule` enable rule, by selecting on the chevron :::image type="icon" source="media/ribbon-issues-button-hidden/chevron-icon.png" border="false"::: icon to view the details of the rule. To understand why a rule evaluates to True or False requires a little understanding of the type of rule. For details of each type of rule, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). The following example shows that the rule type is **Entity** and the entity logical name is **account**. Since the current entity is **contact**, which isn't equal to **account**, this rule returns False.

    :::image type="content" source="media/ribbon-issues-button-hidden/command-properties-example.png" alt-text="Screenshot shows an example to view the details of the rule.":::

1. The approach needed to fix a button's visibility will depend on the various customizations in your specific scenario. Considering our example:
    - If this rule was created erroneously, such that the entity declared in the rule was intended to be **contact** but was set to **account**, you could edit the `new.contact.EnableRule.EntityRule` enable rule and make changes that would permit the rule to evaluate to true.
    - If this rule was added to the command unintentionally, you could modify the `Mscrm.NewRecordFromGrid` command and remove the `new.contact.EnableRule.EntityRule` enable rule from the command definition.
    - If the command is an override of a Microsoft published definition, then this custom version of the command could be deleted to restore the default functionality.

## Repair Options

Select a repair option from one of the tabs below. The first tab is selected by default.

### [Delete the command](#tab/delete)

#### How to delete a command

If there's another solution layer that contains a working definition of the command, then you can delete the definition to restore the inactive working definition.

If this is the only layer and you no longer need the command, then you can remove it from your solution if no other button is referencing the command.

In order to delete a command, we need to determine which solution installed the customization:

1. Select the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-hidden/view-command-definition-solution-layers.png" alt-text="Screenshot of the View command definition solution layers link under a command name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select **Compare** to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    The following image shows the solution layers for the command in our example, and indicates that there's a solution layer for the contact entity that it's an unmanaged customization as denoted by the solution titled **Active**. Your actual scenario may differ, you may not have an **Active** solution layer, you may have a managed solution and the name of that solution will be listed here.

    :::image type="content" source="media/ribbon-issues-button-hidden/solution-layer-example.png" alt-text="Screenshot shows an example of the solution layer.":::

1. Now that we have reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Delete a command from an unmanaged Active solution layer -->

To delete a command in the **Active** unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution where this command has been removed in order to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The command is entity-specific

Based on our example scenario, we identified the entity is **contact** and the command that needs to be deleted is `Mscrm.NewRecordFromGrid` and it's declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Select **Entities** > **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **contact**) and select **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.NewRecordFromGrid`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-hidden/locate-node.png" alt-text="Screenshot shows the location of the CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node and remove the specific `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinition>` nodes that may be present. (Based on our example, we would delete the `<CommandDefinition>` node in which ID is `Mscrm.NewRecordFromGrid`.)

    :::image type="content" source="media/ribbon-issues-button-hidden/delete-node.png" alt-text="Screenshot to delete the CommandDefinition node.":::

1. Save the _customizations.xml_ file.
1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>` node and remove the `<CommandDefinition>` node that has the ID of the command you wish to delete. Make sure you don't unintentionally delete other `<CommandDefinitions>` nodes that may be present.
1. Save the _customizations.xml_ file.
1. Add the modified _customizations.xml_ file back to the compressed solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

</details>

<details>
<summary><b>The command is from a custom-managed solution that my company authored</b></summary>

<!-- ##### Delete a command from a custom-managed solution -->

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

### [Fix the enable/display rule](#tab/fix)

#### How to fix an enable/display rule

1. Select the **View rule definition solution layers** link below the rule name to view the solution(s) that installed a definition of the rule.

    :::image type="content" source="media/ribbon-issues-button-hidden/view-rule-definition-solution-layers.png" alt-text="Screenshot of the View rule definition solution layers link under a rule name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select "Compare' to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    The following image shows the solution layers for the enable rule in our example, and indicates that there's one solution layer in this case, and that it's an unmanaged customization as denoted by the solution titled **Active**. Your actual scenario may differ, you may not an Active solution layer, you may have a managed solution and the name of that solution will be listed here.

    :::image type="content" source="media/ribbon-issues-button-hidden/solution-layer-enable-rule.png" alt-text="Screenshot shows an example of the solution layers for the enable rule.":::

1. Now that we have reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The enable/display rule is in the unmanaged Active solution</b></summary>

<!-- ##### Fix an enable/display rule from an unmanaged Active solution layer -->

To fix an enable/display rule in the **Active** unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import the new version of this solution containing the fixed enable/display rule definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

###### The enable/display rule is entity-specific

Based on our example scenario, we identified the entity is **contact** and the enable rule that needs to be fixed is `new.contact.EnableRule.EntityRule` and it's declared in the **Active** unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the enable rule and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Select **Entities**.
1. Select **Add Existing**.
1. Select the entity your enable/display rule is defined on (In our example, this is **contact**) and select **OK**.
1. Make sure you uncheck the **Include entity metadata** and **Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the enable/display rule. (In our example, ID of the enable rule is `new.contact.EnableRule.EntityRule`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-hidden/locate-enable-display-rule.png" alt-text="Screenshot shows the location of the enable/display rule.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the enable/display rule that will permit the rule to evaluate to True under the correct circumstances to fix the rule. For more help about declaring rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules). (Based on our example, we would change the rule definition to the following)

    :::image type="content" source="media/ribbon-issues-button-hidden/change-rule-definition.png" alt-text="Screenshot shows an example to change the rule definition.":::

1. Add the modified _customizations.xml_ file back to the solution .zip file.
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The enable/display rule is in the Application Ribbon (applies to "All entities")

If the enable/display rule isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the enable/display rule and the Active solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the enable/display rule.
1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the enable/display rule that will permit the rule to evaluate to True under the correct circumstances to fix the rule. For more help about declaring rules, see [Define ribbon enable rules](/powerapps/developer/model-driven-apps/define-ribbon-enable-rules), and [Define ribbon display rules](/powerapps/developer/model-driven-apps/define-ribbon-display-rules).
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
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The enable/display rule is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

<!-- ##### Fix an enable/display rule from a custom-managed solution from a third-party/ISV -->

To fix an enable/display rule that was installed by a custom-managed solution that was created by a third-party/ISV, you'll need to contact the author of the solution and request a new version of the solution that contains the fixed enable/display rule definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The enable/display rule is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix an enable/display rule from a Microsoft published managed solution -->

To fix an enable/display rule that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It's possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

### [Remove the enable/display rule from the command](#tab/remove)

#### How to fix a command

In order to fix a command, we need to determine which solution installed the customization.

1. Select the **View command definition solution layers** link below the command name to view the solution(s) that installed a definition of the command.

    :::image type="content" source="media/ribbon-issues-button-hidden/view-command-definition-solution-layers.png" alt-text="Screenshot of the View command definition solution layers link below a command name.":::

1. The Solution Layers pane will display the layering of each ribbon component definition a particular solution has installed. The layer at the top of the list is the current definition that is used by the application, the other layers are inactive and aren't used by the application at the moment. If the top solution is uninstalled or an updated version is installed that removes the definition, then the next layer will become the current active definition used by the application. When an unmanaged **Active** solution layer is present, it will always be the definition the application uses. If there's no Active solution listed, then the solution listed at the top of the list will be the definition used by the application. Any custom-managed solutions that aren't published by Microsoft will also take precedence over Microsoft published solution layers.

    The Entity context indicates the object the ribbon customization is on, if "All Entities" is listed, then the layer is from the Application Ribbon client extensions and not entity specific, otherwise the logical name of the entity will be listed.

    When there are two or more layers, you can select two rows and select "Compare' to view a comparison of the definitions brought in by each solution.

    Selecting **Back** will return to the previous Command Checker window.

    The following image shows the solution layers for the command in our example, and indicates that there's one solution layer in this contact, and that it's an unmanaged customization as denoted by the solution titled **Active**. Your actual scenario may differ, you may not have an Active solution layer, you may have a managed solution and the name of that solution will be listed here.

    :::image type="content" source="media/ribbon-issues-button-hidden/solution-layer-example.png" alt-text="Screenshot shows an example of the solution layers for the command.":::

1. Now that we have reviewed the solution layers and identified the solution that installed the customization, we must fix the definition in the appropriate solution.

Select one of the following options that matches your particular scenario:

<details>
<summary><b>The command is in the unmanaged Active solution</b></summary>

<!-- ##### Fix a command from an unmanaged Active solution layer -->

To fix a command in the Active unmanaged solution layer, we'll export an unmanaged solution containing the entity or Application Ribbon and edit the `<RibbonDiffXml>` node in the _customizations.xml_ file, and then import a new version of this solution containing the fixed command definition. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

> [!WARNING]
> Do not remove the `Mscrm.HideOnModern` display rule from a command to force a button to appear in the Unified Interface. Commands that have the `Mscrm.HideOnModern` display rule are intended for the legacy Web Client interface and are not supported in the Unified Interface, and may not work correctly.

###### The command is entity-specific

Based on our example scenario, we identified the entity is **contact** and the command that needs to be fixed is `Mscrm.NewRecordFromGrid` and it's declared in the Active unmanaged solution layer from a publisher named **DefaultPublisherCITTest**.

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the Active solution layer. (In our example, this is **DefaultPublisherCITTest**)
1. Select **Entities**.
1. Select **Add Existing**.
1. Select the entity your command is defined on (In our example, this is **contact**) and select **OK**.
1. Make sure you uncheck **Include entity metadata** and **Add all assets** options before selecting **Finish**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the `<Entity>` node child of the entity node you wish to edit and locate its child `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node. (In our example, ID of the `<CommandDefinition>` node is `Mscrm.NewRecordFromGrid`, so we would locate the following node)

    :::image type="content" source="media/ribbon-issues-button-hidden/locate-node-example.png" alt-text="Screenshot shows the location of the example CommandDefinition node.":::

1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands). (Based on our example, we would modify the `<CommandDefinition>` node by removing the `new.contact.EnableRule.EntityRule` enable rule that is causing the button to be hidden.)

    :::image type="content" source="media/ribbon-issues-button-hidden/modify-node.png" alt-text="Screenshot shows an example to modify the CommandDefinition node.":::

1. Add the modified _customizations.xml_ file back to the solution .zip file
1. Import the solution file.
1. Select **Publish All Customizations**.

###### The command is in the Application Ribbon (applies to "All entities")

If the command isn't entity-specific, rather it's applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Select **New** to create a new solution, set **Publisher** to the value shown in the Command Checker's solution layers listing for the command and the **Active** solution layer.
1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
1. Select **Save**.
1. Select **Export Solution** and export the unmanaged solution.
1. Extract the .zip file.
1. Open the _customizations.xml_ file.
1. Locate the root `<RibbonDiffXml>` node.
1. Locate the `<CommandDefinition>` node.
1. Edit the `<RibbonDiffXml>` node and make the necessary changes to the `<CommandDefinition>` node that will permit the command to function properly under the correct circumstances to fix the command. For more help about declaring commands, see [Define ribbon commands](/powerapps/developer/model-driven-apps/define-ribbon-commands).
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
1. In your separate affected organization, Import this new version of your custom-managed solution.

</details>

<details>
<summary><b>The command is from a custom-managed solution that I did not author or my organization does not own (from a third-party/ISV)</b></summary>

<!-- ##### Fix a command from a custom-managed solution from a third-party/ISV -->

To fix a command that was installed by a custom-managed solution that was created by a third-party/ISV, you'll need to contact the author of the solution and request a new version of the solution that contains the fixed command definition and install this new solution into your affected organization.

</details>

<details>
<summary><b>The command is in a Microsoft published managed solution</b></summary>

<!-- ##### Fix a command from a Microsoft published managed solution -->

To fix a command that was installed by a Microsoft published managed solution, you may need a newer version of the solution to be installed, which would typically be done during a release update. It's possible that you have identified a bug that still needs to be fixed. Contact customer support for assistance.

</details>

## Reference

[Command checker for model-driven app ribbons](https://powerapps.microsoft.com/blog/introducing-command-checker-for-model-app-ribbons/)
