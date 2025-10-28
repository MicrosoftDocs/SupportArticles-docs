---
title: Troubleshoot common Commerce Data Exchange (CDX) issues
description: Troubleshoot common Commerce Data Exchange (CDX) errors in Dynamics 365 Commerce. Learn how to resolve issues like batch job failures and download session errors.
ms.reviewer: johnmichalak, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 10/16/2025
---

# Troubleshoot Commerce Data Exchange (CDX)

This article explains how to troubleshoot common errors with Commerce Data Exchange (CDX) in Microsoft Dynamics 365 Commerce environments. CDX is a system that transfers data between Headquarters and channels, such as online stores or brick-and-mortar stores. Data distribution is asynchronous. In other words, the process of gathering and packaging data at the source occurs separately from the process of receiving and applying data at the destination. For some scenarios, such as price and inventory lookups, data must be retrieved in real time. To support these scenarios, Commerce Data Exchange also includes a service that enables real-time communication between Headquarters and a channel.

## Issue 1: Download sessions failing with null connection string

### Symptoms

You receive the following error message:

> System.ArgumentNullException: Value cannot be null. Parameter name: connectionString at Microsoft.Dynamics.Retail.CommerceDataExchange.SqlTargetRequestHandler.

### Cause

This error occurs because of batch job statuses. You can view the error in a failed download job on the **Download sessions** page.

### Solution

1. In Dynamics 365 Commerce headquarters, go to **System administration** \> **Inquiries** \> **Batch jobs**.
1. Find the data writing batch associated with the Commerce Scale Unit to which the download job is supposed to be applied.
1. Change the batch job's status to **Withhold**.

## Issue 2: Can't execute Run now command from Distribution schedule page unless batch processing is used

### Symptoms

You can't perform the **Run now** command from the **Distribution schedule** page unless batch processing is used.

:::image type="content" source="./media/commerce-data-exchange/batch-processing-distribution-schedule.png" alt-text="The Distribution schedule page, executing a job with Batch processing enabled":::

### Cause

This change was intentionally made in Commerce version 10.0.11 because of performance issues that occur if jobs run during times when environments are most heavily used. Also, as part of this feature enhancement, recurrence can't be used when the **Full data sync** (full job synchronization) command is run from the **Channel database** page in Commerce headquarters. You can only run a single occurrence.

### Solution

Microsoft doesn't recommend that you change this behavior. However, if you're in a development environment, you can change it in Commerce headquarters by:

1. Go to **Commerce shared parameters** \> **Configuration parameters**
1. Set a new parameter with a name of `CDX_DISABLE_FORCESCHEDULEINBATCH` and a value of `1`.

## Issue 3: Error due to extended table length

### Symptoms

You receive the following error message:

> Microsoft.Dynamics.Retail.CommerceDataExchange.SqlWriteRequestRunException: Failed to run SqlWriteRequestRunner for table AX.\<TABLE NAME\>.

### Cause

This error occurs when the length of one or more DBO tables is extended, causing data truncation to be required. In this scenario, a truncation failure occurs.

### Solution

Create a Microsoft Support request.

For information on best practices, see [Enable custom Commerce Data Exchange synchronization via extension](/dynamics365/commerce/dev-itpro/cdx-extensibility). These best practices include removing the extended data type (EDT) extension on the table field you're editing. Instead, use the CDX extension table to store the long (full) value required.

## Issue 4: Error due to download session failure

### Symptoms

The download session fails and returns an error message that includes:

> ...tried too many times.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** \> **Headquarters setup** \> **Parameters** \> **Commerce scheduler parameters**.
1. Set the **Try count** field to **3**.
   1. *If you set this value too high, download sessions might fail during high-usage times.*
1. When you update the **Try count** field, the job sets its status to **Canceled** and stops retrying itself.

For more information, see [Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices).

## Issue 5: Unable to cancel a running CDX job

### Symptoms

You can't cancel a running CDX job.

### Solution

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

## Issue 6: Slow download sessions after adding multiple POS terminals

### Symptoms

After you add multiple POS terminals, download sessions take a long time, or you experience overall slowness in Commerce headquarters.

### Cause

When you create a new Store Commerce app offline database, and add it to the relevant channel database group. The database inherits all existing download sessions since the last full database synchronization occurred. Even under normal conditions, the significant data generation that might occur can be too large and affect performance. At the busiest times, this process can severely impair the environment's performance.

### Solution

Use one of the following options:

- A "dummy" channel database group (that is, a group that isn't associated with any distribution schedule job) that you assign to the newly generated terminals.
- A special offline profile where the **Pause offline synchronization** option is set to **Yes**. With this option, data generation can occur when required and the system is most available to do it. However, the system might pause multiple times as required. If it's too late to use this approach, create a Microsoft Support request.

## Issue 7: Incremental (delta) data synchronization takes too long

### Symptoms

Normal, incremental (delta) data synchronization takes too long, even though the number of affected rows is small.

### Cause

This issue can occur when you create a new channel (store), because the system must recreate all the data for the new store.

### Solution

Use a "dummy" channel database associated with a "dummy" channel database group, and assign it to the newly generated channel (store). With this configuration, data generation can occur when required and the system is most available to do it. If it's too late to use this approach, create a Microsoft Support request.

## Issue 8: P-job error due to violation of primary key restraint

### Symptoms

The P-job fails to create an upload session, and you receive the following error message:

> System.Data.SqlClient.SqlException (0x80131904): Violation of PRIMARY KEY constraint 'PK\_UPLOADSESSION'. Cannot insert duplicate key in object 'crt.UPLOADSESSION'.

### Solution

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

## Issue 9: Session package download error due to record not found

### Symptoms

When you try to download an upload session package from the **Upload sessions** page in Commerce headquarters, you receive the following error message:

> Record for Id - \<Number\> not found.

### Solution

Create a Microsoft Support request.

## Issue 10: Error due to CDX download sessions failing to be applied

### Symptoms

The CDX download sessions fail to be applied, and you receive the following error message:

> Failed to get download session package URI.

### Solution

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

## Issue 11: No download sessions are applied, and no upload sessions are created

### Symptoms

No download sessions are applied, and no upload sessions are created.

### Solution

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

## Issue 12: Upload sessions error due to multiple records in the RetailListingStatusLog table

### Symptoms

An upload session fails and returns the following error message:

> Infolog for task Default:P-0001 (...) Error when bulk inserting data. Target table: RetailListingStatusLog.

### Cause

An error occurs because the upload session package contains multiple records in the **RetailListingStatusLog** table. These records have the same **StatusDateTime** value between two or more records.

### Solution

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

## Issue 13: Failure during switch to offline mode

### Symptoms

When a cashier tries to switch to offline mode, or is forced offline, the switch fails.

### Cause

Many possible causes exist for the failure:

1. The register doesn't have enough available hard drive space.
1. You're using SQL Server Express and the database file reaches its 10-gigabyte (GB) size limit.
1. The register has pending download sessions.
   1. Pending download sessions indicate that the register isn't up to date. Therefore, offline switching might temporarily be prevented

### Solution

Contact Microsoft Support.

- If this issue occurs in a production environment, sign in to [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index), and create a request for immediate support.
- If the issue occurs in a nonproduction environment, create a Microsoft Support request using the [Power Platform admin center](/power-platform/admin/support-overview) or [LCS](/dynamics365/fin-ops-core/dev-itpro/lifecycle-services/submit-request-dynamics-service-engineering-team).

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
