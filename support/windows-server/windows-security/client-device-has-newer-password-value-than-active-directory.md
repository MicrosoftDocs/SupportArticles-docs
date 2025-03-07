---
title: Client device has a newer password value than Active Directory
description: Introduces a resolution for the scenario in which the client device has a newer password value than Active Directory.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom:
- sap:windows security\netlogon,secure channel,dc locator
- pcy:WinComm Directory Services
---
# Client device has a newer password value than Active Directory

After collecting data based on the steps in [Data collection for troubleshooting secure channel issues](data-collection-for-troubleshooting-secure-channel-issues.md), you might find that the Active Directory value for the `pwdLastSet` attribute has an older value than `Cupdtime` in the affected device. This article introduces the common causes and the resolution.

## Common causes

- Active Directory replication issues.
- A domain controller recovered from a backup.
- Authoritative restoration of the computer object in Active Directory.

All these common reasons need to be resolved from the Active Directory end, as the issue can't be resolved on the client device end. Data should be consistent across all domain controllers. We recommend you check the Active Directory replication status, domain controller health, and network communication. See the [More information](#more-information) section for further reference.

## Resolution

Once the issue has been resolved at the Active Directory end, reset the computer secure channel by following these steps:

1. Run one of the following commands:

   - From a Windows command prompt:
   
      ```console
      nltest /sc_reset:domain_name
      ```

   - From a Windows PowerShell prompt:

      ```powershell
      Test-ComputerSecureChannel -Repair -Credential *
      ```

3. Reboot the device.

## More information

- Active Directory replication troubleshooting - [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems)
- Active Directory required ports - [Configure a firewall for AD domains and trusts](../active-directory/config-firewall-for-ad-domains-and-trusts.md)
