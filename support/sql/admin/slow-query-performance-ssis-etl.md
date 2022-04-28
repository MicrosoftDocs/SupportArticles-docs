---
title: Slow query performance from SSIS/ETL jobs
description: This article helps you resolve issues that occur because of Slow query performance from SSIS/ETL jobs.
ms.date: 04/27/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.author: v-jayaramanp
author:  
---

# Slow query performance from SSIS/ETL jobs

## Symptoms

You may encounter some performance issues from the SSIS/ETL jobs, which are normal.  treat asuch jobs as a normal application, but due to the feature of those jobs, they are usually consist of complex joins, huge DML queries. And may take a long time to complete even in good state. 