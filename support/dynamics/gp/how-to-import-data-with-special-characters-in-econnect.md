---
title: How to import data with special characters in eConnect
description: This article gives an XML code example of how to use CDATA in the eConnect schema for Microsoft Dynamics GP to integrate special characters.
ms.reviewer: theley, dclauson
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to import data with special characters in eConnect for Microsoft Dynamics GP

The article describes how to import data in eConnect for Microsoft Dynamics GP when the source data contains special characters. For example, the Customer Name field is named CUSTNAME in eConnect. This field has a value of CITY POWER & LIGHT. To account for the ampersand (&) in the value, wrap the data in XML tags that begin with CDATA. When you do this, you can import the data that contains the ampersand.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968364

The following is an example of an xml document that uses the CDATA xml tags:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<eConnect>
   <RMCustomerMasterType>
      <taUpdateCreateCustomerRcd>
         <CUSTNMBR>JEFF0002</CUSTNMBR>
         <CUSTNAME><![CDATA[CITY POWER & LIGHT]]></CUSTNAME>
         <STMTNAME>Litware Inc.</STMTNAME>
         <SHRTNAME>Litware</SHRTNAME>
         <ADRSCODE>PRIMARY</ADRSCODE>
         <ADDRESS1>123 Main Street</ADDRESS1>
         <CITY>Valley City</CITY>
         <STATE>ND</STATE>
         <ZIPCODE>51234</ZIPCODE>
         <COUNTRY>USA</COUNTRY>
         <PHNUMBR1>4255550100</PHNUMBR1>
         <PHNUMBR2>4255550101</PHNUMBR2>
         <FAX>4255550102</FAX>
         <UPSZONE>red</UPSZONE>
         <SHIPMTHD>PICKUP</SHIPMTHD>
         <TAXSCHID>USALLEXMPT-0</TAXSCHID>
         <PRBTADCD>PRIMARY</PRBTADCD>
         <PRSTADCD>PRIMARY</PRSTADCD>
         <STADDRCD>PRIMARY</STADDRCD>
         <SLPRSNID>GREG</SLPRSNID>
         <SALSTERR>TERRITORY 6</SALSTERR>
         <COMMENT1>comment1</COMMENT1>
         <COMMENT2>comment2</COMMENT2>
         <PYMTRMID>Net 30</PYMTRMID>
         <CHEKBKID>PAYROLL</CHEKBKID>
         <KPCALHST>0</KPCALHST>
         <UseCustomerClass>0</UseCustomerClass>
         <UpdateIfExists>1</UpdateIfExists>
      </taUpdateCreateCustomerRcd>
   </RMCustomerMasterType>
</eConnect>
```
