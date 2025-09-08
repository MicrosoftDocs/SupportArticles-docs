---
title: Error Number = 9469 Stored Procedure
description: Error message when you use eConnect in Microsoft Dynamics GP together with a bank transaction in Analytical Accounting.
ms.reviewer: theley, dclauson, dlanglie
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Error Number = 9469 Stored Procedure taAnalyticsDistribution" Error message when you use eConnect in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you use `eConnect` in Microsoft Dynamics GP together with a bank transaction in Analytical Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935626

## Symptoms

When you use `eConnect` in Microsoft Dynamics GP, you receive the following error message:

> Error Number = 9469 Stored Procedure taAnalyticsDistribution Error Description = Cannot find a distribution amount based on input value.

This problem occurs if the following conditions are true:

- You're using `eConnect` together with a bank transaction in Analytical Accounting in Microsoft Dynamics GP.
- You use the `DistSequence` element in the `taAnalyticsDistribution` node when you process a bank transaction.

## Cause

This problem occurs because the `taBRBankTransactionDist` node doesn't have a distribution sequence. Bank transactions are posted as soon as they're entered. So you can't use the `DistSequence` value in the `taAnalyticsDistribution` node.

## Resolution

To resolve this problem, you must map the account number (ACTNUMST) when you use `eConnect` to obtain Analytical Accounting information about a bank transaction.

> [!NOTE]
> The same account number can't be used multiple times in the document.

The following sample XML document displays nodes and elements. These nodes and these elements are required for the Analytical Accounting information to be integrated successfully with a bank transaction.

> [!NOTE]
> In this sample XML document, account 000-1120-00 is the default cash account in the checkbook. Account 000-1103-00 is the offset account.

```xml
<eConnect>
  <BRBankTransactionType>
    <taBRBankTransactionDist_Items>
      <taBRBankTransactionDist>
        <Option>1</Option>
        <ACTNUMST>000-1103-00</ACTNUMST>
        <DEBITAMT>31.72</DEBITAMT>
        <CRDTAMNT>0</CRDTAMNT>
        <DistRef>Dist Ref 2</DistRef>
      </taBRBankTransactionDist>
    </taBRBankTransactionDist_Items>
  <taAnalyticsDistribution_Items>
    <taAnalyticsDistribution>
        <DOCNMBR>MIKE0008</DOCNMBR>
        <DOCTYPE>3</DOCTYPE>
        <NOTETEXT>This is an AA test</NOTETEXT>
        <DistRef>New Schema Type for AA</DistRef>
        <AMOUNT>31.72</AMOUNT>
        <aaTrxDim>CCTR</aaTrxDim>
        <aaTrxDimCode>CC01</aaTrxDimCode>
      </taAnalyticsDistribution>
      <taAnalyticsDistribution>
        <DOCNMBR>MIKE0008</DOCNMBR>
        <DOCTYPE>3</DOCTYPE>
        <NOTETEXT>This is an AA test</NOTETEXT>
        <DistRef>New Schema Type for AA</DistRef>
        <AMOUNT>31.72</AMOUNT>
        <aaTrxDim>CCTR</aaTrxDim>
        <aaTrxDimCode>CC01</aaTrxDimCode>
      </taAnalyticsDistribution>
    </taAnalyticsDistribution_Items>
    <taBRBankTransactionHeader>
      <Option>1</Option>
      <CMTrxType>3</CMTrxType>
      <TRXDATE>4/14/2007</TRXDATE>
      <CHEKBKID>FLEX BENEFITS</CHEKBKID>
      <CMTrxNum>MIKE0008</CMTrxNum>
      <paidtorcvdfrom>Paid To</paidtorcvdfrom>
      <DSCRIPTN>Description</DSCRIPTN>
      <TRXAMNT>31.72</TRXAMNT>
      <USERID>sa</USERID>
      <DistRef>Dist Ref 1</DistRef>
    </taBRBankTransactionHeader>
  </BRBankTransactionType>
</eConnect>
```
