---
title: Tasks aren't scheduled as expected in Microsoft Project
description: Describes an issue where Tasks aren't scheduled as expected in Microsoft Project. Provides a solution.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: plammer
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Professional 2013
  - Project 2013 Standard
  - Project Professional 2010
  - Project Server 2010
  - Project Standard 2010
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
ms.date: 05/26/2025
---

# Tasks don't schedule as expected in Microsoft Project

## Summary

This article describes why a task isn't scheduled as expected in Microsoft Project and offers suggestions for correcting the behavior.

## More Information

### Project 2010

A task may not schedule as expected for many reasons. To determine the exact cause in Project 2010, review the following questions:

> [!NOTE]
> Before testing any of the scenarios in this article, make a backup copy of the file or save any changes you might have made to the file.

1. Is the Calculate project after each edit option set to off?

   When you specify a manual calculation, Microsoft Project calculates your file only when you press F9. Set Calculation to **On** to resolve scheduling conflicts. 

   To set the calculation method, follow these steps:

   a. On the **File** tab, select **Options**.

   b. Select the **Schedule** tab.

   c. Under Calculation, select either **On** or **Off**.

2. Is the **Show Scheduling Messages** option turned off?

   If the **Show Scheduling Messages** option is turned off, changes to the project file that result in scheduling conflicts are processed. If the **Show Scheduling Messages** option is turned on, you can see the conflict and correct it. 

   To turn the **Show Scheduling Messages** option on or off, follow these steps:

   1. On the **File** tab, select **Options**.
   1. Select the **Schedule** tab.
   1. Clear the **Show Scheduling Messages** check box.
   1. Select the **Advanced** tab.
   1. Under **Planning Wizard**, select all check boxes.

   > [!NOTE]
   > After scheduling messages are turned on, press **F9** on the keyboard. Any scheduling messages that occur must be resolved before the project will be calculated correctly.

3. Are you scheduling from the project's **Start Date** or the project's **Finish Date**?

   When you schedule from the project's **Start Date**, the tasks begin as soon as possible. 
   
   When you schedule from the project's **Finish Date**, the tasks begin as late as possible. 
   
   To check which date is set in your file, select **Project Information** on the **Project** tab.

4. What is the project's Start Date?

   If the Show Scheduling Messages option is turned on, and you enter a task that occurs before the project's Start Date, you receive a warning message. If you want to schedule a task to start before the project's Start Date, manually enter the date for the task. To check the Project Start Date, select **Project Information** on the **Project** tab.

5. Did you enter a percent complete on a task?

   If you entered a percent complete on a task, and the task has already started, you can't change the Start Date automatically. To determine where the task would schedule automatically, set the task to zero percent complete. To do this, follow these steps:

   1. Select the task.
   1. On the **Task** tab, select **Task Information**.
   1. Select the **General** tab.
   1. In the **Percent Complete** box, type **0**.
   1. Select **OK**.

6. Did you assign an Actual Start Date to the task?

   You can assign an Actual Start Date to a task and not enter a percent complete. The task isn't scheduled automatically unless you set the Actual Start Date to NA. 
   
   To set the Actual Start Date, insert the Actual Start Field into your table by following these steps:

    1. Select the title of any column currently in your table.
    1. On the **Format** tab, select **Insert Column**.
    1. Select **Actual Start** for the Field Name and select **OK**.

7. Did you assign a constraint type other than **As Soon As Possible (ASAP)** to the task?

   A constraint can cause a task to be scheduled according to the type of constraint and the date set. In Microsoft Project, a task that has the constraint of **As Late As Possible (ALAP)**  in a project  is scheduled from the project's Finish Date. 
   
   To check the constraint type, follow these steps:

   1. Double-click the ID number for the task.
   1. Select the **Advanced** tab.

8. Are there any predecessor or successor relationships?

   The type of relationship determines when the task can be scheduled. In Microsoft Project, the **Task will always honor their constraint dates** setting overrides the task relationship links. 
   
   To set this option, follow these steps:

    1. On the **File** tab, select **Options**.
    1. Select the **Schedule** tab.
    1. Select the check box **Tasks will always honor their contraint dates**.
    1. Select **OK**.

