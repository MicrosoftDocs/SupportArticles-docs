---
title: Troubleshoot Commerce Offline Mode Errors in Dynamics 365
description: Learn how to troubleshoot common offline implementation issues in Dynamics 365 Commerce, from employee configuration to database storage errors.
ms.reviewer: johnmichalak, Luke.Graham, v-shaywood
ms.custom: sap:Data synchronization
ms.date: 03/16/2026
---

# Troubleshoot Commerce offline implementation

## Summary

This article helps you resolve common offline mode errors in Microsoft Dynamics 365 Commerce, including sign-in failures, employee configuration problems, channel errors, and database problems. In an offline implementation, the Store Commerce app for Windows automatically switches from the [channel database](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx#important-commerce-headquarters-pages) to the offline database when the [Commerce Scale Unit](/dynamics365/commerce/commerce-architecture#commerce-scale-unit) becomes unavailable.

During a sales transaction, if a data request doesn't succeed within the timeout interval, the POS automatically switches to the offline database and continues the transaction. While the POS device is in offline mode, the Store Commerce app tries to reconnect to the Commerce Scale Unit after the reconnection attempt interval. Configure the timeout and reconnection attempt intervals in the [offline profile](/dynamics365/commerce/dev-itpro/implementation-considerations-offline).

## Errors due to sign-in problems

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_AuthenticationFailed`
- `Microsoft_Dynamics_Commerce_Runtime_AuthorizationFailed`
- `Microsoft_Dynamics_Commerce_Runtime_WorkerNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_PartyNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_RetailStaffNotFound`

### Cause

A sign-in-related error occurs because data isn't found or is incorrectly configured in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. Contact your system administrator if the problem persists.

## Errors due to employee address book not found, or employee not mapped to store in offline database

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_ChannelEmployeeAddressBookNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_EmployeeNotOnStore`

### Cause

This issue can be caused by one of the following problems:

- The system can't find the store's employee address books.
- The worker isn't correctly mapped to the store in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. Contact your system administrator if the problem persists.

## Errors due to employee position detail not found or invalid

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_EmployeePositionAssignmentNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_EmployeePositionDetailNotFound`

### Cause

This problem occurs because the worker's position detail or assignment isn't found or is invalid in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. Contact your system administrator if the problem persists.

## Error due to employee POS permission settings not found or configured incorrectly

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_EmployeePermissionGroupNotFound`

### Cause

This problem occurs because the worker's POS permission settings aren't found or are configured incorrectly in the offline database.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. Contact your system administrator if the problem persists.

## Channel errors due to inability to switch to offline mode

### Symptoms

You receive one of the following errors:

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
1. Contact your system administrator if the problem persists.

## User errors due to inability to switch to offline mode

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_CredentialsNotConfigured`
- `Microsoft_Dynamics_Commerce_Runtime_CredentialsNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidAuthenticationCredentials`
- `Microsoft_Dynamics_Commerce_Runtime_LocalLogonFailed`
- `Microsoft_Dynamics_Commerce_Runtime_UserBlockedDueToTooManyFailedLogonAttempts`

### Cause

The device can't switch to offline mode. The user information is either unavailable or incorrectly configured.

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Staff scheduler** job (by default, the **1060** scheduler job).
1. Contact your system administrator if the problem persists.

## Error due to offline database storage problem

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_CriticalStorageError`

### Solution

Use the [offline dashboard](/dynamics365/commerce/dev-itpro/implementation-considerations-offline#important-offline-features) to check the status of the offline database permissions, size, and disk space.

## Error when the same user tries to perform a manager override

### Symptoms

You receive the following error message:

`Microsoft_Dynamics_Commerce_Runtime_ElevatedUserSameAsLoggedOnUser`

### Cause

This error occurs when the same user tries to perform a manager override.

### Solution

A different user must perform the manager override.

## Database errors when the device can't switch to offline mode

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_RealtimeServiceNotSupported`
- `Microsoft_Dynamics_Commerce_Runtime_TransientStorageError`

### Cause

The device can't switch to offline mode. The offline database is either incorrectly installed or incorrectly configured.

### Solution

Verify that the offline database is correctly installed and configured. Contact your system administrator if the issue persists.

## Errors due to terminal or device configuration not found

### Symptoms

You receive one of the following errors:

- `Microsoft_Dynamics_Commerce_Runtime_TerminalNotFound`
- `Microsoft_Dynamics_Commerce_Runtime_DeviceConfigurationNotFound`

### Solution

1. In Commerce headquarters, go to **Retail and Commerce** > **Retail and Commerce IT** > **Distribution schedule**.
1. Run the **Channel configuration scheduler** job (by default, the **1070** scheduler job).
1. Contact your system administrator if the problem persists.

## Errors due to internal server, timeout, or runtime invalid format issues

### Symptoms

You receive one of the following errors:

- `Internal_Server_Error`
- `Request_Timeout_Error`
- `Microsoft_Dynamics_Commerce_Runtime_InvalidFormat`

### Cause

These errors can have various underlying causes.

### Solution

Create a Microsoft Support request by using the [Power Platform admin center](/power-platform/admin/support-overview).

## Related content

- [Troubleshoot Commerce Data Exchange (CDX)](commerce-data-exchange.md)
- [Commerce Data Exchange troubleshooting](/dynamics365/commerce/dev-itpro/cdx-troubleshooting)
- [Online and offline point of sale (POS) operations](/dynamics365/commerce/pos-operations)
