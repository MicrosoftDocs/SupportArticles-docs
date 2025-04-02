---
title: Error Code 80040203 Invalid Argument
description: Provides a solution to an error that occurs when you try to import a solution into Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Error code 80040203 (Invalid Argument) error when importing a solution into Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution into Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4514229

## Symptoms

When you try to [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) into Dynamics 365, you receive the following error message:

> The import of solution: \<Solution Name> failed.  
> Error Code 80040203.

> [!NOTE]
> This error code is documented in [Web service error codes](/powerapps/developer/common-data-service/org-service/web-service-error-codes) with the following information:
>
> Name: InvalidArgument  
> Hex: 80040203  
> Number: -2147220989  
> Invalid argument.

Additionally, the error dialog may reference the following type of object:

> **Type**: Relationship  
> **Name**: bpf_\<entity>\_\<publisher>\_\<BPF Name>  

The downloaded log file indicates the following on the **Components** page:

> **ItemType**: Entity Relationship  
> **Name**: bpf_\<entity>\_\<publisher>\_\<BPF Name>  
> **ErrorCode**: 0x80040203  
> **ErrorText**: Attribute Display Name for id: \<GUID>, objectcolumn: DisplayName and labelTypeCode: Attribute not specified

## Cause

The error occurs because the schema retains an entity relationship that should be removed after the entity is deleted from the [Business Process Flow (BPF)](/power-automate/business-process-flows-overview).

The referenced **Entity Relationship** name is a concatenation of an entity and a BPF. This issue occurs when an entity is removed from a BPF stage and replaced with a different entity, followed by an update to the BPF while it's still activated. Although the entity is removed from the BPF, the relationship persists in the schema and is exported with the solution from the source. This lingering relationship causes the error during import.

## Resolution

Microsoft is aware of this issue and is working on a fix to automatically remove the relationship after a delete and update. In the meantime, the following workarounds can be used to resolve the issue.

### Option 1 - Update solution file

If you can't recreate the solution package and need to proceed with the import, you can manually remove the problematic relationship from the solution file.

1. Unzip the solution file.
2. Edit the **customization.xml** file.
3. Search for the relationship mentioned in the error: bpf_\<entity>\_\<publisher>\_\<BPF Name>
4. Delete all XML references to the `EntityRelationship`:

    ```xml
    <EntityRelationship Name="bpf_<entity>_<publisher>_<BPF Name>">
    ...
    </EntityRelationship>
    ```

5. Save the file.
6. Zip the entire directory.
7. Import the solution again.

### Option 2 - Remove the relationship from the source and recreate your solution

This option provides a long-term resolution and ensures the issue is fixed for future exports of the solution.

1. Open the source organization.
2. Select **Settings** > **Customizations** > **Customize the System**.
3. Select the entity in the relationship:

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
8. Export the solution and import it into the target environment.
