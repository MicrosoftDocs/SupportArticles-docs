---
title: Microsoft Dynamics RMS Diagnostic
description: Describes the information that is collected by the Microsoft Dynamics RMS diagnostic.
ms.reviewer: 
ms.date: 03/31/2021
---
# [SDP 3][cae41a93-53b6-455a-a5b2-2140b3e8a7c6] Microsoft Dynamics RMS Diagnostic

The Microsoft Dynamics RMS Diagnostic analyzes and collects information about the Microsoft Dynamics RMS system. This article describes the information that is collected by the Microsoft Dynamics RMS Diagnostic.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2749474

## Information that is collected

### Operating system

| Description| File name |
|---|---|
|Machine Name|ResultReport.xml|
|OS Name|ResultReport.xml|
|Build|ResultReport.xml|
|Time Zone/Offset|ResultReport.xml|
|Last Reboot/Uptime|ResultReport.xml|
|AntiMalware|ResultReport.xml|
|User Account Control|ResultReport.xml|
|UserName|ResultReport.xml|
  
### Computer system

| Description| File name |
|---|---|
|Computer Model|ResultReport.xml|
|Processor(s)|ResultReport.xml|
|Machine|SERVERDATABASE_WhoAmI.txt|
  
### RMS Store Operations configuration information

| Description | File name |
|---|---|
|AccountDefaultID|ResultReport.xml|
|AccountMonthlyClosingDay|ResultReport.xml|
|CostUpdateMethod|ResultReport.xml|
|HQCreationDate|ResultReport.xml|
|LastUpdated|ResultReport.xml|
|LayawayDeposit|ResultReport.xml|
|LimitItem|ResultReport.xml|
|LimitPurchase|ResultReport.xml|
|LimitTimeFrame|ResultReport.xml|
|LimitType|ResultReport.xml|
|SerialNumber|ResultReport.xml|
|StoreID|ResultReport.xml|
|SyncID|ResultReport.xml|
|TaxSystem|ResultReport.xml|
|VATRegistrationNumber|ResultReport.xml|
|ID|ResultReport.xml|
|StoreName|ResultReport.xml|
|StoreAddress1|ResultReport.xml|
|StoreCity|ResultReport.xml|
|StoreZip|ResultReport.xml|
|StorePhone|ResultReport.xml|
|QuoteExpirationDays|ResultReport.xml|
|BackOrderExpirationDays|ResultReport.xml|
|LayawayExpirationDays|ResultReport.xml|
|WorkOrderDueDays|ResultReport.xml|
|LayawayFee|ResultReport.xml|
|ReceiptCount|ResultReport.xml|
|ReceiptCount2|ResultReport.xml|
|EDCTimeout|ResultReport.xml|
|WorkOrderDeposit|ResultReport.xml|
|PriceCalculationRule|ResultReport.xml|
|Options|ResultReport.xml|
|TaxBasis|ResultReport.xml|
|TaxField|ResultReport.xml|
|ItemTaxID|ResultReport.xml|
|DBTimeStamp|ResultReport.xml|
|DefaultTenderID|ResultReport.xml|
|Options2|ResultReport.xml|
|VoucherExpirationDays|ResultReport.xml|
|EnableGlobalCustomers|ResultReport.xml|
|DefaultGlobalCustomer|ResultReport.xml|
|Options3|ResultReport.xml|
|Options4|ResultReport.xml|
|NextAutoAccountNumber|ResultReport.xml|
|AccountingInterface|ResultReport.xml|
  
### SQL configuration

| Description| File name |
|---|---|
|SQLServerName|ResultReport.xml|
|SQLDB|ResultReport.xml|
  
### RMS column information

| Description| File name |
|---|---|
|RMS Column Information (.csv):|<**ComputerName**>_RMS_Column_Information.csv|
|RMS Column Information (.txt):|<**ComputerName**>_RMS_Column_Information.txt|
  
### RMS miscellaneous system configuration files

