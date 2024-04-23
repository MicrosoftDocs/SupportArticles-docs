---
title: Error when you try to migrate a virtual machine between two stand-alone hosts
description: Error occurs when trying to migrate a virtual machine between two stand-alone hosts.
ms.date: 04/09/2024
ms.reviewer: jarrettr
---
# The host does not have access to sufficient storage of the requested classification error when migrating a VM

This article helps you fix an issue in which you receive **The host does not have access to sufficient storage of the requested classification** error when you migrate a virtual machine between two stand-alone hosts.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2823834

## Symptoms

When you use System Center 2016 Virtual Machine Manager (VMM 2016) or VMM 2012 to migrate a virtual machine (VM) between two stand-alone hosts, the operation fails with the following error:

> The host does not have access to sufficient storage of the requested classification for one or more virtual disks associated with virtual machine <**VM_NAME**>.

## Cause

It can occur if the virtual machine on the source host is located on storage that is classified as **Remote**, and if the target host doesn't also have storage that is classified as **Remote** (that is, if it has access only to storage that is classified as **Local**). In versions of VMM earlier than VMM 2012 SP1, VM migrations from **Remote** storage to **Local** storage aren't supported.

## Workaround

To work around this issue, migrate the storage of the virtual machine to the same source host's **Local** storage classification. After you do it, the VM migration between the stand-alone hosts shouldn't be blocked.

## More information

In System Center 2012 Virtual Machine Manager Service Pack 1 (SP1) and later versions, you'll continue to see this error message. However a change was made in the placement wizard to remove the blocking condition and enable you to select the **Next** button to complete the migration anyway.
