---
title: How SUTA/FUTA calculates
description: How SUTA/FUTA calculates in Microsoft Dynamics GP.
ms.reviewer: amelroe
ms.date: 03/31/2021
---
# How SUTA/FUTA calculates in Microsoft Dynamics GP

This article explains how SUTA and FUTA are calculated in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3077838

Information about FUTA/SUTA reporting:

The SUTA and FUTA wages in the Employee Summary (UPR00900) table are no longer used in Microsoft Dynamics GP. The wages no longer appear in any of the Microsoft Dynamics GP windows. However, the wages can be seen in SmartList objects and can be added to reports that contain the Employee Summary table.

In Microsoft Dynamics GP 2010 and later versions, the FUTA Summary report and the SUTA Summary report were added. The FUTA and SUTA wages in the Employee Summary table are no longer used. These period end reports are much more functional because they print multiple states SUTA wages, include state wages previous on SUTA tax, and compute wage limits and the total amount owed on both the SUTA and FUTA reports.

The SUTA and FUTA wages still exist in the UPR00900 table; however are no longer used. The fields are not accessible through the user interface of Microsoft Dynamics GP, but can be added to reports or SmartList objects that contain the Employee Summary table.

Microsoft Dynamics GP will continue to update the UPR00900 table. But because the table is no longer used, the numbers may not be reliable. When the new FUTA Summary report and the SUTA Summary report was added, it was not tested or designed to work with the UPR00900 table. To obtain the SUTA or FUTA wages, the period end report must be run because the wages in the UPR00900 table may not be correct.

Both FUTA and SUTA calculate as follows:

1. The system looks at each transaction in the Payroll Transaction History table (UPR30300) that are subject to FUTA.

2. If the pay code is subject to FUTA, the SBJTFUTA column will be populated with a **1** for that pay code line. Pay codes are listed as Payroll Types of 1 in the UPR30300. Here is a sample script to view just pay code lines for a specific year in the UPR30300:

    ```sql
    select * from UPR30300 where pyrlrtyp='1' and year1='2015'
    ```

3. If the pay code is not subject to FUTA, the SBJTFUTA column is a **0**.

4. The SBJFUTA column will remain a '0' for a benefit. Instead it will look at the Payroll Benefit Setup (UPR00600) to determine if is subject to FUTA.

5. To figure out the FUTA wages, the system adds up each UPRTRXAM column for the pay codes and benefits, only for the transactions that are subject to FUTA.

6. Then, the system looks at the Payroll Unemployment TSA table (UPR40101) in the FUSUTSAD column to see what deductions are tax sheltered from FUTA tax and from which states.

7. It then subtracts the TSA deductions to get the FUTA wages.

8. The system also looks at the FUTA wage limit (FUSUWLMT column) in the Payroll Unemployment Setup table (UPR40100) to see if the employee has reached the wage limit. If the employee has reached their wage limit, FUTA will not calculate.
