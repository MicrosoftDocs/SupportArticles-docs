---
title: Process BACS payments when you use European EFT module
description: Describes the setup steps and the transaction steps for processing Bankers Automated Clearing System (BACS) payments in Great Plains 8.0 without using an additional product.
ms.topic: how-to
ms.date: 03/13/2024
ms.reviewer: theley
---
# How to process BACS payments when you use the European Electronic Funds Transfer module in Great Plains

This article describes the setup steps and the transaction steps for processing Bankers Automated Clearing System (BACS) payments in Great Plains 8.0 without using an additional product.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 886608

## Introduction

The European Electronic Funds Transfer (EFT) module is designed to be used with an electronic banking product such as Albany eBank. However, if you do not want to use such an additional product, you can still process Bankers Automated Clearing System (BACS) payment runs by using the European EFT module. This article describes how to process Bankers Automated Clearing System (BACS) payment runs in Great Plains 8.0 when you are not using an electronic banking product.

## More information

To process BACS payment runs, use the EFT Payment Register report as the BACS output file. This report is printed after you post an EFT batch or transaction. You must modify this report in Report Writer to comply with the format that is required by BACS or by your bank software.

### Setup

1. Click **Tools**, click **Setup**, click **Posting**, and then click **Posting**.

    The Setup Posting window opens.

2. Select **Purchasing** in the **Series** list, and then select **Computer Cheques** in the **Origin** list.

3. In the scrolling window next to **EFT Payment Register** in the **Send To** section, click to select the check box under the folder icon.

    > [!NOTE]
    > We recommend that you do not select the check box under the question mark icon. By not selecting this check box, you can make sure that the BACS file is always generated.

4. In the **Append/Replace** list, select **Replace**.

    When a new register is generated, the previous payment register is replaced.
5. In the **Path** section, specify a full path.
6. To type the creditor bank details, click **Cards**, click **Purchasing**, click **Creditor**, click **Remit To Address**, and then click **Bank**.

    The Creditor Bank Maintenance window opens.
7. Select the bank format from the **Bank Format** list, and then type the appropriate information in the following boxes:
   - **Bank Name**  
   - **Bank Account Number**  
   - **Bank Code**

    > [!NOTE]
    > If you previously used the United Kingdom Bankers Automated Clearing System (UKBACS) module, migration guidelines for UKBACS creditor bank details exist.

8. Assign bank details to the chequebooks that are used for electronic payments. To do this, click **Cards**, click **Financial**, click **Chequebook**, and then click **Bank**.

### Transaction processing

1. Click **Transactions**, click **Purchasing**, and then click **Batches**.

    The Payables Batch Entry window opens.
2. In the **Payment Method** section, click **Bank Transfer**.
3. Continue your typical processing of cheques.

    > [!NOTE]
    > Creditors that have active EFT bank details that match the batch's chequebook EFT bank details are included in the EFT Payment Register report.
4. Click **Process** in the **Print Payables Cheques** window.
5. If the Report Destination window appears for the EFT Payment Register report, click **OK**.

    > [!NOTE]
    > You are only prompted if the check box under the question mark icon is selected in the **Send To** section of the Posting Setup window.
6. The output file that you submit to BACS is created in the location that is defined in the Posting Setup window.
