---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      sapatadi # GitHub alias
ms.author:   sapatadi # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     02/06/2024
---
# Remove an unmanaged layer for Ribbon

Unmanaged customizations reside at the top layer for a component and subsequently define the runtime behavior of the component. In most situations you don't want unmanaged customizations determining the behavior of your components. To remove the unmanaged layer for a component, follow these steps: 

1. Open the Command Checker tool to delete unmanaged customization for ribbon components. To open Command Checker, append the &ribbondebug=true parameter to your Dynamics 365 application URL. Please follow [Troubleshooting ribbon issues in Power Apps - Power Apps | Microsoft Learn](/troubleshoot/power-platform/power-apps/create-and-use-apps/ribbon-issues) to understand how to use command checker. 
 
1. After the **Command Checker** dialog box opens, select the button/command/enable rule/display rule and click on “**View solution layers**” for which there is an unmanaged customization. 
As an example New Button below has an unmanaged customization! Once you select it, please click on “View button solution layer”   
:::image type="content" source="media/ribbon-issues/unmanaged-button-location.png" alt-text="Screenshot shows button location in commandchecker." lightbox="media/ribbon-issues/unmanaged-button-location.png":::

1. Once you click on Solution Layer, you will see Remove customization link next to unmanaged layer. 

   1. :::image type="content" source="media/ribbon-issues/unmanaged-button-solutionlayer.png" alt-text="Screenshot shows solution layers for ribbon in commandchecker." lightbox="media/ribbon-issues/unmanaged-button-solutionlayer.png":::
 

1. Please regenerate metadata once you delete the unmanaged layer.

:::image type="content" source="media/ribbon-issues/unmanaged-button-rcm.png" alt-text="Screenshot shows solution rcm ribbon in commandchecker." lightbox="media/ribbon-issues/unmanaged-button-rcm.png":::

**Remove an unmanaged layer for Ribbon (manual procedure)** 
This manual procedure can be done if the unmanaged ribbon customization you wish to remove is not visible in the Command Checker.  
This process will require you to export an unmanaged solution containing the entity or Application Ribbon and edit the '<RibbonDiffXml>' in the customizations.xml file, and then import a new version of this solution where this component has been removed to delete the component. See [Export, prepare to edit, and import the ribbon](/powerapps/developer/model-driven-apps/export-prepare-edit-import-ribbon). 

**The Ribbon component is entity-specific** 
Complete the following steps if the component is declared for a specific entity: 
1. Open Advanced Settings. 
1. Navigate to Settings > Solutions. 
1. Open an existing solution or create a new solution 
1. If creating a new solution (The following steps are not necessary if you already have an existing solution) 
1. Click New to create a new solution, set Publisher to your preferred publisher, or if you are unsure, use the default publisher for the organization. 
1. Click Entities. 
1. Click Add Existing. 
1. Select the entity your ribbon component is defined on and click OK. 
1. Make sure you uncheck the "Include entity metadata" and "Add all Assets" options before clicking Finish. 
1. Click Save. 
1. Click Export Solution and export unmanaged solution. 
1. Extract the .zip file. 
1. Open the customizations.xml file. 
1. Locate the <Entity> node child of the entity node you wish to edit and locate its child <RibbonDiffXml> node. 
1. Locate the node to be deleted
   1. `To remove a command, you must locate the <CommandDefinition> node with the Id of the command you wish to delete `
   1. `To delete a HideCustomAction, you must locate the <HideCustomAction> node containing the Id of the item you wish to remove. `
   1. `To delete an Enable Rule or Display Rule, you must locate the <RuleDefinitions> node and then locate the child <EnableRule> or <DisplayRule> node having the Id of the item you wish to delete. `
   
   1. `To remove a button, you must locate the <CustomAction> node with the Id of the CustomAction you wish to delete or locate and delete the CustomAction that contains the ``<button>``, <splitbutton>, <flyoutanchor> or <group> node having the Id of the control you wish to delete. `
   
   1. `To remove a LocLabel, you must locate the <LocLabel> node with the Id of the LocLabel you wish to delete. `
   
   1. `To remove all ribbon customizations for this entity, replace the <RibbonDiffXml> with the default empty XMl as shown below under `[`Removing all unmanaged ribbon customizations`](https://eng.ms/docs/cloud-ai-platform/business-applications-and-platform/bap-power-apps/papps-scale/commanding-ribbon-alm/remove-unmanaged-solution-layer#removing-all-unmanaged-ribbon-customizations) 
   
1. Edit the '<RibbonDiffXml>' node and remove the appropriate node(s) located as described above. Make sure you don't unintentionally delete other nodes that may be present. 
1. Save the customizations.xml file. 
1. Add the modified customizations.xml file back to the solution .zip file. 
1. Import the solution file. 
1. Click Publish All Customizations. 

**The Ribbon component is in the Application Ribbon (applies to "All entities")** 
If the component is not entity-specific, rather it is applicable to "All Entities" declared in the Application Ribbon, then the steps will be slightly different as follows: 

1. Open Advanced Settings.

1. Navigate to Settings > Solutions. 

1. Open an existing solution or create a new solution 

1. If creating a new solution (The following steps are not necessary if you already have an existing solution) 

   1. Click New to create a new solution, set Publisher to your preferred publisher, or if you are unsure, use the default publisher for the organization. 
   
   1. Click Client Extensions. 
   
   1. Click Add Existing. 
   
   1. Click Application Ribbons. 
   
   1. Click Save. 
   
1. Click Export Solution and export unmanaged solution. 

1. Extract the .zip file. 

1. Open the customizations.xml file. 

1. Locate the root <RibbonDiffXml> node. 

1. Locate the node to be deleted.

   1. To remove a command, you must locate the '<CommandDefinition>' node with the Id of the command you wish to delete 
   
   1. To delete a HideCustomAction, you must locate the '<HideCustomAction>' node containing the Id of the item you wish to remove. 
   
   1. To delete an Enable Rule or Display Rule, you must locate the '<RuleDefinitions>' node and then locate the child '<EnableRule>' or '<DisplayRule>' node having the Id of the item you wish to delete. 
   
   1. To remove a button, you must locate the '<CustomAction>' node with the Id of the CustomAction you wish to delete or locate and delete the CustomAction that contains the <button>, '<splitbutton>', '<flyoutanchor>' or '<group>' node having the Id of the control you wish to delete. 
   
   1. To remove a 'LocLabel', you must locate the '<LocLabel>' node with the Id of the LocLabel you wish to delete. 
   
   1. To remove all ribbon customizations for the application ribbon, replace the <RibbonDiffXml> with the default empty XMl as shown below under [Removing all unmanaged ribbon customizations](https://eng.ms/docs/cloud-ai-platform/business-applications-and-platform/bap-power-apps/papps-scale/commanding-ribbon-alm/remove-unmanaged-solution-layer#removing-all-unmanaged-ribbon-customizations) 
   
1. Edit the <RibbonDiffXml> node and remove the appropriate node located as described above. Make sure you don't unintentionally delete other nodes that may be present. 

1. Save the customizations.xml file. 
1. Add the modified customizations.xml file back to the compressed solution .zip file. 
1. Import the solution file. 
1. Click Publish All Customizations.  

**Removing all unmanaged ribbon customizations** 
To remove all unmanaged ribbon customizations, for either a specific entity or application ribbon, follow the steps above and replace the '<RibbonDiffXml>' in the solution customizations.xml with the following default empty XML declaration:

'<RibbonDiffXml>   
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
</RibbonDiffXml>'
