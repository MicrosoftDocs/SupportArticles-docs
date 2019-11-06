---
title: Tasks are not scheduled as expected in Microsoft Project
description: Describes an issue where Tasks are not scheduled as expected in Microsoft Project. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: plammer 
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft Office Project Professional 2003
- Microsoft Office Project Standard 2003
- Project Professional 2010
- Project Server 2010
- Project Standard 2010
- Project Professional 2013
- Project 2013 Standard
---

# Tasks are not scheduled as expected in Microsoft Project

## Summary

This article describes why a task may not be scheduled as expected in Microsoft Project and offers suggestions for correcting the behavior.

## More Information

A task may not be scheduled as expected for a number of reasons. To determine the exact cause in Project 2010, ask yourself the following questions.

> [!NOTE]
> Before testing any of the scenarios in this article, make a backup copy of the file or save any changes you might have made to the file.

1. Is the Calculate project after each edit option set to off?

   When you specify a manual calcualtion, Microsoft Project will calculate your file only when you press F9. Set Calculation to On to resolve scheduling conflicts. To set the calculation method, follow these steps:

   a. On the Filetab, click Options

   b. Click the Scheduletab.

   c. Under Calculation, click on either Onor Off.

2. Is the Show Scheduling Messages option turned off?

   If the Show Scheduling Messages option is turned off, changes to the project file that result in scheduling conflicts will be processed. If the Show Scheduling Messages option is turned on, you can see the conflick and correct it. To turn the Show Scheduling Messages option on or off, follow these steps:

   1. On the Filetab, click Options.
   1. Click the Scheduletab.
   1. Click to select or clear the ShowSchedulingMessagescheck box.
   1. Click the Advancedtab.
   1. Under PlanningWizard, select all check boxes.

   > [!NOTE]
   > After scheduling messages are turned on, press F9 on the keyboard. Any scheduling messages that occur must be resolved before the project will be calculated correctly.

3. Are you scheduling from the project's Start Date or the project's Finish Date?

   When scheduling from the project's Start Date, the task will begin as soon as possible. When scheduling from the project's Finish Date, the tasks will begin as late as possible. To check which date is set in your file, click ProjectInformationon the Projecttab.

4. What is the project's Start Date?

   If the Show Scheduling Messages option is turned on, and you enter a task that occurs before the project's Start Date, you will receive a warning message. If you want to schedule a task to start before the porject's Start Date, manually enter the date for the task. To check the Project Start Date, click Projectinformationon the Projecttab.

5. Did you enter a percent complete on a task?

   If you entered a percent complete on a task, and the task has already started, you cannot change the Start Date automatically. To determine where the task would schedule automatically, set the task to zero percent complete. To do this, follow these steps:

   1. Select the task.
   1. On the Tasktab, click Task Information.
   1. Click the Generaltab.
   1. In the Percent Completebox, type 0.
   1. Click OK.

6. Did you assign an Actual Start Date to the task?

   You can assign an Actual Start Date to a task and not enter a percent complete. The task will not be scheduled automatically unless you set the Actual Start Date to NA. To set the Actual Start Date, insert the actual start field into your table. To do this, follow these steps:

    1. Select the title of any column currently in your table.
    1. On the Formattab, click Insert Column.
    1. Select Actual Startfor the Field Nameand click OK.

7. Did you assign a constraint type other than As Soon As Possible (ASAP) to the task?

   A contraint can cause a task to be scheduled according to the type of constraint and the date set. In Microsoft Project, a task that has the constraint of As Late As Possible (ALAP) task in a project that is scheduled from the project's Finish Date. To check the constraint type, follow these steps:

   1. Double-click the ID number for the task.
   1. Click the Advanced tab.

8. Are there any predecessor or successor relationships?

   The type of relationship will determine when the task can be scheduled. In Microsoft Project, the Task will always honor their constraint datessetting overrides the task relationship links. To set this option, follow these steps:

    1. On the Filetab, click Options.
    1. Click the Scheduletab.
    1. Click to select the Tasks will always honor their contraints dates check box.
    1. Click OK.

