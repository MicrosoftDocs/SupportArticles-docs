---
title: SharePoint doesn't support export/import of subsites with Publishing templates
description: Describes an issue in which SharePoint Server doesn't support migrations of subsites into root sites or root sites into subsites in site collections that have the Publishing features turned on.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User experience\Accessibility
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# SharePoint Server doesn't support export/import of subsites with Publishing templates

_Original KB number:_ &nbsp; 968483

## Symptom

Microsoft SharePoint Server 2007/2010/2013 doesn't support migrations of subsites into root sites or root sites into subsites in site collections that have the Publishing features turned on.

## Cause

The reason for this limitation is that the Publishing features store vital information such as page layouts, and various properties such as information about variation, reusable content, and so on, in the root site of a site collection.

There is sometimes a business need to move parts of an existing site collection into a new site collection by exporting parts of the content using `STSADM -o export / import` or using SharePoint Management Shell cmdlets such as `Export-SPWeb` and `Import-SPWeb`.

This migration of subsites into root sites of a site collection is supported for all subsites that don't have features enabled that store information outside the exported scope.

## Resolution

Valid migration scenarios when using the Publishing features are the following:

- Export the site collection starting at the root site and then import it as the root site into a new site collection.
- Export subsites of the site collection and then import them as subsites into an existing site collection that has the Publishing features enabled.

Some manual work may be required to ensure master pages and page layouts that are in use in the subsites are copied over to the new site collection.

## More information

- [Export-SPWeb](/powershell/module/sharepoint-server/Export-SPWeb)
- [Import-SPWeb](/powershell/module/sharepoint-server/Import-SPWeb)
