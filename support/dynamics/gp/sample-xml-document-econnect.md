---
title: Sample XML document in eConnect
description: A sample XML document that you can use to import tax information for a sales order processing transaction in eConnect for Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# Sample XML document that you can use to import tax information for a sales order processing transaction in eConnect for Microsoft Dynamics GP

This article contains a sample XML document that you can use to import tax information for a sales order processing transaction in `eConnect` for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927322

## Introduction

The XML document demonstrates the `eConnect` nodes and elements that are required to successfully import tax information for a sales order processing transaction.

## More information

```xml
<?xml version="1.0" encoding="utf-8"?>
<eConnect>
    <SOPTransactionType>
        <taSopLineIvcInsert_Items>
            <taSopLineIvcInsert>
                <SOPTYPE>2</SOPTYPE>
                <SOPNUMBE>99999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <DOCDATE>2006-10-17</DOCDATE>
                <LOCNCODE>WAREHOUSE</LOCNCODE>
                <ITEMNMBR>128 SDRAM</ITEMNMBR>
                <UNITPRCE>12.95</UNITPRCE>
                <XTNDPRCE>12.95</XTNDPRCE>
                <QUANTITY>1</QUANTITY>
                <TAXAMNT>0.93</TAXAMNT>
                <LNITMSEQ>16384</LNITMSEQ>
                <TAXSCHID>USASTCITY-6*</TAXSCHID>
            </taSopLineIvcInsert>
            <taSopLineIvcInsert>
                <SOPTYPE>2</SOPTYPE>
                <SOPNUMBE>99999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <DOCDATE>2006-10-17</DOCDATE>
                <LOCNCODE>WAREHOUSE</LOCNCODE>
                <ITEMNMBR>24X IDE</ITEMNMBR>
                <UNITPRCE>14.95</UNITPRCE>
                <XTNDPRCE>14.95</XTNDPRCE>
                <QUANTITY>1</QUANTITY>
                <TAXAMNT>1.07</TAXAMNT>
                <LNITMSEQ>32768</LNITMSEQ>
                <TAXSCHID>USASTCITY-6*</TAXSCHID>
                </taSopLineIvcInsert>
            </taSopLineIvcInsert_Items>
            <taSopLineIvcTaxInsert_Items>
            <taSopLineIvcTaxInsert>
                <SOPTYPE>2</SOPTYPE>
                <SOPNUMBE>99999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <TAXTYPE>0</TAXTYPE>
                <SALESAMT>12.95</SALESAMT>
                <TAXDTLID>USASTE-PS6N0</TAXDTLID>
                <STAXAMNT>0.93</STAXAMNT>
                <LNITMSEQ>16384</LNITMSEQ>
            </taSopLineIvcTaxInsert>
            <taSopLineIvcTaxInsert>
                <SOPTYPE>2</SOPTYPE>
                <SOPNUMBE>99999</SOPNUMBE>
                <CUSTNMBR>ADVANCED0001</CUSTNMBR>
                <TAXTYPE>0</TAXTYPE>
                <SALESAMT>14.95</SALESAMT>
                <TAXDTLID>USASTE-PS6N0</TAXDTLID>
                <STAXAMNT>1.07</STAXAMNT>
                <LNITMSEQ>32768</LNITMSEQ>
            </taSopLineIvcTaxInsert>
            </taSopLineIvcTaxInsert_Items>
            <taSopHdrIvcInsert>
            <SOPTYPE>2</SOPTYPE>
            <DOCID>ORDER</DOCID>
            <SOPNUMBE>99999</SOPNUMBE>
            <TAXAMNT>2.00</TAXAMNT>
            <LOCNCODE>WAREHOUSE</LOCNCODE>
            <DOCDATE>2006-10-17</DOCDATE>
            <CUSTNMBR>ADVANCED0001</CUSTNMBR>
            <SUBTOTAL>27.9</SUBTOTAL>
            <DOCAMNT>34.89</DOCAMNT>
            <BACHNUMB>TAXES</BACHNUMB>
            <TAXSCHID>USASTCITY-6*</TAXSCHID>
            <CREATEDIST>1</CREATEDIST>
            <USINGHEADERLEVELTAXES>0</USINGHEADERLEVELTAXES>
            <CREATETAXES>0</CREATETAXES>
            <DEFTAXSCHDS>0</DEFTAXSCHDS>
        </taSopHdrIvcInsert>
    </SOPTransactionType>
</eConnect>
```
