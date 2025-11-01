---
title: Troubleshooting Tool for Windows Guest Agent - VM assist
description: Provides script-based tool to help diagnose and resolve Azure Guest Agent issues on Azure virtual machines runnign Windows.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.date: 10/24/2025
ms.reviewer: v-jsitser, scotro, v-ryanberg
ms.service: azure-virtual-machines
ms.custom: sap:zzzz
---

#  Troubleshooting Tool for Windows Guest Agent - VM assist

## Tool overview

VM assist (Windows version) is a PowerShell script intended to be used to diagnose issues with the Azure Windows VM Guest Agent in addition to other issues related to the general health of the VM. This includes various information about the system such as firewall rules, running services, running drivers, installed software, NIC settings, and installed software, and installed Windows Updates.

Output of the checks can be viewed in the PowerShell window the script is ran in. Additionally running VM assist generates a detailed .htm report showing the results of each check it performs and suggests mitigations for issues it finds.

## How to install

Please see the GitHub page to see the latest instruction for how a customer can [install VM assist](https://github.com/Azure/azure-support-scripts/blob/master/vmassist/windows/README.md).

## Analyzing output
The script will run a series of checks to analyze the health of the VM Guest Agent and check for various known configurations that could cause issues. Each check will either pass or fail in the PowerShell window. 

Once completed, it will also generate a log file and an html report:
 - C:\logs\vmassist_*.log
 - C:\logs\vmassist_*.htm

The .log file will have a copy of the results that are displayed in the PowerShell window for later reference.

## Current list of findings/checks

Here are the current list of checks/findings along with any potential internal articles that can help in case the customer needs further assistance.

| Checks | Details |
|--------|---------|
| Check for Folder| Validates that the folder C:\WindowsAzure folder exists and is also used to help determine that the Guest Agent was installed.<br><br>If this doesn't exist then its likely that the guest agent needs to be installed. |
| Check for binaries | Validates that the guest agent .exes (WindowsAzureGuestAgent.exe and WaAppAgent.exe) exist and is also used to help determine that the Guest Agent was installed.<br><br>If this doesn't exist then its likely that the guest agent needs to be installed. |
| Status of agent services | Validates that the guest agent services (WindowsAzureGuestAgent and RdAgent) exist and is also used to help determine that the Guest Agent was installed.<br><br>If this doesn't exist then its likely that the guest agent needs to be installed. If they do exist then ensure they're set to `Running` and ideally their StartType will be set to `Automatic` |
| Status of `winmgmt` service | Validates that the winmgmt service is running. |
| Status of `KeyIso` service | Validates that the `KeyIso (CNG Key Isolation)` service is running.<br><br> See this [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1551510/RPC-Issues_AGEX)  for more details. |
| Check if agent services/processes have crashed | This checks if the Guest Agent services/processes have crashed in the last day. If its just a one off crash, then it may not be important unless it happens right when the issue is reported. On the other hand, if its constantly crashing then it needs to be investigated.<br><br>First look in the WaAppAgent.log and System/Application event logs. |
| Checks if `stdregprov` is working | The VM agent MSI uses WMI StdRegProv to access the registry. If WMI is not working properly the MSI cannot set the RdAgent service path from the registry and the MSI install fails. <br><br> See this [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1595962/WinGA-failing-to-install-due-broken-WMI_AGEX) for more details. |
| Agent is installed | Returns True if the guest Agent is installed. If its not installed then the guest agent needs to be installed. |
| Installed by PA or MSI | This checks if the Guest Agent was installed by the provisioning agent or manually via .MSI. Neither of these options are `wrong`, but its included for informational purposes. |
| Supported version | Checks that they are using an up to date, supported version of the Guest Agent. |
| Proxy | Checks for netsh proxies. This doesn't check for the existance of *all* type of proxy on the system. For example, it doesn't check if there is a `3rd party proxy application` installed. <br><br>If there are wireserver connectivity issues you can start troubleshooting with the [Troubleshooting 168.63.129.16](https://learn.microsoft.com/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-connectivity). If you need to specifically look into proxy then see [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1566544/Proxy-Issues_AGEX). |
| CRP cert exists and is valid | Checks that the CRP "Windows Azure CRP Certificate Generator" certificate exists. This certificate is there to secure the communication with the host, and transfer protected settings used by extensions.<br><br> See this [public article](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/troubleshoot-extension-certificates-issues-windows-vm) for more details. |
| WCF debugging | This may occur if Windows Communication Framework (WCF) profiling is enabled. WCF profiling should only be enabled while debugging a WCF issue. It should not be left enabled while running a production workload.<br><br> See this [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1630419/Crashing-Due-to-WCF-Profile-Enabled_AGEX) for more details. |
| Wireserver (168.63.129.16) connectivity on 80, 32526, and REST API | If there are wireserver connectivity issues you can start troubleshooting with the [Why is this here and the proxy check above](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1027820/WireServer-Troubleshooting_AGEX). |
| IMDS connectivity | IMDS connectivity is not required for the Guest Agent to work, but the Guest Agent does try to connect so you may see errors in the logs. Additionally VM assist itself gets information on the VM from IMDS to populate some sections of the .HTML file.<br><br>So not having connectivity to IMDS will not break the Guest Agent, start with the [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495850/Basic-Workflow_IMDS). |
| Third-party modules in WaAppAgent and WindowsAzureGuestAgent | Other applications occasionally inject their .dlls into the Guest Agent process. Most of the time it will not cause the Guest Agent to fail. However, it is possible that these .dlls can cause unexpected failures in the Guest Agent that are difficult to debug. Although it is relatively rare that these cause an issue, if any of these .dlls are from unexpected applications and you've exhausted [Needs to be Public - rare--](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495025/Guest-Agent-Workflow_AGEX) then consider having the customer remove/reconfigure the application so that it no longer injects its .dlls into the Guest Agnet process(es). As this scenario is pretty rare, you may want to check with a SME/TA first. |
| Checks permissions on machineKeys folder | Checks to see that the default permissions are in place on `C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys`. If improper permissions are applied that block access then the Guest Agent itself may be 'Ready', but extensions that use protected settings won't work.<br><br> See this [Needs to be Public](https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/1986524/Crypto-or-Certificate-Errors-with-Windows-Guest-Agent_AGEX) for more details. |
| Checks permissions on `C:\WindowsAzure` and `C:\Packages` | Validates that the System account has access to these directories. These directories are what the Guest Agent and extensions use for their binaries, config files, and log files, so its important the System account has access. |
| Sufficient disk space |This checks for available disk space. If the disk space is completely filled then the Guest Agent may not be able to write its status file, update, install extensions, etc. The customer would either need to delete files or expand their disk. |
| DHCP IP | If there is one private IP on the VM's NIC, then we highly recommend having DHCP enabled in the guest VM. If they need a static private IP address, they should [configure it through the Azure portal or PowerShell](https://learn.microsoft.com/zure/virtual-network/ip-services/virtual-networks-static-private-ip-arm-ps), and make sure the DHCP option inside the VM is enabled. This will ensure that the IP configuration will always match what is configured on the VM in Azure.<br><br>If they have multiple private IPs assigned to their VM's NIC, then ensure that they followed the steps to [statically assign the IPs correctly](https://learn.microsoft.com/azure/virtual-network/ip-services/virtual-network-multiple-ip-addresses-portal#os-config). After this, if the Guest Agent isn't able to communicate with 168.63.129.16, then check that the primary IP in Windows [matches the primary IP in their VM's NIC in Azure](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/no-internet-access-multi-ip). |







