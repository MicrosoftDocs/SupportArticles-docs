---
title: Error 415 adding hosts to SCVMM
description: Fixes an issue in which you can't add hosts to System Center 2012 Virtual Machine Manager Service Pack 1 and receive error 415.
ms.date: 04/09/2024
ms.reviewer: wenca, dewitth, markstan
---
# Adding a Host to System Center 2012 Virtual Machine Manager SP1 fails with error 415

This article fixes an issue in which you can't add hosts to System Center 2012 Virtual Machine Manager Service Pack 1 and receive error 415.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2818420

## Symptoms

Adding hosts to System Center 2012 Virtual Machine Manager Service Pack 1 fails and error 415 may be present in the VMM job history. The verbatim of the error is:

> Error ( 415 )
> Agent installation failed copying C:\Program Files:\Microsoft System Center\Virtual Machine Manager\agents\I386\3.1.6011.0\msiInstaller.exe to \\\servername\ADMIN$\msiInstaller.exe.
>
> Recommended Action
>
> 1. Ensure \<servername> is online and not blocked by a firewall.
> 2. Ensure that file and printer sharing is enabled on \<servername> and it not blocked by a firewall.
> 3. Ensure that there is sufficient free space on the system volume.
> 4. Verify that the ADMIN$ share on \<servername> exists. If the ADMIN$ share does not exist, reboot \<servername> and then try the operation again.

An optional **Details** item may be logged as well that provides more information. For example:

> Details: The process cannot access the file because it is being used by another process  
> Details: The target account name is incorrect

## Cause

This can occur if the ports normally opened during vmmAgent installation failed to be opened and/or the File Server role is not enabled.

## Resolution

### Step 1: Verify that the Admin$ share is present and accessible by the VMM Run As account

Log on to the VMM server using the credentials specified for the **Run As** account used to run the job. This account must be able to connect to \\\\\<servername>\admin$ and copy a file to that share. If this fails, proceed to step 2.

### Step 2: Verify that the Run As account is a local administrator on the target machine

Log on to the target host and examine the local users and groups. Verify that this account is a member of the local administrators group.

### Step 3: Open the required ports

To open the required ports, open **Advanced Firewall** settings, choose **Inbound Rules** and scroll down to the bottom of the list. Make sure that the five items below are all enabled. In the first image below, only **Windows Remote Management** is enabled.

:::image type="content" source="media/adding-host-error-415/enable-windows-remote-management.png" alt-text="Only the Windows Remote Management is enabled in Inbound Rules.":::

The image below shows all items enabled.

:::image type="content" source="media/adding-host-error-415/windows-remote-management-and-management-instrumentation-are-enabled.png" alt-text="All the Windows Remote Management and Windows Management Instrumentation are enabled in Inbound Rules.":::

You can automate this by running the following commands:

```console
netsh advfirewall firewall set rule group="Windows Management Instrumentation (WMI)" new enable="Yes"
```

```console
netsh advfirewall firewall set rule group="Windows Remote Management" new enable="Yes"
```

### Step 4: Enable the File Sharing role

If step 1 above did not resolve the issue, enable the **File Server** role. In **Roles and Features**, place a check in **File Server**. Reboot is optional but recommended.

:::image type="content" source="media/adding-host-error-415/enable-file-server-role.png" alt-text="Enable the File Server role in the Add Roles and Features Wizard window.":::
