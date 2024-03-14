---
title: Copy setup tables from one company to another in Dynamics GP
description: Describes how to copy setup tables from one company to another in Microsoft Dynamics GP and in Microsoft Business Solutions – Great Plains.
ms.topic: how-to
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to copy setup tables from one company to another in Microsoft Dynamics GP

This article describes how to copy setup tables from one company to another company in Microsoft Dynamics GP and in Microsoft Business Solutions – Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872709

## Introduction

The following list contains the setup tables that can be copied to a new company database.

If you are running Microsoft Business Solutions - Great Plains 8.0, see the [Additional tables in Microsoft Business Solutions - Great Plains 8.0](#additional-tables-in-microsoft-business-solutions---great-plains-80) section in this article.

After the tables have been copied to the new company, run the Check Links function on all modules in the new company. To run the Check Links function, follow the steps for your version of the program:

- Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010:

    On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.

- Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0:

    On the **File** menu, point to **Maintenance**, and then click **Check Links**.

| Finance |
|---|
|GL00100 Chart of Accounts (Account Master)</br></br> Do not copy the GL00101.|
|GL00102 Account Category Master|
|GL00103 Fixed Allocation Master|
|GL00104 Variable Allocation Master|
|GL00105 Account Index Master|
|CM00100 CM Checkbook Master|
|CM40100 Cash Management Setup|
|CM40101 Cash Management Transaction Type Setup|
|GL00200 Budget Master file|
|GL00201 Budget Summary Master file|
|GL40000 General Ledger Setup|
|GL40100 Quick Journal Setup|
|GL40101 Quick Journal Account Setup|
|GL40200 Segment Description Master|
|SY04100 Bank Master|
|MC40000 Multicurrency Setup|
|MC40100 Multicurrency Rate Type Setup|
|ASI*.* Advanced Lookup Files|
||

| Purchase |
|---|
|PM00100 PM Class Master File|
|PM00101 Vendor Class Accounts|
|PM00200 PM Vendor Master File|
|PM00203 Vendor Accounts|
|PM00300 PM Address Master|
|PM40100 PM Setup File|
|PM40101 PM Period Setup File|
|PM40102 Payables Document Types|
|PM40103 Payables Distribution Type SETP|
|POP00101 Buyer Master|
|POP40100 Purchasing Setup Table|
|POP40600 Purchasing Non-IV Item Currency Setup|
|ASI*.* Advanced Lookup Files|
||

| Sales |
|---|
|IVC40100 Invoicing Setup|
|IVC40101 Invoicing Document Setup|
|RM00101 Customer Master|
|RM00102 Customer Master Address File|
|RM00105 National Accounts Master|
|RM00201 RM Class Master|
|RM00301 RM Salesperson Master files|
|RM00303 Sales Territory Master File|
|RM40101 RM Module Setup File|
|RM40201 RM Period Setup|
|RM40401 Document Type Setup File|
|SOP00100 Sales Process Holds Master|
|SOP00200 Sales Prospect Master|
|SOP40100 Sales Setup|
|SOP40200 Sales Type ID setup|
|SOP40201 Sales Default Process Holds Setup|
|SOP40300 Sales Document Setup|
|SOP40400 Sales User Defined Table Setup|
|SOP40500 Sales Master Number Setup|
|SOP40600 Sales Non-IV Item Currency Setup|
|ASI*.* Advanced Lookup Files|
||

| Inventory |
|---|
|BM00101 Bill of Materials Header|
|BM00111 Bill of Materials Component|
|BM40100 Bill of Materials Setup|
|IV00101 Item Master|
|IV00102 Item Quantity Master|
|IV00103 Item Vendor Master|
|IV00104 Item Kit Master|
|IV00105 Item Currency Master|
|IV00106 Item Purchasing|
|IV00107 Item Price List Options|
|IV00108 Item Price List|
|IV00109 Item Serial Number Mask|
|IV40100 Inventory Control Setup|
|IV40201 Inventory U of M Schedule Setup|
|IV40202 Inventory U of M Schedule Detail Setup|
|IV40400 Item Class Setup|
|IV40401 Item Class Currency Setup|
|IV40500 Item Lot Category Setup|
|IV40600 Item Category Setup|
|IV40700 Site Setup|
|IV40800 Price Level Setup|
|IV40900 Price Group Master|
|IV41000 Stock Calendar|
|IV41001 Stock Calendar Exception Days|
|ASI*.* Advanced Lookup Files|
||

| Company |
|---|
|SY00300 Account Format Setup|
|SY01100 Posting Account Master|
|SY02200 Posting Journal Destinations|
|SY02300 Posting Settings|
|SY03000 Shipping Methods Master|
|SY03100 Credit Card Master|
|SY03300 Payment Terms Master|
|SY40100 Fiscal Period Setup|
|SY40101 Fiscal Period Header|
|TX00101 Sales/Purchases Tax Schedule Header Master|
|TX00102 Sales/Purchases Tax Schedule Master|
|TX00201 Sales/Purchases Tax Master|
|STN*.* Named Printers Setup|
|ASI*.* Dynamics Explorer Files|
||

| U.S. Payroll (When you copy payroll setup information from one company to another company, the following setup tables are used.)|
|---|
|UPR40100 Payroll Unemployment Setup|
|UPR40101 Payroll Unemployment TSA|
|UPR40200 Payroll Setup|
|UPR40301 Payroll Position Setup|
|UPR40500 Payroll Accounts Setup|
|UPR40501 Payroll Tax Expense/Withholding Setup|
|UPR40600 Payroll Pay Code Setup|
|UPR40700 Payroll Workers Comp Setup|
|UPR40800 Payroll Benefit Setup|
|UPR40801 Payroll Benefit Based On Setup|
|UPR40900 Payroll Deduction Setup|
|UPR40901 Payroll Deduction Based On Setup|
|UPR40902 Payroll Deduction Sequence Setup|
|UPR41100 Payroll State Code Setup|
|UPR41200 Payroll Class Setup|
|UPR41201 Payroll Class Detail Setup|
|UPR41400 Payroll Local Tax Setup|
|UPR41401 Payroll Local Tax Table Setup|
|UPR41500 Payroll Shift Code Setup|
|UPR41700 Payroll Setup Supervisor|
|UPR41800 Payroll Maximum Deduction Setup (only in Microsoft Dynamics GP 10.0)|
|UPR41801 Payroll State/Fed Setup (only in Microsoft Dynamics GP 10.0)|
|UPR41900 Payroll Earnings Setup (only in Microsoft Dynamics GP 10.0)|
|UPR41901 Payroll Earnings Paycodes (only in Microsoft Dynamics GP 10.0)|
|UPR41902 Payroll Earnings Deductions (only in Microsoft Dynamics GP 10.0)|
||

> [!NOTE]
> If you copy the UPR40500 file, the posting accounts will be identical to those of the company that you are copying.

| Payroll Extensions (deduction in arrears, payables integration to payroll, overtime rate manager) |
|---|
|ORM_UPR_SETP_OT_DTL|
|ORM_UPR_SETP_OT_HDR|
|UPR40600_OT|
|APR_DIA40100|
|APR_DIA40200|
|APR_UPR40500|
|APR_UPR40900|
|APR_PIP40100|
||

| Advanced Payroll |
|---|
|APR40600|
|APR41100|
|APR41101|
|APR41501|
|APR41601|
|APR_APR70901|
|APR_APR70900|
|APR_UPR40500|
|APR_APR40101|
|APR_APR40100|
||

| Canadian Payroll |
|---|
|CPY10010 CDN Payroll Employer Master|
|CPY10020 CDN Payroll Department Master|
|CPY10030 CDN Payroll Employee Job Titles|
|CPY10050 CDN Payroll Employee Class|
|CPY10051 CDN Payroll Class Attached Pay codes File|
|CPY10060 CDN Payroll Pay code Master|
|CPY10061 CDN Payroll Pay code Attached Pay codes|
|CPY10062 CDN Payroll Income Attached Pay Codes|
|CPY10063 CDN Payroll Rate Table Codes|
|CPY10064 CDN Payroll Rate Tables|
|CPY10070 CDN Payroll WCB Master|
|CPY10075 CDN Payroll WCB Administration|
|CPY10080 CDN Payroll User Paid By|
|CPY10081 CDN Payroll User Drop Down Strings|
|CPY10082 CDN Payroll Reporting Codes|
|CPY10170 CDN Payroll Employee Unions|
|CPY10171 CDN Payroll UnionAttached Pay codes|
|CPY20200 CDN Payroll Job Master|
|CPY20201 CDN Payroll Phase Master|
|CPY20700 P_Security_Group_MSTR|
|CPY20705 P_Security_Group_Detail|
|CPY20710 P_Security_User_MSTR|
|If the following information is the same, you can also copy these files:</br>CPY20100 CDN Payroll Control Master</br></br>CPY20110 CDN Payroll CSB Setup Information</br></br>CPY20111 CDN Payroll CSB Pay codes|
||

| Human Resource |
|---|
|BE020230 HR_Benefit_SETP|
|BE021030 BEN2_FMLA_Line|
|BE031000 BEN_FMLA_INFO|
|HR2Ben21 HR_Benefit_Tiers_SETP|
|HR2Ben11 HR_Benefit_Fund|
|HR2Ben12 HR_Benefit_MDVE_Table|
|HR2Ben13 HR_Benefit_Life_Premiums|
|HR2Ben14 HR_Venefit_MDVE_Types|
|HR2Div02 HR_Division2|
|HR2Tra01 HR_Train_Course|
|HR2Tra03 HR_Train_Class|
|HRCom022 HR_Company2_extra|
|HRDep022 HR_Department2_Extra|
|HRDiv022 HR_Division2_Extra|
|HRPBen05 HRP_BEN_FMLA_Set12Month|
|HRPro022 HR_Property|
|HRPppc01 HRP_Position_Pay_Code|
|HRsax012 HR_Salary_Matrix|
|HRsax022 HR_Salary_Matrix_Table|
|HRsax042 HR_Salary_Matrix_Col|
|HRsax032 HR Salary Matrix rows|
|HRtra042 HR_Train_Class_Skills|
|HRtrpc02 HR_Train_Position_Course_Class|
|HRtrps01 HR_Train_Position_Course|
|RV010221 HR_Review_LINE_V2|
|RV020221 HR_Review_Setup_LINE_V2|
|RV030221 HR_Review_Words_Setup_LINE|
|SK010230 HR_Skills_Line|
|TAAC0130 TA_SETP_Accrual_Type|
|TAPY0130 TA_Payroll_Link</br></br> The TAPY0130 TA_Payroll_Link table was removed in Microsoft Dynamics GP 9.0 and in Microsoft Dynamics GP 10.0.|
|TAST0130 TA_Setup|
|TAST0230 TA_Attendance_reason|
|TAST0330 TA_Attendance_Types|
|TAST0532 TA_Pay_Period_accrual_LINE|
|TATM0130 TA_SETP_Types|
||

| Advanced Human Resource |
|---|
|APR_BLM41500|
|APR_BLM41501|
|APR_BLM41600|
|APR_BLM41601|
|APR_BLM41400|
|APR_BLM41401|
|APR_BLM41100|
|APR_BLM41101|
|APR_BLM41300|
|APR_BLM41301|
|APR_BLM41200|
|APR_BLM41201|
|APR_BLM42100|
|APR_BLM42101|
|APR_BLM42200|
|APR_BLM42201|
|APR_BLM43100|
|APR_BLM43200|
|APR_BLM43201|
|APR_BLM43300|
|APR_BLM43301|
|APR_APR40500|
|EHW40100|
|EHW40201|
|EHW40200|
|EHW40300|
|EHW40400|
|EHW40501|
|EHW40500|
|CLM40100|
|CLM40300|
|CLM40700|
|CLM40700|
|CLM40701|
|CLM40600|
|CLM40500|
|CLM40400|
|CLM40200|
||

| PTO Manager |
|---|
|PTO40100|
|PTO40101|
|PTO40200|
|PTO40201|
||

| Analytical Accounting |
|---|
|AAG00400 aaTrxDimMstr (dimensions)|
|AAG00401 aaTrxDimCodeSetp (codes)|
|AAG00402 aaTrxDimCodeNumSetp|
|AAG00403 aaTrxDimCodeBoolSetp|
|AAG00404 aaTrxDimCodeDateSetp|
|AAG00405 aaTrxDimRelation|
|AAG00406 aaTrxDimCodeRelation|
|AAG00407 AA Trx Dim Adjustment Option|
|AAG00500 aaDateSetup</br>AAG00600 aaTreeMstr|
|AAG00601 aaTreeNodeMstr|
|AAG00602 aaTreeNodeLink|
|AAG00603 aaTreeNodeUserWork|
|AAG00605 aaTreeMstrDupe|
|AAG00700 aaOptionSetp|
|AAG00200 aaAccountMstr|
|AAG00201 aaAccountClassMstr|
|AAG00202 aaAccountClassDim|
|AAG00900 AA Budget Tree Master|
|AAG00901 AA Budget Tree Trx Dim Master|
|AAG00902 AA Budget Tree Trx Dim Code Master|
|AAG00903 AA Budget Master|
|AAG00904 AA Budget Tree Balance|
|AAG00905 AA Budget Tree Account Balance|
|AAG00906 AA Budget Tree View Work|
|AAG01000 AA UDF Setup option|
|AAG01001 AA UDF Trx Dim Setup|
|AAG01002 AA Trx Dim CodeUDF Maintenance|
||

> [!NOTE]
> If you are copying Analytical Accounting (AA) setup tables from company A that has AA activated to company B that does not yet have AA activated, you must first install and activate AA in company B. After AA is activated in company B, copy these AA setup tables from company A. Then, use the script in Method 1 in Knowledge Base (KB) article 897280 to update the next available values that are stored in table AAG00102 in the Dynamics database for the AA setup tables. This script will prevent you from receiving error messages of primary key issues.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[897280](https://support.microsoft.com/help/897280) Error message when you try to post Analytical Accounting transactions in Microsoft Dynamics GP: "Cannot insert duplicate key in object"  

## Make a database backup

To make a full/complete database backup in SQL Server 2000, follow these steps:

1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.
2. Expand **Microsoft SQL Servers**, and then expand **SQL Server Group**.
3. Expand the name of the server that is running SQL Server.
4. Expand the **Databases** folder.
5. Right-click the **DYNAMICS** database, point to **All Tasks**, and then click **Backup Database**.
6. In the SQL Server Backup - DYNAMICS window, verify that **Database-complete** is selected.
7. Click **Add**, and then click **File Name**. Locate where you want to store the database backup.
8. Type a name for the backup in the **Filename** field, and then click **OK**. For example, type Dynamics.bak in the **Filename** field.
9. Click **OK** to exit the Destination window.
10. Click **OK** to start the database backup.

    You should receive the following message when the backup process is complete:

    > The backup operation has been completed successfully message.

11. Repeat steps 1 through 10 for each company database.

To make a Full/Complete database backup in SQL Server 2005 or in SQL Server 2008, follow these steps:

1. In the Connect to Server window, open SQL Server Management Studio. To do this, follow these steps:
    1. In the **Server name** box, type the name of the server that is running SQL Server.
    2. In the **Authentication** box, click **SQL Authentication**.
    3. In the **Login** box, type *sa*.
    4. In the **Password** box, type the password for the sa user, and then click **Connect**.
2. Expand the instance of SQL Server.
3. Expand the **Databases** folder.
4. Right-click the **DYNAMICS** database, point to **All Tasks**, and then click **Backup Database**.
5. In the **Back Up Database - DYNAMICS** window, verify that **Full** is selected in **Backup Type**.
6. Click **Add**, and then click **File Name**. Browse to the location where you want to store the database backup.
7. Type a name for the backup in the **Filename** field, and then click **OK**. For example, type *Dynamics.bak* in the **Filename** field.
8. Click **OK** to exit the Destination window.
9. Click **OK** to start the database backup.

    You should receive the following message when the backup process is complete:

    > The backup of database 'DYNAMICS' completed successfully.

10. Repeat steps 1 through 10 for each company database.

## Additional tables in Microsoft Business Solutions - Great Plains 8.0

The following tables were added in Microsoft Business Solutions - Great Plains 8.0:

| Sales |
|---|
|SOP00300 Sales Customer Item Substitute (Inventory Setup would need to be copied)|
|SOP10111 Sales Picking Instruction Master|
|SOP40101 Sales Workflow Setup|
||

| Inventory |
|---|
|IV00113 Item Price List Details|
|IV00114 Inactive Items|
|IV00115 Multiple Manufacture Items Master|
||

The following table was added in Microsoft Dynamics GP 9.0:

|IV00117 Item Site Bin Priorities|
|---|
||

> [!NOTE]
> The following three tools are also available:
>
> - The General Ledger Master Records Trigger tool
> - The Receivables Management Master Records Trigger tool
> - The Payables Management Master Records Trigger tool

These tools will let you add an account, a vendor, or a customer in a master database and then make the change to one database or to all databases. Each tool is sold separately or can be purchased in a bundle of the three tools. For more information, contact Global Support or send an e-mail message to [mbsprofessionalservices@microsoft.com](mailto:mbsprofessionalservices@microsoft.com).

## References

For more information about how to transfer setup information between company databases by using Microsoft SQL 2000 and DTS, see [How to transfer setup information between company databases by using Microsoft SQL Server](https://support.microsoft.com/topic/how-to-transfer-setup-information-between-company-databases-by-using-microsoft-sql-server-ffd3d078-4e49-00d6-d6d9-440b8820606c).

For more information about how to copy Fixed Assets setup files from an existing company to a new company in Great Plains, see [Fixed Assets setup files to copy from an existing company to a new company in Microsoft Dynamics GP](https://support.microsoft.com/topic/fixed-assets-setup-files-to-copy-from-an-existing-company-to-a-new-company-in-microsoft-dynamics-gp-f258ca2a-f17a-d1b8-91cf-0ea90c1c1780).

For more information about how to start over with only Project Setup Information in Great Plains, see [You see unwanted data in Project Accounting after you start over in Microsoft Dynamics G](https://support.microsoft.com/topic/you-see-unwanted-data-in-project-accounting-after-you-start-over-in-microsoft-dynamics-gp-6c5447cc-eb66-04db-c7b6-dcd56c8ca757).
