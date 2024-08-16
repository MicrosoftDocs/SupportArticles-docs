---
title: (Schema validation found non-datatype errors) error when opening an InfoPath Form Web Part
description: Describes the issue in which you receive the (Schema validation found non-datatype errors) error when you open an InfoPath Form Web Part on an external list.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\InfoPath Forms Service
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2010
  - InfoPath 2010
ms.reviewer: thomabr, sheyia, erica, markmead, harikumh, zsolti, russmax, fselkirk
ms.date: 12/17/2023
---
# (Schema validation found non-datatype errors) error message when you try to open an InfoPath Form Web Part on an external list in SharePoint Server 2010

_Original KB number:_ &nbsp; 982247

## Symptoms

Assume that you have an External List page on a Microsoft SharePoint Server 2010 server. The page uses the InfoPath Form Web Part. When you try to open an item on the page, you receive the following error message:

> Schema validation found non-datatype errors.  
Click **Try Again** to attempt to load the form again. If this error persists, contact the support team for the Web site.  
Click **Close** to exit this message.  
**Hide error details**  
Correlation ID :CID_string

## Cause

This problem occurs because a required field in a SharePoint 2010 external list database has the following characteristics:

- The field is marked as non-nullable.
- The field can accept empty strings as valid input. In this situation, Microsoft InfoPath 2010 treats empty strings and null entries as equivalent values. Therefore, these values are treated as invalid input.

## Workaround

To work around this problem, if you have a database field that is marked as required when you define an operation on the external content type, make sure that the field contains values that are valid and nonblank.
