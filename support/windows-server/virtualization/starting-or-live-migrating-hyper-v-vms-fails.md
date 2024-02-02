---
title: Starting or live migrating Hyper-V VMs fails
description: Error 0x80070569 occurs when you try to start or do a live migration for a Hyper-V virtual machine.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, ctimon, kledman
ms.custom: sap:live-migration, csstroubleshoot
ms.subservice: hyper-v
---
# Starting or live migrating Hyper-V virtual machines may fail with error 0x80070569

This article provides workarounds to solve the issue that virtual machines can't start or you can't do a live migration for a Hyper-V virtual machine in Windows Server.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2779204

## Symptoms

Virtual machines running on Windows Server 2016 or Windows Server 2012 R2 Hyper-V hosts may fail to start. You may receive an error message that's similar to:

> Error 0x80070569 ('VM_NAME' failed to start worker process: Logon Failure: The user has not been granted the requested logon type at this computer.)

When you do a live migration of a Hyper-V virtual machine, the live migration may fail. You may receive an error message that's similar to:

> Failed to create Planned Virtual Machine at migration destination: Logon failure: the user has not been granted the requested logon type at this computer. (0x80070569)

Additionally, when you do a recovery checkpoint and try to convert it to a reference point by using the `ConvertToReferencePoint` method, the conversion may fail. You may receive an error message that's similar to:

> Failed to write VHD attachment "VHDX_NAME" to "VM_NAME": Account restrictions are preventing this user from signing in. For example, blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced. (0x8007052f)

> [!NOTE]
> The issue may stop temporarily if an Administrator logs into the Hyper-V host and runs the command `gpupdate /force`.

## Cause

This issue occurs because the NT Virtual Machine\Virtual Machines special identity doesn't have the **Log on as a service** right on the Hyper-V host computer. Usually, the Virtual Machine Management Service (VMMS) replaces this user permission at every Group Policy refresh to ensure it's always present. However, you may notice that the Group Policy refresh doesn't function correctly in certain situations.

## Workaround

To work around this problem, use the output of the `gpresult` command to identify the Group Policy Object (GPO) that modifies user rights settings. Then, use one of the following methods to correct the issue:

### Method 1

Place the computer account for the Hyper-V Host in an Organizational Unit (OU) that doesn't have any policies applied, that manage user rights, and then run `gpupdate /force` command or reboot the computer. It should remove the user rights applied by policy and allow user rights defined in the local security policy to take effect.

### Method 2

Take the following steps on the Hyper-V host machine:

1. Sign in to the machine as a Domain Administrator.
2. Install the Group Policy Management feature from the Server Manager console.
3. After installation, open the GPMC MMC snap-in and browse to the policy that manages User Rights.
4. Edit the policy to include NT Virtual Machine\Virtual Machines in the entries for **Log on as a service**.
5. Close the policy editor.
6. Run `gpupdate /force` on the Hyper-V host computer to refresh policy. You may need to wait several minutes for Active Directory replication to occur.

### Method 3

Take the following steps on a client computer running Windows 8 that supports the [Client Hyper-V](/previous-versions/windows/it-pro/windows-8.1-and-8/hh857623(v=ws.11)) feature:

1. Sign in to the machine as a Domain Administrator.
2. Install the Client Hyper-V feature.
3. Install the Windows 8 Remote Server Administration Tools (RSAT).
4. Open the Group Policy Management console and browse to the policy that manages User Rights.
5. Edit the policy to include NT Virtual Machine\Virtual Machines on the entries for the **Log on as a service** user right.
6. Close the policy editor on the client.
7. Run `gpupdate /force` on the Hyper-V host to refresh policy. You may need to wait several minutes for Active Directory replication to occur.

## Best practices about Hyper-V hosts

Don't install any extra roles or features that don't specifically support virtualization on Hyper-V servers. For example, in a Hyper-V Cluster, the Hyper-V Role and the Failover Clustering feature are installed to support highly available virtualized workloads. Hyper-V hosts play a critical role in an organizations' virtualization strategy. If Hyper-V servers are domain-joined, we recommend that you manage them in a separate OU in Active Directory. Only group policies that apply specifically to Hyper-V host machines should be applied to this OU. Doing so minimizes the risk of a policy conflict affecting the proper functioning in a Hyper-V host.

## Best practices about management of user rights, file system permissions, and registry permissions via Group Policy

You can manage the following items via GPOs:

- User rights assignments
- File system permissions
- Registry permissions

However, the management interface available in Group Policy will overwrite any of these items defined locally on the computer. You should always use these capabilities with caution. Make sure that the GPOs that set these items apply only to the computers that actually need them. Since these items aren't cumulative, any GPO that applies these items must contain all security principals or service accounts that may be operating on the computers where the GPOs apply.

## Best practices about the Default Domain Policy

The Default Domain Policy is used programmatically by the operating system. It maintains critical, domain-wide policies that can only be set in this policy object. So the Default Domain Policy should only be modified when necessary. To manage Group Policy settings for the entire domain, administrators should create new policy objects linked at the domain level. Whenever possible, policies should be applied at the OU level rather than the domain level. So, settings are applied only to the users and computers that require them.
