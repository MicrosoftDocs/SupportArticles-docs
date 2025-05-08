---
# required metadata
title: Troubleshoot Azure network connections
description: Troubleshoot Azure network connections in Windows 365.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: ericor, erikje
ms.custom: intune-azure, get-started
ms.collection:
- M365-identity-device-management
- tier2
---
# Troubleshoot Azure network connections

The Azure network connection (ANC) periodically checks your environment to make sure that all requirements are met and that it's in a healthy state. If any check fails, you can see error messages in the Microsoft Intune admin center. This guide contains some further instructions for troubleshooting issues that might cause checks to fail.

## Active Directory domain join

When a Cloud PC is provisioned, it's automatically joined to the provided domain. To test the domain join process, a domain computer object is created in the defined organizational unit (OU) with a name similar to "CPC-Hth" every time Windows 365 health checks are run. These computer objects are disabled when the health check is complete. Active Directory domain join failure can occur for many reasons. If the domain join fails, make sure that:

- The domain join user has sufficient permissions to join the domain provided.
- The domain join user can write to the OU provided.
- The domain join user isn't restricted in how many computers they can join. For example, the default maximum number of joins per user is 10, and this maximum can affect Cloud PC provisioning.
- The subnet being used can reach a domain controller.
- You test `Add-Computer` using the domain join credentials on a virtual machine (VM) connected to the Cloud PC vNet/subnet.
- You troubleshoot domain join failures like any physical computer in your organization.
- If you have a domain name that can be resolved on the internet (like `contoso.com`), make sure that your Domain Name System (DNS) servers are configured as internal. Also, make sure that they can resolve Active Directory domain DNS records, not your public domain name.

If you encounter the following errors in your ANC health checks, consider the following suggestions to ensure your Azure and on-premises configurations can successfully reach the required Windows 365 endpoints:

> Internal Server Error

> InternalServerErrorUnableToRunDscScript

### Domain controller line of sight

Successful communication with a domain controller within your organization is essential for configuring an ANC to allow hybrid domain-joined Cloud PCs. Ensure that the Azure vNet used for your ANC connection has a network route to a domain controller and ensure that your DNS setup can successfully resolve it.

> [!NOTE]
> This section only applies to hybrid environments.

### ANC Endpoint Access

During ANC configuration, the service needs to download configuration data from various Microsoft endpoints as listed in [Network requirements](/windows-365/enterprise/requirements-network). Failure to reach these endpoints due to misconfigured network settings can lead to a failure. To ensure successful access, Transport Layer Security (TLS) inspection should be avoided on any vNET used for ANC connections. Ensure that you can successfully resolve and reach these endpoints through the Azure vNet used and ensure that any firewall, proxy, or other Network services employed within the network allow access to them.

<a name='azure-active-directory-device-sync'></a>

## Microsoft Entra device sync

Before mobile device management (MDM) enrollment can take place during provisioning, a Microsoft Entra ID object must be present for the Cloud PC. This check is intended to make sure that your organizations computer accounts are syncing to Microsoft Entra ID in a timely manner.

Make sure that your Microsoft Entra computer objects appear in Microsoft Entra ID quickly. We recommend that they appear within 30 minutes, and no longer than 60 minutes. If the computer object doesn't arrive in Microsoft Entra ID within 90 minutes, provisioning fails.

If provisioning fails, make sure that:

- The sync period configuration on Microsoft Entra ID is set appropriately. Speak with your identity team to make sure that your directory is syncing fast enough.
- Your Microsoft Entra ID is active and healthy.
- Microsoft Entra Connect is running correctly, and there are no issues with the sync server.
- You manually perform an `Add-Computer` into the OU provided for Cloud PCs. Time how long it takes for that computer object to appear in Microsoft Entra ID.

> [!NOTE]
> If you receive the following warning after confirming that the recommended configuration is correctly set and are not experiencing provisioning failures, no further action is required. This warning can occur if the check is performed directly after a sync has been completed.

## Azure subnet IP address range usage

As part of the ANC setup, you're required to provide a subnet to which the Cloud PC connects. For each Cloud PC, provisioning creates a virtual NIC and consumes an IP address from this subnet.

Make sure that sufficient IP address allocation is available for the number of Cloud PCs you expect to provision. Also, plan enough address space for provisioning failures and potential disaster recovery.

If this check fails, make sure that you:

- Check the subnet in the Azure virtual network. It should have enough address space available.
- Make sure there are enough addresses to handle three provisioning retries, each of which might hold onto the network addresses used for a few hours.
- Remove any unused virtual network interface cards (vNICs). It's best to use a dedicated subnet for Cloud PCs to make sure that no other services are consuming the allocation of IP addresses.
- Expand the subnet to make more addresses available. This can't be completed if there are devices connected.

