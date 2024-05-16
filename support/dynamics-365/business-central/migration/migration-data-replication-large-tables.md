---
title: Data replication error DelimitedTextIncorrectRowDelimiter for large tables
description: Provides a resolution for an error that occurs during the data replication process for large tables in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/16/2024
---
# Data replication error "DelimitedTextIncorrectRowDelimiter" for large tables in Business Central cloud migration

This article provides a resolution for an error that might occur when you run [data replication](/dynamics365/business-central/dev-itpro/administration/migration-data-replication?tabs=largetable) for large tables during cloud migration.

## Symptoms

The following error message is displayed in the cloud migration log for the table that failed to be copied. The cloud migration log is a part of page 40063, [Cloud Migration Management](/dynamics365/business-central/dev-itpro/administration/migration-manage#cloud-migration-management-page), and can be viewed by the administrator signed in to the Business Central SaaS environment.

> ErrorCode=DelimitedTextIncorrectRowDelimiter,'Type=Microsoft.DataTransfer.Common.Shared.HybridDeliveryException,Message=The specified row delimiter is incorrect. Cannot detect a row after parse 100 MB data.,Source=Microsoft.DataTransfer.Common,'

## Cause

The error message is reported by the Azure Blob Storage infrastructure when an Azure Data Factory executes a replication pipeline. The error message usually occurs for large tables when they're copied from one table to another. This error occurs only when the migration source is a SQL Server database, the whole table is large, and a single field contains a large value. For example, images larger than 20 MB stored in the table fields might cause this error.

## Resolution

The only reliable way to migrate tables with large fields is to deploy the source database in Azure SQL and then [set up cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-setup-overview) from the Azure SQL database instead of the on-premises SQL Server.
