---
title: Unable to migrate virtual machine from one host to another
description: Describes the errors that occur when you migrate a Virtual Machine (VM) from one Host to another from the SCVMM 2008 Console.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:live-migration, csstroubleshoot
---
# Unable to migrate virtual machine from one host to another

This article describes the errors that occur when you migrate a Virtual Machine (VM) from one Host to another from the SCVMM 2008 Console.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969726

## Symptoms

When you try to migrate a Virtual Machine (VM) from one Host to another from the SCVMM 2008 Console, it may fail with the following error:

> "Unable to migrate the virtual machine \<virtual Machine Name> because the processor is not compatible with the host \<Host Name>"  
>
> "Unable to migrate the virtual machine \<name> because the processor is not compatible with the host \<host>."

This error appears in the Migrate Virtual Machine Wizard in the "Rating Explanation" section, where the rating was zero.

The target host may also show the following status:

> Overall Status: OK
>
> Connection status: Responding
>
> Agent status: Responding
>
> Agent version: Up-to-date
>
> Virtualization service status: Running
>
> Virtualization service version: Up-to-date

The box next to "This host is available for placement" is checked.

## Cause

When migrating a Virtual Machine that has a saved state, SCVMM uses built-in checks to determine whether a saved state VM can be migrated between hosts or deployed from a library to a host. If these checks fail, then we get the error message. A few things we compare include:

- Manufacturer (for example, Intel vs AMD)

- Processor architecture (x86 vs x64)

- Virtual Server version (SP1 vs R2 SP1)

- Family of the processor

If any of these values are different between the two hosts, then that host isn't valid to do a saved state migration.

## Resolution

As a workaround, you can delete the Snapshots/Checkpoints and shutdown the VM. Once you do this, you should be able to migrate it from one host to another.

> [!Note]
> In VMM 2008 R2, you can set the Allow migration to a virtual machine host with a different processor property to allow a virtual machine to run on a host that has a different processor version than the host on which the virtual machine was created. The virtual machine must be stopped to set this property.

> [!IMPORTANT]
> Setting the Allow migration to a virtual machine host with a different processor property allows for greater flexibility in live or saved-state migrations; however, it reduces the functionality of the virtual machine's processor. So you should use this only when necessary, such as to facilitate live migration between clustered hosts that have different processor versions.Setting the Allow migration to a virtual machine host with a different processor property allows for greater flexibility in live or saved-state migrations; however, it reduces the functionality of the virtual machine's processor. So you should use this only when necessary, such as to facilitate live migration between clustered hosts that have different processor versions.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