| Description | File name |
|---|---|
|Text files (.txt)|<**ComputerName**>_HookCount.txt|
|Text files (.txt)|<**ComputerName**>_hotfixes.txt|
|Text files (.txt)|<**ComputerName**>_HQClientTimeout.txt|
|Text files (.txt)|<**ComputerName**>_HQManagerPath.txt|
|Text files (.txt)|<**ComputerName**>_HQManagerTemplates.txt|
|Text files (.txt)|<**ComputerName**>_ipconfig.txt|
|Text files (.txt)|<**ComputerName**>_MSFTSQLSVR.txt|
|Text files (.txt)|<**ComputerName**>_MSSQLSERVER.txt|
|Text files (.txt)|<**ComputerName**>_OleforRetail.txt|
|Text files (.txt)|<**ComputerName**>_RMS_Column_Information.txt|
|Text files (.txt)|<**ComputerName**>_RMS_Configuration.txt|
|Text files (.txt)|<**ComputerName**>_RMS_Items.txt|
|Text files (.txt)|<**ComputerName**>_RMS_Sql_Triggers.txt|
|Text files (.txt)|<**ComputerName**>_RMS_Store.txt|
|Text files (.txt)|<**ComputerName**>_RMS_VersionHistory.txt|
|Text files (.txt)|<**ComputerName**>_software_installed.txt|
|Text files (.txt)|<**ComputerName**>_SOManagerPath.txt|
|Text files (.txt)|<**ComputerName**>_SOManagerTemplates.txt|
|Text files (.txt)|<**ComputerName**>_sqlProtocols.txt|
|Text files (.txt)|<**ComputerName**>_SqlServices.txt|
|Text files (.txt)|<**ComputerName**>_SQLVersionInfo.txt|
|Text files (.txt)|<**ComputerName**>_systeminfo.txt|
|Text files (.txt)|<**ComputerName**>_WhoAmI.txt|
  
### RMS SQL triggers

| Description| File name |
|---|---|
|RMS Sql Triggers (.csv)|<**ComputerName**>_RMS_Sql_Triggers.csv|
|RMS Sql Triggers (.txt)|<**ComputerName**>_RMS_Sql_Triggers.txt|
  
### RMS Store information

| Description| File name |
|---|---|
|RMS Store Information (.csv)|<**ComputerName**>_RMS_Store.csv|
|RMS Store Information (.txt)|<**ComputerName**>_RMS_Store.txt|
  
### Files of RMS Store Operations configuration

| Description| File name |
|---|---|
|RMS Store Operations Configuration Information (.csv)|<**ComputerName**>_RMS_Configuration.csv|
|RMS Store Operations Configuration Information (.txt)|<**ComputerName**>_RMS_Configuration.txt|
  
### RMS version history

| Description| File name |
|---|---|
|RMS Version History (.csv)|<**ComputerName**>_RMS_VersionHistory.csv|
|RMS Version History (.txt)|<**ComputerName**>_RMS_VersionHistory.txt|
  
### Microsoft SQL Server version

| Description| File name |
|---|---|
|Sql Server Version (.csv)|<**ComputerName**>_SQLVersioninfo.csv|
|Sql Server Version (.txt)|<**ComputerName**>_SQLVersioninfo.txt|
  
### Event log files

| Description| File name |
|---|---|
|Application (.csv) |<**ComputerName**>_evt_Application.csv|
|Application (.evtx) |<**ComputerName**>_evt_Application.evtx|
|Application (.txt) |<**ComputerName**>_evt_Application.txt|
|System (.csv) |<**ComputerName**>_evt_System.csv|
|System (.evtx) |<**ComputerName**>_evt_System.evtx|
|System (.txt) |<**ComputerName**>_evt_System.txt|
  
### Rule detection summary

| RuleID| Title| Description |
|---|---|---|
|RC_RMS_Duplicate_Batches|RMS Duplicate Batches Found|This diagnostic tool has found duplicate Batches within the current configuration.|
|RC_RMS_Duplicate_Customers|RMS Duplicate Customers Found|This diagnostic tool has found duplicate customers within the current configuration.|
|RC_RMS_Duplicate_Items|RMS Duplicate Items Found|This diagnostic tool has found duplicate Items within the current configuration.|
  
## Additional Information

In addition to the files that are collected and listed here, this troubleshooter can detect one or more of the following situations:

- You must be in the administrators group on the computer from where the diagnostic is run.
