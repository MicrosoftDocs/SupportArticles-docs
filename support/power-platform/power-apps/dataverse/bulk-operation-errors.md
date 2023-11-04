---
title: Troubleshoot Dataverse bulk operation errors
description: Provides resolutions for the common errors that might occur while using bulk operations with Dataverse.
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
# Troubleshoot Dataverse bulk operation errors

This article describes common errors you might encounter when using Dataverse [bulk operations](/power-apps/developer/data-platform/bulk-operations) and how you can avoid them.

## Client errors

You might encounter common errors that are due to issues in the bulk operation request being sent. See [Troubleshoot Dataverse client errors](client-errors.md) if you encounter any client error when using bulk operations.

## System errors

This section contains the most frequent system errors encountered when using bulk operation messages. Despite being system errors, certain actions can be taken to avoid them.

### Error "Sql error: Generic SQL error"

> Error Code: -2147204784
> Sql ErrorCode: -2146232060
> Sql Number: 1205
> Error Message: Generic SQL error. CRM ErrorCode: -2147204784 Sql ErrorCode: -2146232060 Sql Number: 1205

This error occurs when attempting to update the same record concurrently. Make sure you don't attempt concurrent requests on the same records.

### Error "Sql error: SQL timeout expired"

> Error Code: -2147204783
> Sql ErrorCode: -2146232060
> Sql Number: -2
> Error Message:SQL timeout expired. CRM ErrorCode: -2147204783 Sql ErrorCode: -2146232060 Sql Number: -2

This error is likely to occur if the batch size of your request is too large. To avoid SQL timeouts, reduce the batch size of your request.

### Error "The transaction of the SQL command has already been rolled back or committed
<!-- 
I wish we had some specific error codes for this 
-->

> Error Message: The transaction of the SQL command has already been rolled back or committed; this is usually caused by a swallowed SQL deadlock exception.

This error and its underlying deadlock exception are likely to occur when attempting to update the same record concurrently. To avoid deadlocks, make sure you don't attempt concurrent requests on the same records.

### Error "There is no active transaction"

> Error Code: -2147220911  
> Error Message: There is no active transaction. This error is usually caused by custom plug-ins that ignore errors from service calls and continue processing.

This error isn't related to the use of bulk operations. Review any custom plug-ins that might be executed as part of your request. For more information about these errors, see [Transaction errors](dataverse-plug-ins-errors.md#transaction-errors).

### See also

[Scalable Customization Design in Microsoft Dataverse](/power-apps/developer/data-platform/scalable-customization-design/overview)
