---
title: The tax detail record doesn't exist
description: Provides a solution to an error that occurs when you try to post a transaction in Purchase Order Processing on Microsoft Dynamics GP 2010 SP 1 or Microsoft Dynamics GP 10.0 SP 5.
ms.reviewer: theley, beckyber
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# When you try to post a transaction in Purchase Order Processing on Microsoft Dynamics GP 2010 SP 1 or Microsoft Dynamics GP 10.0 SP 5, you receive an error message: ERROR: The tax detail record doesn't exist or is assigned to two accounts

This article provides a solution to an error that occurs when you try to post a transaction in Purchase Order Processing on Microsoft Dynamics GP 2010 SP 1 or Microsoft Dynamics GP 10.0 SP 5.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2481303

## Symptoms

When you try to post a shipment/invoice or invoice transaction in Purchase Order Processing in Microsoft Dynamics GP 2010 Service Pack 1 or Microsoft Dynamics GP 10.0 Service Pack 5, you receive the following error message:

> ERROR: The tax detail record doesn't exist or is assigned to two accounts.

## Cause

Beginning with Microsoft Dynamics GP 2010 Service Pack 1 and Microsoft Dynamics GP 10.0 Service Pack 5, an extra check was put in place before posting a transaction to ensure that shipment/invoice or invoice documents with multiple lines that have a single tax detail with different distribution accounts assigned to them couldn't be posted. It was done as an interim fix for another issue that requires extra changes that couldn't be made in the service pack timeline. If this check fails, the following error message will be presented, and the transaction won't post.

> **ERROR: The tax detail record doesn't exist or is assigned to two accounts.

Although Purchase Order Processing shipment/invoice and invoice transactions allow multiple accounts to be assigned to the same tax detail, the data model of the Payables Tax table, PM10500, doesn't allow for a document to have a single tax detail with multiple distribution accounts. Because of this restriction, on previous versions, users with the same configuration meeting the message now received in Microsoft Dynamics GP 2010 Service Pack 1 and Microsoft Dynamics GP 10.0 Service Pack 5 would have received the following error on their posting journals:

> ** Error: Posting to table PM10500. Restore from a backup if possible.

With this error message on previous versions, the transaction posting would have processed and would have appeared to complete. However, the Payables tax table (PM10500) would have been incomplete as it would only have had the first account line and the extra account lines for the document and tax detail combination wouldn't have existed.

## Resolution

This issue is scheduled to be addressed in Microsoft Dynamics GP 2010 Service Pack 2.

## More information

Depending on your requirements and existing setup, here are some potential workarounds:

1. Rather than editing the tax distributions on the Purchase Order Processing document, edit the distributions once the transaction is in General Ledger.
2. Set up extra tax details so that separate tax details are used per distribution account.
3. Post documents with only the same tax detail and account. It may mean only having a single line per document.
4. If you're using Project Accounting with the **Include Purchase Taxes in Project Cost** option marked in Project Setup, consider unmarking the option. Keep in mind this option may be required to be marked in certain industries and/or countries/regions. A few extra considerations before unmarking are as follows:
    1. The option changes how the total cost on the project is updated and how the cost is recognized on the project.
    1. Depending on the project type and accounting method, it may also have an impact on revenue recognition.
    1. The option may change the account that the tax amount will use to be either the Work In Progress or Cost of Goods Sold.
