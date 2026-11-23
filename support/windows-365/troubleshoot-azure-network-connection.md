---
title: Troubleshoot Azure network connections
description: Troubleshoot Azure network connections in Windows 365.
manager: dcscontentpm
ms.date: 11/17/2026
ms.topic: troubleshooting
ms.reviewer: ericor, erikje, joeno
ms.custom:
- sap:Azure Network Connection\VNET Setup and Config Issues
- pcy:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
ai-usage: ai-assisted
appliesto:
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/windows-365target=_blank>Supported versions of Windows 365</a>
---
# Troubleshoot Azure network connections

## Summary

The Azure network connection (ANC) periodically checks your environment to make sure that all requirements are met and that it's in a healthy state. If any check fails, you can see error messages in the Microsoft Intune admin center. This guide contains some further instructions for troubleshooting issues that might cause checks to fail.

## Active Directory domain join

When a Cloud PC is provisioned, it's automatically joined to the provided domain. To test the domain join process, a domain computer object is created in the defined organizational unit (OU) with a name similar to "CPC-Hth" every time Windows 365 health checks are run. These computer objects are disabled when the health check is complete. Active Directory domain join failure can occur for many reasons. If the domain join fails, make sure that:

- The domain join user has sufficient permissions to join the provided domain.
- The domain join user can write to the provided OU.
- The domain join user isn't restricted in how many computers they can join. For example, the default maximum number of joins per user is 10, and this maximum number affects Cloud PC provisioning.
- The subnet being used can reach a domain controller.
- You test `Add-Computer` by using the domain join credentials on a virtual machine (VM) connected to the Cloud PC vNet/subnet.
- You troubleshoot domain join failures like any physical computer in your organization.
- If you have a domain name that can be resolved on the internet (such as `contoso.com`), make sure that your Domain Name System (DNS) servers are configured as internal. Also, make sure that they can resolve Active Directory domain DNS records, not your public domain name.

If you encounter the following errors in your ANC health checks, consider the suggestions in the following two sections to ensure your Azure and on-premises configurations can successfully reach the required Windows 365 endpoints:

> `Internal Server Error`

> `InternalServerErrorUnableToRunDscScript`

### Domain controller line of sight

Successful communication with a domain controller within your organization is essential for configuring an ANC to allow hybrid domain-joined Cloud PCs. Ensure that the Azure vNet used for your ANC connection has a network route to a domain controller and ensure that your DNS setup can successfully resolve it.

> [!NOTE]
> This section only applies to hybrid environments.

### Windows Remote Management (WinRM) requirements for ANC

WinRM is required to complete an ANC setup.

To ensure successful provisioning, verify that WinRM isn't restricted to specific IP addresses, whether through a Group Policy Object (GPO) or Microsoft Intune configuration service provider (CSP), for the groups that your provisioning policies use. Configure WinRM to allow network requests from any IP address.

For more information, see [GPO configurations](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management) or [Intune CSP](/windows/client-management/mdm/policy-csp-remotemanagement).

### ANC endpoint access

During ANC configuration, the service needs to download configuration data from various Microsoft endpoints as listed in [Network requirements](/windows-365/enterprise/requirements-network). If misconfigured network settings prevent access to these endpoints, the configuration fails. To ensure successful access, avoid Transport Layer Security (TLS) inspection on any virtual network that's used for ANC connections. Ensure that you can resolve and reach these endpoints through the Azure virtual network and that your firewall, proxy, or other network services allow access to them.

<a name='azure-active-directory-device-sync'></a>

## Microsoft Entra device sync

Before mobile device management (MDM) enrollment can take place during provisioning, a Microsoft Entra ID object must be present for the Cloud PC. This check ensures that your organization's computer accounts sync to Microsoft Entra ID in a timely manner.

Make sure that your Microsoft Entra computer objects appear in Microsoft Entra ID quickly. We recommend that they appear within 30 minutes, and no longer than 60 minutes. If the computer object doesn't arrive in Microsoft Entra ID within 90 minutes, provisioning fails.

If provisioning fails, make sure that:

- The sync period configuration on Microsoft Entra ID is set appropriately. Speak with your identity team to ensure that your directory syncs fast enough.
- Your Microsoft Entra ID is active and healthy.
- Microsoft Entra Connect is running correctly, and there are no issues with the sync server.
- You manually perform an `Add-Computer` into the OU provided for Cloud PCs. Time how long it takes for that computer object to appear in Microsoft Entra ID.

> [!NOTE]
> If you receive an **Entra ID Sync Warning** after confirming that the recommended configuration is correctly set and there are no provisioning failures, no further action is required. This warning can occur if the check is performed directly after a sync has been completed.

## Azure subnet IP address range usage

As part of the ANC setup, you need to provide a subnet to which the Cloud PC connects. For each Cloud PC, provisioning creates a virtual NIC and consumes an IP address from this subnet.

Make sure that you allocate sufficient IP addresses for the number of Cloud PCs that you expect to provision. Also, plan enough address space to accommodate provisioning failures and potential disaster recovery.

If this check fails, make sure that you:

- Check the subnet in the Azure virtual network. It should have enough address space available.
- Make sure there are enough addresses to handle three provisioning retries, each of which might hold onto the network addresses used for a few hours.
- Remove any unused virtual network interface cards (vNICs). To ensure that no other services consume the allocated IP addresses, use a dedicated subnet for Cloud PCs.
- Expand the subnet to make more addresses available. You can't complete this step if there are devices that are connected to the subnet.

