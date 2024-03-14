---
title: Error when you delete a Sales Order Processing batch in Microsoft Dynamics GP
description: Describes a problem that occurs when you try to delete a Sales Order Processing batch after you upgrade to Microsoft Dynamics GP 9.0 SP3 or to a later version of Microsoft Dynamics GP. A workaround is provided.
ms.topic: troubleshooting
ms.reviewer: theley, kevtunst
ms.date: 03/13/2024
---
# Error message when you try to delete a Sales Order Processing batch in Microsoft Dynamics GP: "Unhandled script exception: Illegal address for field 'Customer Number' in script 'vatDaybook_SOPRemoveRC'"

This article provides help to solve an error that occurs when you delete a Sales Order Processing batch in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952213

## Symptoms

Consider the following scenario. You upgrade to Microsoft Dynamics GP 9.0 Service Pack 3 or to a later version of Microsoft Dynamics GP. Then, you try to delete a Sales Order Processing (SOP) batch. In this scenario, you receive the following error message:

> Unhandled script exception: Illegal address for field 'Customer Number' in script 'vatDaybook_SOPRemoveRC'. Script terminated.

Therefore, you cannot delete the SOP batch. However, you can delete the SOP batch if you uninstall VAT Daybook in Microsoft Dynamics GP.

This problem occurs if the following conditions are true:

- The country/region code that you use is **GB**.
- You use the reverse charge tax.

## Cause

This problem occurs because Microsoft Dynamics GP calls the vatDaybook_SOPRemoveRC script. However, the vatDaybook_SOPRemoveRC script does not exist. When Microsoft Dynamics GP runs the following code, this problem occurs.

```sql
sp_helptext vatDaybook_SOPRemoveRC
```

## Resolution

To resolve this problem, obtain the latest service pack.

## Workaround

To work around this problem, delete the transactions that are assigned to the SOP batch in the Sales Transaction Entry window. To do this, follow these steps:

1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.
2. In the **Document No** list, click a document number that is assigned to the SOP batch.
3. Follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Delete**.
   - In Microsoft Dynamics GP 9.0, click **Delete**.
4. When you are prompted to delete the transaction, click **Delete**.
5. Repeat steps 2 through 4 for each transaction that is assigned to the SOP batch.

## Status

- Microsoft Dynamics GP 10.0

    Microsoft has confirmed that this is a problem. This problem was first corrected in Microsoft Dynamics GP 10.0 Service Pack 2.

- Microsoft Dynamics GP 9.0

    Microsoft has confirmed that this is a problem in the Microsoft products. This problem was first corrected in Microsoft Dynamics GP 9.0 Service Pack 4.

## Steps to reproduce the problem

1. Follow the appropriate step:

   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then click **Reverse Charge VAT Setup**.
   - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Company**, and then click **Reverse Charge VAT Setup**.

2. Make sure that the reverse charge is set up by using a positive tax details identifier (ID) and a negative tax details ID.

3. Click **Transactions**, point to **Sales**, and then click **Sales Batches**.

4. In the **Batch ID** field, enter a batch ID, and then click **Delete**.

5. If you are prompted to delete the batch ID, click **Delete**.
