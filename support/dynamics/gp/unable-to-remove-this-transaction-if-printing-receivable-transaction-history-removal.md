---
title: An open apply record exists or an apply record exists outside the selected range error when printing the Receivables Transaction History Removal report
description: Describes a problem that occurs if a document has an asterisk next to the body of the report. A resolution is provided.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "An open apply record exists or an apply record exists outside the selected range" error when printing Receivables Transaction History Removal report

This article provides a resolution for the issue that you can't print the Receivables Transaction History Removal report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871985

## Symptoms

When you try to print the Receivables Transaction History Removal report in Microsoft Dynamics GP, you receive the following error message in the header and applies to the document if it has an asterisk next to it:

> Unable to Remove This Transaction: an open apply record exists or an apply record exists outside the selected range.

## Cause

If an asterisk does not appear next to a specific document, the history was successfully removed. The message is listed in the header of the document and only applies it the document has an asterisk next to it. It is by design that the history will not be removed if you have the setup marked to retain history.

## Resolution

To resolve this problem, follow these steps:

1. Open the **Receivables Management Setup** dialog box. To do this, follow the appropriate step:
    - In Microsoft Dynamics GP 10.0 and higher versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Sales**, and then select **Receivables**.
    - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Setup** on the **Tools** menu, point to **Sales**, and then select **Receivables**.
2. Clear the **Print Historical Aged Trial Balance** check box, and then select **OK**.

3. Open the **Remove Transaction History** dialog box, and then remove the transaction in the **Remove Receivables Transaction History** dialog box. To open the **Remove Transaction History** dialog box, follow the appropriate step:

   - In Microsoft Dynamics GP 10.0 and higher versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Sales**, and then select **Remove Transaction History**.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Utilities** on the **Tools** menu, point to **Sales**, and then select **Remove Transaction History**.

    > [!NOTE]
    > To maintain data integrity, remove both the debit document and the applied credit document.

4. Open the **Receivables Management Setup** dialog box, select the **Print Historical Aged Trial Balance** check box, and then select **OK**.
