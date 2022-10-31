---
title: Unable to update or delete data in a linked table
description: Workaround an issue in which you may receive errors if you update or to delete an Access table by using an update or delete query that reads data from a linked-text file.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# "Updating or deleting data in a linked table is not supported by this ISAM" error in Access

_Original KB number:_ &nbsp; 824159

> [!NOTE]
> This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file. Requires basic macro, coding, and interoperability skills.

## Symptoms

If you try to update a Microsoft Access table by using an update query that reads data from a linked-text file, the update may fail and you may receive the following error message:

> Updating data in a linked table is not supported by this ISAM.

Note for Microsoft Office Access 2007 users

To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message:

> 503616

If you try to update an Access table by using a delete query that reads data from a linked-text file, the deletion may fail and you may receive the following error message:

> Deleting data in a linked table is not supported by this ISAM.

Note for Microsoft Office Access 2007 users

To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message:

> 503617

## Workaround

To work around this problem, import the text file to the Access database and then run the update query or run the delete query.

## References

For more information about how to import a text file in Microsoft Office Access 2003, click **Microsoft Office Access Help** on the **Help** menu, type *Import or link data and objects* in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.

For more information about how to import a text file in Microsoft Access 2002, click **Microsoft Access Help** on the **Help** menu, type *Import or link data and objects* in the Office Assistant or the Answer Wizard, and then click **Search** to view the topics returned.
