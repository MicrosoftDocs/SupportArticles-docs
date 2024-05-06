---
title: Data replication issues for large tables in cloud migration
description: Troubleshooting article for data replication process for large tables in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/24/2024
---

# Data replication issues for large tables in cloud migration

This article explains errors that you might encounter when you run data replication during cloud migration for large tables.

## Symptoms

The full error message is:
"ErrorCode=DelimitedTextIncorrectRowDelimiter,'Type=Microsoft.DataTransfer.Common.Shared.HybridDeliveryException,Message=The specified row delimiter is incorrect. Cannot detect a row after parse 100 MB data.,Source=Microsoft.DataTransfer.Common,'".

It's thrown by Azure Blob infrastructure while an Azure Data Factory is executing a replication pipeline, and we have no means to intercept this error and wrap it into something nicer for the user.

## Cause

The error message is displayed in the cloud migration log for the table that failed to be copied. The cloud migration log is a part of page 40063 "Cloud Migration Management", and can be viewed by the admin logged in into the Business Central SaaS environment.

This error usually happens for large tables when they're copied table to table. This error happens only if the migration source is a SQL Server database, when the whole table is large and a single field contains a large value. For example, images larger than 20 MB stored in table fields might cause this error.

## Resolution

The only reliable way to migrate tables with large fields is to deploy the source database in Azure SQL and then set up cloud migration from the Azure SQL database instead of the on-premises SQL Server.