---
title: Troubleshoot provisioning errors
description: Troubleshoot provisioning errors in Windows 365.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: mattsha, erikje
ms.custom:
- pcy:Provisioning\Provisioning Failure
- sap:WinComm User Experience
ms.collection:
- M365-identity-device-management
- tier2
---
# Troubleshoot provisioning errors

The following errors can occur during Cloud PC provisioning.

<a name='azure-ad-service-connection-point-scp-misconfigured'></a>

## Microsoft Entra ID service connection point misconfigured

The service connection point (SCP) is used by your Cloud PCs to discover your Microsoft Entra tenant information. You must configure your SCPs by using Microsoft Entra Connect for each forest you plan to join Cloud PCs to.

If the SCP configuration doesn't exist or can't be discovered by using the virtual network declared, provisioning fails.

To understand more about the SCP and learn how to configure it, see the [Microsoft Entra documentation](/azure/active-directory/devices/hybrid-azuread-join-managed-domains).

### Suggested solution

Confirm with your identity team that the SCP exists for all target forests.

## Azure network connection isn't healthy

Cloud PC provisioning is blocked if the associated Azure network connection (ANC) isn't healthy.

The ANC refreshes every six hours. Provisioning fails if the ANC refresh fails while provisioning is underway.

### Suggested solution

Make sure that the ANC is healthy and retry the provisioning.

## Disk allocation error

Windows 365 provisioned the Cloud PC but didn't allocate the full OS storage according to what the user should have received based on their assigned Windows 365 license. As a result, the user can't see or use the full storage that they were assigned.

### Suggested solution

Retry provisioning.

## Domain join failed

Windows 365 failed to join the Cloud PC to your on-premises Active Directory (AD) domain. Many factors can cause this failure.

- Make sure that the AD domain, organizational unit (OU), and credentials in the associated ANC are correct.
- Make sure that the domain join user has sufficient permissions to perform the domain join.
- Make sure that the virtual network and subnet can reach a domain controller correctly.

`JsonADDomainExtension` is the Azure function used to perform this domain join. Make sure that everything required for this domain join to succeed is in place.

### Suggested solution

Attach an Azure virtual machine (VM) to the configured virtual network and perform a domain join using the credentials provided.

<a name='hybrid-azure-ad-join-failed'></a>

## Microsoft Entra hybrid join failed

Windows 365 doesn't perform any Microsoft Entra hybrid join function for the customer. Microsoft Entra hybrid join must be configured and healthy as a prerequisite for Cloud PC.

If provisioning fails because of Microsoft Entra hybrid join, it's likely because of an insufficient sync period configured in your AD Sync service. Make sure that Microsoft Entra Connect is configured to sync the AD computer objects every 30 minutes, and no more than 60 minutes. This step times out if the Microsoft Entra object doesn't appear within 90 minutes.

Another factor to consider is your on-premises AD replication time. Make sure that the domain controller being used for Windows 365 is replicated fast enough to make it into Microsoft Entra ID within this five-hour time-out window.

If your organization uses Active Directory Federation Services (ADFS), this registration process is optimized and might result in Cloud PC provisioning being completed faster than a Microsoft Entra Connect sync might be.

### Suggested solution

Check to see if the AD object:

- Appears in the correct OU.
- Is successfully synced to Microsoft Entra ID before provisioning times out.

## Intune enrollment failed

Windows 365 performs a device-based mobile device management (MDM) enrollment into Intune.

If Intune enrollment fails, make sure that:

- All of the required Intune endpoints are available on the virtual network of your Cloud PCs.
- There are no MDM enrollment restrictions on the tenant. Windows corporate device enrollment is allowed in custom and default policies.
- The Intune tenant is active and healthy.
- If co-managing Cloud PCs with Intune and Configuration Manager, ensure that the Cloud PC OU isn't targeted for client push installation. Instead deploy the Configuration Manager agent from Intune. For more information, see [Client installation methods in Configuration Manager](/mem/configmgr/core/clients/deploy/plan/client-installation-methods).

### Suggested solution

Attempt an Intune enrollment using a test device or VM.

## License not found

While provisioning is in progress, someone removed the user's Windows 365 license.

### Suggested solution

Make sure that the user has a valid license associated with it.

## Local administrator permissions error

Windows 365 provisioned the Cloud PC but didn't grant the user local administrator permissions as defined by a User Settings policy. As a result, the user won't be an administrator on their Cloud PC. So, they can't make system-level changes or install apps on the system-level context.

### Suggested solution

Retry provisioning or create a new User Settings policy.

## Microsoft Teams optimization error

