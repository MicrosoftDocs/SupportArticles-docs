---
title: Reverse assemblies in Bill of Materials
description: Discusses the reversal of assembly transactions in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley, v-mialm 
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Manufacturing Series
---
# How to reverse assemblies in Bill of Materials in Microsoft Dynamics GP and in Microsoft Great Plains

This article describes how to reverse assembly transactions in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 903696

## Introduction

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

In Microsoft Dynamics GP and in Microsoft Great Plains, you might unintentionally create many extra assemblies. When you have many extra assemblies, you might have too many subassembly items and too few individual component items. So you may want to reverse assembly transactions to return items from an assembly to the corresponding subassembly or to the individual components.

## More information

When you post an assembly transaction, that transaction increases the on-hand quantity of the particular finished goods or of the subassembly. Additionally, the transaction decreases the on-hand quantity of each assembly component by a corresponding amount, depending on the standard quantity that is required to assemble one unit of the finished good or of the subassembly. In this situation, the inventory account that corresponds to the finished goods, to the subassembly, and to the assembly components is correspondingly credited or debited.

To manually reverse assemblies in Microsoft Dynamics GP and in Microsoft Great Plains, you must make manual inventory adjustment entries. The manual inventory adjustment entries must decrease the goods units or the subassembly units. The manual inventory adjustment entries must correspondingly increase the assembly component units of the goods units and of the subassembly units. These inventory adjustment entries must credit and debit inventory accounts only. To do it, make the adjustment entries by using the **Item Transaction Entry** dialog box. To open this dialog box, point to **Inventory** on the **Transactions** menu, and then select **Transaction Entry**.

> [!NOTE]
> If you use only one inventory account in the general ledger to account for all item activity, you don't have to post the inventory adjustment entries to the general ledger. (Item activity includes purchases, sales, and assemblies.) However, if you use multiple inventory accounts in the general ledger, you must post the inventory adjustment debit and credit entries to the correct inventory accounts.

To determine the exact unit cost that was removed from inventory for each component that was used in an assembly, use the **Reprint Inventory Journals** dialog box to obtain the Assembly Posting Journal. To open this dialog box, point to **Inventory** on the **Reports** menu, and then select **Posting Journals**. In the Assembly Posting Journal, you can also obtain the cost for each assembled finished goods item that was debited to inventory for each assembly posting that you want to reverse.

### Stock methods

Microsoft Dynamics GP and Microsoft Great Plains use bill of materials (BOM) stock methods for subassemblies and assembly transactions only. The stock method that you select for the finished goods in a bill of materials doesn't affect sales order processing.

The overall unit cost of a finished goods item depends on the stock method that you use to determine the value of each component from which the finished goods item is assembled. In Microsoft Dynamics GP and in Microsoft Great Plains, the following valuation methods are available:

- **FIFO/LIFO Periodic**: In this method, the actual costs go in, and the standard costs go out when you generate sales or create assemblies. The standard cost is added to the unit cost of the finished goods item.
- **FIFO/LIFO Perpetual**: In this method, the actual costs go in, and the actual costs go out when you generate sales or create assemblies. The actual cost is added to the unit cost of the finished goods item.
- **Average Perpetual**: In this method, the actual costs go in, and the average costs go out when you generate sales or create assemblies. The average cost is added to the unit cost of the finished goods item.

### Bill of Materials Maintenance window

The Bill of Materials Maintenance window contains fields for the following stock methods:

- **Build If Necessary**  
- **Stock**  
- **Build**

#### Build If Necessary

The **Stock Method** topic in Microsoft Dynamics GP and Microsoft Great Plains Help describes the **Build If Necessary** field as follows:

> "If marked, items will be allocated from the available quantities in inventory. Additional units are built if the quantity for the item reaches zero."

The **Assemble Quantity** value that appears in the **Assembly Entry** dialog box is equal to the quantity that Microsoft Dynamics GP and Microsoft Great Plains require to finish the assembly if the following conditions are true:

