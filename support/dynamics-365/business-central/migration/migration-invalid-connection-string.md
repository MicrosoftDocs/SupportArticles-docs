---
title: Invalid database connection string provided error
description: Provides a resolution for the Invalid database connection string error in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/20/2024
ms.custom: sap:Migration\NAV and BC On-premise
---
# "Invalid database connection string provided" error in Business Central cloud migration

This article solves the "Invalid database connection string provided" error that occurs in [Business Central cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-manage).

## Symptoms

You receive the following error message during the Business Central cloud migration.

> Invalid database connection string provided

This issue often appears together with the "Keyword not supported" or "Value cannot be null" error.

## Cause

An incorrect SQL connection string was configured in the [Cloud Migration Setup assisted setup guide](/dynamics365/business-central/dev-itpro/administration/migration-setup).

## Resolution

Run the **Cloud Migration Setup** guide again and verify the connection string is correct.

For more information, see [Define the SQL connection](/dynamics365/business-central/dev-itpro/administration/migration-setup#define-sql-database-connection-and-integration-runtime).
