---
title: Troubleshooting Azure Windows VM Agent
description: Troubleshoot the Azure Windows VM Agent isn't working issues
services: virtual-machines
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.collection: windows
author: dkdiksha
manager: dcscontentpm
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 09/23/2022
ms.author: genli
---
# Troubleshooting Azure Windows VM Agent

Azure VM Agent is a virtual machine (VM) agent. It enables the VM to communicate with the Fabric Controller (the underlying physical server on which VM is hosted) on IP address 168.63.129.16. This is a virtual public IP address that facilitates the communication. For more information, see [What is IP address 168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16).

 The VM that is migrated to Azure from on-premises or that is created by using a customized image doesn't have Azure VM Agent installed. In these scenarios, you have to manually install the VM agent. For more information about how to install the VM Agent, see [Azure Virtual Machine Agent Overview](/azure/virtual-machines/extensions/agent-windows).

After Azure VM Agent is successfully installed, you can see following services listed in services.msc on the VM:

- Windows Azure Guest Agent - This service is responsible for configuring various extensions and communication from Guest to Host. It's also responsible for collecting logs into WAppAgent.log.
- Telemetry Service - This service is responsible for sending the telemetry data of the VM to the backend server.
- RDAgent - This service is responsible for the Installation of Guest Agent. Transparent Installer is also a component of Rd Agent that helps to upgrade other components and services of Guest Agent. RD Agent is also responsible for sending heartbeats from Guest VM to Host Agent on the physical server.

> [!NOTE]
> Starting in version 2.7.41491.971 of the VM Guest Agent, the Telemetry component is included in the Windows Azure Guest Agent service, Therefore, you might not see this Telemetry service listed in newly created VMs.

## Checking agent status and version

Go to the VM properties page in Azure portal, and check the **Agent status**. If the Azure VM Agent is working correctly, the status shows **Ready**. If VM Agent is in **Not Ready** status, the extensions and **Run command** on the Azure portal won’t work.

## Troubleshooting VM agent that is in Not Ready status

### Step 1 Check whether the Azure VM Agent service is installed

- Check for the Package

    Locate the C:\WindowsAzure folder. If you see the GuestAgent folder that displays the version number, that means that Azure VM Agent was installed on the VM. You can also look for the installed package.  If Azure VM Agent is installed on the VM, the package will be saved in the following location: `C:\windows\OEM\GuestAgent\VMAgentPackage.zip`.

    You can run the following PowerShell command to check whether VM Agent has been deployed to the VM:

    `Get-AzVM -ResourceGroupName "RGNAME" -Name "VMNAME" -DisplayHint expand`

    In the output, locate the **ProvisionVMAgent** property, and check whether the value is set to **True**. If it is, this means that the agent is installed on the VM.

- Check the Services and Processes

   Go to the Services console (services.msc) and check the status of the following services: Azure VM Agent Service, RD Agent service, Windows Azure Telemetry Service, and Windows Azure Network Agent service.

    You can also check whether these services are running by examining Task Manager for the following processes:

  - WindowsAzureGuestAgent.exe: Azure VM Agent service
  - WaAppAgent.exe: RD Agent service
  - WindowsAzureTelemetryService.exe: Windows Azure Telemetry Service
  
   If you can't find these processes and services, this indicates that you don't have Azure VM Agent installed.

- Check the Program and Feature

    In Control Panel, go to **Programs and Features** to determine whether the Azure VM Agent service is installed.

If you don't find any packages, services and processes running and don't  even see Azure VM Agent installed under Programs and Features, try [installing Azure VM Agent service](/azure/virtual-machines/extensions/agent-windows). If the Guest Agent doesn't install properly, you can [Install the VM agent offline](./install-vm-agent-offline.md).

If you can see the services and they're running, restart the service that sees if the problem is resolved. If the services are stopped, start them and wait few minutes. Then check whether the **Agent status** is reporting as **Ready**. If you find that these services are crashing, some third party processes may be causing these services to crash. To further troubleshooting of these issues, contact [Microsoft Support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

### Step 2 Check whether auto-update is working

The Azure VM Agent has an auto-update feature. It will automatically check for new updates and install them. If the auto-update feature doesn't work correctly, try uninstalling and installing the Azure VM Agent by using the following steps:

1. If Azure VM Agent appears in **Programs and Features**, uninstall the Azure VM Agent.

2. Open a Command Prompt window that has administrator privileges.

3. Stop the Guest Agent services. If the services don't stop, you must set the services to **manual startup** and then restart the VM.

    ```
    net stop RDAgent 
    net stop WindowsAzureGuestAgent
    net stop WindowsAzureTelemetryService
    ```

