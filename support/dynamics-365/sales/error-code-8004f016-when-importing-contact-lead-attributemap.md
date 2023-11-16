---
title: Error code 8004f016 when importing contact-lead AttributeMap
description: Error code 8004f016 occurs when you import contact-lead AttributeMap in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-data -management
---
# Error code 8004f016 when importing contact-lead AttributeMap in Microsoft Dynamics 365

This article provides resolutions for the error code **8004f016** that may occur when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4470790

## Symptoms

When you try to import a solution in Microsoft Dynamics 365, you encounter the following error:

> The import of solution: [solution name] failed.  
Error code 8004f016

The grid within the error dialog includes a row of **Type** = **Mappings** and **Name** = **contact-lead**. The detail text shown for this row is the following message:

> A managed solution cannot overwrite a AttributeMap component on the target system that has an unmanaged base instance.  The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged AttributeMap component on the target system, and now a managed solution from the same publisher is trying to install that same AttributeMap component as managed.  This will cause an invalid layering of solutions on the target system and is not allowed.

## Cause

Microsoft is investigating an issue with the contact-lead attribute map that can cause this error.

## Resolution

While Microsoft is investigating this issue with the contact-lead attribute map, you can use the steps below to work around this issue:

**Option 1:** Don't include the contact to lead (lead_parent_contact) relationship in the solution

This is a standard relationship that can be found within the Contact entity under the 1:N Relationships with the name lead_parent_contact.

**Option 2:** Remove the XML for the contact-lead attribute map:

1. Extract the contents of the solution file and open the customizations.xml file in a text editor.
2. Locate and remove the following section of XML:

    ```xml
    <EntityMap>
        <EntitySource>contact</EntitySource>
        <EntityTarget>lead</EntityTarget>
        <AttributeMaps>
            <AttributeMap>
                <AttributeSource>contactid</AttributeSource>
                <AttributeTarget>parentcontactid</AttributeTarget>
            </AttributeMap>
        </AttributeMaps>
    </EntityMap>
    ```

3. Save the customizations.xml file.
4. Select all of the files from the solution and send them to a compressed (.zip) file.
5. Attempt to import the updated solution.
