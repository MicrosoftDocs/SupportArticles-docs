---
title: Removing VMM service account from the db_owner role causes login failures for end users
description: This article describes an issue that removing the VMM service account from the db_owner role in the VMM database causes login failures for end users.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Removing VMM service account from the db_owner role triggers login failures for end users

This article describes an issue that removing the Virtual Machine Manager (VMM) service account from the db_owner role in the VMM database causes login failures for end users.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3087868

## Summary

System Center 2012 Virtual Machine Manager setup creates a login for the VMM service account and adds it to db_owner role in the VMM database. Membership in the db_owner role is required for the VMM service account. Removing the account from the db_owner role triggers login failures for end users.

Assigning any combination of roles with lesser permissions and individual permissions instead of db_owner for the VMM service account isn't supported.

## More information

When a user connects to VMM through the console or a command shell, the VMM service dynamically adds the user to the VMM database. When the user disconnects, the VMM service automatically removes the user from the VMM database.

As a connected user performs actions, the VMM service runs **EXECUTE AS** statements to run database stored procedures on the user's behalf. For it to work, the VMM service account must have the IMPERSONATE permission on the user. Non-dbo users don't have this permission.

You can't work around this limitation by explicitly granting the IMPERSONATE permission to a non-dbo service account because you can grant IMPERSONATE only on an existing principal. Because the VMM service dynamically adds and removes database users, you can't grant IMPERSONATE permissions on them ahead of time. The user must exist at the time you grant permissions.

The SQL Server language reference specifically documents the requirement that a principal must exist when the IMPERSONATE permission is granted to the principal. For more information, see [Specifying a User or Login Name](/sql/t-sql/statements/execute-as-transact-sql#_user).
