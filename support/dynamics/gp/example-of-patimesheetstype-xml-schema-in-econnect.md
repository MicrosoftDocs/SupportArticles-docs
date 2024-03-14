---
title: Example of PATimeSheetsType XML Schema in eConnect
description: Provides an example of a PATimeSheetsType XML Schema in eConnect together with Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.date: 03/13/2024
---
# Example of a PATimeSheetsType XML Schema in eConnect together with Microsoft Dynamics GP

This article contains an example of a `PATimeSheetsType` XML Schema that can be used to integrate a Project TimeSheetEntry transaction into the sample company. You can use this sample code with eConnect together with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919441

The following `PATimeSheetsType` XML Schema contains data that can be used to integrate a Project TimeSheetEntry transaction into the sample company.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<eConnect>
   <PATimeSheetsType>
      <taPATimeSheetLineInsert_Items>
         <taPATimeSheetLineInsert>
            <PATSTYP>1</PATSTYP>
            <PATSNO>TS000000000000001</PATSNO>
            <EMPLOYID>ACKE0001</EMPLOYID>
            <CURNCYID>Z-US$</CURNCYID>
            <PADT>4/12/2007 12:00:00 AM</PADT>
            <PAPROJNUMBER>HOTELEDGER</PAPROJNUMBER>
            <PACOSTCATID>CONSULTING</PACOSTCATID>
            <PAQtyQ>1</PAQtyQ>
         </taPATimeSheetLineInsert>
      </taPATimeSheetLineInsert_Items>
      <taPATimeSheetHdrInsert>
         <PATSTYP>1</PATSTYP>
         <PATSNO>TS000000000000001</PATSNO>
         <PADOCDT>4/12/2007 12:00:00 AM</PADOCDT>
         <BACHNUMB>TEST</BACHNUMB>
         <EMPLOYID>ACKE0001</EMPLOYID>
         <PAREPD>7</PAREPD>
         <PAREPDT>4/1/2007</PAREPDT>
         <CURNCYID>Z-US$</CURNCYID>
         <PAREFNO />
         <PAreptsuff />
         <PACOMM />
         <PATQTY>1</PATQTY>
      </taPATimeSheetHdrInsert>
   </PATimeSheetsType>
</eConnect>
```
