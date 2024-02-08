---
title: Error code 80040203 Invalid Argument error
description: Provides a solution to an error that occurs when you try to import a solution into Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Error code 80040203 (Invalid Argument) error occurs when you try to import a solution into Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution into Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4514229

## Symptoms

When you try to import a solution in Dynamics 365, you receive the following error message:

> "The import of solution: \<Solution Name> failed.  
Error Code 80040203."

> [!NOTE]
> This error code is documented in [Web service error codes](/powerapps/developer/common-data-service/org-service/web-service-error-codes) with the following information:
>
> Name: InvalidArgument  
> Hex: 80040203  
> Number: -2147220989  
> Invalid argument.  

## Cause

This error can be caused for several reasons. If your error dialog references the following type of object, review the rest of this article for a potential solution:

> **Type**: Relationship  
**Name**: bpf_\<entity>\_\<publisher>\_\<BPF Name>  

Download the Log File that when opened to the Components page will show:

> **ItemType**: Entity Relationship  
**Name**: bpf_\<entity>\_\<publisher>\_\<BPF Name>  
**ErrorCode**: 0x80040203  
**ErrorText**: Attribute Display Name for id: \<GUID>, objectcolumn: DisplayName and labelTypeCode: Attribute not specified

The Name of the Entity Relationship will be the concatenation of an Entity and a Business Process Flow (BPF). The Entity was previously removed from a BPF stage and replaced with a different Entity, and then the BPF was updated while still activated. The entity has been removed from the BPF but the relationship still exists in the schema. So it's exported with the solution from the source. This relationship is causing the error to be displayed.

## Resolution

Microsoft is aware of this issue and is working on a change to remove this relationship after a delete then update.

There are two workarounds for this issue:

### Option 1 - Update Solution File

If you need to import the solution and can't recreate the solution package, then remove the relationship from the solution.

1. Unzip the solution.
2. Edit the customization.xml.
3. Search for the relationship mentioned in the error: bpf_\<entity>\_\<publisher>\_\<BPF Name>
4. Delete all the XML for the EntityRelationship:

    ```xml
    <EntityRelationship Name="bpf_<entity>_<publisher>_<BPF Name>">
    ...
    </EntityRelationship>
    ```

5. Save the file.
6. Zip the entire directory.
7. Import the solution again.

### Option 2 - Remove the relationship from the source and recreate your solution

It's a long-term resolution and will fix the issue for the next export of the solution.

1. Open the source organization.
2. Select **Settings** / **Customizations** / **Customize the System**
3. Select the Entity in the relationship:

    ```xml
    bpf_<entity>_<publisher>_<BPF Name>
    ```

4. Expand **1:N Relationships**.
5. Locate the relationship:

    ```xml
    bpf_<entity>_<publisher>_<BPF Name>
    ```

6. Select and delete the relationship.
7. Publish **All Customizations**.
8. Export the solution and import it into the target.
