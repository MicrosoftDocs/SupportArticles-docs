---
title: Troubleshoot Dataverse bulk operation errors
description: Provides resolutions for system errors that might occur while using bulk operations with Microsoft Dataverse.
ms.date: 11/09/2023
author: divkamath
ms.author: dikamath
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
# Troubleshoot Dataverse bulk operation errors

This article describes system errors you might encounter when using Microsoft Dataverse [bulk operations](/power-apps/developer/data-platform/bulk-operations) and how to avoid them.

## Error "Sql error: Generic SQL error"

> Error Code: -2147204784  
> Sql ErrorCode: -2146232060  
> Sql Number: 1205  
> Error Message: Generic SQL error. CRM ErrorCode: -2147204784 Sql ErrorCode: -2146232060 Sql Number: 1205

### Resolution

This error occurs when attempting to update the same record concurrently. Make sure you don't attempt concurrent requests on the same record.

## Error "Sql error: SQL timeout expired"

> Error Code: -2147204783  
> Sql ErrorCode: -2146232060  
> Sql Number: -2  
> Error Message: SQL timeout expired. CRM ErrorCode: -2147204783 Sql ErrorCode: -2146232060 Sql Number: -2

### Resolution

This error is likely to occur if the batch size of your request is too large. To avoid SQL time-outs, reduce the batch size of your request.

## Error "The transaction of the SQL command has already been rolled back or committed"

> Error Code: -2147220907  
> Error Message: The transaction of the SQL command has already been rolled back or committed; this is usually caused by a swallowed SQL deadlock exception.

### Resolution

This error and its underlying deadlock exception are likely to occur when trying to update the same record concurrently. To avoid deadlocks, make sure you don't attempt concurrent requests on the same record.

## Error "There is no active transaction"

> Error Code: -2147220911  
> Error Message: There is no active transaction. This error is usually caused by custom plug-ins that ignore errors from service calls and continue processing.

### Resolution

This error isn't related to the use of bulk operations. Review any custom plug-ins that might be executed as part of your request. For more information about these errors, see [Transaction errors](dataverse-plug-ins-errors.md#transaction-errors).

## Client errors

You might encounter errors caused by issues in the bulk operation requests being sent. If you encounter a client error when using bulk operations, see [Troubleshoot Dataverse client errors](client-errors.md).

### See also

[Scalable Customization Design in Microsoft Dataverse](/power-apps/developer/data-platform/scalable-customization-design/overview)
