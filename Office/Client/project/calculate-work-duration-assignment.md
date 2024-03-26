---
title: How work and duration are calculated with assignment changes
description: Describes how work and duration are calculated when you make resource assignment changes.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: petewi
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Server 2013
  - Project 2013 Standard
  - Project Professional 2013
  - Project Server 2010
  - Project Standard 2010
  - Project Professional 2010
  - Microsoft Office Project Standard 2003
  - Microsoft Office Project Professional 2003
ms.date: 03/31/2022
---

# How work and duration are calculated with assignment changes

## Summary

This article describes how work and duration are calculated when you make resource assignment changes.

## More Information

When you make multiple resource assignment changes on an Effort Driven task within the same edit session, Microsoft Project calculates work using the following formula:

Work = Total Work * (Resource Units/Total Resource Units)

For example, if you have a 2-day (2d) duration task where a resource (R1) is assigned 200%, the 2d duration task calculates to 32 hours (32 h) of work. If you add a new resource (R2) to the task, then Microsoft Project calculates work and duration for each resource in the following manner:

Resource R1 Work:

`21.33h = 32h Total Work * (200% R1 Units/300% Total Units)`

Resource R2 Work:

`10.67 = 32h Total Work * (100% R2 Units/300% Total Units)`

 **NOTE:** Total Units (300%) are calculated by adding the R1 resource unit (200%) and the R2 resource unit (100%).

Task T1 Duration Calculation:

`2.67d = 21.33h (R1 Total Work)/100% (R1 Units based on 8 hour day)`

`1.33d = 10.67h (R2 Total Work)/100% (R2 Units based on 8 hour day)`
 
The duration of the task changes from 2d to 2.67d due to the length of time necessary for the driving resource to complete it's assigned work. The driving resource for a task is determined to be the highest ratio of Work/Units for all resource assignments on a task. In this example, R1 is the driving resource because 2.67d is higher than 1.33d. Based on an 8-hour day, it will take R1 2.67d to complete 21.33 h of work.

### Steps to Reproduce Behavior in Project 2013


1. Create a new Blank Project   
2. Set new task to be Auto Scheduled. Enter a new task called T1 with a duration of 2days.   
3. On the View ribbon, in the Split View section, uncheck Timeline and check Details.    
4. Right click in the Detail pane and click Schedule.   
5. For the remaining steps use the Project 2010 from step 6.   


### Steps to Reproduce Behavior in Project 2010


1. Create a new Blank Project.   
2. Set New Tasks to Auto Scheduled. Enter a new task, T1. Set the duration to two days.   
3. On the View tab, click the check box for Details View to split the window.   
4. Press F6. The lower pane becomes the active pane.   
5. On the Format tab, click Schedule.   
6. Click to select the Effort Driven check box, and then click OK   
7. Press F6. The upper pane becomes the active pane.   
8. Select the T1 task.   
9. On the Resource tab, click Assign Resources.   
10. In the Assign Resource dialog box, enter two resources, R1 and R2.   
11. Select R1. In the units column type 200%, and then click Assign. 

    **NOTE** The lower pane R1 is assigned 200% for 32 h of work.   
12. Select R2, and then click Assign. Click Close.   

    **NOTE** The lower pane R1 is assigned 100% for 21.33 h of work while R2 is assigned 100% for 10.67 h of work.

### Steps to Reproduce Behavior in Project 2007 and earlier versions


1. On the File menu, click New. If you receive the Summary Information dialog box, click OK.   
2. Enter a new task, T1. Set the duration to two days.   
3. On the Window menu, click Split.   
4. Press F6.

   The lower pane becomes the active pane.
   
5. On the Format menu, point to Details, and then click Resource Schedule.   
6. Click to select the Effort Driven check box, and then click OK.   
7. Press F6.

    The upper pane becomes the active pane. 
  
8. Select the T1 task.   
9. On the Tools menu, point to Resources, and then click Assign Resources.   
10. In the Assign Resources dialog box, enter two resources, R1 and R2.   
11. Select R1. In the units column type 200%, and then click Assign.

    **NOTE** The lower pane R1 is assigned 200% for 32 h of work.   
12. Select R2, and then click Assign. Click Close. 
    
    **NOTE** The lower pane R1 is assigned 100% for 21.33 h of work while R2 is assigned 100% for 10.67 h of work.
