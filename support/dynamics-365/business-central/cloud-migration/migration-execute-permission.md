---
title: "The EXECUTE (or SELECT) permission was denied on the object"
description: Troubleshooting article for missing or denied EXECUTE (or SELECT) permission issues in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/18/2024
---

# "The EXECUTE (or SELECT) permission was denied on the object"

This article explains permission-related errors that might occur when running the **Cloud Migration Setup** assisted setup guide in Business Central, which is part the data migration process from on-premises to Business Central online. [Learn more about cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup).

## Symptom

While running the **Cloud Migration Setup** assisted setup guide, you get one of the follwoing error messages:

- **The EXECUTE (or SELECT) permission was denied on the object**
- **User does not have permission to perform this action**

## Cause

The SQL login account used by self-hosted integration runtime to access on-premises database doesn't have the required SQL roles.

## Resolution

Make sure that SQL user that's specified in the Self-hosted Integration Runtime connection string has the following roles on the on-premises database:

- sysadmin server-level role

  [Learn more about server-level roles](/sql/relational-databases/security/authentication-access/server-level-roles).
  
- db_owner database role

   [Learn more about database-level roles](/sql/relational-databases/security/authentication-access/database-level-roles).
