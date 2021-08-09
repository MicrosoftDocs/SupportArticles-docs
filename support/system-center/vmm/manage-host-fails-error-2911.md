---
title: Managing a host fails with error 0x8007000E
description: Fixes an issue in which you receive error 2911 when you manage a host in Virtual Machine Manager.
ms.date: 07/09/2020
ms.prod-support-area-path: 
---
# Managing a host in VMM fails with error 2911 - Not enough storage is available to complete this operation (0x8007000E)

This article helps you fix an issue in which you receive error 2911 when you manage a host in Virtual Machine Manager (VMM).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2016 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2869591

## Symptoms

The following error message is generated when managing a Hyper-V host with Virtual Machine Manager:

> Error (2911)  
> Insufficient resources are available to complete this operation on the HVhost01.contoso.com server.  
> Not enough storage is available to complete this operation (0x8007000E)
>
> Recommended Action  
> Ensure that the virtual machine host has sufficient memory and disk space to perform this action. Try the operation again.

## Cause

It can occur if Windows Management Framework (WMF) 3.0 is installed on Hyper-V host without also applying update [2781512](https://support.microsoft.com/help/2781512).

## Resolution

To resolve this issue install hotfix [2781512](https://support.microsoft.com/help/2781512).

Other issues that can cause this error:

1. Antivirus blocking Windows Management Instrumentation (WMI) access.
2. Missing VMM optimizations found in [Troubleshoot Needs Attention, Not Responding, and Access Denied hosts in Virtual Machine Manager](troubleshoot-host-status-errors.md).

## More information

- [WinRM operations to Hyper-V fail on a Windows 7 SP1-based or Windows Server 2008 R2 SP1-based computer that has Windows Management Framework 3.0 installed](https://support.microsoft.com/help/2781512)

- [Troubleshoot Needs Attention, Not Responding, and Access Denied hosts in Virtual Machine Manager](troubleshoot-host-status-errors.md)
