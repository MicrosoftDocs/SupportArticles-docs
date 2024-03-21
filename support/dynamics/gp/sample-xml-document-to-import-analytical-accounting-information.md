---
title: Sample XML to import Analytical Accounting information
description: This article contains information that you must have in an XML document for the Analytical Accounting information on a Payables Transaction when you use eConnect for Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.date: 03/20/2024
ms.custom: sap:Financial - Analytical Accounting
---
# A sample XML document to import Analytical Accounting information on a Payables Transaction when using eConnect

This article describes a sample XML document that you can use to import Analytical Accounting information on a Payables Transaction when you are using eConnect for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933023

When you use eConnect for Microsoft Dynamics GP, you must include the `taAnalyticsDistribution` node in the XML document. In the `taAnalyticsDistribution` node, include the `aaAssignedPercent` element, and then set this element to a specific value. The `aaAssignedPercent` element determines the percentage that will be distributed to the specific dimension code that you supply in the XML document. The following sample XML document includes multiple `taAnalyticDistribution` nodes that are based on a percentage.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<eConnect>
   <PMTransactionType>
      <taPMDistribution_Items>
         <taPMDistribution>
            <DOCTYPE>1</DOCTYPE>
            <VCHRNMBR>99999</VCHRNMBR>
            <VENDORID>DOLECKIC0001</VENDORID>
            <DSTSQNUM>16384</DSTSQNUM>
            <DISTTYPE>6</DISTTYPE>
            <DEBITAMT>100</DEBITAMT>
         </taPMDistribution>
         <taPMDistribution>
            <DOCTYPE>1</DOCTYPE>
            <VCHRNMBR>99999</VCHRNMBR>
            <VENDORID>DOLECKIC0001</VENDORID>
            <DSTSQNUM>32768</DSTSQNUM>
            <DISTTYPE>2</DISTTYPE>
            <CRDTAMNT>100</CRDTAMNT>
         </taPMDistribution>
      </taPMDistribution_Items>
      <taAnalyticsDistribution_Items>
         <taAnalyticsDistribution>
            <aaAssignedPercent>50</aaAssignedPercent>
            <aaSubLedgerAssignID>1</aaSubLedgerAssignID>
            <DOCNMBR>99999</DOCNMBR>
            <DOCTYPE>0</DOCTYPE>
            <DistSequence>16384</DistSequence>
            <aaTrxDim>ECONNECT</aaTrxDim>
            <aaTrxDimCode>ECON2</aaTrxDimCode>
         </taAnalyticsDistribution>
         <taAnalyticsDistribution>
            <aaAssignedPercent>50</aaAssignedPercent>
            <aaSubLedgerAssignID>2</aaSubLedgerAssignID>
            <DOCNMBR>99999</DOCNMBR>
            <DOCTYPE>0</DOCTYPE>
            <DistSequence>16384</DistSequence>
            <aaTrxDim>ECONNECT</aaTrxDim>
            <aaTrxDimCode>ECON3</aaTrxDimCode>
         </taAnalyticsDistribution>
      </taAnalyticsDistribution_Items>
      <taPMTransactionInsert>
         <BACHNUMB>SAVE</BACHNUMB>
         <VCHNUMWK>99999</VCHNUMWK>
         <VENDORID>DOLECKIC0001</VENDORID>
         <DOCNUMBR>99999</DOCNUMBR>
         <DOCTYPE>1</DOCTYPE>
         <DOCAMNT>200.00</DOCAMNT>
         <DOCDATE>2007-02-10</DOCDATE>
         <PSTGDATE>2007-02-10</PSTGDATE>
         <VADDCDPR>PRIMARY</VADDCDPR>
         <DUEDATE>2007-02-20</DUEDATE>
         <DSCDLRAM>0</DSCDLRAM>
         <PRCHAMNT>200.00</PRCHAMNT>
         <CHRGAMNT>200.00</CHRGAMNT>
         <CREATEDIST>0</CREATEDIST>
      </taPMTransactionInsert>
   </PMTransactionType>
</eConnect>
```
