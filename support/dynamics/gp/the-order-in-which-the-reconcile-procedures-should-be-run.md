---
title: The order in which the reconcile procedures should be run
description: Describes the order in which you should run the reconcile procedures in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley, krasmuss
ms.date: 03/13/2024
---
# Information about the order in which the reconcile procedures should be run in Microsoft Dynamics GP

This article describes the order in which we recommend that you run the reconcile procedures in Sales Order Processing, in Purchase Order Processing, and in Inventory Control in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864622

> [!NOTE]
The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.

## More information

- Step 1 - Reconcile Sales Order Processing

  On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Sales**, and then select **Reconcile - Remove Sales Documents**.

- Step 2 - Reconcile Purchase Order Processing

  On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Purchasing**, and then select **Reconcile Purchasing documents**.

- Step 3 - Reconcile Inventory

  On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Inventory**, and then select **Reconcile**.

- Step 4 - Reconcile Project Accounting

  > [!NOTE]
  > This step is required only if you are using Project Accounting.
On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Project**, and then select **PA Reconcile IV**.

- Step 5 - Reconcile Field Service

  > [!NOTE]
  > This step is required only if you are using any of the Field Service functionalities on a version that is earlier than Microsoft Dynamics GP 10.0 Service Pack 2. This step reconciles all the Field Service functionalities.

  On the **Microsoft Dynamics GP** menu, select **Tools**, select **Utilities**, select **Project**, select **Service Utilities**, and then select **Reconcile Quantities**.
