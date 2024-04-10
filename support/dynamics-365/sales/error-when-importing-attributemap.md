---
title: Error when importing AttributeMap
description: Provides a solution to an error that occurs when you import AttributeMap in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Error occurs when importing AttributeMap in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you import AttributeMap in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4494576

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The import of solution: [solution name] failed.  
Error code 8004f016"

The grid within the error dialog includes a row of Type = Mappings. The detail text shown for this row is the following message:

> "A managed solution cannot overwrite a AttributeMap component on the target system that has an unmanaged base instance. The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged AttributeMap component on the target system, and now a managed solution from the same publisher is trying to install that same AttributeMap component as managed. This will cause an invalid layering of solutions on the target system and is not allowed."

Download the XML log file and open in Excel. In the **Components** tab, locate the cell: 0x8004F016.

In the next column will be an error message that includes the ID of the component:

> "A managed solution cannot overwrite the AttributeMap component with Id= [component ID] which has an unmanaged base instance. The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged AttributeMap component on the target system, and now a managed solution from the same publisher is trying to install that same AttributeMap component as managed. This will cause an invalid layering of solutions on the target system and is not allowed."

## Cause

As mentioned within the error details, the most likely scenario for this error is that an unmanaged customization has been made on the default solution in the target organization. Which will cause an invalid layering of solutions on the target system and isn't allowed.

Example: Your Dynamics 365 instance already has a component such as a custom AttributeMap that was created by editing the default solution. If you later try to import a solution with that same AttributeMap (component) as a managed solution, you'll receive this error.

## Resolution

For AttributeMap, the managed component can be found with two Web API queries and then deleted in the target:

1. Open a browser to your organization and then duplicate the tab.
2. Replace the `[GUID from Error]` with the GUID from the error message from the log file and then append to your organization:

    `api/data/v9.1/attributemaps([GUID from Error])?$select=_entitymapid_value,sourceattributename, targetattributename`

    Example:  
    `https://MyOrganization.crm11.dynamics.com/api/data/v9.1/attributemaps(0a7bb84f-3d3c-e911-a977-0022480187f0)?$select=_entitymapid_value,sourceattributename,targetattributename`

    There's the output:

    ```console
    {
    "@odata.context": "https://MyOrganization.crm11.dynamics.com/api/data/v9.1/$metadata#attributemaps(_entitymapid_value,sourceattributename,targetattributename)/$entity",
    "@odata.etag": "W/"5299006"",
    "_entitymapid_value": "1172d7cc-3c3c-e911-a977-0022480187f0",
    "sourceattributename": "css_mapfieldparent",
    "targetattributename": "css_mapfieldchild",
    "attributemapid": "0a7bb84f-3d3c-e911-a977-0022480187f0",
    "_organizationid_value": "112f329f-0a5f-4e2c-a2f0-c54e4824faa9"
    }
    ```

3. Replace the `[_entitymapid_value]` with the value from the first query and then append your organization:

    `api/data/v9.1/entitymaps([_entitymapid_value])?select=sourceentityname,targetentityname`

    Example:  
    `https://MyOrganization.crm11.dynamics.com/api/data/v9.1/api/data/v9.1/entitymaps(1172d7cc-3c3c-e911-a977-0022480187f0)?select=sourceentityname,targetentityname`

    There's the output:

    ```console
    {
    "@odata.context": "https://emeacrm3.crm11.dynamics.com/api/data/v9.1/$metadata#entitymaps(sourceentityname,targetentityname)/$entity",
    "@odata.etag": "W/"5296276"",
    "sourceentityname": "css_testamparent",
    "targetentityname": "css_testamchild",
    "entitymapid": "1172d7cc-3c3c-e911-a977-0022480187f0",
    "_organizationid_value": "112f329f-0a5f-4e2c-a2f0-c54e4824faa9"
    }
    ```

4. Use the information retrieved from the two queries to identify the AttributeMap:

    `sourceentityname`: `css_testamparent`,  
    `sourceattributename`: `css_mapfieldparent`,  
    `targetentityname`: `css_testamchild`,  
    `targetattributename`: `css_mapfieldchild`,

5. An AttributeMap can't exist without a `1:N relationship`. Look for the following example in the target organization:

    1:N relationship from **[sourceentityname]** ->**[targetentityname]** based on fields **[sourceattributename]** -> **[targetattributename]**

6. Locate this component in the target organization by navigating to **Settings**, **Customizations**, **Customize the System**.
7. Select **Entities**, and then Open **[sourceentityname]**.
8. Select **1:N Relationships**.
9. Sort by **Related Entity** and open relationship to **[targetentityname]**.
10. Select **Mappings** on the left.
11. Remove the mapping with:

    Source Name: [sourceattributename]  
    Target Name: [targetattributename]

12. Attempt to import your solution again.
