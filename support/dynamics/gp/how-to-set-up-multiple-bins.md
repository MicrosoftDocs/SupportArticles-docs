---
title: How to set up Multiple Bins in Dynamics GP
description: Contains information on how to set up Multiple Bins in Microsoft Dynamics GP when the Inventory Control module is registered.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Manufacturing Series
---
# How to set up Multiple Bins in Microsoft Dynamics GP

This article describes the steps to set up Multiple Bins in Microsoft Dynamics GP when the Inventory Control module is registered.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945961

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

If you want inventory quantities to use a bin other than the system-generated AUTOCREATE bin, you must assign a default bin.

## Determine the default bin option that you want to use

To do this, follow one of these options:

- Option 1: Assign a default bin

    1. On the **Cards** menu, point to **Inventory**, and then click **Bin/Sites**. Verify that the appropriate bins have been created in the Site Bin Maintenance window.
    2. On the **Cards** menu, point to **Inventory**, and then click **Quantities/Sites**.
    3. In the **Item Number** list, click an item number.
    4. In the **Sites** area, click **Site ID**, and then in the **Sites** list, click a site.
    5. In the **Bin** field, type a bin to be used as the default bin for this site.
    6. Click **Save**.

        > [!NOTE]
        > The item quantities for each site are stored in the Item Quantity Master table (IV00102).

- Option 2: Use the system-generated AUTOCREATE bin

## Enable Multiple Bins

1. Follow one of these steps:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Inventory**, and then click **Inventory Control**.

    - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Setup**, point to **Inventory**, and then click **Inventory Control**.

2. Click to select the **Enable Multiple Bins** check box, and then click **OK**. Click **OK** when you receive the following message:

    > You should follow the steps provided in the inventory setup checklist after enabling multiple bins. This will include enabling inventory and checking links.

3. Perform the Check Links procedure. To do this, follow these steps:

    1. Follow one of these steps:

        - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        - In Microsoft Dynamics GP 9.0, on the **File** menu, point to **Maintenance**, and then click **Check Links**.

    2. In the **Series** list, click **Inventory**.

    3. Click **All**, and then click **OK**.

    4. When you are prompted to print a report, select a destination, and then click **OK**.

4. Perform the Reconcile Inventory Quantities procedure. To this, follow these steps.

    1. Follow one of these steps:
        - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Inventory**, and then click **Reconcile**.

        - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Utilities**, point to **Inventory**, and then click **Reconcile**.
    2. Click **Process**.
    3. When you are prompted to print a report, select a destination, and then click **OK**.

    > [!NOTE]
    > If you entered a default bin for items and sites in Option 1, the quantities will transfer the bin specified in Option 1.

## Transfer quantities between bins for the same site

Use the Bin Transfer Entry window to transfer quantities between bins within the same site. To open the Bin Transfer Entry window, on the **Transactions** menu, point to **Inventory**, and then click **Bin Transfers**.

> [!NOTE]
> To open the Bin Transfer Entry window, you must first exit Microsoft Dynamics GP, and then start Microsoft Dynamics GP.

## Transfer quantities between bins for different sites

Use the Inventory Transfer Entry window to transfer quantities between bins at different sites. To open the Inventory Transfer Entry window, on the **Transactions** menu, point to **Inventory**, and then click **Transfer Entry**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