9. Are you using automatic Resource Leveling?

   Automatic resource leveling will add delay to a task to avoid resource conflicts. This results in the task Start Date being pushed out. If you select the Manual option, delay will not be added to tasks automatically. To remove any delay added to a task and to set resource leveling to manual, do the following:

    * To remove delay, click Clear Leveling on the Resource tab.
    
    * To set resource leveling to manual, click Leveling Options on the Resource tab, and then click Manual.

10. Is there a value in the Task Delay field?

    If the Task Delay field contains a value greater than zero, you cannot schedule the task earlier. To clear the Delay field, see step 9.

11. Is the task a subtask?

    If a Summary task (at any level) has a predecessor or a constrain, the subtask cannot be scheduled any earlier than the summary task. To check a summary task for predecessors or constraints, follow these steps:

    1. Select the task.
    1. On the Tasktab, click Task Information.
12. Is there a resource assigned to the task?

    The resource calendar can affect the scheduling of a resource-driven task but not a fixed duration task. In Microsoft Project, the resource calendar can affect all three task types (fixed duration, fixed work, and fixed units). Remove the resource to see if, in fact , the resource is affecting the scheduling. After the resource is removed, if the task schedules as expected, then check the resource's calendar. To check the Resoure calendar, follow these steps:

    On the Project tab, click Change Working Time, and then select the resource name from the drop down list.

13. Are you trying to schedule a task during a non-working time?

    If a day is marked as non-working, then you cannot schedule a task to start on that day. To check the Project Calendar, click Change WorkingTime on the Projecttab.

14. Are there any predecessor or successor relationships assigned to summary tasks?

    Predecessor and Successor relationships assigned to summary task can affect sub task of the summary task in addition to the summary task(s) that are linked.

    The type of relationship will determine when the task can be scheduled. In Microsoft Project, the Tasks will always honor their constraint dates setting overrides the task relationship links. Earlier versions of Microsoft Project do not have this option. To set this option, follow these steps:

    1. On the Filetab, click Options.
    1. Click the Scheduletab.
    1. Click to select the Task will always honor their contraint datescheck box.
    1. Click OK.

To determine the exact cause in Project 2007 and earlier versions, ask yourself the following questions.

> [!NOTE]
> Before testing any of the scenarios in this article, make a backup copy of the file or save any changes you might have made to the file.

1. Is the Calculation option set to Manual?

   When you specify a manual calculation, Microsoft Project will calculate your file only when you press F9. Set Calculation to Automatic to resolve scheduling conflicts. To set the calculation method, follow these steps:
   1. On the **Tools** menu, click **Options**.   
   2. Click the **Calculation** tab.   
   3. Under **Calculation**, click either **Automatic** or **Manual**.   
   
2. Is the Show Scheduling Messages option turned off?

   If the Show Scheduling Messages option is turned off, changes to the project file that result in scheduling conflicts will be processed. If the Show Scheduling Messages option is turned on, you can see the conflict and correct it. To turn the Show Scheduling Messages option on or off, follow these steps:
   1. On the **Tools** menu, click **Options**.   
   2. Click the **Schedule** tab.   
   3. Click to select or clear the **Show Scheduling Messages** check box.   
   4. Click the **General** tab.   
   5. Under **PlanningWizard**, select all check boxes.   

    > [!NOTE]
    > After scheduling messages are turned on, press F9 on the keyboard. Any scheduling messages that occur must be resolved before the project will be calculated correctly.   
3. Are you scheduling from the project's Start Date or the project's Finish Date?

   When scheduling from the project's Start Date, the tasks will begin as soon as possible. When scheduling from the project's Finish Date, the tasks will begin as late as possible. To check which date is set in your file, click **Project information** on the **Project** menu.   
4. What is the project's Start Date?

   If the Show Scheduling Messages option is turned on, and you enter a task that occurs before the project's Start Date, you will receive a warning message. If you want to schedule a task to start before the project's Start Date, manually enter the date for the task. To check the Project Start Date, click **Project information** on the **Project** menu.

