---
title: Troubleshooting Tool for Windows Guest Agent - VM assist
description: Provides script-based tool to help diagnose and resolve Azure Guest Agent issues on Azure virtual machines running Windows.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.date: 10/24/2025
ms.reviewer: v-jsitser, scotro, v-ryanberg
ms.service: azure-virtual-machines
ms.custom: sap:zzzz
---
#  Troubleshooting tool for Windows guest agent: VM assist

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

The Microsoft Azure Windows VM Agent is a secure, lightweight process that manages virtual machine (VM) interaction with the Azure fabric controller. The Azure Windows VM Agent has a primary role in enabling and running Azure VM extensions. VM extensions enable post-deployment configuration of VMs, such as installing and configuring software. VM extensions also enable recovery features, such as resetting the administrative password of a VM. Without the Azure Windows VM Agent, you can't run VM extensions.

## Purpose  
VM assist (Windows version) is a PowerShell script to diagnose issues that affect the Azure Windows VM Agent. It also examines other issues that are related to the general health of the VM. This diagnosis includes firewall rules, running services, running drivers, installed software, network adapter settings, installed software, and installed Windows Updates.

## Key features
You can view output from the checks in the PowerShell window that the script is run in. Additionally, running VM assist generates a detailed .htm report that shows the results of each check that it performs. The tool also suggests mitigations for the issues that it finds.

## Prerequisites
* Windows Server 2012 R2 and later versions of Windows
* Windows 11 or later versions of the client
* Windows PowerShell 4.0+ and PowerShell 6.0+

## How to run the tool

You can run the tool in any of the following manners.

### Option 1: Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections. See this GitHub page for the latest instruction to [install VM assist](https://github.com//azure/azure-support-scripts/blob/master/vmassist/windows/README.md).

RDP into the VM, open an elevated PowerShell window, and then run the following code to download and run the script: 

```powershell
Set-ExecutionPolicy Bypass -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(Invoke-WebRequest -Uri https://aka.ms/vmassist -OutFile vmassist.ps1) | .\vmassist.ps1
```

Alternatively, you can specify the full URL instead of the aka.ms short link:

```powershell
(Invoke-WebRequest -Uri https://raw.githubusercontent.com//azure/azure-support-scripts/master/vmassist/windows/vmassist.ps1 -OutFile vmassist.ps1) | .\vmassist.ps1
```

### Option 2: Manually download and run

Download:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://raw.githubusercontent.com//azure/azure-support-scripts/master/vmassist/windows/vmassist.ps1 -OutFile vmassist.ps1
```

Alternatively, you can specify the full URL instead of the aka.ms short link:

```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com//azure/azure-support-scripts/master/vmassist/windows/vmassist.ps1 -OutFile vmassist.ps1
```

Run the script:

```powershell
Set-ExecutionPolicy Bypass -Force
.\vmassist.ps1
```

### Option 3: Download from browser

 1. Download the ```vmassist.ps1``` file [from a web browser](https://github.com//azure/azure-support-scripts/blob/master/vmassist/windows/vmassist.ps1).
 1. In an elevated PowerShell window, make sure that you're in the same directory that you downloaded the script to, and then run the following code to run the script:

 ```powershell
