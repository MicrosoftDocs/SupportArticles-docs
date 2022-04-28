---
title: Troubleshoot slow query performance in the SSIS or ETL jobs
description: This article helps you resolve issues that occur because of Slow query performance from SSIS/ETL jobs.
ms.date: 04/27/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.author: v-jayaramanp
author:  
---

# Troubleshoot slow query performance in SSIS or ETL jobs

## Symptoms

You may encounter some performance issues from the SSIS or ETL jobs, which are normal. When such jobs fail, the failure is caused by complex joins and huge DML queries. These jobs may take a long time to complete.

Before you start troubleshooting such issues, consider the following questions:

- Did you check to narrow down which SQL statement in the Batch, ETL, or Bulk Data Processing job is slow?
- Did you already enable some performance monitor tool (Microsoft or 3rd party) to monitor the session status in SQL Server of the Batch, ETL, or Bulk Data Processing job?
- When did the issue begin? Before that, is there any change on the data volume? on Batch/ETL/Bulk Data Processing job t-sql statement?
- SQL Server or OS patch or upgrade? Server Hardware change/migration?