- The stock method of any subassembly is set to **Build If Necessary**.
- Microsoft Dynamics GP and Microsoft Great Plains experience a shortage of the subassembly during the build operation for the finished goods item. This build operation is known as the assembly transaction.

> [!NOTE]
> To view the **Assemble Quantity** value, point to **Inventory** on the **Transactions** menu, and then select **Assembly Entry**.

So the assembly of the required subassemblies occurs at the same time as the assembly of the finished goods. In this situation, components are immediately taken from inventory. When you use this stock method, all available subassembly units are considered for the finished goods transaction.

#### Stock

The **Stock Method** topic in Microsoft Dynamics GP and Microsoft Great Plains Help describes the **Stock** field as follows:

> "Always use the quantity from inventory. On the transaction, only the Stock Quantity is updated, and is the extended standard quantity."

If the stock method for any subassembly is set to **Stock**, Microsoft Dynamics GP and Microsoft Great Plains prompt you to override a subassembly shortage. The program prompts you to override the subassembly shortage if the subassembly shortage occurs during the build operation for the finished goods item. This build operation is known as the assembly transaction. Which prompt appears in the **Assembly Entry** dialog box.

If you override the subassembly unit shortage, and if you post the finished goods assembly, the on-hand quantity for the finished goods appears as a negative value. This behavior only occurs if you don't use serial numbers or lot tracking for the finished goods. If you later post the batch of subassembly transactions to replenish the stock, a cost variance may occur. The cost variance depends on the valuation methods, on the costs of the assembly components, and on the cost of the subassembly item.

If you decide not to override the subassembly unit shortage, Microsoft Dynamics GP and Microsoft Great Plains print an exception report. Additionally, you can't post the finished goods transaction until the following conditions are true:

- The subassembly batch is posted.
- The on-hand quantity for each required subassembly unit is replenished.

When you use this stock method, the building or the assembly of unavailable subassemblies doesn't occur at the same time as the assembly of the finished goods item. In this situation, you must have available subassembly units to complete the finished goods transaction.

> [!NOTE]
> You can still make Microsoft Dynamics GP and Microsoft Great Plains override subassembly shortages in this situation.

#### Build

The **Stock Method** topic in Microsoft Dynamics GP and Microsoft Great Plains Help describes the **Build** field as follows:

> "Always build the quantity needed. These items are rarely stocked in inventory. On the assembly transaction, the Assemble Quantity is the extended standard quantity."

If the stock method of any subassembly is set to **Build**, Microsoft Dynamics GP and Microsoft Great Plains don't require a subassembly shortage to trigger the automatic building of subassembly components for the finished goods assembly transaction. In this situation, the **Assemble Quantity** box in the **Assembly Entry** dialog box has a value that is equal to the quantity that Microsoft Dynamics GP and Microsoft Great Plains require to complete the corresponding part of the finished goods item.

So the assembly of required subassemblies occurs at the same time as the assembly of the finished goods when you use this stock method. The assembly components are taken directly from inventory. The available subassembly units aren't considered for finished goods transactions.

### Stock methods and layers

When you use the **Build** stock method or the **Build If Necessary** stock method, receipt layers for subassemblies that were created at the same time as finished goods or as main assembly transactions automatically have a corresponding **QTYSOLD** value. The **QTYSOLD** value is equal to the **QTYRECVD** value. This transaction closes that receipt layer for sales allocations and for future assemblies because the receipt layer has been used for the posted finished goods. When you use the **Stock** stock method, Microsoft Dynamics GP and Microsoft Great Plains only create extra IV10200 layers after the subassembly batch is posted or after the individual subassembly transactions are posted.

## References

For more information about the fields in the **Bill of Materials Maintenance** dialog box, see the Microsoft Dynamics GP or Microsoft Great Plains Help. To view the information, follow these steps:

1. On the **Help** menu, select **Contents**.
2. Select the **Contents** tab, expand **Bill of Materials**, expand **Bill of Materials windows**, and then select **Bill of Materials Maintenance window**.
3. In the right pane, select **Fields**, and then view the items that appear under **Stock Method**.
