---
title: Unable to print or preview a report
description: Describes a problem that occurs when you try to print or preview the report, and then you move between the report pages. You receive a No current record error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: rachelce
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# "No current record" error when you print or preview a report in Access

_Original KB number:_ &nbsp; 888635

> [!NOTE]
> Novice: Requires knowledge of the user interface on single-user computers. This article applies to a Microsoft Office Access database (.mdb and .accdb) and a Microsoft Office Access project (.adp).

## Symptoms

You receive a "No current record" error message in Microsoft Access when you try to print or preview a report by using the **Print** command or the **Print Preview** command, and then you move between the report pages.

## Cause

This problem may occur when the following conditions are true:

- Your report is grouped on multiple fields.
- In the **Group On** group property list, you selected **Each Value**.
- In the **Group Footer** group property list, you selected **Yes**.
- You have calculations in the group footer.

## Workaround

To work around this problem, use one of the following methods:

- Change the **Group On** group property to **Interval** for one of the field groups.
- Change the **Group Footer** group property to **No** for one of the field groups.
- Remove the calculations from the group footer.

> [!NOTE]
> To troubleshoot the precise cause of this problem, try each of these methods one at a time until you no longer receive the error message.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

For more information about how to group and how to sort in a report, click **Microsoft Office Access Help** on the **Help** menu, type change sorting and grouping levels in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.
