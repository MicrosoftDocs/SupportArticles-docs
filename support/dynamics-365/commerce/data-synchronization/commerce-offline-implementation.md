---
title: Troubleshoot Commerce offline implementation
description: Learn how to troubleshoot errors for offline implementations of Microsoft Dynamics 365 Commerce.
author: johnmichalak
ms.author: johnmichalak
ms.topic: troubleshooting
ms.date: 10/15/2025
---
# Troubleshoot Commerce offline implementation

This article explains how to troubleshoot errors for offline implementations of Microsoft Dynamics 365 Commerce.

## Issue 1: Errors due to sign-in issues

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_AuthenticationFailed
- Microsoft_Dynamics_Commerce_Runtime_AuthorizationFailed
- Microsoft_Dynamics_Commerce_Runtime_WorkerNotFound
- Microsoft_Dynamics_Commerce_Runtime_PartyNotFound
- Microsoft_Dynamics_Commerce_Runtime_RetailStaffNotFound

#### Root cause

A sign-in-related issue has occurred. This issue might occur because data isn't found or correctly configured in the offline database.

### Resolution

To fix this issue, in Commerce headquarters, run the **Staff scheduler** job (by default, the **1060** scheduler job). Also, contact your system administrator.

## Issue 2: Errors due to employee address book not being found, or employee not mapped to store in offline database

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_ChannelEmployeeAddressBookNotFound
- Microsoft_Dynamics_Commerce_Runtime_EmployeeNotOnStore

#### Root cause

This issue might occur because the store's employee address books aren't found or the worker isn't correctly mapped to the store in the offline database.

### Resolution

To fix this issue, in Commerce headquarters, run the **Staff scheduler** job (by default, the **1060** scheduler job). Also, contact your system administrator.

## Issue 3: Errors due to employee position detail not found or invalid

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_EmployeePositionAssignmentNotFound
- Microsoft_Dynamics_Commerce_Runtime_EmployeePositionDetailNotFound

#### Root cause

This issue might occur because the worker's position detail or assignment isn't found or valid in the offline database.

### Resolution

To fix this issue, in Commerce headquarters, run the **Staff scheduler** job (by default, the **1060** scheduler job). Also, contact your system administrator.

## Issue 4: Error due to employee POS permission settings not found or configured incorrectly

### Symptoms

You receive the following error:

Microsoft_Dynamics_Commerce_Runtime_EmployeePermissionGroupNotFound

#### Root cause

This issue might occur because the worker's POS permission settings aren't found or are configured incorrectly in the offline database.

### Resolution

To fix this issue, in Commerce headquarters, run the **Staff scheduler** job (by default, the **1060** scheduler job). Also, contact your system administrator.

## Issue 5: Channel errors due to inability to switch to offline mode

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_AuthenticationMethodDisabled
- Microsoft_Dynamics_Commerce_Runtime_ChannelConfigurationNotFound
- Microsoft_Dynamics_Commerce_Runtime_ChannelNotPublished
- Microsoft_Dynamics_Commerce_Runtime_ChannelRecordNotFound
- Microsoft_Dynamics_Commerce_Runtime_EmployeePermissionContextNotFound
- Microsoft_Dynamics_Commerce_Runtime_InvalidChannel
- Microsoft_Dynamics_Commerce_Runtime_InvalidChannelConfiguration
- Microsoft_Dynamics_Commerce_Runtime_StaffIdContextMissing
- Microsoft_Dynamics_Commerce_Runtime_LocalDeviceAuthenticationFailed

#### Root cause

Unable to switch to offline mode. The channel information is either unavailable or incorrectly configured.

### Resolution

To fix this issue, in Commerce headquarters, run the **Channel configuration scheduler** job (by default, the **1070** scheduler job). Also, contact your system administrator.

## Issue 6: User errors due to inability to switch to offline mode

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_CredentialsNotConfigured
- Microsoft_Dynamics_Commerce_Runtime_CredentialsNotFound
- Microsoft_Dynamics_Commerce_Runtime_InvalidAuthenticationCredentials
- Microsoft_Dynamics_Commerce_Runtime_LocalLogonFailed
- Microsoft_Dynamics_Commerce_Runtime_UserBlockedDueToTooManyFailedLogonAttempts

#### Root cause

Unable to switch to offline mode. The user information is either unavailable or incorrectly configured.

### Resolution

To fix this issue, in Commerce headquarters, run the **Staff scheduler** job (by default, the **1060** scheduler job). Also, contact your system administrator.

## Issue 7: Error due to offline database storage issue 

### Symptoms

You receive the following error:

Microsoft_Dynamics_Commerce_Runtime_CriticalStorageError

### Resolution

Use the offline dashboard to check the status of offline database permissions, size, and disk space.

## Issue 8: Error due to same user attempting to perform a manager override

### Symptoms

You receive the following error:

Microsoft_Dynamics_Commerce_Runtime_ElevatedUserSameAsLoggedOnUser

#### Root cause

This error occurs when the same user tries to perform a manager override.

### Resolution

A different user must perform the manager override.

## Issue 9: Database errors due to inability to switch to offline mode

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_RealtimeServiceNotSupported
- Microsoft_Dynamics_Commerce_Runtime_TransientStorageError

#### Root cause

Unable to switch to offline mode. The offline database is either incorrectly installed or incorrectly configured.

### Resolution

Verify that everything has been set up successfully. Also, contact your system administrator.

## Issue 10: Errors due to terminal or device configuration not found

### Symptoms

You receive one of the following errors:

- Microsoft_Dynamics_Commerce_Runtime_TerminalNotFound
- Microsoft_Dynamics_Commerce_Runtime_DeviceConfigurationNotFound

### Resolution

To fix this issue, run the **Channel configuration scheduler** job (by default, the **1070** scheduler job). Also, contact your system administrator.

## Issue 11: Errors due to internal server, timeout, or runtime invalid format issues 

### Symptoms

You receive one of the following errors:

- Internal_Server_Error
- Request_Timeout_Error
- Microsoft_Dynamics_Commerce_Runtime_InvalidFormat

#### Root cause

These errors cover a variety of possible scenarios. 

### Resolution

Microsoft recommends that you contact Support to get direct assistance (where applicable).

## More information

[Commerce offline implementation considerations](/dynamics365/commerce/dev-itpro/implementation-considerations-offline)

[Commerce Data Exchange implementation guidance](/dynamics365/commerce/dev-itpro/implementation-considerations-cdx)

[Commerce Data Exchange troubleshooting](/dynamics365/commerce/dev-itpro/cdx-troubleshooting)

[Commerce Data Exchange best practices](/dynamics365/commerce/dev-itpro/cdx-best-practices)

[Online and offline point of sale (POS) operations](/dynamics365/commerce/pos-operations)

[Dynamics 365 Commerce architecture overview](/dynamics365/commerce/commerce-architecture)

[Select an in-store topology](/dynamics365/commerce/dev-itpro/retail-in-store-topology)

[Device management implementation guidance](/dynamics365/commerce/implementation-considerations-devices)


[Configure and install Commerce Scale Unit (self-hosted)](/dynamics365/commerce/dev-itpro/retail-store-scale-unit-configuration-installation)



