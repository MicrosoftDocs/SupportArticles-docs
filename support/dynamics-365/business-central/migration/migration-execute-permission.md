---
title: Missing or denied EXECUTE or SELECT permission error
description: Provides a resolution for the missing permission issue or the EXECUTE (or SELECT) permission was denied error in Business Central cloud migration.
ms.author: jswymer
ms.reviewer: jswymer
ms.date: 05/20/2024
ms.custom: sap:Migration\NAV and BC On-premise
---
# "EXECUTE (or SELECT) permission was denied on the object" error in Business Central cloud migration

This article solves permission-related errors that might occur when running the [Cloud Migration Setup assisted setup guide](/dynamics365/business-central/dev-itpro/administration/migration-setup) in Business Central, which is part of the data migration process from on-premises to Business Central online.

## Symptoms

When you run the **Cloud Migration Setup** assisted setup guide in Business Central, you receive one of the following error messages:

> - The EXECUTE (or SELECT) permission was denied on the object.

> - User does not have permission to perform this action.

## Cause

The SQL login account used by the [self-hosted integration runtime](/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory) to access the on-premises database doesn't have the required SQL roles.

## Resolution

Make sure that the SQL user that's specified in the self-hosted integration runtime connection string has the following roles on the on-premises database:

- [sysadmin server-level role](/sql/relational-databases/security/authentication-access/server-level-roles#fixed-server-level-roles)
- [db_owner database role](/sql/relational-databases/security/authentication-access/database-level-roles#fixed-database-roles)
