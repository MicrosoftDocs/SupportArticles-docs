---
title: Progress bars not drawn for tasks that are in progress
description: More details about the issue that task progress bars not working as expected in Gantt Chart view.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timj
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# Progress bars not drawn for tasks that are in progress in Project

## Symptoms

In Microsoft Project, in a Gantt Chart view, task progress bars may not be displayed when there is progress on a task.

## Cause

This behavior may be caused by either of the following two conditions.

### Condition 1: Resource Calendar Is 24 Hours

The resource calendar for the resource assigned to the task is based on the 24 Hours base calendar, or the resource calendar's working time is 24 hours.

**NOTE** Condition 1 only occurs in Project 2003 and earlier versions.

### Condition 2: Progress Bar Style Deleted

You deleted the progress bar style from the Bar Styles dialog box in a Gantt Chart view.

**NOTE** For condition 2, the behavior occurs on all tasks in the view.

To verify if the progress bar style exists or has been deleted, follow these steps:

1. On the menu ribbon's Format tab, click the arrown in the right corner of the Chart Style section to view Bar Styles. In Project 2010, choose the Format tab, click Format, and then click Bar Styles. NOTE: In Project 2007 and earlier versons, click Bar Styles on the Format menu.
2. By default, a progress bar style is listed in the Name column with Progress as the name. You can also identify a progress bar in the Bar Styles dialog box, where Actual Start is in the From column and Complete Through is in the To column.

## Workaround

### Condition 1: Resource Calendar Is 24 Hours

To work around condition 1, change the definition for the Progress bar style. To do this, follow these steps:

1. On the View menu, click the Gantt Chart that you want to edit.   
2. On the Format menu, click Bar Styles.
3. In the Progress bar definition, change Complete Through to Stop in the To column.   
4. Click OK.   

### Condition 2: Progress Bar Style Deleted

To work around condition 2, add a bar to display progress in a Gantt Chart. To do this in Project 2013 and later, follow these steps:

Project 2013

  1. On the menu ribbon, select the Format tab.
  2. In the Chart Style section of the ribbon, click the arrow in bottom right corner to display the Bar Styles dialog.   
  3. Click the row in the Bar Styles dialog where you want to insert the progress bar definition.   
  4. Click Insert Row.
  5. In the Name field for the blank row, type Progress.   
  6. Select the Appearance field for the Progress style.   
  7. On the Bars tab, under Middle, follow these steps, or choose the desired shape, pattern, and color to meet your needs:    
  8. In the Shape list, click the third bar shape: a medium bar width shape.   
  9. In the Pattern list, click the first bar pattern: a solid pattern.   
  10. In the Color list, click Black.   
  11. In the Show For... Tasks column, type Normal.   
  12. In the From column, type ActualStart.   
  13. In the To column, type CompleteThrough.   
  14. Click OK.   
   

Project 2010

1. On the View tab, click the Gantt Chart that you want to format.   
2. On the Format tab, click Format, and then click BarStyles.   
3. Click the row in the Bar Styles dialog where you want to insert the progress bar definition.   
4. Click InsertRow.   
5. In the Name field for the blank row, type Progress.   
6. Select the Appearance field for the Progress style.   
7. On the Bars tab, under Middle, follow these steps, or choose the desired shape, pattern, and color to meet your needs:
   1. In the Shape list, click the third bar shape: a medium bar width shape.   
   2. In the Pattern list, click the first bar pattern: a solid pattern.   
   3. In the Color list, click Black.   
   
8. In the Show For... Tasks column, type Normal.   
9. In the From column, type ActualStart.   
10. In the To column, type CompleteThrough.   
11. Click OK.   

To do this in Project 2007 and earlier versions, follow these steps: 

1. On the View menu, click the Gantt Chart that you want to format.   
2. On the Format menu, click Bar Styles.   
3. Click the row in the Bar Styles dialog box where you want to insert the progress bar definition.   
4. Click Insert Row.   
5. In the Name field for the blank row, type Progress.   
6. Select the Appearance field for the Progress style.   
7. On the Bars tab, under Middle, follow these steps, or choose the desired shape, pattern, and color to meet your needs:
   1. In the Shape list, click the third bar shape: a medium bar width shape.    
   2. In the Pattern list, click the first bar pattern: a solid pattern.   
   3. In the Color list, click Black.   
8. In the Show For ... Tasks column, type Normal.   
9. In the From column, type Actual Start.   
10. In the To column, type Complete Through.   
11. Click OK.
