---
title: How to use determine whether specific module is registered
description: Provides a table of module ID values and names that you can use in Microsoft Dexterity Sanscript code to determine whether a specific module is registered.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to use Microsoft Dexterity Sanscript code to determine whether a specific module is registered

This article lists the module IDs that you can use in Microsoft Dexterity Sanscript code to determine whether a specific module is registered in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 843651

As a developer, you may have a situation in which you want to enable your application or pieces of your application only if a specific module is registered in Microsoft Dynamics GP. To determine whether a specific module is registered in Microsoft Dynamics GP, use code that resembles the following code example.

> [!NOTE]
> The following code example is for General Ledger.

```console
if 'Module Registered'[1] of globals then 
{do GL specific code here} 
end if;
```

The following table lists the module IDs that you can use in the code.

|Module ID| Module name |
|---|---|
|1|General Ledger|
|2|Advanced Financial Analysis|
|3|Multicurrency Management|
|4|Bank Reconciliation|
|5|Project Accounting|
|6|Electronic Banking|
|7|Reserved|
|8|Fixed Asset Management|
|9|Receivables Management|
|10|Invoicing|
|11|Sales Order Processing|
|12|Multidimensional Analysis|
|13|Account Level Security|
|14|Dynamics Process Server|
|15|National Accounts|
|16|Collections Management|
|17|Service Call Management|
|18|Contract Administration|
|19|Payables Management|
|20|Advanced Purchase Order Processing|
|21|Purchase Order Processing|
|22|Intercompany Processing|
|22|Intercompany Processing|
|23|Payables Management|
|24|Magnetic Media|
|25|Integration Assistant for Excel|
|26|Inventory Control|
|27|Warehouse Management|
|28|Reserved|
|29|Bill of Materials|
|30|Cash Flow Management|
|31|eService Center|
|32|Depot Management|
|33|Returns Management|
|34|Preventive Maintenance|
|35|Payroll - US|
|36|Direct Deposit - US|
|37|Payroll Connect|
|38|SmartList|
|39|Reserved|
|40|Reserved|
|41|Magnetic Media|
|42|US 941 Magnetic Media|
|43|Human Resources|
|44|Project Tracking|
|45|Org Structures|
|46|Business Alerts|
|47|System Manager|
|48|Client Server System Manager|
|49|Integration Manager|
|50|Dynamics Modifier|
|51|Dexterity|
|52|Reserved|
|53|Payroll Tax Service|
|54|SM CS+ SQL|
|55|Reserved|
|56|Dynamics Continuum|
|57|Customization Site License|
|58|Requisition Management|
|59|eCommerce|
|60|eView|
|61|eOrder|
|62|eEmployee|
|63|Reserved|
|64|Reserved|
|65|Reserved|
|66|Reserved|
|67|Reserved|
|68|Manufacturing|
|69|Safe Pay|
|70|Electronic Bank Reconciliation|
|71|RM Electronic Fund Transfer|
|72|PM Electronic Fund Transfer|
|73|Small Business Suite|
|74|Resource Planning|
|75|Landed Cost|
|76|Auto PO|
|77|eTech|
|78|eService Class|
|79|eReturns|
|80|Language: English|
|81|Language: German|
|82|Language: French|
|83|Language: Spanish|
|84|Language: Portuguese|
|85|Language: Polish|
|86|Language: Czech|
|87|Language: Dutch|
|88|Language: French Canadian|
|89|Classic Features|
|90|GL Transaction Matching|
|91|Account Rollup Inquiry|
|92|Revenue/Expense Deferrals|
|93|Lockbox Processing|
|94|Refund Checks|
|95|Customer/Vendor Consolidations|
|96|Multi-bin|
|97|Language: Sweden|
|98|Language: Denmark|
|99|Language: Norway|
|100|Language: Finland|
|101|Language: Estonia|
|102|Language: Lithuania|
|103|Language: Latvia|
|104|Language: China|
|105|Extended Pricing|
|106|Reserved|
|107|Cashbook Bank Management|
|108|Electronic Bank Management|
|109|Electronic Reconciliation Management|
|110|Field Level Security|
|111|Reserved|
|112|Analytical Accounting|
|113|Reserved|
|114|Reserved|
|115|Available to Promise|
|116|Business Alerts|
|117|MS SQL Server Desktop Engine|
|118|Advanced Distribution|
|119|Advanced Picking|
|120|Business Portal|
|121|BP Employee Pay|
|122|BP Encumbrance Employee Profile|
|123|BP Recruitment|
|124|BP Skills and Training|
|125|BP Time and Attendance|
|126|BP Key Performance Indicators|
|127|BP Electronic Doc. Delivery|
|128|Project Time & Expense|
|129|SOX Accelerators|
|130|Demand Planner|
|131|Grant Management|
|132|Encumbrance Management|
|133|Extender|
|134|SmartList Builder|
|135|Analysis Basic Cubes|
|136|Analysis Cubes Library|
|137|Advanced Analysis Cubes Library|
|138|CGA Student Edition|
|139|Education and Evaluation Edition|
|140|Audit Trails|
|141|Electronic Signatures|
