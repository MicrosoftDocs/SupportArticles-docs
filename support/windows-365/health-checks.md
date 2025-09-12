---
title: Azure network connection health checks in Windows 365
description: Learn about the health checks that are automatically run on Azure network connections.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: mattsha, erikje
ms.custom:
- pcy:Azure Network Connection\Health Check Issues
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---
# Azure network connection health checks

A unique feature of Windows 365 is the Azure network connection (ANC) health checks. The health checks are periodically run to make sure that:

- Cloud PC provisioning is successful.
- End-user Cloud PC experiences are optimal.

## Azure network connection status

In the **Azure network connection** tab, every ANC created displays a status. This status helps you determine whether new Cloud PCs can be expected to provision successfully, and whether existing end-users are having an optimal Cloud PC experience.

Statuses include:

- **Running checks**: The health checks are currently running. The ANC list view automatically refreshes every five minutes. Wait for the checks to complete before attempting to assign it to a provisioning policy.
- **Checks successful**: All health checks passed. The ANC is ready for use.
- **Checks successful with warnings**: All critical health checks passed. However at least one noncritical check might have issues. An example of a check that might trigger this state is the Microsoft Entra hybrid join sync check. Microsoft Entra hybrid join sync can take up to 90 minutes. Therefore, we checked much of the Microsoft Entra hybrid join sync service but couldn't confirm that the device sync succeeded until later. Provisioning policies can use ANCs with this status.
- **Checks failed**: One or more required checks failed. An ANC can't be used if it's in a failed state. Resolve the underlying issue and retry the health checks.
- **Inactive**: The ANC is inactive and health checks are paused. Reactivate the ANC to restart the health checks. After the health checks are passed, the ANC is ready for use.

## Status error details

Every failed ANC or success with a warning error state includes the technical details behind the failure. Select the **View details** link for each failed check to view more information on the failure. After you fix the underlying issue, retry the health check to rerun the tests. To retry the health check, you must have the [Intune Administrator](/azure/active-directory/roles/permissions-reference#intune-administrator) or [Windows 365 Administrator](/azure/active-directory/roles/permissions-reference) role.

## Supported checks

- **DNS can resolve Active Directory domain**: Ensure that the Service Location (SRV) locator resource records for a domain controller can be located via DNS. For more information, see [Verify that SRV Domain Name System (DNS) records have been created](../windows-server/networking/verify-srv-dns-records-have-been-created.md).
- **Active directory domain join**: Confirm that the domain join action using the credentials, domain, and Organizational Unit (OU) provided on the ANC configuration is successful. Failures in this check can occur if the password has been changed.
- **Endpoint connectivity**: Connectivity to the required [URL/endpoints](/windows-365/enterprise/requirements-network).
- **Microsoft Entra device sync (warning)**: Device ID sync is enabled on the Microsoft Entra tenant, and the computer object is being synced within 90 minutes.
- **Azure subnet IP address usage**: Sufficient IP addresses are available in the provided Azure subnet.
- **Azure tenant readiness**: The defined Azure subscription is enabled and ready for use. No Azure policy restrictions are blocking the creation of Windows 365 resources
- **Azure virtual network readiness**: The defined virtual network is in a Windows 365-supported region.
- **First party app permissions exist on Azure subscription**: Sufficient permissions exist on the Azure subscription.
- **First party app permissions exist on Azure resource group**: Sufficient permissions exist on the Azure resource group.
- **First party app permissions exist on Azure virtual network**: Sufficient permissions exist on the Azure virtual network.
- **Environment and configuration are ready**: The underlying infrastructure is ready for provisioning to succeed.
- **Intune enrollment restrictions allow Windows enrollment**: Verify that Intune enrollment restrictions are configured to allow Windows enrollment.
- **Localization language package readiness**: Verify that the operating system and Microsoft 365 language packages are reachable. Also, verify that the localization package download link is reachable.
- **UDP connection check**: Network configuration allows the use of User Datagram Protocol (UDP) direct connection (STUN).
- **Single sign-on configuration**: Determine if the network is properly configured for [single sign-on](/windows-365/enterprise/identity-authentication#single-sign-on-sso) to Microsoft Entra hybrid joined Cloud PCs by ensuring a Kerberos Server object exists.

## Next steps

[Learn more about Azure network connections](/windows-365/enterprise/azure-network-connections).
