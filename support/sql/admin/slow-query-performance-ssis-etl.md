---
title: Troubleshoot slow query performance in the SSIS or ETL jobs
description: This article helps you resolve issues that occur because of Slow query performance from SSIS/ETL jobs.
ms.date: 04/27/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: yuej
ms.author: v-jayaramanp
---

# Troubleshoot slow query performance in SSIS or ETL jobs

## Symptoms

You may encounter some performance issues from the SQL Server Integration Services (SSIS) or Extract, Transform and Load (ETL) jobs, which are treated as normal. When jobs fail, the failure could be caused by complex joins and huge DML queries. These jobs may take a long time to complete.

Before you start troubleshooting such issues, consider the following questions:

- Did you check which SQL statement in the Batch, ETL, or Bulk Data Processing job is slow?
- Did you already enable some performance monitor tool (Microsoft or 3rd party) to monitor the session status in SQL Server of the Batch, ETL, or Bulk Data Processing job?
- When did the issue begin? Before that, is there any change on the data volume? on Batch/ETL/Bulk Data Processing job t-sql statement?
- SQL Server or OS patch or upgrade? Server Hardware change/migration?

For example, the SSIS job may contain lots of data flow tasks, it may try to download some source file from the FTP server, and then insert the data into SQL. You may need to use some methods to identify where the jobs are stuck.
Sys.sysprocesses, sys.dm_exec_sql_text to find out if there were active SSIS related query, program name should be like:
