---
title: Can't connect to a Hyper-V virtual machine
description: Fixes an issue in which you can't connect to a Hyper-V VM and receive error 'Virtual Machine Manager lost the connection to the virtual machine.'
ms.date: 04/09/2024
ms.reviewer: wenca, jchornbe
---
# Virtual Machine Manager lost the connection to the virtual machine when connecting to a Hyper-V VM

This article fixes an issue in which you can't connect to a Hyper-V virtual machine (VM) and receive error **Virtual Machine Manager lost the connection to the virtual machine**.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2288932

## Symptoms

When authenticated to the System Center Virtual Machine Manager Self-Service Portal (SSP), selecting a virtual machine (VM) hosted on Windows Hyper-V and clicking **Connect to VM** results in the following error message being displayed on a white screen:

> Virtual Machine Manager lost the connection to the virtual machine because another connection was established to this machine.

Consider the following scenario:

- Two user accounts exist: *User1* and *User2*.
- *User1* isn't a configured in SCVMM anywhere.
- *User2* is a member of a self-service user role in SCVMM and is the owner of a VM.
- *User1* logs on to a Windows client and connects to the SSP where they authenticate as *User2*.
- The VM owned by *User2* is selected from the list and the **Connect to VM** button is clicked.

In this scenario, the error message above is displayed.

## Cause

This issue can occur because the credentials for the user account logged on to Windows (*User1*) are passed through instead of those used to authenticate to the SSP (*User2*).

By default the **Do not store my credentials** radio button is selected which causes this behavior.

*User1* can be authenticated on the Hyper-V host, but Authorization Manager (AzMan) fails to find any record of their privileges to connect to the VM's console. (As authentication **succeeds**, it is not considered a **failed logon attempt**.)

## Resolution

To resolve this issue, select the radio button **Store my credentials** on the logon page of the SSP. By doing this, the credentials entered here are passed through when **Connect to VM** is clicked.

## More Information

If *User2* was logged on to Windows, the problem would not occur, as both sets of credentials match. If logged on to Windows as a *local* user account instead of a *domain* account, Credentials Manager would prompt for credentials when **Connect to VM** is clicked, as local accounts cannot be used on remote machines (and entering the credentials for *User2* here would work).
