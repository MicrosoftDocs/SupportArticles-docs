---
title: Errors when open or make a reference to a linked table
description: Describes the problem that occurs when you open or make a reference to a linked table in Access. You may receive the Couldn't find input table or query 'name' error message.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# "Cannot find the input table or query" or "record source doesn't exist" error when using Access

_Original KB number:_ &nbsp; 287696

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies only to a Microsoft Access database (.accdb and .mdb).

## Symptoms

When you open or make a reference to a linked table in Microsoft Access, you may receive one of the following error messages:

Error message 1

> The Microsoft Jet database engine cannot find the input table or query '\<**name**>'. Make sure it exists and that its name is spelled correctly.

Error message 2

> The record source '\<**name**>' specified on this form or report does not exist.

Error message 3

- In Microsoft Access 2002

  - > Microsoft Access can't find the object '\<**name**>.'
  - > Run-time error '7874': Microsoft Access can't find the object '\<**name**>.'

- In Microsoft Office Access 2003, Microsoft Office Access 2007, and Microsoft Office Access 2010
  
  - > Microsoft Office Access can't find the object '\<**name**>.'
  - > Run-time error '7874': Microsoft Office Access can't find the object '\<**name**>.'

## Cause

You may receive this error message if Access can't find the table or the query in the database, if a link points to an external file that doesn't exist, or if the external file has been moved to a new location. This error can also occur if a deleted or renamed table or query is referenced on the **Lookup** tab of another table.

## Resolution

To troubleshoot this behavior, do the following:

- Check to ensure that the table or query exists. If it doesn't exist, you can remove all references to it, or if it's a missing table, reimport or relink the table. If it's a missing query, reimport or re-create the query. Often the `RecordSource` property of a form or a report contains a reference to a table or a query whose name has changed or which has been deleted.
- If the table or query exists, it is likely that there is a syntax error or a spelling error in the reference to it. If so, correct the syntax error or spelling error in the reference.
- When you try to open a linked table, the source table may not be in the path that you specified when it was first linked. If you have moved the file, you can use the Linked Table Manager to update the link information.
