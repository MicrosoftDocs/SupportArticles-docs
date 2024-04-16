---
title: You cannot complete this action for this component error when importing a solution
description: When you try to import a solution in Microsoft Dynamics 365, you may receive an error that states you cannot complete this action for this component because of the configuration of its managed properties. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "You cannot complete this action for this component" error when importing a solution

This article provides a resolution for the error **You cannot complete this action for this component because of the configuration of its managed properties** that may occur when importing a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4464328

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, the solution import fails with the following message:

> The import of solution: [solution name] failed

In the error dialog there will be a failure status and the following message is displayed in the **Detail** column:

> You cannot complete this action for this component because of the configuration of its managed properties

If you select **Download Log File** and view the **Components** tab in Excel, you see a message such as:

> Status Column: Failure  
ErrorCode: 0x8004F026  
ErrorText: The evaluation of the current component(name=Entity, id=[GUID] in the current operation (Update) failed during managed property evaluation of condition: The evaluation of the current component(name=Entity, id=[GUID] in the current operation (Update) failed during managed property evaluation of condition: Managed Property Name: [ManagedPropertyLogicalName]; Component Name: Entity; Attribute Name: [ManagedPropertyLogicalName];

## Cause

Microsoft is aware of an issue where this error can occur when importing a solution containing some entities such as Marketing List, SystemUser, Team, CustomerAddress, Position, TransactionCurrency entity. If your solution contains one of these entities, see the Resolution section of this article.

This error indicates there is a mismatch in managed properties for an entity that you are trying to import with the same entity in the target organization. The mismatch between target entity attribute and the source entity attribute may be related to the version of the source organization being an older version than the target organization (example 8.2 to 9.0). If a system upgrade has taken place on the target organization and has updated a managed entity attribute, then the solution will fail if it contains a different definition of the attribute for this entity.

**Example:** In Microsoft Dynamics 365 version 8.2, a custom entity is created with a relationship to the Marketing List entity. In Microsoft Dynamics 365 version 9.0, a system update has been applied to change the managed attribute of the Marketing List entity to make it visible in the Microsoft Dynamics 365 mobile app (Name: IsVisibleInMobileClient, Logical Name: canmodifymobileclientvisibility) to true. A managed solution is exported from the 8.2 organization containing the custom entity, and by default the Marketing List entity definition is included as a dependency in the solution. When the managed solution is imported into the Microsoft Dynamics CRM 9.0 organization, there is a mismatch of the attribute definition. Since the entity in the target organization is managed and the managed attribute is not updateable and from a different publisher, it cannot be changed to the version in the solution and the error is displayed.

## Resolution

Microsoft is releasing a fix for this issue for the entities mentioned in the Cause section. If one of these entities is part of your solution, there is a workaround you can use in the meantime. The solution file can be modified to change the source organization entity attribute value to match the target organization entity attribute.

> [!NOTE]
> This resolution will only work for this import of this solution. If the solution is exported again from the source organization, this edit will have to be completed again. This should be a temporary resolution until the fix has released.

1. Unzip the solution file.
2. Open the customizations.xml file in a text editor
3. Search for the LogicalCollectionName (example: lists, team, and so on.)

   \<EntitySetName>lists\</EntitySetName>

4. Scroll down and find the attribute name that is mentioned in the error message. For the Marketing List entity, the attribute will most likely be IsVisibleInMobileClient. For the other entities mentioned in the Cause section, the field will be IsReadOnlyInMobileClient.

   \<IsVisibleInMobileClient>0\</IsVisibleInMobileClient>

5. Change the value to the opposite of the current setting (example: **0** to **1**.)

    \<IsVisibleInMobileClient>1\</IsVisibleInMobileClient>

6. Zip all the files together into a new edited solution and use this solution for the import.

## More information

The entity in the target organization that has the mismatch is identified in the error dialog. To retrieve the [ManagedPropertyLogicalName] attribute values that are mismatched, use the Web API to retrieve the entity identified by the GUID:

1. Open a web browser to access the Microsoft Dynamics 365 web application for the target organization where you are attempting to import the solution.
2. Duplicate the tab (right-click tab and then select Duplicate) so that you can use the authenticated browser session.

3. In the new tab run the following command replacing [GUID] with the GUID value from the error details and replacing [organizationURL] with the URL for your organization: `https://[organizationURL]/api/data/v8.2/EntityDefinitions([GUID])`

4. Search the output for the string in the [ManagedPropertyLogicalName].
5. Do the same procedure on the source organization and compare the values of the attribute mentioned in the error message.

**Example:**

Error message:

> The evaluation of the current component(name=Entity, id=efd3a52d-04ca-4d36-a54c-2a26a64f5571) in the current operation (Update) failed during managed property evaluation of condition: The evaluation of the current component(name=Entity, id=efd3a52d-04ca-4d36-a54c-2a26a64f5571) in the current operation (Update) failed during managed property evaluation of condition: Managed Property Name: canmodifymobileclientvisibility; Component Name: Entity; Attribute Name: canmodifymobileclientvisibility;

When using the query `https://[organizationURL]/api/data/v8.2/EntityDefinitions(efd3a52d-04ca-4d36-a54c-2a26a64f5571)`, the entities DisplayName is **Marketing List**:

```console
 "DisplayName":{
 "LocalizedLabels": [
 {
 "Label": "Marketing List",
 "LanguageCode": 1033,
 "IsManaged": true,
 "MetadataId": "<ID>",
 "HasChanged": null
 }
 ],
 The entities LogicalName is "list":
 "LogicalName": "list",
 And the entitiesLogicalCollectionName is "lists"
 "LogicalCollectionName": "lists",
 t.
```
