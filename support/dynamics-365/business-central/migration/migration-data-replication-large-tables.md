---
title: Data replication error DelimitedTextIncorrectRowDelimiter for large tables in Business Central cloud migration
description: Provides a resolution for an error that occurs during the data replication process for large tables in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/08/2024
---
# Data replication error DelimitedTextIncorrectRowDelimiter for large tables in Business Central cloud migration

This article provides a resolution for an error that might occur when you run [data replication during cloud migration for large tables](/dynamics365/business-central/dev-itpro/administration/migration-data-replication?tabs=largetable).

## Symptoms

The following error message is displayed in the cloud migration log for the table that failed to be copied. The cloud migration log is a part of page 40063 "Cloud Migration Management", and can be viewed by the administrator who signed in to the Business Central SaaS environment.

> ErrorCode=DelimitedTextIncorrectRowDelimiter,'Type=Microsoft.DataTransfer.Common.Shared.HybridDeliveryException,Message=The specified row delimiter is incorrect. Cannot detect a row after parse 100 MB data.,Source=Microsoft.DataTransfer.Common,'

## Cause

The error message is reported by Azure Blob Storage infrastructure while an Azure Data Factory is executing a replication pipeline. The error message usually occurs for large tables when they're copied from table to table. This error occurs only if the migration source is a SQL Server database, when the whole table is large and a single field contains a large value. For example, images larger than 20 MB stored in the table fields might cause this error.

## Resolution

The only reliable way to migrate tables with large fields is to deploy the source database in Azure SQL and then [set up cloud migration from the Azure SQL database](/dynamics365/business-central/dev-itpro/administration/migration-setup-overview) instead of the on-premises SQL Server.