1. Delete the Guest Agent Services:

    ```
    sc delete RDAgent 
    sc delete WindowsAzureGuestAgent
    sc delete WindowsAzureTelemetryService
    ```

1. Under `C:\WindowsAzure` create a folder that is named OLD. 

1. Move any folders that are named Packages or GuestAgent into the OLD folder.
1. Restart the VM to complete the uninstalling process. 
1. Download and install the latest version of the agent installation package from [here](https://go.microsoft.com/fwlink/?linkid=394789&clcid=0x409). You must have Administrator rights to complete the installation.

1. Install Guest Agent by using the following command:

    ```
    msiexec.exe /i c:\VMAgentMSI\WindowsAzureVmAgent.2.7.<version>.fre.msi /quiet /L*v c:\VMAgentMSI\msiexec.log
    ```

    Then check whether the **Windows Azure Guest Agent** service starts correctly.

    In rare cases in which Guest Agent doesn't install correctly, you can [Install the VM agent offline](./install-vm-agent-offline.md).

### Step 3 Check whether the VM can connect to the Fabric Controller

Use a tool such as PsPing to test whether the VM can connect to 168.63.129.16 on ports 80 and 32526. If the VM doesn’t connect as expected, check whether outbound communication over ports 80 and 32526 is open in your local firewall on the VM. If this IP address is blocked, VM Agent may display unexpected behavior in a variety of scenarios.

## Advanced troubleshooting

Events for troubleshooting Azure VM Agent are recorded in the following log files:

- C:\WindowsAzure\Logs\WaAppAgent.log
- C:\WindowsAzure\Logs\TransparentInstaller.log

The following are some common scenarios in which Azure VM Agent can enter **Not ready** status or stop working as expected.

<br/>

### Windows VMs using Azure VM agent version 2.7.41491.1004 may experience issue with Sysprep

Running Sysprep.exe on these VMs might end up with the below errors.

- When you run Sysprep the first time, you'll see the following error:

  > ADMINISTRATOR: Error Handler

- When you run Sysprep more than once, you'll see the following error:

  > A fatal error occurred while trying to sysprep the VM

The issue is only with version 1004, hence you can try upgrading the agent to the latest agent version, or you can try upgrading it to version 1005 by using below MSI, which has the bug fixed.

*\\reddog\Builds\branches\git_compute_iaas_vmagent_master\2.7.41491.1005\retail-amd64\exports\IaaSVmAgentInstaller*

Also, reset the Sysprep state of the VM first. This consists of [modifying a few registry keys](https://www.wintips.org/fix-sysprep-fatal-error-dwret-31-machine-invalid-state-couldnt-update-recorded-state/).

<br/>

### Agent Stuck on "Starting"

In the WaAppAgent log, you can see that the agent is stuck at the Starting process and can't start.

**Log information**

[00000007] [05/28/2019 12:58:50.90] [INFO] WindowsAzureGuestAgent starting. Version 2.7.41491.901

**Analysis**

The VM is still running the older version of the Azure VM Agent. In the C:\WindowsAzure folder, you may notice that multiple Azure VM Agent instances are installed, including several of the same version. Because multiple  agent instances are installed, the VM doesn't start the latest version of Azure VM Agent.

**Solution**

Manually uninstall the Azure VM Agent, and then reinstall it by following these steps:

1. Open Control Panel > Programs and Features, and uninstall the Azure VM Agent.
1. Open Task Manager, and stop the following services: Azure VM Agent Service, RD Agent  service, Windows Azure Telemetry Service, and Windows Azure Network Agent service.
1. Under C:\WindowsAzure, create a folder that’s named OLD.
1. Move any folders that are named Packages or GuestAgent into the OLD folder. Also, move any of the GuestAgent folders in C:\WindowsAzure\logs that start as GuestAgent_x.x.xxxxx to the OLD folder.
1. Download and install the latest version of the MSI agent. You must have administrator rights to complete the installation.
1. Install Guest Agent by using the following MSI command:

    ```
    msiexec.exe /i c:\VMAgentMSI\WindowsAzureVmAgent.2.7.<version>.fre.msi /quiet /L*v c:\VMAgentMSI\msiexec.log
    ```

1. Verify that the RD Agent, Azure VM Agent, and Windows Azure Telemetry services are now running.

1. Check the WaAppAgent.log to make sure that the latest version of Azure VM Agent is running.

1. Delete the OLD folder under C:\WindowsAzure.
  
<br/>

### Unable to connect to WireServer IP (Host IP)

You notice the following error entries in WaAppAgent.log and Telemetry.log:

**Log information**

```Log sample
[ERROR] GetVersions() failed with exception: Microsoft.ServiceModel.Web.WebProtocolException: Server Error: Service Unavailable (ServiceUnavailable) ---> 
System.Net.WebException: The remote server returned an error: (503) Server Unavailable.
```

```Log sample
[00000011] [12/11/2018 06:27:55.66] [WARN]  (Ignoring) Exception while fetching supported versions from HostGAPlugin: System.Net.WebException: Unable to connect to the remote server 
---> System.Net.Sockets.SocketException: An attempt was made to access a socket in a way forbidden by its access permissions 168.63.129.16:32526
at System.Net.Sockets.Socket.DoConnect(EndPoint endPointSnapshot, SocketAddress socketAddress)
at System.Net.ServicePoint.ConnectSocketInternal(Boolean connectFailure, Socket s4, Socket s6, Socket& socket, IPAddress& address, ConnectSocketState status, IAsyncResult asyncResult, Exception& exception)
--- End of inner exception stack trace ---
at System.Net.WebClient.DownloadDataInternal(Uri address, WebRequest& request)
at System.Net.WebClient.DownloadString(Uri address)
at Microsoft.GuestAgentHostPlugin.Client.GuestInformationServiceClient.GetVersions()
at Microsoft.WindowsAzure.GuestAgent.ContainerStateMachine.HostGAPluginUtility.UpdateHostGAPluginAvailability()`
```

**Analysis**

The VM can't reach the Wireserver host server.

**Solution**

1. Because Wireserver isn't reachable, connect to the VM by using Remote Desktop, and then try to access the following URL from an internet browser: <http://168.63.129.16/?comp=versions>
1. If you can't reach the URL from step 1, check the network interface to determine whether it is set as DHCP-enabled and has DNS. To check the DHCP status, of the network interface, run the following command:  `netsh interface ip show config`.
1. If DHCP is disabled, run the following making sure you change the value in yellow to the name of your interface: `netsh interface ip set address name="Name of the interface" source=dhcp`.
1. Check for any issues that might be caused by a firewall, a proxy, or other source that could be blocking access to the IP address 168.63.129.16.
1. Check whether Windows Firewall or a third-party firewall is blocking access to ports 80 and 32526. For more information about why this address shouldn't be blocked,  see [What is IP address 168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16).

<br/>

### Guest Agent is stuck "Stopping"  

You notice the following error entries in WaAppAgent.log:

**Log information**

```Log sample
[00000007] [07/18/2019 14:46:28.87] [WARN] WindowsAzureGuestAgent stopping.
[00000007] [07/18/2019 14:46:28.89] [INFO] Uninitializing StateExecutor with WaitForTerminalStateReachedOnEnd : True
[00000004] [07/18/2019 14:46:28.89] [WARN] WindowsAzureGuestAgent could not be stopped. Exception: System.NullReferenceException: Object reference not set to an instance of an object.
at Microsoft.WindowsAzure.GuestAgent.ContainerStateMachine.GoalStateExecutorBase.WaitForExtensionWorkflowComplete(Boolean WaitForTerminalStateReachedOnEnd)
at Microsoft.WindowsAzure.GuestAgent.ContainerStateMachine.GoalStateExecutorBase.Uninitialize(Boolean WaitForTerminalStateReachedOnEnd)
at Microsoft.WindowsAzure.GuestAgent.ContainerStateMachine.GoalStateExecutorForCloud.Uninitialize(Boolean WaitForTerminalStateReachedOnEnd)
at Microsoft.WindowsAzure.GuestAgent.AgentCore.AgentCore.Stop(Boolean waitForTerminalState)
at Microsoft.WindowsAzure.GuestAgent.AgentCore.AgentService.DoStopService()
at Microsoft.WindowsAzure.GuestAgent.AgentCore.AgentService.<>c__DisplayClass2.<OnStopProcessing>b__1()
```

**Analysis**

Azure VM Agent is stuck at the Stopping process.

**Solution**

1. Make sure that WaAppAgent.exe is running on the VM. If it isn't running, restart the **rdagent** service, and wait five minutes. When WaAppAgent.exe is running, end the WindowsAzureGuest.exe process.
2. If step 1 doesn't resolve the issue, remove the currently installed version and install the latest version of the agent manually.

<br/>

### Npcap Loopback Adapter

You notice the following error entries in WaAppAgent.log:

```Log sample
[00000006] [06/20/2019 07:44:28.93] [INFO]  Attempting to discover fabric address on interface Npcap Loopback Adapter.
[00000024] [06/20/2019 07:44:28.93] [WARN]  Empty DHCP option data returned
[00000006] [06/20/2019 07:44:28.93] [ERROR] Did not discover fabric address on interface Npcap Loopback Adapter
```

**Analysis**

The Npcap loopback adapter is installed on the VM by Wireshark. Wireshark is an open-source tool for profiling network traffic and analyzing packets. Such a tool is often referred to as a network analyzer, network protocol analyzer, or sniffer.

**Solution**

The Npcap Loopback Adapter is likely installed by WireShark. Try disabling it, and then check whether the problem is resolved.


<br/>

### RPC issues

You notice the following error entries in WaAppAgent.log:

```Log sample
[00000004] [01/12/2019 00:30:47.24] [ERROR] RdCrypt Initiailization failed. Error Code: -2147023143.
[00000004] [01/12/2019 00:30:47.24] [ERROR] Failed to get TransportCertificate. Error: System.AccessViolationException
Microsoft.Cis.Fabric.CertificateServices.RdCertificateFactory.Shutdown()
[00000004] [01/12/2019 00:30:47.24] [WARN]  Could not get transport certificate from agent runtime for subject name: 12345678-d7c8-4387-8cf3-d7ecf62544e5. Installing certificates in the LocalMachine store failed.
[00000004] [01/12/2019 00:30:47.24] [WARN] Fetching certificate blob from the cert URI: http://168.63.129.16/machine/12345678-d7c8-4387-8cf3-d7ecf62544e5/12345678-d447-4b10-a5da-1ba1581cd7d7._VMName?comp=certificates&incarnation=2 failed with exception: System.NullReferenceException
-2147023143 = 0x6d9 = EPT_S_NOT_REGISTERED
```

**Analysis**

This is likely due to the RPC endpoint not listening, or the RPC process on the other side which isn't there.


**Solution**

Check if the "CNGKEYISO" Windows service is in the list of RPC endpoints by running the following command. 

```
portqry -n <VMName> -e 135
```


If you don't see the "CNGKEYISO" process, please start it from the Windows Services console (CNG Key Isolation = KeyIso) and then restart WaAppAgent.exe / WindowsAzureGuestAgent.exe.


<br/>

### PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86.

In this case, you can see that the Windows Guest Agent running, but Extensions aren't working. You notice the following error entries in WaAppAgent.log:

```Log sample
PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86

[00000003] [10/21/2020 02:37:45.98] [WARN]  Could not get transport certificate from agent runtime for subject name: 12345678-dae3-4c2f-be57-55c0ab7a44e5. Installing certificates in the LocalMachine store failed.
[00000003] [10/21/2020 02:37:45.98] [ERROR] Installing certificates in the LocalMachine store failed with exception: Microsoft.WindowsAzure.GuestAgent.CertificateManager.CryptographyNative+PInvokeException: PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86.
```

**Analysis**

This is most likely caused by lack of permissions on the Crypto folders for the SYSTEM account. Collecting a Procmon trace while restarting the GA services (RDAgent / WindowsAzureGuestAgent) should exhibit some Access Denied.


**Solution**

Ensure that the SYSTEM account has Full Control permissions on the following folders:

- C:\ProgramData\Microsoft\Crypto\Keys

- C:\ProgramData\Microsoft\Crypto\RSA

- C:\ProgramData\Microsoft\Crypto\SystemKeys


<br/>


### System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)

You notice the following error entries in WaAppAgent.log - and the Guest Agent is crashing.

```Log sample
[00000018] 2021-01-12T16:35:45Z [INFO]  Test extract the plugin zip file to the temp folder C:\TEMP\12345678-5f85-45dc-9f17-55be1fde7b10
[00000010] 2021-01-12T16:35:45Z [ERROR] InstallPlugins() failed with exception: System.AggregateException: One or more errors occurred. ---> System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.PackageExpand(String packageFilePath, String destinationPath)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.ValidateExtensionZipFile(String pluginName, String pluginVersion, String& pluginZipFile)

```

**Analysis**

It's likely that a third party application has been installed on the VM, and it  has modified the behavior of 32 bits / 64 bits .Net applications.

BadImageFormationException happens when a 64 bits application is loading a 32 bits DLL.

**Solution**

Open the registry and check the following key:

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\Enable64Bit
```
If it's set to 0, then 64 bits .Net application are considered as 32 bits applications. This can't work.

The solution is to set Enable64Bit key to 1 - and reboot the VM.



<br/>

## Next steps

Other known issues with the Azure VM Agent are listed in its [GitHub repository](https://github.com/Azure/WindowsVMAgent/wiki/Known-Issues).

To further troubleshoot the “Azure VM Agent isn't working” issue, [contact Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]