During provisioning attempts, consider any **CanNotDelete** locks that might be applied at the resource group level or higher. If these locks are present, the network interfaces created in the process aren't automatically deleted. If they aren't automatically deleted, you must manually remove the vNICs before you can retry.

During provisioning attempts, consider any existing locks at the resource group level or higher. If these locks are present, the network interfaces created in the process aren't automatically deleted. If this event occurs, you must manually remove the vNICs before you can retry.

## Azure tenant readiness

When checks are performed, the system verifies that the provided Azure subscription is valid and healthy. If it's not valid and healthy, the system can't connect Cloud PCs back to your virtual network during provisioning. Problems such as billing issues might cause subscriptions to become disabled.

Many organizations use Azure policies to make sure that resources are only provisioned into certain regions and services. You should make sure that any Azure policies consider the Cloud PC service and the supported regions.

Sign in to the Azure portal and make sure that the Azure subscription is enabled, valid, and healthy.

Also, visit the Azure portal and view **Policies**. Make sure that no policies are blocking resource creation.

## Azure virtual network readiness

When you create an ANC, you can't use a virtual network located in an unsupported region. For a list of supported regions, see [Requirements](/windows-365/enterprise/requirements).

If this check fails, ensure that the virtual network is in a region in the supported region list.

## DNS can resolve the Active Directory domain

For Windows 365 to successfully perform a domain join, the Cloud PCs that are attached to the virtual network must be able to resolve internal DNS names.

This test attempts to resolve the provided domain name, such as contoso.com or contoso.local. If this test fails, ensure that:

- The DNS servers in the Azure virtual network are correctly configured to an internal DNS server that can successfully resolve the domain name.
- The subnet and virtual network are routed correctly so that the Cloud PC can reach the DNS server.
- The Cloud PCs and VMs in the declared subnet can `NSLOOKUP` on the DNS server, and it responds with internal names.

Along with the standard DNS lookup on the supplied domain name, this test checks for the existence of `_ldap._tcp.<SuppliedDomainName>.com` records. This record indicates the DNS server is an Active Directory domain controller. The record is a reliable way to confirm that AD domain DNS is reachable. Ensure that these records are accessible through the virtual network in your ANC.

## Endpoint connectivity

During provisioning, Cloud PCs must connect to multiple publicly available Microsoft services. These services include Microsoft Intune, Microsoft Entra ID, and Azure Virtual Desktop.

You must ensure that the subnet used by Cloud PCs can reach all of the [required public endpoints](/windows-365/enterprise/requirements-network#allow-network-connectivity).

If this test fails, make sure that:

- You use the Azure virtual network troubleshooting tools to verify that the provided virtual network and subnet can reach the service endpoints listed in the documentation.
- The provided DNS server can resolve the external services correctly.
- There's no proxy between the Cloud PC subnet and the internet.
- There are no firewall rules (physical, virtual, or in Windows) that might block required traffic.
- You consider testing the endpoints from a VM on the same subnet that's declared for Cloud PCs.

If you aren't using Azure CloudShell, ensure that your PowerShell execution policy is configured to allow **Unrestricted** scripts. If you use Group Policy to set execution policy for scripts, ensure that the Group Policy Object (GPO) that targets the organizational unit (OU) defined in the ANC allows **Unrestricted** scripts. For more information, see [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy).

## Environment and configuration are ready

This check identifies infrastructure-related issues that you might be responsible for. It can include errors such as internal service time-outs or errors caused by deleting or changing Azure resources while checks are running.

If you encounter this error, retry the checks. If it persists, contact support for help.

## First-party app permissions

When you create an ANC, the wizard grants a certain level of permissions on the resource group and subscription. These permissions let the service smoothly provision Cloud PCs.

Azure admins holding such permissions can view and modify them.

If any of these permissions are revoked, this check fails. Make sure that the following permissions are granted to the Windows 365 application service principal:

- [Reader](/azure/role-based-access-control/built-in-roles#reader) role on the Azure subscription.
- [Windows365 Network Interface Contributor](/azure/role-based-access-control/built-in-roles#network-contributor) role on the specified resource group.
- [Windows365 Network User](/azure/role-based-access-control/built-in-roles#network-contributor) role on the virtual network.

The role assignment on the subscription is granted to the Cloud PC service principal.

Also, make sure that the permissions aren't granted as [classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles#classic-subscription-administrator-roles) or "Roles (Classic)." This role isn't sufficient. It must be one of the Azure role-based access control built-in roles as listed previously.

## Investigate with Windows 365 Admin Assistant (preview)

You can use Windows 365 Admin Assistant in the Microsoft Intune admin center to help investigate Azure network connection (ANC) issues. Provide the ANC name, failed health check or error message, and approximate time of the failure. Admin Assistant can review available ANC health and configuration information, explain the reported failure, and suggest relevant troubleshooting steps.

For example, you can ask:

- ANC `ANC ID` failed the DNS check. What should I verify about DNS configuration and domain controller connectivity?

- Help me investigate this ANC's endpoint connectivity failure. Which network requirements should I check? Here is the ID: `ANC ID`.

- Could this ANC health-check failure explain the connection issues reported for these Cloud PCs?

If an Azure network connection health check reports an error, use the corresponding troubleshooting section in this article to validate the Assistant's recommendations and perform any required tests or configuration changes. If the issue persists, contact Microsoft Support.

## Next steps

[Learn about the ANC health checks](/windows-365/enterprise/health-checks).
