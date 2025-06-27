---
title: How to print a Gantt Chart view without table information
description: Describes how to print a Gantt Chart view without table information.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: adrianje
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Professional 2010
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
ms.date: 05/26/2025
---

# How to print a Gantt Chart view without table information

## Summary

It is possible to print a Gantt Chart view without any table information. To do this, you must apply a table that has all the column widths set to zero. Note that a Gantt Chart view always requires some table to be applied.

## More Information

To create a table that displays no columns in Microsoft Project 2010 and 2013, do the following:

1. On the **View** tab, click **Tables**, and then click **More Tables**.   
2. For **Tables**: click **Task**.   
3. Click the **New** button.   
4. In the **Name** box, enter **No Table Info**.   
5. In the first row, under **Field** Name, enter ID, and in the first row under **Width**, enter a zero (0).   
6. Click to select **Show In Menu**.   
7. Click **OK**, and then click **Close**.   

You can now use this table to print or preview a Gantt Chart view without table information as follows:

1. On the **View** tab, click **Gantt Chart**.   
2. On the **View** tab, click **Tables**, and then click **No Table Info**.   
3. On the **File** tab, click **Print**.   

> [!NOTE]
> The printout or preview shows only the timescale part of the Gantt Chart without any table information to the left.

To create a table that displays no columns in Microsoft Project 2007 and earlier versions, do the following: 

1. On the **View** menu, click **Table**, and then click **More Tables**.   
2. For **Tables**, click **Task**.   
3. Click the New button   
4. In the **Name** box, enter **No Table Info**.   
5. In the first row, under **Field** Name, enter ID, and in the first row under **Width**, enter a zero (0).   
6. Click to select **Show In** Menu.   
7. Click **OK**, and then click **Close**.   

You can now use this table to print or preview a Gantt Chart view without table information as follows:

1. On the **View** menu, click **More Views**.   
2. Select **Gantt Chart**, and click **Apply**.   
3. On the **View** menu, click **Table**, and then click **No Table Info**.   
4. On the **File** menu, click **Print** or **Print Preview**.   

> [!NOTE]
> The printout or preview shows only the timescale part of the Gantt Chart without any table information to the left.

The above information applies to any view based on the Gantt Chart screen, such as Detail Gantt and Tracking Gantt.
