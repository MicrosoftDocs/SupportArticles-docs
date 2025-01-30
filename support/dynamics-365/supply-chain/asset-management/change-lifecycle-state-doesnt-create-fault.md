---
title: No Fault Cause or Fault Remedy Error When Changing Work Order Lifecycle State
description: Provides fault registration steps to ensure you receive the expected error when changing a work order lifecycle state in Microsoft Dynamics 365 Supply Chain Management.
author: sorenbacker2
ms.author: sorenba
ms.reviewer: kamaybac
ms.date: 01/30/2025
ms.custom: sap:Asset management\Issues with asset management
---
# Changing work order lifecycle state doesn't generate fault cause or fault remedy error

This article provides the setup steps to ensure that the expected fault cause or fault remedy error is generated when you change a work order lifecycle state in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms  

When you change a [work order lifecycle state](/dynamics365/supply-chain/asset-management/setup-for-work-orders/work-order-lifecycle-states) that's set up to validate [fault causes](/dynamics365/supply-chain/asset-management/setup-for-work-orders/fault-management#create-fault-causes) and [fault remedies](/dynamics365/supply-chain/asset-management/setup-for-work-orders/fault-management#create-fault-remedies), the error you expect to be generated doesn't occur for a fault cause or fault remedy. This allows the lifecycle state change despite the validation setup.

## Cause

A likely cause for the expected error to not be generated is that the fault cause and fault remedy couldn't be validated because they don't have a [fault registration](#create-a-fault-registration).

## Resolution

To ensure the expected error is generated, take the following steps to set up lifecycle states and work order types, and create a fault registration.

### Set up lifecycle states and work order types

1. Set up the lifecycle state to enable the validation of fault causes and fault remedies:

   1. Go to **Asset Management module** > **Setup** > **Work orders** > **Lifecycle states**.
   1. Select the work order lifecycle state in question and then select **Edit**.
   1. Under the **Validate** FastTab, set up the message type to **Error**, and set the **Fault cause**, **Fault remedy** and other related options to **Yes**.

2. Set up the work order type to enable the validation of fault causes and fault remedies by making them mandatory for work orders:

   1. Go to **Asset Management module** > **Setup** > **Work orders** > **Work order types**.
   1. Select the work order type in question and then select **Edit**.
   1. Under the **General** FastTab, set the **Fault cause** and **Fault remedy** options and other related options to **Yes** in the **Mandatory** section.

### Create a fault registration

To make sure you receive the expected error message, follow these steps to create a fault registration:

1. Go to **Asset Management** > **Work order** > **All work orders**.

2. Select the work order in question. For simplicity, assume it's a new work order with the **Current lifecycle state** is **New**.

3. In the Action Pane, go to the **Asset** group and select **Asset fault**.

4. Expand the **Symptoms** FastTab and select **Add line**.

5. In the **Fault symptom** field, select the relevant symptom from the dropdown list. Select **Save** and then go back to the work order.

6. In the Action Pane, go to the **Lifecycle state** group and select **Update work order state**.

7. In the **Update work order state** window, select the **Lifecycle state** that has the validation setup (see [Set up lifecycle states and work order types](#set-up-lifecycle-states-and-work-order-types)). For simplicity, assume the **Lifecycle state** is **Released**. Then, select **OK**.

8. Select the **Action Centre/notification bell** in the upper-right corner, and then select **Message details**. The **Message details** shows "The fault cause for symptom X on asset Y is missing. Update has been cancelled." Close the **Message details** window. In the upper-right corner of the work order, the **Lifecycle state** is still shown as **New**.

9. In the Action Pane of the work order, go to the **Asset** group and select **Asset fault**.

10. Expand the **Causes for selected symptom** FastTab and select **Add line**.

11. In the **Fault cause** field, select the relevant cause from the dropdown list. Select **Save** and then go back to the work order.

12. In the Action Pane, go to the **Lifecycle state** group and select **Update work order state**.

13. In the **Update work order state** window, select the **Lifecycle state** that has the validation setup (see [Set up lifecycle states and work order types](#set-up-lifecycle-states-and-work-order-types)). For simplicity, assume the **Lifecycle state** is **Released**. Then, select **OK**.

14. Select the **Action Centre/notification bell** in the upper-right corner, and then select the new **Message details** (mentioned in step 8). The **Message details** shows "Fault remedy for cause Z on symptom X on asset Y is missing. Update has been cancelled." Close the **Message details** window. In the upper-right corner of the work order, the **Lifecycle state** is still shown as **New**.

15. In the Action Pane of the work order, go to the **Asset** group and select **Asset fault**.

16. Expand the **Remedies for selected symptom** FastTab and select **Add line**.

17. In the **Fault remedy** field, select the relevant remedy from the dropdown list. Select **Save** and then go back to the work order.

18. In the Action Pane, go to the **Lifecycle state** group and select **Update work order state**.

19. In the **Update work order state** window, select the **Lifecycle state** that has the validation setup (see [Set up lifecycle states and work order types](#set-up-lifecycle-states-and-work-order-types)). For simplicity, assume it's **Lifecycle state** is **Released**. Then, select **OK**.

20. Select the **Action Centre/notification bell** in the upper-right corner. The first two attempts to update the work order state result in error messages and no update of the **Lifecycle state**. In this third attempt, no error message is generated, and the **Lifecycle state** is correctly updated to **Released**.
