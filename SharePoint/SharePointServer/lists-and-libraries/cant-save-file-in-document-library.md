---
title: Can't save a document in a document library
description: Provides a workaround for an issue in which you cannot save a document in a SharePoint 2010 document library. This issue occurs when a document library contains a required Business data field.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Administration\Files and Documents
  - CSSTroubleshoot
ms.reviewer: erica, harikumh, markmead, russmax, sheyia, zsolti, rrogers, christwe, darinr, majoshi, sridhara, rrogers
appliesto: 
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# You cannot save a document in a SharePoint 2010 document library when the document library contains a required Business data field

## Symptoms

Consider the following scenario: 

- You have a document library in a Microsoft SharePoint Foundation 2010 server or in a Microsoft SharePoint Server 2010 server.
- This document library contains a required Business data field.
- You click **New Document** in the document library, and then you add some content.   
- You try to save the document. 

   **Note** You will receive the following warning message in Microsoft Word 2010:
Required Properties To save to the server, correct the invalid or missing required properties.

In this scenario, the default value of the Business data field is not set and the document cannot be saved. Additionally, you receive the following error message:

```adoc
This file cannot be saved because some properties are missing or invalid. Use the Document Information Panel to provide the correct property values. Errors for required properties are marked with a red asterisk, and errors for invalid properties are marked with a red dashed border.
```

**Note** This issue occurs because the Business data field is a required field.

## Workaround

To work around this issue, choose one of the following workarounds:

### Workaround 1

1. Click **New Document** in the Documents tab of the SharePoint 2010 list.   
2. In Word 2010, click **Insert**.   
3. In the **Text** group, click **Quick Parts**, point to **Document Property**, and then click to insert the control for the business data column.
4. Add data to the control for the business data column, and then save the document.

### Workaround 2

1. Create a new document in the client computer.
2. Upload this document to the document library.
3. Input the value for the required Business data field when you are prompted to do this.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
