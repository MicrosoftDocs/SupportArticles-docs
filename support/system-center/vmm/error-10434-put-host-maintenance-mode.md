---
title: Error 10434 when putting a host into Maintenance Mode
description: Describes an issue in which you receive a 10434 No suitable host is available for migrating the existing highly available virtual machines error.
ms.date: 04/09/2024
ms.reviewer: wenca, vladrai
---
# Putting a VMM 2012 host with a third-party switch extension into Maintenance Mode fails with error 10434

This article helps you fix an issue where you receive error 10434 when trying to put a Virtual Machine Manager host that has a third-party switch extension into Maintenance Mode.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2922318

## Symptoms

When you try to put a Virtual Machine Manager host that has a third-party switch extension installed into Maintenance Mode, you receive the following error message:

> 10434 No suitable host is available for migrating the existing highly available virtual machines.

## Cause

This issue can occur if most of the ports on switch extensions and port profiles are being used.

## Resolution

To resolve this issue, take one of the following actions:

- Increase the maximum number of available ports on switch extensions and port profiles. There should be at least one available port for each virtual machine.
- Live-migrate virtual machines that are using switch extensions manually one by one before you put the host in Maintenance Mode.
