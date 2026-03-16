---
title: Troubleshoot Commerce Data Exchange Issues in Dynamics 365
description: Troubleshoot common Commerce Data Exchange (CDX) errors in Dynamics 365 Commerce. Learn how to resolve batch job failures, download session errors, and more.
ms.reviewer: johnmichalak, dlandi, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 03/16/2026
---

# Troubleshoot Commerce Data Exchange (CDX)

## Summary

This article helps you troubleshoot common [Commerce Data Exchange](/dynamics365/commerce/commerce-architecture#commerce-data-exchange) (CDX) errors in Microsoft Dynamics 365 Commerce. CDX transfers data between Commerce headquarters and channels like online stores and brick-and-mortar stores. It handles both asynchronous data distribution and real-time communication for scenarios like price and inventory lookups.

## Can't run job directly from Distribution schedule page unless batch processing is used

### Symptoms

The **Run now** command from the **Distribution schedule** page opens the batch creation form instead of running the job directly.

:::image type="content" source="./media/commerce-data-exchange/batch-processing-distribution-schedule.png" alt-text="Screenshot of the Distribution schedule page that shows Batch processing is enabled.":::

### Cause

Running data synchronization jobs in the interactive AOS instance affected performance for users across all Finance & Operations forms. These jobs now only run in the batch AOS.

### Solution

Microsoft doesn't recommend changing this behavior. However, if you're in a development environment, you can change it in Commerce headquarters:

1. Go to **Commerce shared parameters** > **Configuration parameters**.
1. Set a new parameter named `CDX_DISABLE_FORCESCHEDULEINBATCH` with a value of `1`.

## Error due to string longer than table column length

### Symptoms

The download or upload session error message contains:

> Microsoft.Dynamics.Retail.CommerceDataExchange.ProcessDataPackageException
> Microsoft.Dynamics.Retail.CommerceDataExchange.BulkCopyDataException
> System.InvalidOperationException: String or binary data would be truncated in table

### Cause

The data in the source database is larger than the column in the target database. This problem typically occurs when you extend a string extended data type (EDT) in Finance and Operations to a greater length, because that change isn't automatically mirrored to the channel database.

### Solution

Create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

For best practices, see [Enable custom Commerce Data Exchange synchronization via extension](/dynamics365/commerce/dev-itpro/cdx-extensibility). Consider removing the EDT extension on the table field you're editing and using the CDX extension table to store the full value instead.

## Slow download sessions after adding multiple POS terminals

### Symptoms

After you add multiple POS terminals, download sessions take a long time, or you experience overall slowness in Commerce headquarters.

### Cause

When you create a new Store Commerce app offline database and add it to the relevant channel database group, the database inherits all existing download sessions since the last full database synchronization. The resulting data generation can be too large and affect performance, especially during peak usage times.

### Solution

Use one of the following options:

- Assign a "dummy" channel database group (a group that isn't associated with any distribution schedule job) to the newly generated terminals.
- Use a special offline profile where the **Pause offline synchronization** option is set to **Yes**. This option lets data generation occur when the system is most available. However, the system might pause data generation multiple times if resources are needed for other tasks. If this approach isn't feasible, create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Incremental (delta) data synchronization takes too long

### Symptoms

Incremental (delta) data synchronization takes too long, even though the number of affected rows is small. Creating a temporary channel database group or running a full sync might cause a similar performance impact.

### Cause

This problem can occur when you add a new channel (store), because the system must recreate all the data for the new store.

### Solution

Data synchronization logic has improved in recent versions. If you plan to add new channels regularly, allow enough time for the first incremental sync after adding a new channel to finish before the data is needed in the scale units.

## Session package download error due to record not found

### Symptoms

When you try to download a data package from the **Download sessions** page in Commerce headquarters, you receive the following error message:

> Record for Id - \<Number\> not found.

### Cause

The storage retention policy deleted the underlying data package. The related download session is likely too old, and a full sync might be needed.

### Solution

Create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## No download sessions are applied, and no upload sessions are created

### Symptoms

No download sessions are applied, and no upload sessions are created.

### Cause

The cause depends on the type of scale unit:

- **Cloud Scale Unit (CSU)**: The CSU deployment in Power Platform admin center might have failed, and the CSU was unregistered from the data synchronization cloud service.
- **On-premises scale unit**: The Async Client Service on the Windows machine might not be running correctly.
- **Store Commerce app**: The app might not be running, or offline mode isn't configured.

> [!NOTE]
> For all cases, you can check when a data sync event last occurred by going to **Channel database** > **Data synchronization** > **Last connection**.

### Solution

Follow these steps based on the type of scale unit:

- **Cloud Scale Unit**: Redeploy the CSU by using the [Power Platform admin center](/power-platform/admin/support-overview).
- **On-premises scale unit**: Check the status and events for the Async Client Service on the Windows machine.
- **Store Commerce app**: Verify that the app is running and that offline mode is configured in the **Database Connection Status** view.

If the issue persists, create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Related content

- [Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices)
- [Commerce Data Exchange implementation guidance](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx)
- [Commerce offline implementation considerations](/dynamics365/commerce/dev-itpro/implementation-considerations-offline)
- [Commerce Data Exchange troubleshooting](/dynamics365/commerce/dev-itpro/cdx-troubleshooting)
- [Dynamics 365 Commerce architecture overview](/dynamics365/commerce/commerce-architecture)
- [Select an in-store topology](/dynamics365/commerce/dev-itpro/retail-in-store-topology)
- [Device management implementation guidance](/dynamics365/commerce/implementation-considerations-devices)
- [Configure, install, and activate Modern POS (MPOS)](/dynamics365/commerce/retail-modern-pos-device-activation)
- [Configure and install Commerce Scale Unit (self-hosted)](/dynamics365/commerce/dev-itpro/retail-store-scale-unit-configuration-installation)
