---
title: Total Size shows full file size for each version
description: Describes an unexpected versioning behavior in SharePoint Server 2013. When only the metadata is changed, the full size of the document is counted against the site collection quota.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Files and Documents
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Total Size from Storage Metrics shows full size file version in SharePoint 2013

_Original KB number:_ &nbsp; 3038333

## Summary

Consider the following scenario:

- You have configured a SharePoint 2013 Site Collection with a quota enabled.
- You have enabled versioning on your document library.
- You check out a document and change only the document metadata.

In this scenario, the **Total Size** value that's reported on the Storage Metrics page always shows the full file size for each version. For example, suppose that you just added a 100-MB file to your document library with versioning enabled. You then edit the document properties and make a change to the title. The total size that's reported by storage metrics will now be 200 MB.

## More information

This behavior is by design.

SharePoint Server 2013 uses SQL Server Shredded Storage to improve data transfer performance and reduce storage utilization. But the SharePoint quota component has no direct relationship to how SQL Server stores it physical data. Therefore, the quota component can't report on the space that's used on SQL Server physical storage.
