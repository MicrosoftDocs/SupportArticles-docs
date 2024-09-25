---
title: The Create Virtual Machine Wizard fails if the cloud contains special characters
description: Fixes an issue where the Create Virtual Machine Wizard fails when you try to deploy the new VM to a cloud that has special characters in its name.
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# The Create Virtual Machine Wizard fails if the cloud contains special characters

This article helps you fix an issue where the **Create Virtual Machine Wizard** fails to create a new virtual machine (VM) when you try to deploy the VM to a cloud that has special characters in its name.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2690609

## Symptoms

The Microsoft System Center 2012 Virtual Machine Manager (VMM) Create Virtual Machine Wizard may fail to create a new virtual machine when attempting to deploy to a cloud that has special characters in its name. The following error will be displayed in the Virtual Machine Manager console:

> VMM is unable to process one of the provided parameters for the cmdlet (New-SCVirtualMachine):  
> Cannot validate argument on parameter 'Cloud'. The argument is null. Supply a non-null argument and try the command again.  
> Try the operation again. If the issue persists, contact Microsoft Help and Support.  
> ID: 12416

## Cause

This error can occur when attempting to deploy to a cloud that has square brackets in its name (such as **[Test Cloud]**).

## Resolution

To resolve this error, navigate to **VMs and Services**, and then expand **Clouds** on the upper left-hand pane of the Virtual Machine Manager console to locate the cloud with square brackets in its name. Right-click the cloud and choose **Properties**. On the **General** tab, delete the brackets in the name of the cloud.

## More information

This error doesn't occur with curly braces (**{Test Cloud}**).
