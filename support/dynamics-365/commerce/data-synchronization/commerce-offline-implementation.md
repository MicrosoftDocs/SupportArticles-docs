---
title: Troubleshoot commerce offline mode errors in Dynamics 365
description: Learn how to troubleshoot common offline implementation problems in Dynamics 365 Commerce, from employee configuration to database storage errors.
ms.reviewer: johnmichalak, Luke.Graham, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 03/16/2026
---

# Troubleshoot Commerce offline implementation errors

## Summary

This article helps you resolve common offline mode errors in Microsoft Dynamics 365 Commerce, including sign-in failures, employee configuration problems, channel errors, and database problems. In an offline implementation, the Store Commerce app for Windows automatically switches from the [channel database](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx#important-commerce-headquarters-pages) to the offline database if the [Commerce Scale Unit](/dynamics365/commerce/commerce-architecture#commerce-scale-unit) becomes unavailable.

During a sales transaction, if a data request doesn't succeed within the timeout interval, the POS automatically switches to the offline database and continues the transaction. While the POS device is in offline mode, the Store Commerce app tries to reconnect to the Commerce Scale Unit after the reconnection attempt interval. You can configure the timeout and reconnection attempt intervals in the [offline profile](/dynamics365/commerce/dev-itpro/implementation-considerations-offline).

## Sign-in problem errors

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_AuthenticationFailed`
- `Microsoft_Dynamics_Commerce_Runtime_AuthorizationFailed`
- `Microsoft_Dynamics_Commerce_Runtime_WorkerNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_PartyNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_RetailStaffNotFound`

### Cause

A sign-in error occurs because data isn't found or is incorrectly configured in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. If the problem persists, contact your system administrator.

## Employee address book not found, or employee not mapped to store in offline database

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_ChannelEmployeeAddressBookNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_EmployeeNotOnStore`

### Cause

This problem can occur for either of the following reasons:

- The system can't find the store's employee address books.
- The worker isn't correctly mapped to the store in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. If the problem persists, contact your system administrator.

## Employee position detail not found or invalid

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_EmployeePositionAssignmentNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_EmployeePositionDetailNotFound`

### Cause

This problem occurs because the worker's position detail or assignment isn't found or is invalid in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. If the problem persists, contact your system administrator.

## Employee POS permission settings not found or configured incorrectly

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_EmployeePermissionGroupNotFound`

### Cause

This problem occurs because the worker's POS permission settings aren't found or are configured incorrectly in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. If the problem persists, contact your system administrator.

## Channel errors because of inability to switch to offline mode

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_AuthenticationMethodDisabled`
- `Microsoft_Dynamics_Commerce_Runtime_ChannelConfigurationNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_ChannelNotPublished`
- `Microsoft_Dynamics_Commerce_Runtime_ChannelRecordNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_EmployeePermissionContextNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidChannel`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidChannelConfiguration`
- `Microsoft_Dynamics_Commerce_Runtime_StaffIdContextMissing`
- `Microsoft_Dynamics_Commerce_Runtime_LocalDeviceAuthenticationFailed`

### Cause

The device can't switch to offline mode. The channel information is either unavailable or incorrectly configured.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Channel configuration scheduler** job (by default, the **1070** scheduler job).
1. If the problem persists, contact your system administrator.

## Can't switch to offline mode

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_CredentialsNotConfigured`
- `Microsoft_Dynamics_Commerce_Runtime_CredentialsNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidAuthenticationCredentials`
- `Microsoft_Dynamics_Commerce_Runtime_LocalLogonFailed`
- `Microsoft_Dynamics_Commerce_Runtime_UserBlockedDueToTooManyFailedLogonAttempts`

### Cause

The device can't switch to offline mode. The user information is either unavailable or configured incorrectly.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. If the problem persists, contact your system administrator.

## Error due to offline database storage problem

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_CriticalStorageError`

### Solution

Use the [offline dashboard](/dynamics365/commerce/dev-itpro/implementation-considerations-offline#important-offline-features) to check the status of the offline database permissions, size, and disk space.

## The same user tries to perform a manager override

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_ElevatedUserSameAsLoggedOnUser`

### Cause

This error occurs if the same user tries to perform a manager override.

### Solution

Only a different user can perform the manager override.

## Database errors when the device can't switch to offline mode

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_RealtimeServiceNotSupported`
- `Microsoft_Dynamics_Commerce_Runtime_TransientStorageError`

### Cause

The device can't switch to offline mode. The offline database is either installed incorrectly or configured incorrectly.

### Solution

1. Verify that the offline database is installed and configured correctly. For more information, see [Health check view for offline readiness](/dynamics365/commerce/health-check-view-offline).
1. If the problem persists, contact your system administrator.

## Terminal or device configuration not found

### Symptoms

You receive one of the following error messages:

- `Microsoft_Dynamics_Commerce_Runtime_TerminalNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_DeviceConfigurationNotFound`

### Cause

The most common cause is when there's still pending data to synchronize to the offline database.

> [!NOTE]
> To check for pending data, in Commerce headquarters, open the **Download sessions** form, filter by the affected offline database, and verify whether there are still sessions in an **Available** state.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Channel configuration** scheduler job (by default, the **1070** scheduler job).
1. Run the **Register configuration** scheduler job (by default, the **1090** scheduler job).
1. If the problem persists, contact your system administrator.

## Internal server, timeout, or runtime invalid format

### Symptoms

You receive one of the following error messages:

- `Internal_Server_Error`
- `Request_Timeout_Error`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidFormat`

### Solution

1. To gather preliminary diagnostics, see [Network health checks](/dynamics365/commerce/pos-healthcheck#network-health-checks).
1. Create a support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Related content

- [Troubleshoot Commerce Data Exchange (CDX)](commerce-data-exchange.md)
- [Commerce Data Exchange troubleshooting](/dynamics365/commerce/dev-itpro/cdx-troubleshooting)
- [Online and offline point of sale (POS) operations](/dynamics365/commerce/pos-operations)