Set-ExecutionPolicy Bypass -Force
.\vmassist.ps1
 ```

## Analyzing output

The script runs a series of checks to analyze the health of the VM Guest Agent and look for various known configurations that could cause issues. Each check either passes or fails in the PowerShell window. 

After the script finishes running, it also generates a log file and an html report:
 
```console
    C:\logs\vmassist_*.log
    C:\logs\vmassist_*.htm
 ```

The `.log` file has a copy of the results that are displayed in the PowerShell window for later reference.

The `.htm` file is a report that shows all the checks and findings together with information about how to mitigate the issues it finds. It also has additional information about the OS and the VM that can further assist you to troubleshoot.

If you open a support request, please include both of these log files to aid the support agent.

:::image type="content" source="media/windows-azure-guest-agent-tools-vmassist/windows-azure-guest-agent-tools-vmassist-output.png" alt-text="Azure VM assist output example." lightbox="media/windows-azure-guest-agent-tools-vmassist/windows-azure-guest-agent-tools-vmassist-output.png":::   

## Current list of checks and findings

The following table lists the current checks and findings together with any potential documentation to help you understand the issue that's detected.

| Checks | Details |
|--------|---------|
| Check for Folder| Verifies that the C:\WindowsAzure folder exists. Also used to help determine whether the Guest Agent is installed.<br><br>If this check doesn't exist, it's likely that the Guest agent has to be installed. |
| Check for binaries | Verifies that the guest agent .exe files (WindowsAzureGuestAgent.exe and WaAppAgent.exe) exist and is also used to help determine that the Guest Agent was installed.<br><br>If this check doesn't exist, it's likely that the guest agent has to be installed. |
| Status of agent services | Verifies that the guest agent services (WindowsAzureGuestAgent and RdAgent) exist. Also used to help determine whether the guest agent was installed.<br><br>If this check doesn't exist, it's likely that the guest agent has to be installed. If it is installed, make sure that it's set to `Running` and that the StartType is `Automatic`. |
| Status of `winmgmt` service | Verifies that the winmgmt service is running. |
| Status of `KeyIso` service | Verifies that the `KeyIso (CNG Key Isolation)` service is running.<br><br>See [Solution: Start the CNG Key Isolation service](windows-azure-guest-agent.md#solution-start-the-cng-key-isolation-service). |
| Check if agent services/processes have crashed | This checks whether the Guest Agent services and processes have failed during the past day. If the incident is only a one-time event, it might not be important unless it occurs at the time when the issue is reported. However, if the services constantly fail, the incident must be investigated.<br><br>Start the investigation by looking in the WaAppAgent.log and system and application event logs. |
| Checks if `stdregprov` is working | The VM agent MSI uses WMI StdRegProv to access the registry. If WMI isn't working correctly, the MSI can't set the RdAgent service path from the registry, and the MSI installation fails. <br><br> See [Guest Agent installation fails because of faulty WMI](windows-azure-guest-agent.md#guest-agent-installation-fails-because-of-faulty-wmi). |
| Agent is installed | Returns True if the guest agent is installed. Otherwise, the guest agent has to be installed. |
| Installed by PA or MSI | This check determines whether the guest agent was installed by the provisioning agent or manually through .MSI. Neither of these options are `wrong`. However, it's included for information. |
| Supported version | Checks whether the Azure Guest Agent version is up to date and supported. |
| Proxy | Checks for netsh proxies. This check doesn't look for the existence of *all* types of proxy on the system. For example, it doesn't check whether a `3rd party proxy application` is installed. <br><br>If wireserver connectivity issues exist, you can start troubleshooting by using [Troubleshooting 168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-connectivity). |
| CRP cert exists and is valid | Checks whether the CRP "Windows Azure CRP Certificate Generator" certificate exists. This certificate secures the communication with the host, and transfers protected settings that are used by extensions.<br><br> See [Troubleshoot extension certificate issues on a Windows VM in Azure](troubleshoot-extension-certificates-issues-windows-vm.md). |
| WCF debugging | This check might run if Windows Communication Framework (WCF) profiling is enabled. WCF profiling should be enabled only while debugging a WCF issue. It should not be left enabled while running a production workload.<br><br> See [Windows Azure Guest Agent service or the RdAgent service stops responding on startup (WCF)](windows-azure-guest-agent.md#windows-azure-guest-agent-service-or-the-rdagent-service-stops-responding-on-startup). |
| Wireserver (168.63.129.16) connectivity on 80, 32526, and REST API | If wireserver connectivity issues exist, you can start troubleshooting by using [Troubleshooting 168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-connectivity). |
| IMDS connectivity | IMDS connectivity isn't required for the guest agent to work, but the guest agent does try to connect. Therefore, you might see error entries in the logs. Additionally, VM assist itself gets information about the VM from IMDS to populate some sections of the .HTML file.<br><br>Not having connectivity to IMDS doesn't break the Guest Agent. See [Troubleshooting tool for Azure VM Instance Metadata Service issues](windows-vm-imds-tool.md). |
| Third-party modules in WaAppAgent and WindowsAzureGuestAgent | Other applications occasionally inject their DLLs into the Guest Agent process. Usually, this behavior doesn't cause the guest agent to fail. However, DLLs might cause unexpected failures in the Guest Agent that are difficult to debug. Although DLLs rarely cause an issue, if any of them are from unexpectedly injected applications, consider removing or reconfiguring the application so that it no longer injects its .dlls into the guest agent processes. |
| Checks permissions on machineKeys folder | Checks whether the default permissions exist on `C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys`. If improper permissions are that block access are applied, extensions that use protected settings won't work even if the guest agent is in a 'Ready' state.<br><br> See [PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86](windows-azure-guest-agent.md#pinvoke-pfximportcertstore-failed-and-null-handle-is-returned-error-code-86). |
| Checks permissions on `C:\WindowsAzure` and `C:\Packages` | Verifies that the System account has access to these directories. These directories are what the guest agent and extensions use for their binaries, configuration files, and log files. Therefore, it's important that the System account has access. |
| Sufficient disk space |This check looks for available disk space. If the disk space is filled, the guest agent might not be able to write its status file, update, install extensions, and so on. In this situation, you must either delete files or expand the disk capacity. |
| DHCP IP | If one private IP exists on the VM's network adapter, we highly recommend that you have DHCP enabled on the guest VM. If a static private IP address is needed, [configure it through the Azure portal or PowerShell](/azure/virtual-network/ip-services/virtual-networks-static-private-ip-arm-ps). Make sure that the DHCP option inside the VM is enabled. This setting makes sure that the IP configuration always matches the VM configuration in Azure.<br><br>If multiple private IPs are assigned to the VM's network adapter, make sure that you follow these steps to [statically assign the IPs correctly](/azure/virtual-network/ip-services/virtual-network-multiple-ip-addresses-portal#os-config). After you perform this procedure, if the guest agent can't communicate with 168.63.129.16, check whether the primary IP in Windows [matches the primary IP in the VM's network adapter in Azure](no-internet-access-multi-ip.md). |

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