9. Are you using automatic **Resource Leveling**?

   Automatic resource leveling adds delay to a task to avoid resource conflicts. This delay results in the task Start Date being pushed out. If you select the manual option, delay isn't added to tasks automatically. 
   
   To remove any delay added to a task and to set resource leveling to manual, follow these steps:

    * To remove delay, select **Clear Leveling** on the **Resource** tab.
    
    * To set resource leveling to manual, select **Leveling Options** on the **Resource** tab, and then select **Manual**.

10. Is there a value in the **Task Delay** field?

    If the **Task Delay** field contains a value greater than zero, you can't schedule the task earlier. To clear the **Delay** field, see step 9.

11. Is the task a subtask?

    If a Summary task (at any level) has a predecessor or a constraint, the subtask can't be scheduled any earlier than the summary task. 
    
    To check a summary task for predecessors or constraints, follow these steps:

    1. Select the task.
    1. On the **Task** tab, select **Task Information**.
12. Is there a resource assigned to the task?

    The resource calendar can affect the scheduling of a resource-driven task but not a fixed duration task. In Microsoft Project, the resource calendar can affect all three task types (fixed duration, fixed work, and fixed units). Remove the resource to see if, in fact, the resource is affecting the scheduling. After the resource is removed, if the task schedules as expected, then check the resource's calendar. 
    
    To check the Resource calendar, on the Project tab, select **Change Working Time**, and then select the resource name from the drop-down list.

13. Are you trying to schedule a task during a non-working time?

    If a day is marked as non-working, then you can't schedule a task to start on that day. To check the Project Calendar, select **Change Working Time** on the **Project** tab.

14. Are there any predecessor or successor relationships assigned to summary tasks?

    **Predecessor** and **Successor** relationships assigned to summary task can affect sub task of the summary task in addition to the summary task(s) that are linked.

    The type of relationship will determine when the task can be scheduled. In Microsoft Project, the **Tasks will always honor their constraint dates** setting overrides the task relationship links. Earlier versions of Microsoft Project don't have this option. 
    
    To set this option, follow these steps:

    1. On the **File** tab, select **Options**.
    1. Select the **Schedule** tab.
    1. Select the check box **Task will always honor their constraint dates**.
    1. Select **OK**.

### Project 2007

To determine the exact cause in Project 2007 and earlier versions, review the following questions:

> [!NOTE]
> Before testing any of the scenarios in this article, make a backup copy of the file or save any changes you might have made to the file.

1. Is the Calculation option set to **Manual**?

   When you specify a manual calculation, Microsoft Project will calculate your file only when you press **F9**. Set Calculation to **Automatic** to resolve scheduling conflicts. 
   
   To set the calculation method, follow these steps:
   1. On the **Tools** menu, select **Options**.   
   2. Select the **Calculation** tab.   
   3. Under **Calculation**, select either **Automatic** or **Manual**.   
   
2. Is the **Show Scheduling Messages** option turned off?

   If the **Show Scheduling Messages** option is turned off, changes to the project file that result in scheduling conflicts will be processed. If the Show Scheduling Messages option is turned on, you can see the conflict and correct it. 
   
   To turn the Show Scheduling Messages option on or off, follow these steps:
   1. On the **Tools** menu, select **Options**.   
   2. Select the **Schedule** tab.   
   3. Select to select or clear the **Show Scheduling Messages** check box.   
   4. Select the **General** tab.   
   5. Under **Planning Wizard**, select all check boxes.   

    > [!NOTE]
    > After scheduling messages are turned on, press **F9** on the keyboard. Any scheduling messages that occur must be resolved before the project will be calculated correctly.   
3. Are you scheduling from the project's Start Date or the project's Finish Date?

   When scheduling from the project's Start Date, the tasks begin as soon as possible. When scheduling from the project's Finish Date, the tasks will begin as late as possible. To check which date is set in your file, select **Project Information** on the **Project** menu.   
4. What is the project's Start Date?

   If the Show Scheduling Messages option is turned on, and you enter a task that occurs before the project's Start Date, you receive a warning message. If you want to schedule a task to start before the project's Start Date, manually enter the date for the task. To check the Project Start Date, select **Project Information** on the **Project** menu.

