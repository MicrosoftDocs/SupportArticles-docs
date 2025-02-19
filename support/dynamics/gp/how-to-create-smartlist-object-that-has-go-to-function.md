---
title: How to use SmartList Builder to create SmartList object
description: Describes how to create a SmartList object that has a Go To function for the Sales Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to use SmartList Builder to create a SmartList object that has a "Go To" function for the Sales Transaction Entry window

This article describes how to use SmartList Builder to create a SmartList object that has a Go To function for the Sales Transaction Entry window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 914894

Although this article describes how to create a Go To function that uses the Sales Transaction Work table, you can use other Work tables and Open tables.

To create a SmartList object that has a Go To function for the Sales Transaction Entry window, follow these steps:

1. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0 and later, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **SmartList Builder**, and then select **SmartList Builder**.
   - In Microsoft Dynamics GP 9.0, point to **SmartList Builder** on the **Tools** menu, and then select **SmartList Builder**.

2. In the **SmartList ID** box, type an ID for the new object.
3. In the **SmartList Name** box, type the name that you want to use for the object.

    > [!NOTE]
    > This name is the name that you will see in SmartList. The name that you type automatically populates the **Item Name** box.

4. Select the plus sign next to the **Tables** area, and then select the appropriate item:

   - In Microsoft Dynamics GP, select **Microsoft Dynamics GP Table**.
   - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains Table**.

5. In the Add Table window, follow these steps:
   1. In the **Product** list, select the appropriate item:
      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**.
      - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains**.
   2. In the **Series** list, select **Sales**.
   3. In the **Table** list, select **Sales Transaction Work**, and then select **Save**.

6. On the **SmartList Builder** menu, select **Go To**, select the plus sign, and then select **Open Form**.
7. In the Add Go To - Open Form form, follow these steps:
   1. In the **Description** box, type a description.
   2. In the **Product** list, select the appropriate item:
      - In Microsoft Dynamics GP, select **Microsoft Dynamics GP**.
      - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains**.
   3. In the **Series** list, select **Sales**.
   4. In the **Form** list, select **Sales Transaction Entry**.

8. Select the plus sign to open the Add Task window, and then follow these steps:
   1. In the Task Type list, select **Set a field value and run the field script**.
   2. In the Field list, select **SOP Type**.
   3. In the Table list, select **Sales Transaction Work**.
   4. In the Value list, select **SOP Type**, and then select **Save**.

9. Select the plus sign to open the Add Task window, and then follow these steps:
   1. In the **Task Type** list, select **Set the value of a field**.
   2. In the **Field** list, select **(L) Temp Type**.
   3. In the **Table** list, select **Sales Transaction Work**.
   4. In the **Value** list, select **SOP Type**, and then select **Save**.

10. Select the plus sign to open the Add Task window, and then follow these steps:
    1. In the **Task Type** list, select **Set a field value and run the field script**.
    2. In the **Field** list, select **(L) Temp Control Number**.
    3. In the **Table** list, select **Sales Transaction Work**.
    4. In the **Value** list, select **SOP Number**, select **Save**, and then select **Save**  again.

    > [!NOTE]
    > By using the local temporary fields, you are using the fields that Dexterity uses. Therefore, the process will still work if an existing document is displayed. The program will prompt you to save any changes if the existing document was altered.

11. In the **Default Go To** list, select the new Go To function that you created in step 7 and in step 8, and then select **OK**.
12. In the **Default** column of the SmartList Builder window, select the fields that you want to display in the new SmartList object.

    For example, select **SOP Type**, **SOP Number**, and **Order Date**.

13. Select **Save**, and then close the SmartList Builder window.
14. On the **View** menu, select **SmartList**.
15. When you are prompted to make changes in SmartList, select **Yes**.
16. Grant security to the new SmartList object so that you can see the new SmartList object. To do this, follow the appropriate steps.

    In Microsoft Dynamics GP 10.0 and later

    1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Security Tasks**.
    2. In the **Task ID** list, select the appropriate task ID.
    3. In the **Product** list, select **SmartList**.
    4. In the **Type** list, select **SmartList Object**.
    5. In the **Series** list, select **SmartList Object**.
    6. Select the check box for the SmartList object that you created, and then select **Save**.
    7. Exit and then restart SmartList.

    In Microsoft Dynamics GP 9.0

    1. On the **Tools** menu, select **Setup**, select **System**, and then select **SmartList Security**.
    2. In the **Company** list, select the company.
    3. In the **User ID** list, select the user.
    4. In the **SmartList Objects** area, select the check box for the new SmartList object, and then select **OK**.
    5. Exit and then restart SmartList.

    > [!NOTE]
    > If you are using Microsoft Business Solutions - Great Plains 8.0, skip this step.

17. Select the name of the new SmartList object that you created.
18. Double-click a record that is returned in the results.

The Sales Transaction Entry window opens, and data is passed to the window. If you open the new SmartList object in SmartList, and you can see the number **6** under **SOP Type**, follow these steps:

1. Select **Tools**, point to **SmartList Builder**, and then select **SmartList Builder**.
2. In the **SmartList ID** box, type the ID for the new SmartList object.
3. In the **Display Name** column, select **SOP Type**.
4. Select the blue arrow to open the Set Field Options window.
5. Change the **0** to a **6**, and then type Fulfillment Order in the **Description** box.
6. Select **Save**, and then select **Save** again.
7. Open SmartList, and then select the new object.

   **Fulfillment Order** is now displayed instead of **6**.