Windows 365 provisioned the Cloud PC. However, it didn't configure the Cloud PC to use Microsoft Teams in the mode optimized for running on a remote VM. This optimization doesn't install Microsoft Teams and all of its components. It only sets the configuration that takes effect if you install Microsoft Teams on the Cloud PC. If this optimization isn't set and Microsoft Teams is installed on this device, Microsoft Teams doesn't run in the optimized mode for remote connections.

### Suggested solution

Retry provisioning.

## Not enough IP addresses available

When providing a subnet to the ANC, make sure that there are more than sufficient IP addresses.

Every Cloud PC provisioning process uses one of the IP addresses provided in the range.

If provisioning fails, it's retried a total of three times. Each time, a new vNic and IP address are allocated. These IP addresses are released in hours, but this allocation can cause issues if the address space is too narrow.

### Suggested solution

Check the virtual network for available IP addresses, and make sure that there are more than enough IPs available for the retry process to succeed.

## Provisioning policy not found

While provisioning is in progress, someone deleted the provisioning policy.

### Suggested solution

Make sure that the provisioning policy is available and assigned to the correct user group.

## Request disallowed by policy

Windows 365 uses the customer-provided virtual network to perform a vNic ingestion from the Cloud PC into the customer's virtual network. Sometimes an enterprise implements an Azure Policy to restrict the creation of certain Azure objects. Make sure that there are no Azure policies that might restrict Windows 365 from creating Azure objects on your behalf.

### Suggested solution

View **Policy** in the Azure portal and look for any policy events stopping the Windows 365 service from provisioning the Cloud PC.

## Start menu power icons error

Windows 365 provisioned the Cloud PC but didn't hide the shutdown and restart icons in the Start menu. As a result, the user sees the shutdown and restart icons in the Start menu. If the user ends their Cloud PC connection by selecting the shutdown icon, they might need to restart the Cloud PC from the Cloud PC portal before connecting again.

### Suggested solution

Retry provisioning or create a device configuration policy to [hide the shutdown button](/windows/client-management/mdm/policy-csp-start#start-hideshutdown) and [hide the restart button](/windows/client-management/mdm/policy-csp-start#start-hiderestart).

## Supported Azure regions for Cloud PCs not listed in the provisioning user interface

If a specific region isn't listed in the Cloud PC provisioning user interface (UI), but is listed in the [Windows 365 requirements documentation](/windows-365/enterprise/requirements), Windows 365 might expand in a new region. If your networking infrastructure is in such a region, select **New support request** to open a support ticket for evaluation.

## Time zone redirection error

Windows 365 provisioned the Cloud PC but didn't configure time zone redirection. As a result, the user doesn't see their local time reflected when connected to their Cloud PC. Instead, they see the standard UTC time.

### Suggested solution

Retry provisioning or create a Group Policy Object with the **Allow time zone redirection** group policy configured. To learn more about the policy, download the [Group Policy Settings Reference Spreadsheet](https://www.microsoft.com/download/101451).

## User not found

While provisioning is in progress, someone deleted the associated user.

### Suggested solution

Make sure that the assigned user account is valid.

## Windows reset error

Windows 365 provisioned the Cloud PC but didn't disable the built-in Windows reset option. As a result, the user can manually trigger the built-in Windows reset option under **Settings**. The Cloud PC will never successfully complete the reset, which makes the Cloud PC unusable.

### Suggested solution

Retry provisioning.

## Blocking High Risk Ports: One or more high risk ports couldn't be disabled

Windows 365 provisioned the Cloud PC but was unable to block all high-risk ports based on Microsoft security standards. Windows 365 disables high-risk ports used to manage resources or unsecured/unencrypted data transmission and shouldn't be exposed to the internet by default.

If you receive this error, some factors to consider are:

- Sometimes, an enterprise implements an Intune group policy that enables one of these ports by default.  
- Make sure that there are no Intune policies that might override Windows 365's default of disabling these high-risk ports.

### Suggested solution

Try any of these solutions:

- Retry provisioning.
- If the device is Intune-enrolled, you can apply the Intune policy to disable the ports.
- The user can also disable the ports manually by adding a local firewall rule to their device. For a list of high-risk ports that are recommended for blocking, see [Security admin rules in Azure Virtual Network Manager](/azure/virtual-network-manager/concept-security-admins#protect-high-risk-ports).

## Other provisioning failures

If you encounter other provisioning errors not covered previously, make sure all the [required endpoints](/windows-365/enterprise/requirements-network?tabs=enterprise%2Cent#allow-network-connectivity) are allowed on the virtual network used for your ANC and any gateway device.

## Next steps

[Troubleshooting Windows 365 issues](/windows-365/enterprise/troubleshooting).
