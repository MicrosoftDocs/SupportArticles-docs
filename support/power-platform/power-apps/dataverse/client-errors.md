---
title: Troubleshoot Dataverse client errors
description: Provides resolutions for the common client errors that occur when using Dataverse.
ms.date: 11/02/2023
author: hakhemic
ms.author: hakhemic
ms.reviewer: jdaly
manager: tasousa
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

This article describes common client errors you might encounter when using Dataverse and how you can avoid them. For client errors specific to the Web API, see [Troubleshoot Dataverse Web API client errors](web-api-client-errors.md)

## Error: "Principal user [...], is missing ____ privilege [...] on OTC=____ for entity '____'"

This authorization error is due to missing privileges. Consider adding the missing privilege to one of the principal (user/team) roles. [Learn how privilege checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#privilege-check).

## Error: "Principal with id <guid> does not have CreateAccess right(s) for record with id <guid> of entity ____"

This authorization error indicates that a privilege check passed, but the subsequent access check failed. [Learn how access checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#access-check).

## Error: "Cannot insert duplicate key"

This SQL error occurs when a request violates a key constraint in the database. Make sure the records in your payload follow any existing key constraints. For example, a `CreateMultiple` request where one of the records in the payload uses a primary key value that is already used by an existing record would violate a key constraint and cause this error.

## Error: "Contact With Ids = <guid> Do Not Exist"

This error occurs when attempting to update records that don't exist, likely because a record identifier in the payload has no counterpart in the database. Make sure the key values identifying the records in your payload match the key values of existing records.

## Error: "CrmCheckPrivilege failed. Returned hr = -2147220839 on UserId: <guid> and Privilege: ____"

This authorization error is due to a failing privilege check. [Learn how privilege checks are used to determine access to a record](/power-platform/admin/how-record-access-determined#privilege-check).
