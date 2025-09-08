---
title: Troubleshoot Dataverse client errors
description: Provides resolutions for common client errors that occur in Microsoft Dataverse.
ms.date: 04/17/2025
author: divkamath
ms.author: dikamath
ms.reviewer: jdaly
manager: tasousa
ms.custom: sap:User permissions\User unable to perform operations
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - hakhemic
  - JimDaly
---
# Troubleshoot Dataverse client errors

This article describes common client errors you might encounter when using Microsoft Dataverse and how to avoid them. For Web API-specific client errors, see [Troubleshoot Dataverse Web API client errors](~/power-platform/dataverse/dataverse-web-api-and-sdk/web-api-client-errors.md).

## Error: "Principal user is missing privilege on OTC for entity"

> Error Code: -2147220960

This authorization error is caused by missing privileges. Consider adding the missing privileges to one of the principal (user/team) roles. [Learn how privilege checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#privilege-check).

## Error: "Principal with ID \<guid> does not have CreateAccess right(s) for record with ID \<guid> of entity"

> Error Code: -2147187962

This authorization error indicates that a privilege check passed, but the subsequent access check failed. [Learn how access checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#access-check).

## Error: "Cannot insert duplicate key"

> Error Code: -2147220937

This SQL error occurs when a request violates a key constraint in the database. Make sure the records in your payload follow any existing key constraints. For example, a `CreateMultiple` request where one of the records in the payload uses a primary key value that is already used by an existing record will violate a key constraint and cause this error.

## Error: "Contact With IDs = \<guid> Do Not Exist"

> Error Code: -2147220969

This error occurs when trying to update records that don't exist. It's likely because a record identifier in the payload has no counterpart in the database. Make sure the key values identifying the records in your payload match the key values of existing records.

## Error: "CrmCheckPrivilege failed. Returned hr = -2147220839 on UserId: \<guid> and Privilege"

> Error Code: -2147220839

This authorization error is caused by a failed privilege check. [Learn how privilege checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#privilege-check).
