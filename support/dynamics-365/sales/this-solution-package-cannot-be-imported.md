---
title: This solution package cannot be imported
description: Describes a solution to the 8004801a error that occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# This solution package cannot be imported because it contains invalid XML error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456502

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "This solution package cannot be imported because it contains invalid XML. You can attempt to repair the file by manually editing the XML contents using the information found in the schema validation errors, or you can contact your solution provider.  
Error code 8004801a."

If you select **Technical Details**, you see the following message along with more error details:

> "Schema validation of the customizations.xml file within the compressed solution package file failed. To manually validate and edit the file, you can download the schema file [here](https://go.microsoft.com/fwlink/?LinkId=196060) and use an XML editor that supports schema validation to get more details."

## Cause

A solution package contains Dynamics 365 customizations that are stored as XML. This XML has a specific schema definition that identifies which elements are valid. If the XML contains elements that aren't valid according to the schema definition, this error message will appear when trying to import the solution.

## Resolution

**Check if the details match a known issue**  
    Select the option to view the Technical Details, and see if it matches any of the following known issues:

- [Solution import failure: The element 'general' has invalid child element 'enablelivepersonacarduci'](https://community.dynamics.com/forums/thread/)
- ["The element 'Workflow' has invalid child element 'ProcessTriggers'" error occurs when importing a Dynamics 365 solution](https://support.microsoft.com/help/4462895)
- ["The element 'savedquery' has incomplete content](https://support.microsoft.com/help/4463330)

**If you had manually modified the customizations XML**  
Select the Technical Details link within the error dialog. You'll then see additional details about what invalid elements are found in the XML. The message also includes a link to download the schema file that can be used with an XML editor that supports schema validation. After correcting any invalid elements in the XML, try to import the solution again.

For more information, see [Edit the customizations XML file with schema validation](/dynamics365/customerengagement/on-premises/developer/customize-dev/edit-customizations-xml-file-schema-validation)

**If you received the solution from a solution provider**  
Contact your solution provider.

