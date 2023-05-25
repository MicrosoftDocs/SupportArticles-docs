---
title: SQL Server troubleshooting and diagnostic tools for on-prem and hybrid scenarios
description: This article describes which tools Microsoft technical support uses for troubleshooting SQL Server Hybrid issues
ms.date: 04/11/2023
ms.custom: sap:Other tools
ms.reviewer: 
ms.prod: sql
ms.author: pijocoder
---
# SQL Server troubleshooting and diagnostic tools for on-prem and hybrid scenarios

_Applies to:_ SQL Server 

## Introduction


## Supported platforms


|Common Scenario  |Basic logs to collect  |Tool to gather logs  |Tool to analyze logs  |
|---------        |---------              |---------            |---------             |
|Availability Group     |  • Cluster logs</br> Event logs </br> • System Monitor (Performance monitor logs) </br> • SQL Server error logs </br> • SQLDIAG XEL files </br> • AlwaysOn Health session XEL files </br> • System Health session XEL files </br> • Extended Events for AG data movement </br> • DMV and Catalog view snapshots for AG         | </br>Preferred: **SQL LogScout** </br>Use data collection scenario named "AlwaysOn"</br>https://github.com/microsoft/sql_logscout#scenarios</br></br></br>Alternative: **TSSv2** </br> Use scenario "SQL Base" </br>https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tssv2</br></br>Alternative: **PSSDIAG**</br>Use custom diagnostic "Always On Basic Info"</br>https://github.com/microsoft/DiagManager/wiki/Create-a-PSSDiag-Package|  Preferred: **AGDiag**</br>Scenarios to use -> Analyze failover, failures</br>https://github.com/microsoft/agdiag/wiki/Getting-Started</br></br>Alternative: **SQL Nexus**</br>Scenarios to use -> Performance, Latency, Health, Best practices</br>https://github.com/microsoft/SqlNexus/wiki/How-to-use-SQL-Nexus         |
|Slow Performance     |  </br> • Extended Event (XEvent) trace captures batch-level starting/completed events, errors and warnings, log growth/shrink, lock escalation and timeout, deadlock, login/logout </br> • List of actively-running SQL traces and Xevents </br> • Snapshots of SQL DMVs that track waits/blocking and high CPU queries </br> • Query Data Store info (if that is active) </br> • Tempdb contention info from SQL DMVs/system views </br> • Linked Server metadata (SQL DMVs/system views) </br> • Service Broker configuration information (SQL DMVs/system views)       | Preferred: **SQL LogScout**</br>Use data collection scenario named "GeneralPerf" or "DetailedPerf" or "LightPerf"</br>https://github.com/microsoft/sql_logscout#scenarios</br></br>Alternative: **PSSDIAG**</br>Use scenario "General Performance" or "Detailed Performance" or "Light Performance"</br>https://github.com/microsoft/DiagManager/wiki/Create-a-PSSDiag-Package |  Preferred: **SQL Nexus**</br>Scenarios to use -> Performance analysis, Best Practice recommendations, Bottleneck Analysis, Blocking, Top Queries</br>https://github.com/microsoft/SqlNexus/wiki/How-to-use-SQL-Nexus</br></br>Alternative: **RML Utilities**</br>Scenarios to use -> Query Analysis to understand Top resource consuming queries</br>https://learn.microsoft.com/troubleshoot/sql/tools/replay-markup-language-utility       |
|Connection     | • BID Trace/Driver Traces</br>• Network Trace</br>• Auth Trace</br>• SQL Server Error logs</br>• Windows Event logs</br>Snapshots of NETSTAT and TASKLIST        | Preferred: **SQL Trace**</br>Configure collection settings in the INI file</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE</br></br>Alternative: **SQL LogScout**</br>Use scenario "NetworkTrace"</br>https://github.com/microsoft/sql_logscout#scenarios</br></br>Alternative: **SSPICLIENT**</br>Scenario -> use when encountering SSPI or Kerberos errors and will log a detailed trace for analysis</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SSPICLIENT    |  Preferred: **SQL Network Analyzer**</br>Scenarios to use -> read network packet capture files and produce a report highlighting potential areas of interest.</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA</br></br>Alternative: **SQLCHECK**</br>reports on any settings that may affect connectivity</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK</br></br>Alternative: **SQLBENCH**</br>display timings for comparative analysis</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLBENCH</br></br>Alternative: **DBTEST**</br>record how long it takes to connect and how long to execute a command</br>https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/DBTEST        |
|Replication     |         |         |         |
|Installation     |         |         |         |
|Backup/Restore     |         |         |         |
|Memory Usage Troubleshooting     |         |         |         |
|Memory Dumps     |         |         |         |
