---
title: Guidance for troubleshooting virtual machine live migration
description: Introduces general guidance for troubleshooting scenarios related to virtual machine live migration.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:live-migration, csstroubleshoot
---
# Virtual machine live migration troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806289" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Active Directory replication issues</span>

This article is designed to get you started on troubleshooting issues encountered during virtual machine live migration.

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
    
    Open **Log on as a service** and check whether the following user accounts are listed:  
    - NT SERVICE\ALL SERVICES  
    - NT VIRTUAL MACHINE\Virtual Machines

- Check for the antivirus exclusions. For more information, see [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md).
- Check the corruption of the *Registry.pol* file:  
  Run notepad and open *C:\\Windows\\System32\\GroupPolicy\\Machine\\Registry.pol*. The file must start with the **PReg** signature.
- Compare permissions on the folders containing the virtual machines files with a working host with the same operating system level.

## Common issues and solutions

For more information about the common issues and solutions for virtual machine live migration, see [Troubleshoot live migration issues](troubleshoot-live-migration-issues.md).

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Run the SDP tool to collect the logs from the source and destination nodes.
4. Unzip the file and run the following cmdlet on both nodes:

    ```PowerShell
    TSS.ps1 -SDP HyperV -SkipSDPList skipBPA,skipTS
    ```

Collect all logs. Zip and upload the collection on the workspace.
