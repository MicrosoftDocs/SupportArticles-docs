---
title: How to use pointer routings in Manufacturing
description: Provides a detailed explanation of pointer routings and an example of how to use them.
ms.reviewer: ttorgers, aeckman
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use pointer routings in Manufacturing in Microsoft Dynamics GP

This article discusses how to use pointer routings in Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930347

## The purpose and the use of pointer routings

Pointer routings are an ideal tool if you have a series of routing sequences that are common to multiple finished-good items. To use pointer routings, you must use operation codes. An operation code defines the information that is common to a single routing sequence.

For example, in a bakery, the following are the common tasks that will become routing sequences:

- Bake
- Cool
- Package

The length of time for each task in the routing sequence may vary slightly. But you use similar labor codes and machine IDs regardless of the item that you produce.

You must define an operation code for each task. For example, the operation code for the Bake task includes an applicable description, a work center, and the machine ID information for the oven or the ovens that will be used. You can also supply estimates for the machine time and for the cycle time. When you supply these estimates, you do not have to enter data for the machine time and for the cycle time. Instead, you only have to edit the data.

After you define an operation code for each task, you create a pointer routing that groups the operation codes for the three tasks. You create the pointer routing so that you are prompted to add all three tasks as three routing sequences when you add the first task to an item's routing sequence.

## Pointer routing preferences

If you want to use pointer routings, you must enable pointer routings in the Routing Preference Defaults window. To do this, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **Routings**.
2. In the Routing Preference Defaults window, select the **Use Pointer Routings** check box.
3. Select **OK**.

## Operation codes

To create operation codes, follow these steps:

1. On the **Cards** menu, point to **Manufacturing**, point to **Routings**, and then select **Operations**. The Operations Setup window opens.
2. In the **Work Center ID** list, select the work center in which the sequence will occur.
3. In the **Operation Code** box, type an operation code. The **Operation Code** box represents an alphanumeric field that is used to uniquely identify this operation.
4. Type any additional information in the following fields:
   - **Setup Time**
   - **Setup Labor Code**
   - **Labor Time**
   - **Run Labor Code**
   - **Machine Time**
   - **Machine ID**
   - **Queue Time**
   - **Move Time**
   - **Cycle Time**

   Enter as much information as you can so that you will save time later when you create the individual routings.

5. Select **Insert** to insert the operation code into the list at the bottom of the window. This action enables the operation code for the work center that you selected.

## Define the pointer routings

To define pointer routings, create the header record and then add any sequences that you want. To do this, follow these steps:

1. Create the header record. To do this, follow these steps:

   1. On the **Cards** menu, point to **Manufacturing**, point to **Routings**, and then select **Ptr Rtg Creation**.
   2. In the Pointer Routing Creation window, type a pointer routing name in the **Pointer Rtg. Name** box.
   3. In the **Work Center ID** list, select a work center for the first task in the routing sequence.
   4. In the **WC Opcode** list, select an operation code for the first task in the routing sequence.
   5. Select **Save**.
2. Add the sequences. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Manufacturing**, point to **Routings**, and then select **Pointer Edit**. The Pointer Routing Edit window opens.
   2. In the **Pointer Rtg. Name** list, select the pointer routing that you created in step 1.
   3. In the **Work Center ID** list, select a work center for the second task in the routing sequence.
   4. In the **WC Opcode** list, select an operation code for the second task in the routing sequence.
   5. Select **Insert**.
   6. Repeat steps 3 through 5 for any additional tasks.

## Use the pointer routings to create new finished-good routings

1. On the **Cards** menu, point to **Manufacturing**, point to **Routings**, and then select **Routings Entry**.
2. In the Routing Sequence Entry window, enter a new routing sequence for the first task in the routing sequence. To do this, accept the default value in the **Sequence Number** field. Or, type a new value in the **Sequence Number** field. In the **Work Center ID** list, select a work center for the first task.
3. In the **Work Center Opcode** list, select the operation code for the first task in the routing sequence.

    > [!NOTE]
    > Make sure that you select the same work center and the same operation code that you selected when you created the pointer routing header record.
4. The Pointer Routing window opens behind the Routing Sequence Entry window. Move the Routing Sequence Entry window. Or, select **Windows**, and then select **Pointer Routing**.

5. In the Pointer Routing window, select the pointer routing that you want to use in the **Pointer Rtg Name** list. If you have to, change the information in the **Sequence Number** box and in the **Increment Sequence by** box to control the numbering of the sequences that will be added.

6. Select **OK**.
7. In the Routing Sequence Entry window, review the sequences that you added to the routing, and then make any adjustments that are required.
