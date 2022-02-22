---
title: Guidance of troubleshooting live migration
description: Introduces general guidance of troubleshooting scenarios related to live migration.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:live-migration, csstroubleshoot
ms.technology: hyper-v
---
# Live migration troubleshooting guidance

This article is designed to get you started on troubleshooting issues encountered during live migration.

## Troubleshooting checklist

- Check the hosts are at the same level of patching and whether they can update to the latest rollup.
- Update the BIOS, firmware and third party drivers.
- Check whether the virtual machines have the latest matching integration services.
- Check whether the migration is authorized on each side.
- Check whether the protocol used is identical on each side.
- Check whether the TCP Port 6600 and 3343 (for clustering) are listening on both sides.
- Check compatibilities issues by running a `Compare-VM` command. Provide the name of the VM and the destination host. For example:

  ```powershell
  Compare-VM -Name <vm_name> -DestinationHost <host_name>
  ```

- Check whether any group policy object is preventing the migration from occurring. Verify that the following policy have at least the default settings.
  - Open *GPEDIT.MSC* and navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**.  
    Open **Create symbolic links** and check whether the following user accounts are listed:  
    - Administrators  
    - NT VIRTUAL MACHINE\Virtual Machines  
    - Log on as a service  
    - NT SERVICE\ALL SERVICES  
    - NT VIRTUAL MACHINE\Virtual Machines

- Check for the antivirus exclusions. For more information, see [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md).
- Check the corruption of the *Registry.pol* file:  
  Run notepad and open *C:\\Windows\\System32\\GroupPolicy\\Machine\\Registry.pol*. The file must start with the **PReg** signature.
- Compare permissions on the folders containing the virtual machines files with a working host with the same operating system level.

## Common issues and solutions

For more information about the common issues and solutions for live migration, see [Troubleshoot live migration issues](troubleshoot-live-migration-issues.md).
