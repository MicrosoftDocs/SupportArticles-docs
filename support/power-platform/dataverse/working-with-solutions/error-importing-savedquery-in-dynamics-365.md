---
title: Error importing SavedQuery in Dynamics 365
description: Error occurs when importing SavedQuery in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Error occurs when importing SavedQuery in Microsoft Dynamics 365

This article provides a resolution for the error messages that you may receive when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4496853

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, you encounter the following error:

> The import of solution: [solution name] failed.  
Error code 8004f016

The grid within the error dialog includes a row of Type = System Views. The detail text shown for this row is the following message:

> A managed solution cannot overwrite a SavedQuery component on the target system that has an unmanaged base instance. The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged SavedQuery component on the target system, and now a managed solution from the same publisher is trying to install that same SavedQuery component as managed. This will cause an invalid layering of solutions on the target system and is not allowed.

Download the XML log file and open it in Excel. In the **Components** tab, locate the cell: 0x8004F016.

In the next column will be an error message that includes the ID of the component:

> A managed solution cannot overwrite the SavedQuery component with Id=[Component Id] which has an unmanaged base instance. The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged SavedQuery component on the target system, and now a managed solution from the same publisher is trying to install that same SavedQuery component as managed. This will cause an invalid layering of solutions on the target system and is not allowed.

## Cause

As mentioned within the error details, the most likely scenario for this error is that an unmanaged customization has been made on the default solution in the target organization. This will cause an invalid layering of solutions on the target system and is not allowed.

Example: Your Microsoft Dynamics 365 instance already has a component such as a custom Saved Query that was created by importing an unmanaged solution. If you later try to import a managed solution with the same Saved Query, you will encounter this error.

## Resolution

For Saved Query the managed component can be found with a Web API query and then deleted in the target:

1. Open a browser to your organization and then duplicate the tab.
2. Replace the [GUID from Error] with the GUID from the error message from the log file and then append to your organization:

    api/data/v9.1/savedqueries?$filter=savedqueryid eq '[GUID from Error]'

    Example:

    `https://MyOrganization.crm11.dynamics.com/api/data/v9.1/savedqueries?$filter=savedqueryid eq '1d0f4d57-6d49-e911-a98d-00224800ce20'`

    This is the output:

    ```console
    {
    "@odata.etag": "W/\"5792499\"",
    "returnedtypecode": "css_testsqparent",
    "statecode": 0,
    "layoutxml": "<grid name=\"resultset\" icon=\"1\" preview=\"1\" select=\"1\" jump=\"css_name\" 
    object=\"10224\"><row id=\"css_testsqparentid\" name=\"result\"><cell name=\"css_name\" width=\"150\" />
    <cell name=\"css_testsqfield\" width=\"100\" /></row></grid>",
    "savedqueryid": "1d0f4d57-6d49-e911-a98d-00224800ce20",
    "description": "View to trigger 8004F016 named ",
    "createdon": "DateTime",
    "savedqueryidunique": "bdab33b7-18d0-45d6-9db9-6111afc1e444",
    "fetchxml": "<fetch mapping=\"logical\" output-format=\"xml-platform\" version=\"1.0\"><entity 
    name=\"css_testsqparent\"><attribute name=\"css_name\" /><order descending=\"false\" attribute=\"css_name\"
    /><attribute name=\"css_testsqfield\" /><attribute name=\"css_testsqparentid\" /></entity></fetch>",
    "isuserdefined": true,
    "name": "TestSQView","isdefault": false,
    "solutionid": "fd140aae-4df4-11dd-bd17-0019b9312238",
    "ismanaged": false,
    "versionnumber": 5792499,
    "introducedversion": "1.1.0.0",
    "querytype": 0,
    "statuscode": 1,
    "_modifiedby_value": "ba7ca8f4-5a68-4221-821c-5ca91b5f54ad",
    "modifiedon": "DateTime",
    ```

3. To locate this component in the target organization, navigate to **Settings** > **Customizations** > **Customize the System**.
4. Select **Entities** and sort by **Schema Name**.
5. Locate the Entity that is the returntypecode in the query output.
6. Open the entity and select **Views**.
7. Locate the Name that is the name in the query output.
8. Delete this view.
9. Import the solution again.
