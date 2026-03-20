---
title: Troubleshoot Commerce Data Exchange Errors in Dynamics 365
description: Learn how to troubleshoot Commerce Data Exchange (CDX) errors in Dynamics 365 Commerce. Resolve batch job failures, session errors, and improve data synchronization.
ms.reviewer: johnmichalak, dlandi, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 03/16/2026
---

# Troubleshoot Commerce Data Exchange (CDX)

## Summary

This article helps you troubleshoot common [Commerce Data Exchange](/dynamics365/commerce/commerce-architecture#commerce-data-exchange) (CDX) errors in Microsoft Dynamics 365 Commerce. It covers issues with batch processing on the **Distribution schedule** page, download and upload session failures, data truncation errors, and slow incremental data synchronization after you add new channels. Each section includes symptoms, possible causes, and recommended solutions.

## "Run now" opens batch processing on the Distribution schedule page

### Symptoms

The **Run now** command on the **Distribution schedule** page opens the batch creation form instead of running the job directly.

:::image type="content" source="./media/commerce-data-exchange/batch-processing-distribution-schedule.png" alt-text="Screenshot of the Distribution schedule page that shows batch processing is enabled.":::

### Cause

Running data synchronization jobs in the interactive AOS instance affected performance for users across all Finance & Operations forms. These jobs now run only in the batch AOS.

### Solution

We recommend that you don't change this behavior in a production environment. However, if you're in a development environment, you can change this behavior in Commerce headquarters:

1. Go to **Commerce shared parameters** > **Configuration parameters**.
1. Set a new parameter that's named `CDX_DISABLE_FORCESCHEDULEINBATCH` and has a value of `1`.

## Error caused by string or binary data truncated in table

### Symptoms

You receive a download or upload session error message that indicates one of the following errors:

> Microsoft.Dynamics.Retail.CommerceDataExchange.ProcessDataPackageException
> Microsoft.Dynamics.Retail.CommerceDataExchange.BulkCopyDataException
> System.InvalidOperationException (string or binary data is truncated in table)

### Cause

The data in the source database is larger than the column in the target database. This problem typically occurs when you extend a string extended data type (EDT) in Finance & Operations to a greater length because that change isn't automatically mirrored in the channel database.

### Solution

For best practices, see [Enable custom Commerce Data Exchange synchronization via extension](/dynamics365/commerce/dev-itpro/cdx-extensibility). Consider removing the EDT extension on the table field that you're editing. Also consider using the CDX extension table to store the full value instead.

If the problem persists, create a Microsoft Support request. For more information, see [Get Support](/power-platform/admin/get-help-support).

## Incremental (delta) data synchronization takes too long

### Symptoms

Incremental (delta) data synchronization takes too long, even though the number of affected rows is small. You might experience a similar performance impact if you create a temporary channel database group or run a full sync.

### Cause

This problem can occur if you add a new channel (store) because the system must re-create all the data for the new store.

### Solution

Data synchronization logic is improved in recent versions. If you plan to add channels regularly, allow enough time for the first incremental sync to finish after you add a channel before the data is needed in the scale units.

## Session package download error because record not found

### Symptoms

When you try to download a data package from the **Download sessions** page in Commerce headquarters, you receive the following error message:

> Record for Id - \<Number\> not found.

### Cause

The storage retention policy deleted the underlying data package. The related download session is likely too old, and a full sync might be necessary.

### Solution

Create a Microsoft Support request. For more information, see [Get Support](/power-platform/admin/get-help-support).

## Missing download and upload sessions

### Symptoms

No download sessions are applied, and no upload sessions are created.

### Cause

The cause depends on the type of scale unit:

- **Cloud Scale Unit (CSU)**: The CSU deployment in the Power Platform admin center might fail, and the CSU becomes unregistered from the data synchronization cloud service.
- **On-premises scale unit**: The Async Client Service on the Windows server might not run correctly.
- **Store Commerce app**: The app might not be running, or [offline mode](/dynamics365/commerce/dev-itpro/implementation-considerations-offline) might not be configured.

> [!NOTE]
> Regardless of the cause of the problem, to check when a data sync event last occurred, go to **Channel database** > **Data synchronization** > **Last connection**.

### Solution

Follow these steps based on the type of scale unit:

- **Cloud Scale Unit**: Redeploy the CSU by using the [Power Platform admin center](/power-platform/admin/support-overview).
- **On-premises scale unit**: Check the status and events for the Async Client Service on the Windows server.
- **Store Commerce app**: Verify that the app is running and that offline mode is configured in the **Database Connection Status** view.

If the problem persists, create a Microsoft Support request. For more information, see [Get Support](/power-platform/admin/get-help-support).

## Related content

- [Troubleshoot Commerce offline implementation](commerce-offline-implementation.md)
- [Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices)
- [Commerce Data Exchange implementation guidance](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx)