During provisioning attempts, it's important to consider any CanNotDelete locks that might be applied at the resource group level or higher. If these locks are present, the network interfaces created in the process aren't automatically deleted. If they aren't automatically deleted, you must manually remove the vNICs before you can retry.

During provisioning attempts, it's important to consider any existing locks at the resource group level or higher. If these locks are present, the network interfaces created in the process won't be automatically deleted. If the event occurs, you must manually remove the vNICs before you can retry.

## Azure tenant readiness

When checks are performed, we check that the provided Azure subscription is valid and healthy. If it's not valid and healthy, we're unable to connect Cloud PCs back to your virtual network during provisioning. Problems such as billing issues might cause subscriptions to become disabled.

Many organizations use Azure policies to make sure that resources are only provisioned into certain regions and services. You should make sure that any Azure policies consider the Cloud PC service and the supported regions.

Sign in to the Azure portal and make sure that the Azure subscription is enabled, valid, and healthy.

Also, visit the Azure portal and view **Policies**. Make sure that no policies are blocking resource creation.

## Azure virtual network readiness

When creating an ANC, we block the use of any virtual network located in an unsupported region. For a list of supported regions, see [Requirements](/windows-365/enterprise/requirements).

If this check fails, make sure that the virtual network provided is in a region in the supported region list.

## DNS can resolve the Active Directory domain

For Windows 365 to successfully perform a domain join, the Cloud PCs attached to the virtual network provided must be able to resolve internal DNS names.

This test attempts to resolve the domain name provided. For example, contoso.com or contoso.local. If this test fails, make sure that:

- The DNS servers in the Azure virtual network are correctly configured to an internal DNS server that can successfully resolve the domain name.
- The subnet/vNet is routed correctly so that the Cloud PC can reach the DNS server provided.
- The Cloud PCs/VMs in the declared subnet can `NSLOOKUP` on the DNS server, and it responds with internal names.

Along with the standard DNS lookup on the supplied domain name, we also check for the existence of `_ldap._tcp.yourDomain.com` records. This record indicates the DNS server provided is an Active Directory domain controller. The record is a reliable way to confirm that AD domain DNS is reachable. Make sure that these records are accessible through the virtual network provided in your ANC.

## Endpoint connectivity

During provisioning, Cloud PCs must connect to multiple publicly available Microsoft services. These services include Microsoft Intune, Microsoft Entra ID, and Azure Virtual Desktop.

You must make sure that all of the [required public endpoints](/windows-365/enterprise/requirements-network#allow-network-connectivity) can be reached from the subnet used by Cloud PCs.

If this test fails, make sure that:

- You use the Azure virtual network troubleshooting tools to ensure that the provided vNet/subnet can reach the service endpoints listed in the doc.
- The DNS server provided can resolve the external services correctly.
- There's no proxy between the Cloud PC subnet and the internet.
- There are no firewall rules (physical, virtual, or in Windows) that might block required traffic.
- You consider testing the endpoints from a VM on the same subnet declared for Cloud PCs.

If you aren't using Azure CloudShell, make sure that your PowerShell execution policy is configured to allow **Unrestricted** scripts. If you use Group Policy to set execution policy, make sure that the Group Policy Object (GPO) targeted at the OU defined in the ANC is configured to allow **Unrestricted** scripts. For more information, see [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy).

## Environment and configuration are ready

This check is used for many infrastructure-related issues that might be related to infrastructure that customers are responsible for. It can include errors such as internal service time-outs or errors caused by customers deleting/changing Azure resources while checks are being run.

We recommend you retry the checks if you encounter this error. If it persists, contact support for help.

## First-party app permissions

When you create an ANC, the wizard grants a certain level of permissions on the resource group and subscription. These permissions let the service smoothly provision Cloud PCs.

Azure admins holding such permissions can view and modify them.

If any of these permissions are revoked, this check fails. Make sure that the following permissions are granted to the Windows 365 application service principal:

- [Reader](/azure/role-based-access-control/built-in-roles#reader) role on the Azure subscription.
- [Windows365 Network Interface Contributor](/azure/role-based-access-control/built-in-roles#network-contributor) role on the specified resource group.
- [Windows365 Network User](/azure/role-based-access-control/built-in-roles#network-contributor) role on the virtual network.

The role assignment on the subscription is granted to the Cloud PC service principal.

Also, make sure that the permissions aren't granted as [classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles#classic-subscription-administrator-roles) or "Roles (Classic)." This role isn't sufficient. It must be one of the Azure role-based access control built-in roles as listed previously.

## Next steps

[Learn about the ANC health checks](/windows-365/enterprise/health-checks).
