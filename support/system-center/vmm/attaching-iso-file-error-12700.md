---
title: Error 12700 when attaching an ISO file
description: Fixes an issue in which you can't attach an ISO file to a virtual machine and receive error 12700.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt
---
# Attaching an ISO file in System Center 2012 Virtual Machine Manager fails with error 12700

This article helps you fix an issue in which you can't attach an ISO file to a virtual machine and receive error 12700.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2689989

## Symptoms

In System Center 2012 Virtual Machine Manager, attaching an ISO file to a virtual machine may fail with the following error if the **Share image file instead of copying it** option is selected:

> Error (12700)  
> VMM cannot complete the host operation on the *servername.domainname.com* server because of the error: '*VMName*' failed to add device 'Microsoft Virtual CD/DVD Disk'. (Virtual machine ID C6025A28-89F0-45F9-A28E-42FE334B1C87)  
>
> '*VMName*': The Machine Account '*DOMAINNAME\SERVERNAME$*' does not have read access to file share '*\\\servername.domainname.com\MSSCVMMLibrary\Filename.iso*'. Please add this machine account to the file share security. Error: 'General access denied error' (0x80070005). (Virtual machine ID C6025A28-89F0-45F9-A28E-42FE334B1C87)  
> Unknown error (0x8001)

## Cause

This issue can occur if the library share permissions are incorrect or constrained delegation wasn't configured for the Hyper-V host.

## Resolution

To resolve this issue, perform the steps documented in [How to Enable Shared ISO Images for Hyper-V Virtual Machines in VMM](/previous-versions/system-center/virtual-machine-manager-2008-r2/ee340124(v=technet.10)?redirectedfrom=MSDN).
