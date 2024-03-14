---
title: Description of Manufacturing setup tables
description: Provides information about which Manufacturing setup tables you can copy from one company to another company in Microsoft Dynamics GP.
ms.reviewer: theley, aeckman, lmuelle
ms.date: 03/13/2024
---
# Description of the Manufacturing setup tables that you can copy from an existing company to a new company in Microsoft Dynamics GP

This article lists the Manufacturing setup tables that you can copy from an existing company to a new company in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949762

## Inventory item and related setup information

|Table ID|Table name|
|---|---|
|BC010000|Buyer Codes|
|COSS0401|pref_cost_sys|
|CT00001|IC Cost Standard Company Default|
|CT00002|IC Cost Standard Item Class Defaults|
|CT00003|IC Cost Standard Items Defaults|
|CT00102|IC Cost Item Master|
|CT40401|IC Cost Item Class Setup|
|ICIV0323|IC_IV_STANDARD|
|IVR10015|Item Engineering|
|IVR10100|Alternate Parts|
|PC010000|MRP_Planner_Codes|
  
## Bills of material

| Table ID| Table name |
|---|---|
|BM010115|Bill of Materials Line|
|BM010415|BOM Revision|
|BM010116|BOM_Line_HIST|
|BM010416|BOM_Revision_HIST|
|BMPF0114|pref_bom_user|
|BMPS0114|pref_bom_sys|
  
### Routings

| Table ID| Table name |
|---|---|
|RT010001|routing_mstr|
|RT010130|routing_line|
|RTPS0130|pref_router_sys|
|RTPU0130|pref_router_user|
  
## Facility setup information

> [!NOTE]
> Facility setup information includes calendars, work centers, machines, and labor codes.

| Table ID| Table name |
|---|---|
|DD010000|Down Day|
|CO010000|MFG_Company_ Info|
|DD020000|Down on Weekends|
|DD030000|Up_Days|
|MM010032|Machine Master|
|WC010015|Work Center Master|
|WC010100|Work Center Employee Line Item|
|WC010200|Work Center Machine Line|
|WC010300|Work Center -Employee Absences|
|WC010400|WC_Down_On_Weekends|
|WC010500|WC_Down_Days</br>|
|WC010600|Work Center - Alternates|
|WC010714|WC Operations Codes|
|WC010800|WC Up Days|
|WC019831|Work Center Header|
|WCPF0100|pref_workcenter_user|
|WCPS0100|pref_workcenter_sys</br>|
|LC010014|Labor Code Master|
|PFH10000|pref_hdr|
  
## Order processing setup information

| Table ID| Table name |
|---|---|
|mops0100|pref_mop_sys|
|MOPS0200|pref_mop_sched_sys|
|SP010016|Scheduling Preference_MSTR|
|SP010100|Scheduling_Preference_Line|
|IS050000|Order Fulfillment Setup|
|IS090000|Manufacturing Fulfillment Item Master|
|ISSP0201|Manufacturing Series Sales Order Preferences|
|SOPS113B|pref_sop_sys|
|WPPS0114|pref_wip_sys|
|WPPU0114|pref_wip_user</br></br>|
  
## Material requirements planning setup information

| Table ID| Table name |
|---|---|
|MPPS0130|MRP Setup|
|MPPS0230|pref_mrp_sys|
|MPPU0130|pref_mrp_user|
|MRP0200|mrpScheduleHDR</br>|
|MRP0201|mrpScheduleDetail</br></br>|
  
## Engineering change management information

| Table ID| Table name |
|---|---|
|ECPS0000|pref_ecm_sys|
|ECPU0000|pref_ecm_user|
|EC020230|ECM_Disposition|
|EC030030|ECM_REJECT_CODE|
|EC020030|ECM_Routing_HDR|
  
## Job costing information

| Table ID| Table name |
|---|---|
|ICJC0003|Job Categories|
|ICJC0004|ICJC_Category|
|ICJC0005|ICJC_Line_Categories|
|ICJC0006|ICJC_Revenue_Expense_Code|
|JCPS0040|pref_jc_sys|
  
## Capacity requirements planning information

| Table ID| Table name |
|---|---|
|CP010530|CRP_Prefs</br></br>|
  
## Sales configurator information

| Table ID| Table name |
|---|---|
|OC010000|Option Category MSTR|
|OC010100|Option Category LINE|
|OC010200|Option Category Exclusion|
|OC010300|Option_Category_Inclusion|
|OC010400|Option Promotion MSTR|
  
## Quality assurance information

| Table ID| Table name |
|---|---|
|QAPS0032|pref_qa_sys|
|QAPU0032|pref_qa_user|
|QA100032|QA_Procedure_MSTR|
|QA100132|QA_Procedure_LINE|
|QA110032|AQL_MSTR|
|QA110132|AQL_LINE|
|QA110232|AQL_Sample|
|QA120032|QA_Inspector|
|QA130032|QA_Measurement_Types_MSTR|
|QA130132|QA_Measurement_Types_LINE|
|QA140032|QA_Defect_Code|
|QA150032|QA_Disposition_Code|
|QA160032|QA_Item_Procedure|
  
## More information

After you copy all the setup tables, you can run the mfgfix90checkdata stored procedure to determine any potential issues with the data. To do it, follow these steps:

1. Take one of the following actions, depending on the version of Microsoft SQL Server that you're using.
   - If you're using SQL Server 2005, start SQL Server Management Studio. To do it, point to **All Programs**, select **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
2. Run the mfgfix90checkdata stored procedure. To do it, use one of the following methods.

### Method 1: SQL Server Management Studio

1. In **Object Explorer**, expand **Databases**, and then select **Dynamics**.
2. Select **New Query**, and then type the following select statement in the query pane:  
    `Exec mfgfix90checkdata`

### Method 2: SQL Query Analyzer

1. Type the following select statement in the query pane:  
    `Exec mfgfix90checkdata`

2. On the **Query** menu, select **Results in Text**, and then select **Execute**.
3. On the **Query** menu, point to **Results To**, and then select **Results to Text**.
4. On the **Query** menu, select **Execute**

> [!NOTE]
> For more information about how to fix the issues that are described here, request a Check Data document from your partner or from Microsoft Customer Support Services. For Customer Support Services telephone numbers, visit [Microsoft support](https://support.microsoft.com/contactus/?ws=support).
