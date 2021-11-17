---
title: You do not have security privileges
description: Provides a solution to an error that occurs when you try to view a SmartList object in Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "You do not have security privileges to view all of the tables used in this SmartList" Error message when you try to view a SmartList object in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to view a SmartList object in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 967731

## Symptoms

When you try to view a SmartList object in Microsoft Dynamics GP or Microsoft Dynamics GP 2010, you receive the error message:
> You do not have security privileges to view all of the tables used in this SmartList.

## Cause

This problem occurs if one or more of the following conditions are true:

- You don't have the security privileges that are required to access the table that is used by the SmartList item.
- You created a SmartList Builder object by using an SQL table.
- You are running Microsoft Dynamics GP 10.0, and you are using Data Connections.

## Resolution

To resolve this problem, verify the following based on the version of Microsoft Dynamics GP that you are using:

- Verify that the user has the security privileges that are required to view the SQL tables in a SmartList.
- Verify that the user has access to the table that is used for the object.

### Microsoft Dynamics GP 10.0/ Microsoft Dynamics GP 2010

Create a new security task. To do it, follow these steps:

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Security Tasks**.
2. In the **Security Task Setup** window, in the **Task ID** box, type a task identifier (ID).
3. In the **Task Name** box, type a task name.
4. In the **Task Description** box, type a description.
5. In the **Category** list, select **System**.
6. In the **Product** list, select **SmartList Builder**.
7. In the **Type** list, select **SmartList Builder Permissions**.
8. In the **Series** list, select **SmartList Builder**. The Access List area displays the various permissions for SmartList Builder.
9. Select the check box next to **View SmartLists with SQL Tables**.
10. Select **Save**.
11. Close the Security Task Setup window.

#### SmartList Builder Security

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **SmartList Builder**, point to **Security**, and then select **SQL Table Security**.
2. On the left side, select the check box next to the database name for which you're receiving the error.
3. On the right side, select the check box next to the table/view name that is used by the SmartList Item.

    > [!NOTE]
    > You can also select **Mark All** to mark all the tables in the company database.

### Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **SmartList Builder**, point to **Security**, and then select **User Security**.
2. In the **SmartList User Security** window, select **User Security**.
3. In the **User ID** list, select the user who is receiving the error message that is mentioned in the "Symptoms" section.

4. In the **Roles** area, select the check box next to the **View SmartLists with SQL Tables** option.

5. If you're using user classes, select **User Class Security**, and then repeat step 4.
6. Select **OK** to save the changes.

#### SmartList Builder security

1. On the **Tools** menu, point to **SmartList Builder**, point to **Security**, and then select **SQL Table Security**.
2. On the left side, select the check box next to the database name for which you're receiving the error.
3. On the right side, select the check box next to the table/view name that is used by the SmartList item.

    > [!NOTE]
    > You can also select **Mark All** to mark all the tables in the company database.
4. Repeat step 2 and 3 for views if you've a view used in the SmartList Builder object.
