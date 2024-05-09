---
title: Missing or denied EXECUTE or SELECT permission error
description: Provides a resolution for the missing permission issue or the EXECUTE (or SELECT) permission was denined error in Business Central cloud migration.
ms.author: jswymer
ms.reviewer: jswymer
ms.date: 05/09/2024
---
# "EXECUTE (or SELECT) permission was denied on the object" error

This article solves permission-related errors that might occur when running the **Cloud Migration Setup** assisted setup guide in Business Central, which is part the data migration process from on-premises to Business Central online. [Learn more about cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup).

## Symptoms

When you run the **Cloud Migration Setup** assisted setup guide in Business Central, you get one of the following error messages:

> The EXECUTE (or SELECT) permission was denied on the object.

> User does not have permission to perform this action.

## Cause

The SQL login account used by [self-hosted Integration Runtime](/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory) to access on-premises database doesn't have the required SQL roles.

## Resolution

Make sure that the SQL user that's specified in the self-hosted Integration Runtime connection string has the following roles on the on-premises database:

- [sysadmin server-level role](/sql/relational-databases/security/authentication-access/server-level-roles?view=sql-server-ver16#fixed-server-level-roles)
- [db_owner database role](/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16#fixed-database-roles)
