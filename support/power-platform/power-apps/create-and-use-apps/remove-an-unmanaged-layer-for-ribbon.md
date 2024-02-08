---
title: Remove an active unmanaged layer of the ribbon
description: Provides steps to remove the unmanaged layer of a ribbon component in Microsoft Power Apps.
author: caburk
ms.author: caburk
ms.reviewer: sapatadi, matp, brflood
ms.date: 02/08/2024
---
# Remove an active unmanaged layer of the ribbon in Power Apps

This article provides steps to remove the unmanaged layer of a ribbon component in Microsoft Power Apps.

## Use Command checker to remove an unmanaged layer of a ribbon

Unmanaged customizations reside at the top layer of a component and subsequently define the runtime behavior of the component. In most situations, you don't want unmanaged customizations to determine the behavior of your components. To remove the unmanaged layer of a ribbon component, follow these steps:

1. Open the [Command checker](ribbon-issues.md#use-command-checker) tool to delete unmanaged customizations for ribbon components.

   To enable Command checker, append the `&ribbondebug=true` parameter to the URL of your Dynamics 365 application. For example, `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`.

1. In the **Command checker** dialog, select a button and then select **View button solution layers** to find an unmanaged customization.

   For example, the **New** button shown in the following screenshot has an unmanaged customization.

   :::image type="content" source="media/ribbon-issues/unmanaged-button-location.png" alt-text="Screenshot that shows the button location in Command checker." lightbox="media/ribbon-issues/unmanaged-button-location.png":::

1. Select the **Remove active customization** link next to the unmanaged layer.

   :::image type="content" source="media/ribbon-issues/unmanaged-button-solutionlayer.png" alt-text="Screenshot that shows the solution layers of the ribbon in Command checker." lightbox="media/ribbon-issues/unmanaged-button-solutionlayer.png":::

1. Regenerate metadata once you delete the unmanaged layer.

   :::image type="content" source="media/ribbon-issues/unmanaged-button-rcm.png" alt-text="Screenshot that shows the solution rcm ribbon in Command checker." lightbox="media/ribbon-issues/unmanaged-button-rcm.png":::

## Remove an unmanaged layer of a ribbon (manual procedure)

You can perform this manual procedure if the unmanaged ribbon customization you want to remove isn't visible in the Command checker.  

This process requires you to export an unmanaged solution containing the entity or application ribbon, edit the `<RibbonDiffXml>` node in the *customizations.xml* file, and then import a new version of this solution where this component was removed to delete the component. For more information, see [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon).

## The ribbon component is entity-specific

Follow these steps if the component is declared for a specific entity:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Open an existing solution or create a new solution.

   To create a new solution, follow these steps:

   1. Select **New** to create a new solution and set **Publisher** to your preferred publisher, or use your organization's default publisher if you're unsure.
   1. Select **Entities** > **Add Existing**.
   1. Select the entity your ribbon component is defined on and select **OK**.
   1. Make sure you clear the **Include entity metadata** and **Add all Assets** options before selecting **Finish**.
   1. Select **Save**.

1. Select **Export Solution** and export the unmanaged solution.
1. Extract the *.zip* file.
1. Open the *customizations.xml* file.
1. Locate the child node `<Entity>` of the entity node you want to edit, and then locate its child node `<RibbonDiffXml>`.
1. Locate the node to be deleted.

    - To delete a command, you must locate the `<CommandDefinition>` node with the ID of the command you want to delete.
    - To delete a `HideCustomAction`, you must locate the `<HideCustomAction>` node containing the ID of the item you want to remove.
    - To delete an "Enable Rule" or "Display Rule," you must locate the `<RuleDefinitions>` node, and then locate the child node `<EnableRule>` or `<DisplayRule>` with the ID of the item you want to delete.
    - To delete a button, you must locate the `<CustomAction>` node with the ID of the `CustomAction` you want to delete. Or, locate and delete the `CustomAction` node that contains the `<button>`, `<splitbutton>`, `<flyoutanchor>`, or `<group>` node with the ID of the control you want to delete.
    - To delete a `LocLabel`, you must locate the `<LocLabel>` node with the ID of the `LocLabel` you want to delete.
    - To delete all ribbon customizations for this entity, replace the `<RibbonDiffXml>` node with the default empty XML as shown in the [Remove all unmanaged ribbon customizations](#remove-all-unmanaged-ribbon-customizations) section of this article.

1. Edit the `<RibbonDiffXml>` node and remove one or more appropriate nodes as described earlier. Make sure you don't unintentionally delete other nodes that might be present.
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the *solution .zip* file.
1. Import the solution file.
1. Select **Publish All Customizations**.

## The ribbon component is in the application ribbon (applies to "All entities")

If the component isn't entity-specific but applies to "All Entities" declared in the application ribbon, the steps are slightly different:

1. Open **Advanced Settings**.
1. Navigate to **Settings** > **Solutions**.
1. Open an existing solution or create a new solution.
1. Create a new solution. (The following steps aren't necessary if you already have an existing solution.)

   To create a new solution, follow these steps:

   1. Select **New** to create a new solution and set **Publisher** to your preferred publisher, or use your organization's default publisher if you're unsure.
   1. Select **Client Extensions** > **Add Existing** > **Application Ribbons**.
   1. Select **Save**.

1. Select **Export Solution** and export the unmanaged solution.
1. Extract the *.zip file*.
1. Open the *customizations.xml* file.
1. Locate the root node `<RibbonDiffXml>`.
1. Locate the node to be deleted.

    - To delete a command, you must locate the `<CommandDefinition>` node with the ID of the command you want to delete.
    - To delete a `HideCustomAction`, you must locate the `<HideCustomAction>` node containing the ID of the item you want to remove.
    - To delete an "Enable Rule" or "Display Rule," you must locate the `<RuleDefinitions>` node, and then locate the child node `<EnableRule>` or `<DisplayRule>` with the ID of the item you want to delete.
    - To delete a button, you must locate the `<CustomAction>` node with the ID of the `CustomAction` you want to delete. Or, locate and delete the `CustomAction` that contains the `<button>`, `<splitbutton>`, `<flyoutanchor>`, or `<group>` node with the ID of the control you want to delete.
    - To delete a `LocLabel`, you must locate the `<LocLabel>` node with the ID of the `LocLabel` you want to delete.
    - To delete all ribbon customizations for the application ribbon, replace the `<RibbonDiffXml>` node with the default empty XML as shown in the [Remove all unmanaged ribbon customizations](#remove-all-unmanaged-ribbon-customizations) section of this article.

1. Edit the `<RibbonDiffXml>` node and remove the appropriate node as described earlier. Make sure you don't unintentionally delete other nodes that might be present.
1. Save the *customizations.xml* file.
1. Add the modified *customizations.xml* file back to the compressed solution *.zip* file.
1. Import the solution file.
1. Select **Publish All Customizations**.  

## Remove all unmanaged ribbon customizations

To remove all unmanaged ribbon customizations for either a specific entity or application ribbon, follow the preceding steps and replace the `<RibbonDiffXml>` node in the solution's *customizations.xml* file with the following default empty XML declaration:

```xml
<RibbonDiffXml>
   <CustomActions />
   <Templates>
      <RibbonTemplates Id="Mscrm.Templates"></RibbonTemplates>
   </Templates>
   <CommandDefinitions />
   <RuleDefinitions>
      <TabDisplayRules />
      <DisplayRules />
      <EnableRules />
   </RuleDefinitions>
   <LocLabels />
   </RibbonDiffXml>
```
