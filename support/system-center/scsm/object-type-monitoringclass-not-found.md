---
title: An object of type MonitoringClass was not found
description: Fixes a problem in which An object of type MonitoringClass error occurs when you work with an Operations Manager connector in the System Center Service Manager console.
ms.date: 08/04/2020
ms.reviewer: austinm, luche
---
# An object of type MonitoringClass was not found error when you work with an Operations Manager connector

This article helps you fix an issue in which **An object of type MonitoringClass with ID was not found** error occurs when you work with an Operations Manager connector in the System Center Service Manager console.

_Original product version:_ &nbsp; System Center 2012 R2 Service Manager, System Center 2016 Service Manager  
_Original KB number:_ &nbsp; 4089861

## Symptoms

When you work with a System Center Operations Manager connector in the System Center Service Manager console, you receive an error message that resembles the following:

> Application: System Center Service Manager  
> Application Version: 7.5.7487.0  
> Severity: Error  
> Message: An object of type MonitoringClass with Id \<GUID> was not found.

The \<GUID> value that is reported will depend on the management pack that causes the problem.

## Cause

In Operations Manager, it's not valid to have a NULL `ImageCategory` field in the Operations Manager `ImageReference` SQL Server table. The `ImageCategory` field should be defined by the management pack that added the reference.

## Resolution

To resolve this problem, get an updated management pack that correctly defines the `ImageCategory` field. Or, remove from Operations Manager the management pack that's causing the problem. To determine which management pack is at fault, run the following SQL query against the Operations Manager SQL Server database:

```sql
SELECT [ImageReference].[ImageId], [ImageReference].[ReferenceId], [ImageReference].[ManagementPackId], [ImageReference].TimeAdded,  
[ImageReference].LastModified, SUBSTRING([EnumType].EnumTypeName, 39, 100) AS ImageCategory, [MPElementView].[MPElementName],
[ManagementPack].[ContentReadable]
FROM dbo.ImageReference
JOIN dbo.[Resource] on ([Resource].ResourceId = ImageReference.ImageId)
LEFT JOIN dbo.[Category] ON [Category].CategoryTarget = [Resource].ResourceId
LEFT JOIN dbo.[EnumType] ON [EnumType].EnumTypeId = [Category].CategoryValue
JOIN dbo.MPElementView ON (ImageReference.ReferenceId = MPElementView.MPElementId)
INNER JOIN dbo.[ManagementPack] ON dbo.ManagementPack.ManagementPackId = [ImageReference].ManagementPackId AND dbo.ManagementPack.ContentReadable = 1
WHERE dbo.[ImageReference].[ReferenceId] IN (select dbo.ManagedType.ManagedTypeId from dbo.ManagedType)
and dbo.[Resource].ResourceType = 4
order by ImageCategory
```

To find the management pack that has a NULL value for the `ImageCategory` field, substitute the management pack ID from the query results for the ########-####-####-####-############ placeholder in the following Select statement:

```sql
Select MPName, Version, MPKeyToken, ManagementPackId, IsSealed, isDeleted, TimeAdded from ManagementPackHistory where ManagementPackId = '########-####-####-####-############'
```
