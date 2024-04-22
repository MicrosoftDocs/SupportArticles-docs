---
title: Troubleshoot issues when adding a Hyper-V host
description: Describes how to troubleshoot issues when you add a Hyper-V host in System Center 2012 Virtual Machine Manager and later versions.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt
---
# Troubleshoot issues when you add a Hyper-V host in Virtual Machine Manager

This article describes how to troubleshoot issues that occur when you add a Hyper-V host in System Center 2012 Virtual Machine Manager (VMM) and later versions.

> [!NOTE]
> **Home users**: This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager, System Center 2016 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2742275

The following errors are typically logged in the VMM console when an **Add virtual machine host** job fails:

> Error (421)  
> Agent installation failed on *servername.contoso.com* because of a WS-Management configuration error.
>
> Error (2912)  
> An internal error has occurred trying to contact an agent on the *servername.contoso.com* server.
>
> Error (2916)  
> VMM is unable to complete the request. The connection to the agent *servername.contoso.com* was lost.
>
> Error (2927)  
> A Hardware Management error has occurred trying to contact server *servername.contoso.com*.

To determine the cause of the issue, perform the following steps.

## Step 1: Review the VMM agent installation log file

On the Hyper-V host, review the vmmAgent.msi_date_time.log file that's located in the `%systemdrive%\ProgramData\VMMLogs` directory.

> [!NOTE]
> This log file may not exist if the failure occurs early in the installation process.

## Step 2: Check the current WinHTTP proxy configuration

If WinHTTP is configured to use a proxy server (`netsh winhttp set proxy`), the attempts by VMM to communicate with managed servers through a fully qualified URL (for example, `https://server.contoso.com:5986` may fail unless **Bypass proxy server for local address** is defined to exclude FQDN host addresses. In this situation, error 2916 is returned. By using \<local> alone, you'll bypass all short-name hosts. VMM uses FDQN.

To check the current WinHTTP proxy configuration, run the `netsh winhttp show proxy` command. Additionally, the bypass list must be updated to include the domain name for hosts that are being added. For example, \**.contoso.com* will bypass the proxy for all hosts that end with *contoso.com*.

Example command:

```console
netsh winhttp set proxy proxy-server="http=myproxy.contoso.com:80" bypass-list="*.contoso.com"
```

## Step 3: Verify that the ports used by VMM are not blocked by a firewall

By default, VMM uses the following ports to communicate with the Hyper-V host:

- TCP port 443
- TCP port 5985
- TCP port 5986

For more information about the ports that are used by VMM, see [Ports and Protocols for VMM](/system-center/vmm/plan-ports-protocols).

## Step 4: Check for duplicate service principal names (SPNs)

Perform the steps in [Error 2927 (0x8033809d): Unable to add a managed host in VMM 2012](add-managed-host-error-2927.md) to check for duplicate SPNs.

## Step 5: Check for corrupted performance counters on the Hyper-V host

Check the Application log on the host to see if the following event is logged:

> Log Name: Application  
> Source: Microsoft-Windows-LoadPerf  
> Event ID: 3012  
> Description:  
> The performance strings in the Performance registry value is corrupted when process Performance extension counter provider. The BaseIndex value from the Performance registry is the first DWORD in the Data section, LastCounter value is the second DWORD in the Data section, and LastHelp value is the third DWORD in the Data section.

If event ID 3012 is logged on the host machine, perform the steps in [How to manually rebuild Performance Counters for Windows Server 2008 64bit or Windows Server 2008 R2 systems](https://support.microsoft.com/help/2554336) to rebuild the performance counters.

## Step 6: Manually install the VMM agent on the Hyper-V host

If the `Add-SCVMHost` cmdlet continues to fail, manually install the agent on the Hyper-V host by performing the steps in [Installing a VMM Agent Locally](/previous-versions/system-center/virtual-machine-manager-2007/bb740757(v=technet.10)?redirectedfrom=MSDN).
