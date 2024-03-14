---
title: The calculation of inventory item costs
description: Describes the calculation of inventory item costs in Inventory in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, Adonat
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# Information about the calculation of inventory item costs and the maintenance of these costs in Inventory in Microsoft Dynamics GP

This article describes the calculation of inventory item costs in Inventory in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939912

## Introduction

This article describes the maintenance of these costs. Additionally, this article describes how these processes affect inventory valuation.

## More information

In Microsoft Dynamics GP 9.0 and in later versions of Microsoft Dynamics GP, there are several costing enhancements in Inventory. These costing enhancements provide additional information. And, these costing enhancements capture additional information. In addition, these enhancements improve the ability to maintain accurate costs when you increase inventory or when you decrease inventory. The enhancements also add business logic that automatically determines when there's a cost variance in inventory. This process occurs at the time of posting. This same business logic handles any variance currency amounts that are based on the individual item setup, or that are based on the inventory posting setup.

In the general ledger, cost adjustments are automatically created for the correct accounts. The cost adjustments are also summarized for the correct accounts. Although some of this logic existed in versions earlier than Microsoft Dynamics GP 9.0, the automatic posting of these cost adjustments to General Ledger in Microsoft Dynamics GP is a significant change. In versions that are earlier than Microsoft Dynamics GP 9.0, the cost variance adjustments must be manually created and manually posted to the general ledger. In Microsoft Dynamics GP 9.0 and in later versions of Microsoft Dynamics GP, you don't have to make manual adjustments in the Cost Variance report.

Extra program enhancements determine the types of transactions that can create a cost variance. These enhancements create a potential for general ledger transactions to affect the inventory account balance. But, the end user isn't alerted to the presence of these transactions. However, the transactions are printed in the Purchase Receipts Update Detail report.

For more information about the enhancements, visit one of the following Microsoft Web sites, depending on whether you're a partner or a customer.

- [Partners](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem)
- [Customers](https://mbs2.microsoft.com/fileexchange/?fileID=b40ef1a3-f734-4035-94ca-2c0d424ae865)
