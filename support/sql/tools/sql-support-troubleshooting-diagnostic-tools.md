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
|Availability Group     |         |         |         |
|Row2     |         |         |         |
|Row3     |         |         |         |
|Row4     |         |         |         |
|Row5     |         |         |         |
|Row6     |         |         |         |
|Row7     |         |         |         |
|Row8     |         |         |         |
|Row9     |         |         |         |
|Row10     |         |         |         |





+-----+-----------+-------------------------+-------------------------+
| Com | Basic     | Tool to gather logs     | Tool to analyze logs    |
| mon | logs to   |                         |                         |
| Sc  | collect   |                         |                         |
| ena |           |                         |                         |
| rio |           |                         |                         |
+-----+-----------+-------------------------+-------------------------+
| Ava | Cluster   | Preferred: **SQL        | Preferred: **AGDiag**   |
| ila | logs      | LogScout**              |                         |
| bil |           |                         | Scenarios to use -\>    |
| ity | Event     | Use data collection     | Analyze failover,       |
| Gr  | logs      | scenario named          | failures                |
| oup |           | \"alwayson\"            |                         |
|     | System    |                         | [[https://githu         |
|     | Monitor   | [[htt                   | b.com/microsoft/agdiag/ |
|     | (Pe       | ps://github.com/microso | wiki/Getting-Started]{. |
|     | rformance | ft/sql_logscout#scenari | underline}](https://git |
|     | monitor   | os]{.underline}](https: | hub.com/microsoft/agdia |
|     | logs)     | //github.com/microsoft/ | g/wiki/Getting-Started) |
|     |           | sql_logscout#scenarios) |                         |
|     | SQL       |                         |                         |
|     | Server    |                         |                         |
|     | error     |                         | Alternative: **SQL      |
|     | logs      | Alternative:            | Nexus**                 |
|     |           | **PSSDIAG**             |                         |
|     | SQLDIAG   |                         | Scenarios to use -\>    |
|     | XEL files | Use custom diagnostic   | Performance, Latency,   |
|     |           | \"Always On Basic       | Health, Best practices  |
|     | AlwaysOn  | Info\"                  |                         |
|     | Health    |                         | [[http                  |
|     | session   | [[https://github.com    | s://github.com/microsof |
|     | XEL files | /microsoft/DiagManager/ | t/SqlNexus/wiki/How-to- |
|     |           | wiki/Create-a-PSSDiag-P | use-SQL-Nexus]{.underli |
|     | System    | ackage]{.underline}](ht | ne}](https://github.com |
|     | Health    | tps://github.com/micros | /microsoft/SqlNexus/wik |
|     | session   | oft/DiagManager/wiki/Cr | i/How-to-use-SQL-Nexus) |
|     | XEL files | eate-a-PSSDiag-Package) |                         |
|     |           |                         |                         |
|     | Extended  |                         |                         |
|     | Events    |                         |                         |
|     | for AG    | Alternative: **TSS V2** |                         |
|     | data      |                         |                         |
|     | movement  | Use scenario \"SQL      |                         |
|     |           | Base\"                  |                         |
|     | DMV and   |                         |                         |
|     | Catalog   | [[https://learn.        |                         |
|     | view      | microsoft.com/en-us/tro |                         |
|     | snapshots | ubleshoot/windows-clien |                         |
|     | for AG    | t/windows-troubleshoote |                         |
|     |           | rs/introduction-to-trou |                         |
|     |           | bleshootingscript-tools |                         |
|     |           | et-tssv2]{.underline}]( |                         |
|     |           | https://learn.microsoft |                         |
|     |           | .com/en-us/troubleshoot |                         |
|     |           | /windows-client/windows |                         |
|     |           | -troubleshooters/introd |                         |
|     |           | uction-to-troubleshooti |                         |
|     |           | ngscript-toolset-tssv2) |                         |
|     |           |                         |                         |
|     |           |                         |                         |
+-----+-----------+-------------------------+-------------------------+
| S   | -   Pe    | Preferred: **SQL        | Preferred: **SQL        |
| low | rformance | LogScout**              | Nexus**                 |
| Pe  |           |                         |                         |
| rfo |   Monitor | Use data collection     | Scenarios to use -\>    |
| rma |           | scenario named          | Performance analysis,   |
| nce |  counters | \"GeneralPerf\" or      | Best Practice           |
|     |     for   | \"DetailedPerf\" or     | recommendations,        |
|     |     SQL   | \"LightPerf\"           | Bottleneck Analysis,    |
|     |           |                         | Blocking, Top Queries   |
|     |    Server | [[htt                   |                         |
|     |           | ps://github.com/microso | [[http                  |
|     |  instance | ft/sql_logscout#scenari | s://github.com/microsof |
|     |     and   | os]{.underline}](https: | t/SqlNexus/wiki/How-to- |
|     |           | //github.com/microsoft/ | use-SQL-Nexus]{.underli |
|     |   general | sql_logscout#scenarios) | ne}](https://github.com |
|     |     OS    |                         | /microsoft/SqlNexus/wik |
|     |           |                         | i/How-to-use-SQL-Nexus) |
|     |  counters |                         |                         |
|     |           | Alternative:            |                         |
|     | -         | **PSSDIAG**             |                         |
|     |  Extended |                         | Alternative: **RML      |
|     |     Event | Use scenario \"General  | Utilities**             |
|     |           | Performance\" or        |                         |
|     |  (XEvent) | \"Detailed              | Scenarios to use -\>    |
|     |     trace | Performance\" or        | Query Analysis to       |
|     |           | \"Light Performance\"   | understand Top resource |
|     |  captures |                         | consuming queries       |
|     |     ba    | [[https://github.com    |                         |
|     | tch-level | /microsoft/DiagManager/ | [[https://learn.mic     |
|     |           | wiki/Create-a-PSSDiag-P | rosoft.com/troubleshoot |
|     | starting/ | ackage]{.underline}](ht | /sql/tools/replay-marku |
|     | completed | tps://github.com/micros | p-language-utility]{.un |
|     |           | oft/DiagManager/wiki/Cr | derline}](https://learn |
|     |   events, | eate-a-PSSDiag-Package) | .microsoft.com/troubles |
|     |           |                         | hoot/sql/tools/replay-m |
|     |    errors |                         | arkup-language-utility) |
|     |     and   |                         |                         |
|     |           |                         |                         |
|     | warnings, |                         |                         |
|     |     log   |                         |                         |
|     |     growt |                         |                         |
|     | h/shrink, |                         |                         |
|     |     lock  |                         |                         |
|     |     e     |                         |                         |
|     | scalation |                         |                         |
|     |     and   |                         |                         |
|     |           |                         |                         |
|     |  timeout, |                         |                         |
|     |           |                         |                         |
|     | deadlock, |                         |                         |
|     |     log   |                         |                         |
|     | in/logout |                         |                         |
|     |           |                         |                         |
|     | -   List  |                         |                         |
|     |     of    |                         |                         |
|     |           |                         |                         |
|     |   activel |                         |                         |
|     | y-running |                         |                         |
|     |     SQL   |                         |                         |
|     |           |                         |                         |
|     |    traces |                         |                         |
|     |     and   |                         |                         |
|     |           |                         |                         |
|     |   Xevents |                         |                         |
|     |           |                         |                         |
|     | -         |                         |                         |
|     | Snapshots |                         |                         |
|     |     of    |                         |                         |
|     |     SQL   |                         |                         |
|     |     DMVs  |                         |                         |
|     |     that  |                         |                         |
|     |     track |                         |                         |
|     |     waits |                         |                         |
|     | /blocking |                         |                         |
|     |     and   |                         |                         |
|     |     high  |                         |                         |
|     |     CPU   |                         |                         |
|     |           |                         |                         |
|     |   queries |                         |                         |
|     |           |                         |                         |
|     | -   Query |                         |                         |
|     |     Data  |                         |                         |
|     |     Store |                         |                         |
|     |     info  |                         |                         |
|     |     (if   |                         |                         |
|     |     that  |                         |                         |
|     |     is    |                         |                         |
|     |           |                         |                         |
|     |   active) |                         |                         |
|     |           |                         |                         |
|     | -         |                         |                         |
|     |    Tempdb |                         |                         |
|     |     c     |                         |                         |
|     | ontention |                         |                         |
|     |     info  |                         |                         |
|     |     from  |                         |                         |
|     |     SQL   |                         |                         |
|     |     DM    |                         |                         |
|     | Vs/system |                         |                         |
|     |     views |                         |                         |
|     |           |                         |                         |
|     | -         |                         |                         |
|     |    Linked |                         |                         |
|     |           |                         |                         |
|     |    Server |                         |                         |
|     |           |                         |                         |
|     |  metadata |                         |                         |
|     |     (SQL  |                         |                         |
|     |     DM    |                         |                         |
|     | Vs/system |                         |                         |
|     |           |                         |                         |
|     |    views) |                         |                         |
|     |           |                         |                         |
|     | -         |                         |                         |
|     |   Service |                         |                         |
|     |           |                         |                         |
|     |    Broker |                         |                         |
|     |     conf  |                         |                         |
|     | iguration |                         |                         |
|     |     in    |                         |                         |
|     | formation |                         |                         |
|     |     (SQL  |                         |                         |
|     |     DM    |                         |                         |
|     | Vs/system |                         |                         |
|     |           |                         |                         |
|     |    views) |                         |                         |
|     |           |                         |                         |
|     | >         |                         |                         |
|     | >         |                         |                         |
|     | >         |                         |                         |
+-----+-----------+-------------------------+-------------------------+
| C   | BID       | Preferred: **SQL        | Preferred: **SQL        |
| onn | Tra       | Trace**                 | Network Analyzer**      |
| ect | ce/Driver |                         |                         |
| ion | Traces    | Configure collection    | Scenarios to use -\>    |
|     |           | settings in the INI     | read network packet     |
|     | Network   | file                    | capture files and       |
|     | Trace     |                         | produce a report        |
|     |           | [[https://gith          | highlighting potential  |
|     | Auth      | ub.com/microsoft/CSS_SQ | areas of interest.      |
|     | Trace     | L_Networking_Tools/wiki |                         |
|     |           | /SQLTRACE]{.underline}] | [[https://gi            |
|     | SQL       | (https://github.com/mic | thub.com/microsoft/CSS_ |
|     | Server    | rosoft/CSS_SQL_Networki | SQL_Networking_Tools/wi |
|     | Error     | ng_Tools/wiki/SQLTRACE) | ki/SQLNAUI]{.underline} |
|     | logs      |                         | ](https://github.com/mi |
|     |           |                        | crosoft/CSS_SQL_Network |
|     | Windows   |                         | ing_Tools/wiki/SQLNAUI) |
|     | Event     | Alternative: **SQL      |                         |
|     | logs      | LogScout**              | [[https:                |
|     |           |                         | //github.com/microsoft/ |
|     | Snapshots | Use scenario            | CSS_SQL_Networking_Tool |
|     | of        | \"NetworkTrace\"        | s/wiki/SQLNA]{.underlin |
|     | NETSTAT   |                         | e}](https://github.com/ |
|     | /TASKLIST | [[htt                   | microsoft/CSS_SQL_Netwo |
|     |           | ps://github.com/microso | rking_Tools/wiki/SQLNA) |
|     |           | ft/sql_logscout#scenari |                         |
|     |           | os]{.underline}](https: |                        |
|     |           | //github.com/microsoft/ |                         |
|     |           | sql_logscout#scenarios) | Alternative:            |
|     |           |                         | **SQLCHECK**            |
|     |           |                        |                         |
|     |           |                         | reports on any settings |
|     |           | Alternative:            | that may affect         |
|     |           | **SSPICLIENT**          | connectivity            |
|     |           |                         |                         |
|     |           | Scenario -\> use when   | [[https://gith          |
|     |           | encountering SSPI or    | ub.com/microsoft/CSS_SQ |
|     |           | Kerberos errors and     | L_Networking_Tools/wiki |
|     |           | will log a detailed     | /SQLCHECK]{.underline}] |
|     |           | trace for analysis      | (https://github.com/mic |
|     |           |                         | rosoft/CSS_SQL_Networki |
|     |           | [[https://github.c      | ng_Tools/wiki/SQLCHECK) |
|     |           | om/microsoft/CSS_SQL_Ne |                         |
|     |           | tworking_Tools/wiki/SSP |                        |
|     |           | ICLIENT]{.underline}](h |                         |
|     |           | ttps://github.com/micro | Alternative:            |
|     |           | soft/CSS_SQL_Networking | **SQLBENCH**            |
|     |           | _Tools/wiki/SSPICLIENT) |                         |
|     |           |                         | display timings for     |
|     |           |                         | comparative analysis    |
|     |           |                         |                         |
|     |           |                         | [[https://gith          |
|     |           |                         | ub.com/microsoft/CSS_SQ |
|     |           |                         | L_Networking_Tools/wiki |
|     |           |                         | /SQLBENCH]{.underline}] |
|     |           |                         | (https://github.com/mic |
|     |           |                         | rosoft/CSS_SQL_Networki |
|     |           |                         | ng_Tools/wiki/SQLBENCH) |
|     |           |                         |                         |
|     |           |                         |                        |
|     |           |                         |                         |
|     |           |                         | Alternative: **DBTEST** |
|     |           |                         |                         |
|     |           |                         | record how long it      |
|     |           |                         | takes to connect and    |
|     |           |                         | how long to execute a   |
|     |           |                         | command                 |
|     |           |                         |                         |
|     |           |                         | [[https://              |
|     |           |                         | github.com/microsoft/CS |
|     |           |                         | S_SQL_Networking_Tools/ |
|     |           |                         | wiki/DBTEST]{.underline |
|     |           |                         | }](https://github.com/m |
|     |           |                         | icrosoft/CSS_SQL_Networ |
|     |           |                         | king_Tools/wiki/DBTEST) |
|     |           |                         |                         |
|     |           |                         |                        |
+-----+-----------+-------------------------+-------------------------+
| Re  | SQL       | Preferred: **SQL        | Preferred: **SQL        |
| pli | Server    | LogScout**              | Nexus**                 |
| cat | error     |                         |                         |
| ion | logs      | Use data collection     | Scenarios to use -\>    |
|     |           | scenario named          | Replication reports,    |
|     | Rep       | \"Replication\"         | Performance analysis,   |
|     | lication, |                         | Best Practice           |
|     | CDC, CT   | [[htt                   | recommendations,        |
|     | d         | ps://github.com/microso | Bottleneck Analysis,    |
|     | iagnostic | ft/sql_logscout#scenari | Blocking, Top Queries   |
|     | info (SQL | os]{.underline}](https: |                         |
|     | DM        | //github.com/microsoft/ | [[http                  |
|     | Vs/system | sql_logscout#scenarios) | s://github.com/microsof |
|     | views)    |                         | t/SqlNexus/wiki/How-to- |
|     |           |                        | use-SQL-Nexus]{.underli |
|     |          |                         | ne}](https://github.com |
|     |           | Alternative:            | /microsoft/SqlNexus/wik |
|     |           | **PSSDIAG**             | i/How-to-use-SQL-Nexus) |
|     |           |                         |                         |
|     |           | Use custom diagnostic   |                         |
|     |           | \"Replication\"         |                         |
|     |           |                         |                         |
|     |           | [[https://github.com    |                         |
|     |           | /microsoft/DiagManager/ |                         |
|     |           | wiki/Create-a-PSSDiag-P |                         |
|     |           | ackage]{.underline}](ht |                         |
|     |           | tps://github.com/micros |                         |
|     |           | oft/DiagManager/wiki/Cr |                         |
|     |           | eate-a-PSSDiag-Package) |                         |
+-----+-----------+-------------------------+-------------------------+
| Se  | Setup    | Preferred: **SQL         |                        |
| tup | Bootstrap | LogScout**              |                         |
|     | folder    |                         |                         |
|     | with all  | Use data collection     |                         |
|     | the setup | scenario named          |                         |
|     | logs      | \"Setup\"               |                         |
|     |           |                         |                         |
|     |           | [[htt                   |                         |
|     |           | ps://github.com/microso |                         |
|     |           | ft/sql_logscout#scenari |                         |
|     |           | os]{.underline}](https: |                         |
|     |           | //github.com/microsoft/ |                         |
|     |           | sql_logscout#scenarios) |                         |
|     |           |                         |                         |
|     |           |                        |                         |
|     |           |                         |                         |
|     |           | Alternative:            |                         |
|     |           |                         |                         |
|     |           |                        |                         |
+-----+-----------+-------------------------+-------------------------+
| Bac | Backu     | Preferred: SQL LogScout |                        |
| kup | p/Restore |                         |                         |
| R   | progress  | Use data collection     |                         |
| est | Xevent    | scenario named          |                         |
| ore | (bac      | \"BackupRestore\"       |                         |
|     | kup_resto |                         |                         |
|     | re_progre | [[htt                   |                         |
|     | ss_trace) | ps://github.com/microso |                         |
|     |           | ft/sql_logscout#scenari |                         |
|     | Trace     | os]{.underline}](https: |                         |
|     | flags for | //github.com/microsoft/ |                         |
|     | backup    | sql_logscout#scenarios) |                         |
|     | restore   |                         |                         |
|     | progress  |                        |                         |
|     |           |                         |                         |
|     | SQL VSS   | Alternative:            |                         |
|     | Writer    |                         |                         |
|     | Log (on   |                        |                         |
|     | SQL       |                         |                         |
|     | Server    |                         |                         |
|     | 2019 and  |                         |                         |
|     | later)    |                         |                         |
|     |           |                         |                         |
|     | VSS Admin |                         |                         |
|     | (OS) logs |                         |                         |
|     | for VSS   |                         |                         |
|     | backu     |                         |                         |
|     | p-related |                         |                         |
|     | scenarios |                         |                         |
|     |           |                         |                         |
|     | Pe        |                         |                         |
|     | rformance |                         |                         |
|     | Monitor   |                         |                         |
|     |           |                         |                         |
|     |          |                         |                         |
|     |           |                         |                         |
|     |          |                         |                         |
+-----+-----------+-------------------------+-------------------------+
| Mem |          | Preferred: SQL LogScout |                        |
| ory |           |                         |                         |
| Us  |           | Use data collection     |                         |
| age |           | scenario named          |                         |
| Tro |           | \"Memory\"              |                         |
| ubl |           |                         |                         |
| esh |           | [[htt                   |                         |
| oot |           | ps://github.com/microso |                         |
| ing |           | ft/sql_logscout#scenari |                         |
|     |           | os]{.underline}](https: |                         |
|     |           | //github.com/microsoft/ |                         |
|     |           | sql_logscout#scenarios) |                         |
|     |           |                         |                         |
|     |           |                        |                         |
|     |           |                         |                         |
|     |           | Alternative:            |                         |
|     |           |                         |                         |
|     |           |                        |                         |
|     |           |                         |                         |
|     |           |                        |                         |
+-----+-----------+-------------------------+-------------------------+
| Mem | Manual    | Preferred: SQL LogScout |                        |
| ory | memory    |                         |                         |
| Du  | dumps for | Use data collection     |                         |
| mps | specific  | scenario named          |                         |
|     | t         | \"DumpMemory\"          |                         |
|     | -shooting |                         |                         |
|     | scenarios | [[htt                   |                         |
|     |           | ps://github.com/microso |                         |
|     |           | ft/sql_logscout#scenari |                         |
|     |           | os]{.underline}](https: |                         |
|     |           | //github.com/microsoft/ |                         |
|     |           | sql_logscout#scenarios) |                         |
|     |           |                         |                         |
|     |           |                        |                         |
|     |           |                         |                         |
|     |           | Alternative:            |                         |
|     |           |                         |                         |
|     |           |                        |                         |
+-----+-----------+-------------------------+-------------------------+
