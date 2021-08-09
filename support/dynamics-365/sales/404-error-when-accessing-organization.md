---
title: A 404 error when accessing an organization
description: Provides a solution to a 404 error occurs when you try to access a Microsoft Dynamics CRM 2011 organization after applying Update Rollup 12.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# A 404 error occurs when you try to access a Microsoft Dynamics CRM 2011 organization after applying Update Rollup 12

This article provides a solution to a 404 error occurs when you try to access a Microsoft Dynamics CRM 2011 organization after applying Update Rollup 12.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2808349

## Symptoms

After applying Update Rollup 12 for Microsoft Dynamics CRM 2011 On Premise, you can no longer access an organization because of a 404 error. If platform tracing is enabled when the issue reproduces, the following error appears:

> Microsoft.Crm.CrmException: An item with the same key has already been added . ---> System.ArgumentException: An item with the same key has already been added.  
at System.Collections.Generic.Dictionary\`2.Insert(TKey key, TValue value, Boolean add)  
at Microsoft.Crm.Metadata. PreloadedOptionSetMetadataDataProvider.LoadNormalOptions (IPreloadedMetadataInitializationContext context, Boolean initializeEnumOptionProvider)  
at Microsoft.Crm.Metadata.PreloadedMetadataCacheDataProvider.InitializeOptionSets(IPreloadedMetadataInitializationContext context, LoadMasks masks, IOrganizationContext organizationContext)

## Cause

It's a known issue that will be addressed in a future update.

## Resolution

To work around the issue, it's necessary to run a SQL script against the organization database that is failed to update. While direct modifications to the database are typically unsupported, the use of the following SQL script has been officially approved by Microsoft Dynamics CRM Support.

1. Create a Full database backup of the Microsoft Dynamics CRM Organization that is experiencing the issue.
2. In SQL Management Studio, select **New Query**.
3. In the **Available Databases** drop-down menu, select the Microsoft Dynamics CRM Organization that is experiencing the issue.
4. Copy and paste the below statement into the New Query window, and select **Execute (F5)**:

    ```sql
    declare @IncidentOptionSetId uniqueidentifier = '7779161B-0E32-4001-8D44-339C2D1FF1F0'
    declare @IncidentSystemPicklistIdFor1000 uniqueidentifier = 'DE3D1468-D2F4-4BC6-8BF6-73C5C64C435D'
    declare @IncidentPicklistValueFor1000 int = 1000

    declare @CategoryOptionSetId uniqueidentifier = '3041D03C-4166-4814-A2D4-1E3D93CAF2F1'
    declare @CategorySystemPicklistIdFor1000 uniqueidentifier = 'ECBEE2BC-BAD2-4723-8612-371B4CE8D9E5'
    declare @CategorySystemPicklistIdFor1001 uniqueidentifier = 'DE121D28-F5DF-45F7-B6FC-E97B1604F747'
    declare @CategorySystemPicklistIdFor1002 uniqueidentifier = '8612EA04-81CF-423B-ADF4-EF74EEA70A41'
    declare @CategoryPicklistValueFor1000 int = 1000
    declare @CategoryPicklistValueFor1001 int = 1001
    declare @CategoryPicklistValueFor1002 int = 1002
    declare @CategoryPicklistValueFor6 int = 6
    declare @CategoryPicklistValueFor7 int = 7
    declare @CategoryPicklistValueFor8 int = 8

    declare @SystemSolutionId uniqueidentifier = 'FD140AAD-4DF4-11DD-BD17-0019B9312238'
    declare @AttributePicklistValueLabelTypeCode int = 2
    declare @AttributePicklistValueSolutionComponentType int = 4
    declare @DeleteComponentState int = 2

    declare @PicklistIdMapping table
    (
    OldId uniqueidentifier,
    NewId uniqueidentifier
    )

    delete @PicklistIdMapping
    insert into @PicklistIdMapping (OldId, NewId)
     select AttributePicklistValueId, NULL
     from MetadataSchema.AttributePicklistValue
     where
      Value = @CategoryPicklistValueFor6 and AttributePicklistValueId = @CategorySystemPicklistIdFor1000
      or Value = @CategoryPicklistValueFor7 and AttributePicklistValueId = @CategorySystemPicklistIdFor1001
      or Value = @CategoryPicklistValueFor8 and AttributePicklistValueId = @CategorySystemPicklistIdFor1002
      -- do not include incident status picklist in here
     group by AttributePicklistValueId
     having COUNT(*) = 1

    delete MetadataSchema.LocalizedLabel
    from
     MetadataSchema.LocalizedLabel l
     inner join @PicklistIdMapping m on l.ObjectId = m.OldId
     where l.LabelTypeCode = @AttributePicklistValueLabelTypeCode

    delete DependencyBase where DependentComponentNodeId in
    (
     select DependencyNodeId
     from
      DependencyNodeBase d
      inner join @PicklistIdMapping m on d.ObjectId = m.OldId
      where d.ComponentType = @AttributePicklistValueSolutionComponentType
    )

    delete DependencyNodeBase
    from
     DependencyNodeBase d
     inner join @PicklistIdMapping m on d.ObjectId = m.OldId
     where d.ComponentType = @AttributePicklistValueSolutionComponentType

    delete MetadataSchema.AttributePicklistValue
    from
     MetadataSchema.AttributePicklistValue a
     inner join @PicklistIdMapping m on a.AttributePicklistValueId = m.OldId

    delete @PicklistIdMapping
    insert into @PicklistIdMapping (OldId, NewId)
     select AttributePicklistValueId, NEWID()
     from MetadataSchema.AttributePicklistValue
     where
      Value = @CategoryPicklistValueFor6 and AttributePicklistValueId = @CategorySystemPicklistIdFor1000
      or Value = @CategoryPicklistValueFor7 and AttributePicklistValueId = @CategorySystemPicklistIdFor1001
      or Value = @CategoryPicklistValueFor8 and AttributePicklistValueId = @CategorySystemPicklistIdFor1002
      -- do not include incident status picklist in here
     group by AttributePicklistValueId
     having COUNT(*) > 1

    update MetadataSchema.LocalizedLabel
    set ComponentState = @DeleteComponentState
    from
     MetadataSchema.LocalizedLabel l
     inner join @PicklistIdMapping m on l.ObjectId = m.OldId
     where l.SolutionId = @SystemSolutionId and l.LabelTypeCode = @AttributePicklistValueLabelTypeCode

    update MetadataSchema.AttributePicklistValue
    set ComponentState = @DeleteComponentState
    from
     MetadataSchema.AttributePicklistValue a
     inner join @PicklistIdMapping m on a.AttributePicklistValueId = m.OldId
     where a.SolutionId = @SystemSolutionId

    update MetadataSchema.LocalizedLabel
    set ObjectId = m.NewId
    from
     MetadataSchema.LocalizedLabel l
     inner join @PicklistIdMapping m on l.ObjectId = m.OldId
     where l.LabelTypeCode = @AttributePicklistValueLabelTypeCode

    update DependencyNodeBase
    set ObjectId = m.NewId
    from
     DependencyNodeBase d
     inner join @PicklistIdMapping m on d.ObjectId = m.OldId
     where d.ComponentType = @AttributePicklistValueSolutionComponentType

    update MetadataSchema.AttributePicklistValue
    set AttributePicklistValueId = m.NewId
    from
     MetadataSchema.AttributePicklistValue a
     inner join @PicklistIdMapping m on a.AttributePicklistValueId = m.OldId

    delete @PicklistIdMapping
    insert into @PicklistIdMapping (OldId, NewId)
     select AttributePicklistValueId OldId,
      CASE Value
       WHEN @CategoryPicklistValueFor1000 THEN @CategorySystemPicklistIdFor1000
       WHEN @CategoryPicklistValueFor1001 THEN @CategorySystemPicklistIdFor1001
       WHEN @CategoryPicklistValueFor1002 THEN @CategorySystemPicklistIdFor1002
      END NewId
     from AttributePicklistValueView
     where OptionSetId = @CategoryOptionSetId and Value in (@CategoryPicklistValueFor1000, @CategoryPicklistValueFor1001, @CategoryPicklistValueFor1002)

    delete from @PicklistIdMapping where OldId in (@CategorySystemPicklistIdFor1000, @CategorySystemPicklistIdFor1001, @CategorySystemPicklistIdFor1002)

    insert into @PicklistIdMapping (OldId, NewId)
     select AttributePicklistValueId OldId, @IncidentSystemPicklistIdFor1000 NewId
     from AttributePicklistValueView
     where OptionSetId = @IncidentOptionSetId and Value = @IncidentPicklistValueFor1000
    delete from @PicklistIdMapping where OldId = @IncidentSystemPicklistIdFor1000

    update MetadataSchema.LocalizedLabel
    set ObjectId = m.NewId
    from
     MetadataSchema.LocalizedLabel l
     inner join @PicklistIdMapping m on l.ObjectId = m.OldId
     where l.LabelTypeCode = @AttributePicklistValueLabelTypeCode

    update DependencyNodeBase
    set ObjectId = m.NewId
    from
     DependencyNodeBase d
     inner join @PicklistIdMapping m on d.ObjectId = m.OldId
     where d.ComponentType = @AttributePicklistValueSolutionComponentType

    update MetadataSchema.AttributePicklistValue
    set AttributePicklistValueId = m.NewId
    from
     MetadataSchema.AttributePicklistValue a
     inner join @PicklistIdMapping m on a.AttributePicklistValueId = m.OldId
    ```
