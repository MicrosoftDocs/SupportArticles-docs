---
title: Import taxes on Sales Order Processing invoice in eConnect
description: How to import taxes on a Sales Order Processing invoice in eConnect for Microsoft Dynamics GP 10.0.
ms.topic: how-to
ms.reviewer: dclauson
ms.date: 03/13/2024
---
# How to import taxes on a Sales Order Processing invoice in eConnect for Microsoft Dynamics GP 10.0

This article describes how to import taxes on a Sales Order Processing invoice in eConnect for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945747

## Summary

In eConnect for Microsoft Dynamics GP 10.0, you can import taxes on a Sales Order Processing invoice in Microsoft Dynamics GP 10.0. You must set specific elements in the eConnect schemas so that the tax information is correctly populated on the Sales Order Processing invoice.

## More information

The following sample XML document integrates taxes that are specific to each line item on the Sales Order Processing invoice.

> [!NOTE]
> This document is an example of how to configure an XML document so that you can import line item taxes.

```xml
<eConnect>
    <SOPTRANSACTIONTYPE>
        <taSopLineIvcInsert_Items>
            <taSopLineIvcInsert>
                <SOPTYPE>3</SOPTYPE>
                <SOPNUMBE>999999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <DOCDATE>11/01/2017</DOCDATE>
                <ITEMNMBR>24X IDE</ITEMNMBR>
                <UNITPRCE>40.00</UNITPRCE>
                <XTNDPRCE>40.00</XTNDPRCE>
                <QUANTITY>1</QUANTITY>
                <LNITMSEQ>16384</LNITMSEQ>
                <TAXAMNT>5.00</TAXAMNT>
            </taSopLineIvcInsert>
            <taSopLineIvcInsert>
                <SOPTYPE>3</SOPTYPE>
                <SOPNUMBE>999999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <DOCDATE>11/01/2017</DOCDATE>
                <ITEMNMBR>256 SDRAM</ITEMNMBR>
                <UNITPRCE>300.00</UNITPRCE>
                <XTNDPRCE>300.00</XTNDPRCE>
                <QUANTITY>1</QUANTITY>
                <LNITMSEQ>32768</LNITMSEQ>
                <TAXAMNT>10.00</TAXAMNT>
            </taSopLineIvcInsert>
        </taSopLineIvcInsert_Items>
        <taSopLineIvcTaxInsert_Items>
            <taSopLineIvcTaxInsert>
                <SOPTYPE>3</SOPTYPE>
                <SOPNUMBE>999999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <LNITMSEQ>16384</LNITMSEQ>
                <SALESAMT>40.00</SALESAMT>
                <STAXAMNT>5.00</STAXAMNT>
                <TDTTXSLS>40.00</TDTTXSLS>
                <TAXDTLID>USASTE-PS6N0</TAXDTLID>
            </taSopLineIvcTaxInsert>
            <taSopLineIvcTaxInsert>
                <SOPTYPE>3</SOPTYPE>
                <SOPNUMBE>999999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <LNITMSEQ>32768</LNITMSEQ>
                <SALESAMT>300.00</SALESAMT>
                <STAXAMNT>10.00</STAXAMNT>
                <TDTTXSLS>300.00</TDTTXSLS>
                <TAXDTLID>USASTE-PS6N0</TAXDTLID>
                </taSopLineIvcTaxInsert>
        </taSopLineIvcTaxInsert_Items>
        <taSopHdrIvcInsert>
        <SOPTYPE>3</SOPTYPE>
        <SOPNUMBE>999999</SOPNUMBE>
        <CUSTNMBR>ADVANCED0001</CUSTNMBR>
        <DOCID>STDINV</DOCID>
        <TAXAMNT>15.00</TAXAMNT>
        <SUBTOTAL>340.00</SUBTOTAL>
        <USINGHEADERLEVELTAXES>0</USINGHEADERLEVELTAXES>
        <DOCAMNT>355.00</DOCAMNT>
        <DOCDATE>11/27/2017</DOCDATE>
        <BACHNUMB>TEST</BACHNUMB>
        <TAXSCHID>USAUSSTCITY+6*</TAXSCHID>
        </taSopHdrIvcInsert>
    </SOPTRANSACTIONTYPE>
</eConnect>
```