5. Did you enter a percent complete on a task?

   If you entered a percent complete on a task, and the task has already started, you can't change the Start Date automatically. To determine where the task would schedule automatically, set the task to zero percent complete. To do so, follow these steps:
   1. Select the task.   
   2. On the **Project** menu, select **Task Information**.   
   3. Select the **General** tab.   
   4. In the **Percent Complete** box, type **0**.   
   5. Select OK.   
   
6. Did you assign an Actual Start Date to the task?

   You can assign an Actual Start Date to a task and not enter a percent complete. The task isn't scheduled automatically unless you set the Actual Start Date to **NA**. To set the Actual Start Date, insert the actual start field into your table. To do so, follow these steps:
   1. Select the title of any column currently in your table.   
   2. On the **Insert** menu, select **Insert Column**.   
   3. Select **Actual Start** for the **Field Name** and select **OK**.   
   
7. Did you assign a constraint type other than **As Soon As Possible (ASAP)** to the task?

   A constraint can cause a task to be scheduled according to the type of constraint and the date set. In Microsoft Project, a task that has the constraint of **As Late As Possible (ALAP)** will be scheduled as an ASAP task in a project that is scheduled from the project's Finish Date. 
   
   To check the constraint type, follow these steps:
    1. Double-click the ID number for the task.   
    2. Select the **Advanced** tab.   
   
8. Are there any predecessor or successor relationships?

   The type of relationship determines when the task can be scheduled. In Microsoft Project, the **Tasks will always honor their constraint dates** setting overrides the task relationship links. 
   
   To set this option, follow these steps:
    1. On the **Tools** menu, select **Options**.   
    2. Select the **Schedule** tab.   
    3. Select to select the check box **Tasks will always honor their constraint dates**.   
    4. Select **OK**.    
9. Are you using automatic Resource Leveling?

   Automatic resource leveling adds delay to a task to avoid resource conflicts. This delay results in the task Start Date being pushed out. If you select the **Manual** option, delay isn't added to tasks automatically. To remove any delay added to a task and to set resource leveling to manual, follow these steps:
    - To remove delay, select **Clear Leveling**.   
    - To set resource leveling to manual, select **Resource Leveling** on the **Tools** menu, and then select **Manual**.   
10. Is there a value in the Task Delay field?

    If the Task Delay field contains a value greater than zero, you can't schedule the task earlier. To clear the Delay field, see step 9.
11. Is the task a subtask?

    If a Summary Task (at any level) has a predecessor or a constraint, the subtask can't be scheduled any earlier than the summary task. To check a summary task for predecessors or constraints, follow these steps:
    1. Select the task.   
    2. On the **Project** menu, select **Task Information**.   
   
12. Is there a resource assigned to the task?

    The resource calendar can affect the scheduling of a resource-driven task but not a fixed duration task. In Microsoft Project, the resource calendar can affect all three task types (fixed duration, fixed work, and fixed units). Remove the resource to see if, in fact the resource is affecting the scheduling. After the resource is removed, if the task schedules as expected, then check the resource's calendar. To check the resource calendar, follow these steps:

    On the **Tools** menu, select **Change Working Time**, and then select the resource name from the drop-down list.   
13. Are you trying to schedule a task during a non-working time?

    If a day is marked as non-working, then you can't schedule a task to start on that day. To check the Project Calendar, select **Change Working Time** on the **Tools** menu.

14. Are there any predecessor or successor relationships assigned to summary tasks?

    **Predecessor** and **Successor** relationships assigned to summary tasks can affect sub tasks of the summary task in addition to the summary task(s) that are linked.

    The type of relationship determines when the task can be scheduled. In Microsoft Project, the **Tasks will always honor their constraint dates** setting overrides the task relationship links. Earlier versions of Microsoft Project don't have this option. To set this option, follow these steps:
    
    1. On the **Tools** menu, select **Options**.   
    2. Select the **Scheduling** tab.   
    3. Select to select the **Tasks will always honor their constraint dates** check box.   
    4. Select **OK**.   

If you perform all these tests but still have a scheduling issue, try to create a new task, or try to delete the problem task, and then re-create it.
