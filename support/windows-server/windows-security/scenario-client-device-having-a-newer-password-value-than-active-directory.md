---
title: Client device having a newer password value than Active Directory
description: Introduces the resolution for the scenario in which client device having a newer password value than Active Directory.
ms.date: 10/18/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom: sap:Windows Security\Netlogon, secure channel, DC locator, csstroubleshoot
---
# Client device having a newer password value than Active Directory

After collecting data based on the steps in [Data collection for troubleshooting secure channel issues](data-collection-for-troubleshooting-secure-channel-issues.md), you may find Active Directory value for pwdLastSet attribute has an older value than Cupdtime in affected device. This article introduces the common causes and the resolution.

## Common causes

- Active Directory replication issues.
- A Domain Controller recovered from a backup.
- Authoritative restore of the computer object in Active Directory

All these common reasons need to be resolved from Active Directory end, as the issue cannot be resolved on client device end. Data should be consistent across all domain controllers. We recommend you check Active Directory replication status, domain controllers health and network communication. See [more information](#more-information) section for further reference.

## Resolution

Once the issue has been resolved at the Active Directory end, reset computer secure channel by following these steps:

1. Run the following commands:

   ```console
   nltest /sc_reset:domain_name
   ```

   Or, in PowerShell:

   ```powershell
   Test-ComputerSecureChannel -Repair -Credential *
   ```

2. Reboot device.

## More information

- Active Directory replication troubleshooting - [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems)
- Active Directory required ports - [Configure firewall for AD domain and trusts](../active-directory/config-firewall-for-ad-domains-and-trusts.md)
