---
title: Troubleshoot Commerce Data Exchange (CDX)
description: Learn how to troubleshoot errors for Commerce Data Exchange (CDX) in Microsoft Dynamics 365 Commerce environments.
author: v-chgri
ms.author: johnmichalak
ms.topic: troubleshooting
ms.date: 10/07/2025
---
# Troubleshoot Commerce Data Exchange (CDX)

This article explains how to troubleshoot errors for Commerce Data Exchange (CDX) in Microsoft Dynamics 365 Commerce environments.

## Issue 1

### Symptoms

You receive the following error message: 

`System.ArgumentNullException: Value cannot be null. Parameter name: connectionString at Microsoft.Dynamics.Retail.CommerceDataExchange.SqlTargetRequestHandler.`

#### Root cause

An error has occurred because of batch job statuses. You can view the error in a failed download job on the **Download sessions** page.

### Resolution

Go to **System administration** \> **Inquiries** \> **Batch jobs**, find the data writing batch that is associated with the Commerce Scale Unit that the download job was supposed to be applied to, and change the batch job's status to **Withhold**. In environments that are earlier than version 10.0.12, we recommend that you also create a channel database group that is named **Legacy**, associate the **Default** channel database with this new group, and then exclude the new database group from all distribution schedules. CDX jobs should no longer be generated for the **Default** channel database in the **Legacy** group.

## Issue 2

### Symptoms

You can't perform the **Run now** command from the **Distribution schedule**   page unless batch processing is used.

#### Root cause

This change was intentionally made in version 10.0.11 because of performance issues that occurred if jobs were run during times when environments were most heavily used. In another change that was made as part of this feature enhancement, recurrence can't be used when the **Full data sync** command (full job synchronization) is run from the **Channel database** page in Commerce headquarters. Only a single occurrence can be run.

### Resolution

Microsoft doesn't recommend that you change this behavior. However, if you're in a development environment, you can change it by going to **Commerce shared parameters** \> **Configuration parameters** and setting a new name, CDX_DISABLE_FORCESCHEDULEINBATCH, that has a value of 1.

## Issue 3

### Symptoms

You receive the following error message: 

`Microsoft.Dynamics.Retail.CommerceDataExchange.SqlWriteRequestRunException: Failed to run SqlWriteRequestRunner for table AX.\<TABLE NAME\>.`

#### Root cause

An error has occurred because the length of one or more DBO tables has been extended, so that truncation of data was required. Therefore, a truncation failure has occurred. 

### Resolution

Generate a support request. For best practices, see [Enable custom Commerce Data Exchange synchronization via extension](/dynamics365/commerce/dev-itpro/cdx-extensibility). These best practices include removing the extended data type (EDT) extension on the table field that is being edited and using the CDX extension table to store the long (full) value that is required.

## Issue 4

### Symptoms

The download session is failing, and the error message states "...tried too many times."

#### Root cause

### Resolution

Go to **Retail and Commerce** \> **Headquarters setup** \> **Parameters** \> **Commerce scheduler parameters** and set the **Try count** field to **3**. If the value of this field is too high, download sessions might fail during high-usage times. After you complete this step, the job will set its status to **Canceled** and stop retrying itself. Microsoft recommends that you to read [Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices).

## Issue 5

### Symptoms

You can't cancel a running CDX job.

#### Root cause

### Resolution

If this issue occurs in a production environment, sign in to Microsoft Dynamics Lifecycle Services (LCS), and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## Issue 6

### Symptoms

After you add multiple POS terminals, download sessions take a long time, or there's overall Commerce headquarters slowness.

#### Root cause

When you create a new Store Commerce app offline database and add it to the relevant channel database group, it inherits all existing download sessions since the last full database synchronization occurred. Even at the best of times, the exceptional data generation that might occur can be too large and therefore affect performance. At the worst (that is, busiest) of times, it can severely impair the environment's performance.

### Resolution

Microsoft highly recommends that you have either a "dummy" channel database group (that is, a group that isn't associated with any distribution schedule job) that you assign to the newly generated terminals or a special offline profile where the **Pause offline synchronization** option is set to **Yes**. In this way, data generation can occur when it's required and when the system is most available to do it. (However, the system might pause multiple times as required.) If it's too late to use this approach, create a support request.

## Issue 7

### Symptoms

Normal, incremental (delta) synchronization takes much too long, even though the number of affected rows is small.

#### Root cause

This issue can occur when a new channel (store) is created, because all the data must be recreated for the new store.

### Resolution

Microsoft highly recommends that you have a "dummy" channel database that is associated with a "dummy" channel database group, and assign it to the newly generated channel (store). In this way, data generation can occur when it's required and when the system is most available to do it. If it's too late to use this approach, create a support request.

## Issue 8

### Symptoms

The P-job fails to create an upload session, and you receive the following error message: 

`System.Data.SqlClient.SqlException (0x80131904): Violation of PRIMARY KEY constraint 'PK\_UPLOADSESSION'. Cannot insert duplicate key in object 'crt.UPLOADSESSION'.`

#### Root cause

### Resolution

If this issue occurs in a production environment, sign in to LCS, and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## Issue 9

### Symptoms

When you try to download an upload session package from the **Upload sessions** page in Commerce headquarters, you receive the following error message: 

`Record for Id - \<Number\> not found.`

#### Root cause

### Resolution

Create a support request.

## Issue 10

### Symptoms

CDX download sessions fail to be applied, and you receive the following error message: 

`Failed to get download session package URI.`

#### Root cause

### Resolution

If this issue occurs in a production environment, sign in to LCS, and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## Issue 11

### Symptoms

No download sessions are applied, and no upload sessions are created.

#### Root cause

### Resolution

If this issue occurs in a production environment, sign in to LCS, and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## Issue 12

### Symptoms

Upload sessions fail, and you receive the following error message: 

`Infolog for task Default:P-0001 (...) Error when bulk inserting data. Target table: RetailListingStatusLog.`

#### Root cause

An error has occurred because the upload session package contains multiple records in the **RetailListingStatusLog** table. These records have the same **StatusDateTime** value between two or more.

### Resolution

If this issue occurs in a production environment, sign in to LCS, and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## Issue 13

### Symptoms

When a cashier tries to switch to offline mode or is forced offline, the switch fails.

#### Root cause

There are many possible causes. First, verify basic information: Does the computer have available hard drive space? If you're using SQL Server Express, is the size of the offline database at the 10 gigabytes (GB) limit? Are there pending download sessions for the register? (Pending download sessions indicate that the register is no longer up to date. Therefore, offline switching might temporarily be prevented.)

### Resolution

Additionally, we recommend that you contact Microsoft Support. If this issue occurs in a production environment, sign in to LCS, and create a request for immediate support. If the issue occurs in a nonproduction environment, create a support request.

## More information

[Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices)

[Commerce Data Exchange implementation guidance](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx)

[Commerce offline implementation considerations](/dynamics365/commerce/dev-itpro/implementation-considerations-offline)

[Commerce Data Exchange troubleshooting](/dynamics365/commerce/dev-itpro/cdx-troubleshooting)

[Dynamics 365 Commerce architecture overview](/dynamics365/commerce/commerce-architecture)

[Select an in-store topology](/dynamics365/commerce/dev-itpro/retail-in-store-topology)

[Device management implementation guidance](/dynamics365/commerce/implementation-considerations-devices)

[Configure, install, and activate Modern POS (MPOS)](/dynamics365/commerce/retail-modern-pos-device-activation)

[Configure and install Commerce Scale Unit (self-hosted)](/dynamics365/commerce/dev-itpro/retail-store-scale-unit-configuration-installation)



