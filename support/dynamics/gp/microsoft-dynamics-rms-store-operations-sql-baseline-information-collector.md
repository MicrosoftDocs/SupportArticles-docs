---
title: Microsoft Dynamics RMS Store Operations SQL Baseline Information Collector
description: Describes the information that is collected from a computer when you run the Microsoft Dynamics Retail Management System (RMS) Store Operations SQL Baseline Information Collector for versions of Windows older than Windows 7 and Windows Server 2008.
ms.reviewer: tberger
ms.date: 03/31/2021
---
# [SDP 2][9EDB5129-098B-4784-9116-A0F5BEFE4903] Microsoft Dynamics RMS Store Operations SQL Baseline Information Collector

The Microsoft Dynamics Retail Management System (RMS) Store Operations SQL Baseline Information Collector collects information that is used in troubleshooting Store Operations database issues. This article describes the information that is collected from a computer when you run the Microsoft Dynamics RMS Store Operations SQL Baseline Information Collector.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2460993

## Information that is collected

Number of stores

|Description|File name|
|---|---|
|Count the number of stores in the database|Store.csv|
  
Accounting information

|Description|File name|
|---|---|
|Collection of accounting data that is stored in the Accounting table|Accounting.csv|
  
Configuration

|Description|File name|
|---|---|
|Collection of store-configuration information from the database|Configuration.csv|
  
Items

|Description|File name|
|---|---|
|Collection of items in the database|Items.csv|
  
Duplicate customers

|Description|File name|
|---|---|
|Collection of duplicate customers in the database|Duplicate Customers.csv|
  
Duplicate items

|Description|File name|
|---|---|
|Collection of duplicate items in the database|Duplicate Items.csv|
  
Duplicate batches

|Description|File name|
|---|---|
|Collection of duplicate batches in the database|Duplicate Batches.csv|
  
DB schema

|Description|File name|
|---|---|
|Collection of the database schema|DB Schema.csv|
  
DB triggers

|Description|File name|
|---|---|
|Collection of all the database triggers|DB Triggers.csv|
  
## More information

- We recommend that you run the diagnostic from the computer that is experiencing the problem or from the computer for which you want to represent the environment for your question.
- The diagnostic may be run from multiple computers if you believe that they are involved with the issue and if you want to send additional information that may help resolve the issue. Each computer on which the diagnostic is run will provide more information for the support professional. It is helpful to run the diagnostic against both the client computer and the server to provide complete information.
- We recommend that you run the diagnostic by using credentials sufficient to query the instance of SQL Server to let more-detailed version and setup information be collected. If you do not want to collect information from the SQL Server environment, select **Cancel** when you are prompted for SQL Server connection information. Data from the local computer will still be collected.
- Currently, the troubleshooter reads database values from the current Store Operations database within the Microsoft Dynamics RMS Store Operations installation to determine whether the data within the tables is correct or needs correction.
- This information is collected only if the diagnostic is run on one of the following operating systems:
  - Windows Vista
  - Windows XP
  - Windows Server 2003

## References

For more information about the Microsoft Support Diagnostic Tool (MSDT), see [Frequently asked questions about the Microsoft Support Diagnostic Tool](../../sql/general/answers-questions-msdt.md).
