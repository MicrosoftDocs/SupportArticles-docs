---
title: Error (Within a ForEachRecord only the records of the outermost ForEachRecord may be edited or deleted) when you run ForEachRecord data macro in Access
description: Describes an issue in which you receive a (Within a ForEachRecord only the records of the outermost ForEachRecord may be edited or deleted.) message when you run the ForEachRecord data macro.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: v-shaya
appliesto: 
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# Error (Within a ForEachRecord only the records of the outermost ForEachRecord may be edited or deleted.) when you run ForEachRecord data macro in Access

_Original KB number:_ &nbsp; 982781

## Symptoms

When you run the ForEachRecord data macro in Microsoft Access, you receive the following message:

> Within a ForEachRecord only the records of the outermost ForEachRecord may be edited or deleted.

After you click **OK**, you see that the **Macro Single Step** window displays the name of the problematic macro together with **Error Number: 2950**.

Additionally, you can't use an EditRecord macro or a CreateRecord macro in an inner loop of the ForEachRecord data macro.

## Cause

This issue occurs because the EditRecord data macro action and the DeleteRecord data macro action are supported only when they're run on the following recordsets:

- A parent recordset.
- The outermost recordset that is of a parent/child relationship.

This limitation is by design. This is because data macros aren't nested as transactions, if a system failure occurs during a ForEachRecord loop, the ForEachRecord loop may restart at the incorrect spot when the database restarts. This issue may cause duplicate values to be entered in the Access database or may cause another macro to be fired unintentionally.

## Workaround

To work around this issue, change the data macro so that the nested ForEachRecord data macro does not use the EditRecord action or the CreateRecord action.

## More Information

The error that is described in the "Symptoms" section is also listed in the **Description** column of the USysApplicationLog. However, the error number may be different in the USysApplicationLog.
