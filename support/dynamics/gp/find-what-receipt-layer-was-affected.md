---
title: Find what receipt layer was affected
description: Describes how to find what Receipt Layer was affected by the Cost Adjustment in Microsoft Dynamics GP.
ms.reviewer: theley, aganje
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# How to find what Receipt Layer was affected by the Cost Adjustment in Microsoft Dynamics GP

This article describes how to find what Receipt Layer was affected by the Cost Adjustment in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4094695

## Symptom

How to find what receipt layer was affected by the cost adjustment in Microsoft Dynamics GP?

Hopefully, you find this article useful for determining the receipt layers that were affected by a cost adjustment and how to update the exact layer that was affected if you didn't mean to or did it wrong.

The below information taken from [Blog](https://community.dynamics.com/blogs/post/?postid=8d612be9-be06-41c4-b72b-3fdbaf1831fa). (Refer to the blog article for screen prints.)

## Resolution

I would like to go over how to find what receipt layer was affected by your system generated Cost Adjustment. Some customers have wanted to know how to find this information, so they can go back and adjust the layer back to the original cost because of a mistake that was made. So, with this article I'll explain how to find the receipt layer that was affected and how to adjust the receipt layer back if you choose to do so.

Typically, a journal entry is created with a **GLTRX** prefixed batch and when you drill down on the Source Document you'll receive the following message:
> "Transaction history does not exist for this transaction."

It can make hard to determine what exact receipt layer this cost adjustment affected. In the Reference field, you'll find what document caused the cost adjustment but not the receiving layer affected. The following article goes through why these Cost Adjustments are created.

- [An unexpected GLTRX Batch appears in Financial Batch Entry in Microsoft Dynamics GP](https://support.microsoft.com/en-US/help/2448193)

> [!NOTE]
> You would have to have theHistorical Inventory Trial BalanceInstalled, running and recording information in theSEE30303table before you can use this method to identify the receipt layer that was affected by the cost adjustment.

- See [Why to use the Historical Inventory Trial Balance Report.](https://community.dynamics.com/blogs/post/?postid=0956a4c1-5f98-46ac-a819-5b1aea35d4f9) on how to do it. It also goes over why to use this report as well.

Additionally, you'll need access to SQL Server Management Studios with the ability to run select statements. (Read permissions)

Next, you'll want to note the Transaction Source (TRXSORCE) or Journal Entry (JRNENTRY) of the cost adjustment, so you can enter it in one of the following scripts that will pull the Item Number and what Receipt Number it was on. Also, if this layer has been depleted the document that consumed it will be in the DOCNUMBR column. You can choose what option you want to use. For example, the TRXSORCE is going to start with GLTRX ending in a number and you'll want to enter in place of the xxx on the first script.

```sql
SELECT DOCNUMBR, RCPTNMBR1, * FROM SEE30303 WHERE TRXSORCE = 'xxx'
```

or

```sql
SELECT DOCNUMBR, RCPTNMBR1, * FROM SEE30303 WHERE JRNENTRY = 'xxx'
```

You can get the Journal Entry Number or Transaction Source from **Financial >> Inquiry >> Financial >> Journal Entry Inquiry.**

When you run the script, look at the RCPTNMBR1 column for the receipt that brought the Inventory in.

Next, go to the Purchase Receipts Inquiry (**Inventory >> Inquiry >> Receipts**) to drill down in the Cost Adjustment using the Receipt Number and the Site ID (LOCNCODE field) found in the SEE30303.

Now, that you found the receipt layer and determined it was Invoiced incorrectly you can go to the Inventory Adjust Costs tool **(Inventory >> Utilities >> Adjust Costs)** and adjust it to your wished cost.

> [!NOTE]
> Adjusting the layer will affect any layer related such as transfers and Sales.

In this situation, I received one quantity at $1.00 and sold it at that cost (screen print in blog article). Then I invoiced receipt layer for $1.50 accidentally (should have been $1.00) which created the cost adjustment. I now then switch the $1.50 to $1.00 and then process it. GP then will output a posting journal like this below to show you the new cost for the Subledger and a new Journal Entry will be created for the GL as well

If you want to drill down on the Document Number that depleted the layer go to Item Transaction Inquiry. Or you can go to an Inquiry respective to what type of outflow it's such a Sales Inquiries.  
(The above information taken from [How to Find What Receipt Layer was Affected by the Cost Adjustment.](https://community.dynamics.com/blogs/post/?postid=8d612be9-be06-41c4-b72b-3fdbaf1831fa) and includes screen prints.)

## More information

For more information on GLTRX batches, see [An unexpected GLTRX Batch appears in Financial Batch Entry in Microsoft Dynamics GP](https://support.microsoft.com/help/2448193).
