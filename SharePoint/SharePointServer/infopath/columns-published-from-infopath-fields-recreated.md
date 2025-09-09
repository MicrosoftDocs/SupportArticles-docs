---
title: Columns published from InfoPath fields are recreated
description: Fixes an issue in which columns published from InfoPath fields are recreated when the same InfoPath form template is republished to more than one document libraries in a SharePoint site.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\InfoPath Forms Service
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
search.appverid: MET150
ms.date: 12/17/2023
---
# Columns published from InfoPath fields are recreated when the same InfoPath form template is republished

_Original KB number:_ &nbsp; 2554288

## Symptoms

Consider the following scenario:

- You create an Office InfoPath form template and publish it to a document library in SharePoint. During publishing, you select certain InfoPath fields to be published as columns in the document library. After publishing the form template, you decide to publish the same form template and the same fields to a different document library on the same SharePoint site.

- Later, you implement a change in the InfoPath form template and republish the form template to both the document libraries in the same order as you did during the first publishing.

In this scenario, all the columns in the document libraries that were published from InfoPath fields are recreated.

During this procedure, the internal name of the recreated columns in the SharePoint document libraries is also updated, that is, a numeric starting with **0** is suffixed to the old column name. For example, a column called *LastName* changes to *LastName0*.

The recreation of the columns is a two-step process:

1. The column is added to the SharePoint library again.
2. The columns that are not associated with the InfoPath fields are removed.

## Cause

InfoPath stores the list of fields that are published to SharePoint document libraries in a local manifest along with the columns to which these fields are associated. This is accomplished by referencing the column ID in SharePoint (a unique GUID value) with the InfoPath field.

When you are publishing the updated InfoPath form template to a SharePoint document library the second time, InfoPath checks if the column with the associated ID already exists. If it does not find the corresponding column, a new column is created in the document library. Any columns that are not associated with any of the InfoPath fields are deleted from the document library.

The following operations are performed in the background when you publish the same form template to multiple SharePoint libraries:

- When you publish the form template to the first library the first time, each published column gets created and is associated with the corresponding InfoPath field.

- When you publish the form template to the second library the first time, InfoPath doesn't find the associated columns with the stored IDs and hence creates new columns. It then associates the new column ID with the corresponding InfoPath field.

- When you publish the form template to the first library the second time, InfoPath doesn't find the associated columns with the stored IDs, as the GUIDs from the second library are currently associated with the fields. So InfoPath creates new columns that in turn get new IDs and are
associated with the InfoPath fields.

- In this process, there are many columns created which are not associated with any of the InfoPath fields and are removed from the document library.

- This behavior is repeated when you publish the form template to the second library the second time.

> [!NOTE]
> This issue doesn't occur if the InfoPath form template is being published as a site content type or InfoPath fields are being published as site columns in SharePoint.

## Resolution

There are a couple of methods to prevent this from happening:

- Create a site column for each InfoPath field to be published on the SharePoint site and select the pre-created site columns when publishing the InfoPath form template to both the libraries.

    As the ID of the site columns will not change, InfoPath doesn't have to re-create the existing columns.

- Create a separate copy of the InfoPath form template, one for each of the SharePoint document libraries. This will ensure that InfoPath doesn't re-create the existing columns as the column IDs will not change.

    The disadvantage of this approach is that you need to implement all the changes in all the form template copies that are in use.

> [!NOTE]
> In general instead of publishing the InfoPath form template twice, the recommended approach is to publish the form template as a site content type and associate the site content type with both the SharePoint document libraries.

## More information

For more information, see [Add, remove, or modify SharePoint library columns or site columns](https://support.microsoft.com/office/93d836e0-382a-4f5c-b4f7-632e0e626313).
