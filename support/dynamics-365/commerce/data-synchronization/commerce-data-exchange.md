---
title: Troubleshoot Commerce Data Exchange problems in Dynamics 365
description: Troubleshoot common Commerce Data Exchange (CDX) errors in Dynamics 365 Commerce. Learn how to resolve batch job failures, download session errors, and perform other tasks.
ms.reviewer: johnmichalak, dlandi, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 03/16/2026
---

# Troubleshoot Commerce Data Exchange (CDX)

## Summary

This article helps you troubleshoot common [Commerce Data Exchange](/dynamics365/commerce/commerce-architecture#commerce-data-exchange) (CDX) errors in Microsoft Dynamics 365 Commerce. CDX transfers data between Commerce headquarters and channels such as online stores and brick-and-mortar stores. It handles both asynchronous data distribution and real-time communication for scenarios such as price and inventory lookups.

## "Run now" opens batch processing on the Distribution schedule page

### Symptoms

The **Run now** command on the **Distribution schedule** page opens the batch creation form instead of running the job directly.

:::image type="content" source="./media/commerce-data-exchange/batch-processing-distribution-schedule.png" alt-text="Screenshot of the Distribution schedule page that shows batch processing is enabled.":::

### Cause

Running data synchronization jobs in the interactive AOS instance affected performance for users across all Finance & Operations forms. These jobs now run only in the batch AOS.

### Solution

We recommend that you don't change this behavior. However, if you're in a development environment, you can change this behavior in Commerce headquarters:

1. Go to **Commerce shared parameters** > **Configuration parameters**.
1. Set a new parameter that's named `CDX_DISABLE_FORCESCHEDULEINBATCH` and has a value of `1`.

## Error caused by a string longer than table column length

### Symptoms

You receive a download or upload session error message that indicates one of the following errors:

> Microsoft.Dynamics.Retail.CommerceDataExchange.ProcessDataPackageException
> Microsoft.Dynamics.Retail.CommerceDataExchange.BulkCopyDataException
> System.InvalidOperationException (string or binary data is truncated in table)

### Cause

The data in the source database is larger than the column in the target database. This problem typically occurs when you extend a string extended data type (EDT) in Finance & Operations to a greater length because that change isn't automatically mirrored in the channel database.

### Solution

Create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

For best practices, see [Enable custom Commerce Data Exchange synchronization via extension](/dynamics365/commerce/dev-itpro/cdx-extensibility). Consider removing the EDT extension on the table field that you're editing. Also consider using the CDX extension table to store the full value instead.

## Slow download sessions after you add multiple POS terminals

### Symptoms

After you add multiple POS terminals, download sessions take a long time, or you experience overall slowness in the Commerce headquarters component.

### Cause

When you create a new [Store Commerce app offline database](/dynamics365/commerce/dev-itpro/implementation-considerations-offline), and you add it to the relevant channel database group, the database inherits all existing download sessions since the last full database synchronization. The resulting data generation can be excessively large, and it can affect performance, especially during peak usage times.

### Solution

Use one of the following options:

- Assign a "dummy" channel database group (a group that isn't associated with any distribution schedule job) to the newly generated terminals.
- Use a special [offline profile](/dynamics365/commerce/dev-itpro/implementation-considerations-offline#advanced-offline-feature) for which the **Pause offline synchronization** option is set to **Yes**. This option lets data generation occur when the system is most available. However, the system might pause data generation multiple times if resources are needed for other tasks. If this approach isn't feasible, create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

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

Create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Missing download and upload sessions

### Symptoms

No download sessions are applied, and no upload sessions are created.

### Cause

The cause depends on the type of scale unit:

- **Cloud Scale Unit (CSU)**: The CSU deployment in the Power Platform admin center might have fail, and the CSU becomes unregistered from the data synchronization cloud service.
- **On-premises scale unit**: The Async Client Service on the Windows machine might not run correctly.
- **Store Commerce app**: The app might not be running, or [offline mode](/dynamics365/commerce/dev-itpro/implementation-considerations-offline) might not be configured.

> [!NOTE]
> Regardless of the cause of the problem, to check when a data sync event last occurred, go to **Channel database** > **Data synchronization** > **Last connection**.

### Solution

Follow these steps based on the type of scale unit:

- **Cloud Scale Unit**: Redeploy the CSU by using the [Power Platform admin center](/power-platform/admin/support-overview).
- **On-premises scale unit**: Check the status and events for the Async Client Service on the Windows machine.
- **Store Commerce app**: Verify that the app is running and that offline mode is configured in the **Database Connection Status** view.

If the problem persists, create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Related content

- [Troubleshoot Commerce offline implementation](commerce-offline-implementation.md)
- [Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices)
- [Commerce Data Exchange implementation guidance](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx)
