---
title: Access linked table to a SharePoint list returns Deleted
description: Describes an issue in which an Access linked table that connects to a SharePoint list returns 
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
- Access 2013
---

# Access linked table to a SharePoint list returns #Deleted

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptom

When you open a linked table in Access that's linked to a SharePoint list, the results are displayed as #Deleted.

This issue occurs if the following conditions are true: 

- The Access database uses the following caching options under **Access > Options > Current Database**:  
    - **Use the cache format that is compatible with Microsoft Access 2010 and later** is selected.    
    - **Never Cache** is cleared.    
- The linked table contains one or more **Memo** fields.    

## Workaround

To work around this issue, use one of the following methods: 

- Change the caching options to one of the following:  
  - Clear the option **Use the cache format that is compatible with Microsoft Access 2010 and later**.    
  - Select both the **Use the cache format that is compatible with Microsoft Access 2010 and later** and **Never Cache** options.    
- Use the [ImportSharePointList macro action](https://docs.microsoft.com/office/client-developer/access/desktop-database-reference/importsharepointlist-macro-action) to link to a SharePoint view of the list that doesn't contain the Memo fields.
