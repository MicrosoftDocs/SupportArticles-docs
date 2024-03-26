---
title: Tax computations in Payables Management
description: Describes how taxes are computed in Payables Management in Microsoft Dynamics GP  based on the tax schedule IDs and the shipping method.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Tax computations in Payables Management in Microsoft Dynamics GP

This article describes tax computations in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863206

## Introduction

This article describes how taxes are computed in Payables Management based on the tax schedule IDs and on the shipping method in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

## More Information

The purchase tax schedule is located in the following locations:

- The Company Setup window

    To access the **Company Setup**  window in Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Company**.

    To access the **Company Setup** window in Microsoft Business Solutions-Great Plains 8.0 and in Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Company**, and then select **Company**.

- The Payables Setup Options window

    To access the **Payables Setup Options**  window in Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then select **Payables**. Then, select **Options**.

    To access the **Payables Setup Options** window in Microsoft Business Solutions-Great Plains 8.0 and in Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Purchasing**, and then select **Payables**. Then, select **Options**.

- The Vendor Maintenance window

    To access the **Vendor Maintenance** window, point to **Purchasing** on the **Cards** menu, and then select **Vendor**.

The shipping method first determines the tax schedule ID that will be used to calculate the tax. If the shipping method that is assigned to the transaction is a **Delivery** type, the purchase tax schedule in the **Company Setup** window will be compared to the tax schedule that is assigned to the purchase tax schedule ID in the **Payables Setup Options** window.

If the shipping method that is assigned to the transaction is a **Pickup** type, the purchase tax schedule that is assigned to the vendor's tax schedule address ID will be compared to the tax schedule that is assigned to the purchase tax schedule ID in the **Payables Setup Options** window. The vendor's tax schedule address ID is located in the **Vendor Maintenance** window.

Consider the following example. The following example is tax schedule A for the **Payables Setup** window:

- Detail A
- Detail B
- Detail C

The following example is tax schedule B for the **Company Setup** window:

- Detail A
- Detail D

The following example is tax schedule C for the **Vendor Maintenance** window:

- Detail B
- Detail C

For the Delivery shipping method, Microsoft Dynamics GP looks in the **Company Setup** window and in the **Payables Setup** window. Based on the example, only Detail A will be computed for tax because Detail A is the only common tax detail in both tax schedules.

For the Pickup shipping method, Microsoft Dynamics GP will look in the **Vendor Maintenance** window and in the **Payables Setup** window. Based on the example, Detail B and Detail C will be computed for tax because Detail B and Detail C are the common tax details in both tax schedules.

> [!NOTE]
>
> - The example will only work if you have the **Use Shipping Method when Selecting Default Tax Schedule** check box selected in the **Company Setup Options** window.
> - If the **Use Shipping Method when Selecting Default Tax Schedule** check box isn't selected, Microsoft Dynamics GP will compare only the tax schedules in the **Vendor Maintenance** window and in the **Payables Setup** window. It does it to find the similar tax details that will be used to compute taxes.
