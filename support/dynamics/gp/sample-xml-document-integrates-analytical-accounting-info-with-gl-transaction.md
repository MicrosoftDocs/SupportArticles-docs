---
title: XML document that integrates Analytical Accounting information
description: Provides a sample XML document that displays the nodes and elements that are required for the Analytical Accounting information to be integrated successfully with a General Ledger transaction in Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.date: 03/13/2024
ms.custom: sap:Financial - Analytical Accounting
---
# A sample XML document that integrates Analytical Accounting information with a General Ledger transaction when you use eConnect for Microsoft Dynamics GP

This article contains a sample XML document that integrates Analytical Accounting information with a General Ledger transaction when you use eConnect for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933022

The following sample XML document displays the nodes and elements that are required for the Analytical Accounting information to be integrated successfully with a General Ledger transaction.

```xml
<eConnect>
    <GLTransactionType>
        <taGLTransactionLineInsert_Items>
            <taGLTransactionLineInsert>
                <BACHNUMB>ECONNECT</BACHNUMB>
                <JRNENTRY>9999</JRNENTRY>
                <SQNCLINE>16384</SQNCLINE>
                <CRDTAMNT>0.00</CRDTAMNT>
                <DEBITAMT>100.00</DEBITAMT>
            </taGLTransactionLineInsert>
        <taGLTransactionLineInsert>
            <BACHNUMB>ECONNECT</BACHNUMB>
            <JRNENTRY>12004</JRNENTRY>
            <SQNCLINE>32768</SQNCLINE>
            <CRDTAMNT>100.00</CRDTAMNT>
            <DEBITAMT>0.00</DEBITAMT>
        </taGLTransactionLineInsert>
        <taAnalyticsDistribution_Items>
            <taAnalyticsDistribution>
                <DOCNMBR>12004</DOCNMBR>
                <DOCTYPE>0</DOCTYPE>
                <DistSequence>16384</DistSequence>
                <aaTrxDim>ECONNECT</aaTrxDim>
                <aaTrxDimCode>ECON2</aaTrxDimCode>
            </taAnalyticsDistribution>
            <taAnalyticsDistribution>
                <DOCNMBR>12004</DOCNMBR>
                <DOCTYPE>0</DOCTYPE>
                <DistSequence>32768</DistSequence>
                <aaTrxDim>ECONNECT</aaTrxDim>
                <aaTrxDimCode>ECON3</aaTrxDimCode>
            </taAnalyticsDistribution>
        </taAnalyticsDistribution_Items>
        <taGLTransactionHeaderInsert>
            <BACHNUMB>ECONNECT</BACHNUMB>
            <JRNENTRY>12004</JRNENTRY>
            <REFRENCE>January 04 Balances</REFRENCE>
            <TRXDATE>1/31/2004</TRXDATE>
            <TRXTYPE>0</TRXTYPE>
            <SOURCDOC>GJ</SOURCDOC>
        </taGLTransactionHeaderInsert>
    </GLTransactionType>
</eConnect>
```