5. Did you enter a percent complete on a task?

   If you entered a percent complete on a task, and the task has already started, you cannot change the Start Date automatically. To determine where the task would schedule automatically, set the task to zero percent complete. To do this, follow these steps:
   1. Select the task.   
   2. On the **Project** menu, click **Task Information**.   
   3. Click the **General** tab.   
   4. In the **Percent Complete** box, type 0.   
   5. Click OK.   
   
6. Did you assign an Actual Start Date to the task?

   You can assign an Actual Start Date to a task and not enter a percent complete. The task will not be scheduled automatically unless you set the Actual Start Date to NA. To set the Actual Start Date, insert the actual start field into your table. To do this, follow these steps:
   1. Select the title of any column currently in your table.   
   2. On the **Insert** menu, click **Insert Column**.   
   3. Select **Actual Start** for the **Field Name** and click **OK**.   
   
7. Did you assign a constraint type other than As Soon As Possible (ASAP) to the task?

   A constraint can cause a task to be scheduled according to the type of constraint and the date set. In Microsoft Project , a task that has the constraint of As Late As Possible (ALAP) will be scheduled as an ASAP task in a project that is scheduled from the project's Finish Date. To check the constraint type, follow these steps:
    1. Double-click the ID number for the task.   
    2. Click the **Advanced** tab.   
   
8. Are there any predecessor or successor relationships?

   The type of relationship will determine when the task can be scheduled. In Microsoft Project , the **Tasks will always honor their constraint dates** setting overrides the task relationship links. To set this option, follow these steps:
    1. On the **Tools** menu, click **Options**.   
    2. Click the **Schedule** tab.   
    3. Click to select the **Tasks will always honor their constraint dates**check box.   
    4. Click **OK**.    
9. Are you using automatic Resource Leveling?

   Automatic resource leveling will add delay to a task to avoid resource conflicts. This results in the task Start Date being pushed out. If you select the Manual option, delay will not be added to tasks automatically. To remove any delay added to a task and to set resource leveling to manual, do the following:
    - To remove delay, click **Clear Leveling**.   
    - To set resource leveling to manual, click **Resource Leveling** on the **Tools** menu, and then click **Manual**.   
10. Is there a value in the Task Delay field?

    If the Task Delay field contains a value greater than zero, you can not schedule the task earlier. To clear the Delay field, see step 9.
11. Is the task a subtask?

    If a Summary Task (at any level) has a predecessor or a constraint, the subtask cannot be scheduled any earlier than the summary task. To check a summary task for predecessors or constraints, follow these steps:
    1. Select the task.   
    2. On the **Project** menu, click **Task Information**.   
   
12. Is there a resource assigned to the task?

    The resource calendar can affect the scheduling of a resource-driven task but not a fixed duration task. In Microsoft Project , the resource calendar can affect all three task types (fixed duration, fixed work, and fixed units). Remove the resource to see if, in fact the resource is effecting the scheduling. After the resource is removed, if the task schedules as expected, then check the resource's calendar. To check the resource calendar, follow these steps:

    On the **Tools** menu, click **Change Working Time**, and then select the resource name from the drop down list.   
13. Are you trying to schedule a task during a non-working time?

    If a day is marked as non-working, then you cannot schedule a task to start on that day. To check the Project Calendar, click **Change Working Time** on the **Tools** menu.

14. Are there any predecessor or successor relationships assigned to summary tasks?

    Predecessor and Successor relationships assigned to summary tasks can effect sub tasks of the summary task in addition to the summary task(s) that are linked.

    The type of relationship will determine when the task can be scheduled. In Microsoft Project , the **Tasks will always honor their constraint dates** setting overrides the task relationship links. Earlier versions of Microsoft Project do not have this option. To set this option, follow these steps:
    
    1. On the **Tools** menu, click **Options**.   
    2. Click the **Scheduling** tab.   
    3. Click to select the **Tasks will always honor their constraint dates** check box.   
    4. Click **OK**.   
   
If you have performed all these tests and you still have a scheduling issue, try to create a new task, or try to delete the problem task, and then re-create it.
