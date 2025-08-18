---
title: Troubleshoot Azure Windows VM Agent issues
description: Understand how to troubleshoot issues that prevent the Azure Windows VM Agent from running successfully.
services: virtual-machines
ms.service: azure-virtual-machines
ms.collection: windows
author: kegregoi
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 08/14/2025
ms.author: kegregoi
editor: v-jsitser
ms.reviewer: v-leedennis, scotro, v-liuamson
ms.custom: sap:VM Extensions not operating correctly
---
# Troubleshoot Azure Windows VM Agent issues

**Applies to:** :heavy_check_mark: Windows VMs

[!INCLUDE [Feedback](../../../includes/feedback.md)]

Azure VM Agent is a virtual machine (VM) agent. It enables the VM to communicate with the Fabric Controller (the underlying physical server on which the VM is hosted) on IP address `168.63.129.16`. This address is a virtual public IP address that facilitates communication. For more information, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16).

The VM that's migrated to Azure from an on-premises environment or created by using a customized image doesn't have Azure VM Agent installed. In these scenarios, you have to manually install VM Agent. For more information about how to install the VM Agent, see [Azure Virtual Machine Agent overview](/azure/virtual-machines/extensions/agent-windows).

After Azure VM Agent is successfully installed, you can see the following services listed in *services.msc* on the VM.

| Service | Description |
|--|--|
| Windows Azure Guest Agent | This service is responsible for configuring various extensions and communications from Guest VM to Host Agent. It's also responsible for collecting logs in *WaAppAgent.log*. |
| Telemetry | This service is responsible for sending the telemetry data of the VM to the back-end server. |
| RdAgent | This service is responsible for the installation of Guest Agent. (Transparent Installer is another component of RdAgent that helps to upgrade other components and services of Guest Agent.) RdAgent is also responsible for sending heartbeats from Guest VM to Host Agent on the physical server. |

> [!NOTE]
> Starting in version 2.7.41491.971 of Guest Agent, the Telemetry component is included in the Windows Azure Guest Agent service. Therefore, you might not see this Telemetry service listed in newly created VMs.

## Troubleshooting checklist

For any VM extension to be able to run, Azure VM Guest Agent must be installed and working successfully. If you see that Guest Agent is reported as **Not ready**, or if an extension is failing and returning an error message such as `VMAgentStatusCommunicationError`, follow these steps to begin troubleshooting Guest Agent.

### Step 1: Check whether the VM is started

To verify that the VM is started, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.

1. In the list of VMs, select the name of your Azure VM.

1. In the navigation pane of your Azure VM, select **Overview**.

1. If the VM isn't already on and running, locate the list of actions at the top of the **Overview** page, and then select the **Start** link.

Also, verify that the operating system (OS) is started and running successfully.

### Step 2: Check whether Guest Agent is ready

While you're still on the VM overview page of the Azure portal, select the **Properties** tab. If the **Agent status** field has a value of **Ready**, verify that the **Agent version** field value satisfies the [minimum supported version](./support-extensions-agent-version.md). The following screenshot shows where you can find these fields.

:::image type="content" source="./media/windows-azure-guest-agent/guest-agent-portal-status.png" alt-text="Azure portal screenshot that shows the virtual machine (VM) properties. The agent status is Ready, and the Agent version is 2.7.41491.1083." lightbox="./media/windows-azure-guest-agent/guest-agent-portal-status.png" border="false":::

If the Guest Agent status is **Ready** but you have an issue that involves a VM extension, see [Azure virtual machine extensions and features](/azure/virtual-machines/extensions/overview) to review troubleshooting suggestions.

If the Guest Agent status is **Not ready** or blank, then either Guest Agent isn't installed or it isn't working correctly.

### Step 3: Check whether the Guest Agent services are running

1. [Use Remote Desktop Protocol (RDP) to connect to your VM](/azure/virtual-machines/windows/connect-rdp).

   > [!NOTE]  
   > It isn't necessary to have Guest Agent installed and running in order for RDP connectivity to work successfully. If you experience issues that affect RDP connectivity to your VM, see [Troubleshoot Remote Desktop connections to an Azure virtual machine](./troubleshoot-rdp-connection.md).

1. On your VM, select **Start**, search for *services.msc*, and then select the **Services** app.
1. In the **Services** window, select the **RdAgent** service.
1. Select the **Action** menu, and then select **Properties**.
1. On the **General** tab of the **Properties** dialog box, make sure that the following conditions are true, and then select the **OK** or **Cancel** button:

   - The **Startup type** list is set to **Automatic**.
   - The **Service status** field has a value of **Running**.

   :::image type="content" source="./media/windows-azure-guest-agent/guest-agent-checking-rdagent-service.png" alt-text="Screenshot of the RdAgent Properties dialog box. The dialog box shows the RdAgent service status as Running and the startup type as Automatic.":::

1. In the **Services** window, select the **WindowsAzureGuestAgent** service.
1. Repeat steps 4 and 5.

If the services don't exist, Guest Agent probably isn't installed. In this case, you can [manually install Guest Agent](/azure/virtual-machines/extensions/agent-windows#manual-installation). Before you do a manual installation, [check the installation prerequisites](/azure/virtual-machines/extensions/agent-windows#prerequisites).

### Step 4: Test WireServer connectivity

To run successfully, Guest Agent requires connectivity to the WireServer IP (host IP) address `168.63.129.16` on ports `80` and `32526`. For instructions to test connectivity to this IP address, see the [Troubleshoot connectivity](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-connectivity) section of [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

If any of the tests in that section don't create a connection, check for issues that might cause any of the following components to block access to IP address `168.63.129.16`:

- A firewall
- A proxy
- An application

### Step 5: Review log files

Check the following log locations for any notable errors:

- *C:\\WindowsAzure\\Logs\\WaAppAgent.log*
- *C:\\WindowsAzure\\Logs\\TransparentInstaller.log*

## Common error scenarios

Compare any errors that you find to the following common scenarios that can cause Azure VM Agent to show a **Not ready** status or stop working as expected.

### Can't connect to WireServer IP (168.63.129.16)

<details>
<summary>Click here for troubleshooting details</summary>

The following error entries are logged in the *WaAppAgent.log* file:

```output
[ERROR] GetVersions() failed with exception: Microsoft.ServiceModel.Web.WebProtocolException: Server Error: Service Unavailable (ServiceUnavailable) ---> 
System.Net.WebException: The remote server returned an error: (503) Server Unavailable.
```

```output
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

These error entries indicate that the VM can't reach the WireServer IP address, 168.63.129.16.

### Solution: Enable DHCP, and make sure that the server isn't blocked by firewalls, proxies, or other sources

1. Connect to the VM by using Remote Desktop, and then test connectivity to 168.63.129.16. See the [Troubleshoot connectivity](/azure/virtual-network/what-is-ip-address-168-63-129-16?tabs=windows#troubleshoot-azure-ip-connectivity) section of [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16).
1. If you have only one private IP on your VM's network adapter, we highly recommend that you have DHCP enabled on the guest VM. If you need a static private IP address, you should configure it through the Azure portal or PowerShell, and make sure the DHCP option inside the VM is enabled. To make sure that the IP configuration always matches what's configured on the VM in Azure, [Learn more](/azure/virtual-network/ip-services/virtual-networks-static-private-ip-arm-ps) about how to set up a static IP address by using PowerShell.
1. If you have multiple private IPs assigned to your VM's network adapter, make sure that you carefully follow the steps to [assign the IP configurations correctly](/azure/virtual-network/ip-services/virtual-network-multiple-ip-addresses-portal#os-config). After you finish the steps, if Guest Agent can't communicate with 168.63.129.16, check that the primary IP in Windows [matches the primary IP in your VM's network adapter in Azure](/troubleshoot/azure/virtual-machines/windows/no-internet-access-multi-ip).
1. Check for any issues that a firewall, a proxy, or another source might cause that could block access to IP address `168.63.129.16`.
1. Check whether Windows Firewall or a third-party firewall is blocking access to ports `80` and `32526`. For more information about why this address shouldn't be blocked, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

</details>

### Guest Agent is stuck in the "Stopping" process  

<details>
<summary>Click here for troubleshooting details</summary>

The following error entries are logged in the *WaAppAgent.log* file:

```output
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

These error entries indicate that the Azure VM Agent is stuck in the "Stopping" process.

### Solution A: Start WaAppAgent.exe and stop WindowsAzureGuest.exe

Make sure that *WaAppAgent.exe* is running on the VM. If it isn't running, restart the RdAgent service, and then wait five minutes. After *WaAppAgent.exe* starts running, end the *WindowsAzureGuest.exe* process.

### Solution B: Upgrade Azure VM Agent

If Solution A doesn't resolve the issue, remove the currently installed version, and then [install the latest version of the agent manually](/azure/virtual-machines/extensions/agent-windows#manual-installation).

</details>

### The Npcap loopback adapter is installed

<details>
<summary>Click here for troubleshooting details</summary>

The following error entries are logged in the *WaAppAgent.log* file:

```output
[00000006] [06/20/2019 07:44:28.93] [INFO] Attempting to discover fabric address on interface Npcap Loopback Adapter
[00000024] [06/20/2019 07:44:28.93] [WARN] Empty DHCP option data returned
[00000006] [06/20/2019 07:44:28.93] [ERROR] Did not discover fabric address on interface Npcap Loopback Adapter
```

These error entries indicate that [Wireshark](https://www.wireshark.org) installed the packet capture ([Npcap](https://npcap.com)) loopback adapter of the Network Mapper ([Nmap](https://nmap.org)) Project on the VM. Wireshark is an open source tool for profiling network traffic and analyzing packets. Such a tool is often referred to as a network analyzer, network protocol analyzer, or sniffer.

### Solution: Disable the Npcap loopback adapter

Try to disable the Npcap loopback adapter, and then check whether the problem is resolved.

</details>

### Remote Procedure Call (RPC) issues - RdCrypt Initialization failed

<details>
<summary>Click here for troubleshooting details</summary>

The following error entries are logged in the *WaAppAgent.log* file:

```output
[00000004] [01/12/2019 00:30:47.24] [ERROR] RdCrypt Initialization failed. Error Code: -2147023143.
[00000004] [01/12/2019 00:30:47.24] [ERROR] Failed to get TransportCertificate. Error: System.AccessViolationException
Microsoft.Cis.Fabric.CertificateServices.RdCertificateFactory.Shutdown()
[00000004] [01/12/2019 00:30:47.24] [WARN]  Could not get transport certificate from agent runtime for subject name: 12345678-d7c8-4387-8cf3-d7ecf62544e5. Installing certificates in the LocalMachine store failed.
[00000004] [01/12/2019 00:30:47.24] [WARN] Fetching certificate blob from the cert URI: http://168.63.129.16/machine/12345678-d7c8-4387-8cf3-d7ecf62544e5/12345678-d447-4b10-a5da-1ba1581cd7d7._VMName?comp=certificates&incarnation=2 failed with exception: System.NullReferenceException
-2147023143 = 0x6d9 = EPT_S_NOT_REGISTERED
```

These errors probably occur because of Remote Procedure Call (RPC) issues. For example, the RPC endpoint might not be listening, or the RPC process might be missing on the opposite end.

### Solution: Start the CNG Key Isolation service

Check whether the [Cryptography Next Generation (CNG) Key Isolation](/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server#cng-key-isolation) (`CNGKEYISO`) Windows service is in the list of RPC endpoints. To do this, run the following [portqry](../../../windows-server/networking/portqry-command-line-port-scanner-v2.md) command:

```cmd
portqry -n <VMName> -e 135
```

If you don't see the `CNGKEYISO` process, start it from the Windows Services console (CNG Key Isolation = `KeyIso`), and then restart *WaAppAgent.exe* or *WindowsAzureGuestAgent.exe*.

</details>

### PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86

<details>
<summary>Click here for troubleshooting details</summary>

Windows Guest Agent is running, but extensions aren't working. The following error entries are logged in the *WaAppAgent.log* file:

```output
PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86

[00000003] [10/21/2020 02:37:45.98] [WARN] Could not get transport certificate from agent runtime for subject name: 12345678-dae3-4c2f-be57-55c0ab7a44e5. Installing certificates in the LocalMachine store failed.
[00000003] [10/21/2020 02:37:45.98] [ERROR] Installing certificates in the LocalMachine store failed with exception: Microsoft.WindowsAzure.GuestAgent.CertificateManager.CryptographyNative+PInvokeException: PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86.
```

These errors probably occur because of a lack of permissions on the *Crypto* folders for the SYSTEM account. If you collect a [Process Monitor](/sysinternals/downloads/procmon) (ProcMon) trace while you restart the Guest Agent services (RdAgent or WindowsAzureGuestAgent), you should be able to see some "Access Denied" errors.

### Solution: Add full control of Crypto folders to the SYSTEM account

Make sure that the SYSTEM account has **Full Control** permissions on the following folders:

- *C:\\ProgramData\\Microsoft\\Crypto\\Keys*

- *C:\\ProgramData\\Microsoft\\Crypto\\RSA*

- *C:\\ProgramData\\Microsoft\\Crypto\\SystemKeys*

</details>

### System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)

<details>
<summary>Click here for troubleshooting details</summary>

The following error entries are logged in the *WaAppAgent.log* file to indicate that Guest Agent isn't responding:

```output
[00000018] 2021-01-12T16:35:45Z [INFO]  Test extract the plugin zip file to the temp folder C:\TEMP\12345678-5f85-45dc-9f17-55be1fde7b10
[00000010] 2021-01-12T16:35:45Z [ERROR] InstallPlugins() failed with exception: System.AggregateException: One or more errors occurred. ---> System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.PackageExpand(String packageFilePath, String destinationPath)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.ValidateExtensionZipFile(String pluginName, String pluginVersion, String& pluginZipFile)

```

Most likely, these errors occur because a third-party application was installed on the VM, and it modified the behavior of 32-bit or 64-bit .NET applications.

A `BadImageFormatException` error occurs when a 64-bit application is loading a 32-bit DLL.

### Solution: Set the Enable64Bit registry entry for .NET Framework and restart the VM

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

Open the registry, locate the **HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\.NETFramework** registry subkey, and then view the **Enable64Bit** registry entry.

If the **Enable64Bit** registry entry is set to **0**, then 64-bit .NET applications are considered to be 32-bit applications. Therefore, Azure VM Agent doesn't work.

The solution is to set the **Enable64Bit** key to **1**, and then restart the VM.

</details>

### Windows Guest Agent doesn't start because of a ConfigurationErrorsException or TypeInitializationException error

<details>
<summary>Click here for troubleshooting details</summary>

Windows Guest Agent stops responding upon startup, and the following application log entries are logged:

```output
Log Name:      Application
Source:        .NET Runtime
Date:          3/07/2023 10:25:59 AM
Event ID:      1026
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      vm372437823
Description:
Application: WindowsAzureGuestAgent.exe
Framework Version: v4.0.30319
Description: The process was terminated due to an unhandled exception.
Exception Info: System.Configuration.ConfigurationErrorsException
   at System.Configuration.ConfigurationSchemaErrors.ThrowIfErrors(Boolean)
   at System.Configuration.BaseConfigurationRecord.ThrowIfParseErrors(System.Configuration.ConfigurationSchemaErrors)
   at System.Configuration.ClientConfigurationSystem.EnsureInit(System.String)

Exception Info: System.Configuration.ConfigurationErrorsException
   at System.Configuration.ClientConfigurationSystem.EnsureInit(System.String)
   at System.Configuration.ClientConfigurationSystem.PrepareClientConfigSystem(System.String)
   at System.Configuration.ClientConfigurationSystem.System.Configuration.Internal.IInternalConfigSystem.GetSection(System.String)
   at System.Configuration.ConfigurationManager.GetSection(System.String)
   at System.Configuration.PrivilegedConfigurationManager.GetSection(System.String)
   at System.Diagnostics.DiagnosticsConfiguration.GetConfigSection()
   at System.Diagnostics.DiagnosticsConfiguration.Initialize()
   at System.Diagnostics.DiagnosticsConfiguration.get_IndentSize()
   at System.Diagnostics.TraceInternal.InitializeSettings()
   at System.Diagnostics.Trace.set_AutoFlush(Boolean)
   at Microsoft.WindowsAzure.GuestAgent.Prime.TraceManager..cctor()

Exception Info: System.TypeInitializationException
   at Microsoft.WindowsAzure.GuestAgent.Prime.TraceManager.Write(System.String, System.Object[])
   at Microsoft.WindowsAzure.GuestAgent.AgentCore.AgentCore.Start()
   at System.Threading.ExecutionContext.RunInternal(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
   at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
   at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object)
   at System.Threading.ThreadHelper.ThreadStart()
```

This issue might occur if the *C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\Config\\machine.config* file is missing or corrupted.

### Solution: Copy a working Machine.config file to the VM, and then restart the Guest Agent services

To resolve the issue, follow these steps:

1. Copy the *Machine.config* file from a working VM, and then paste the file into the *C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\Config* folder on the problematic VM.
1. Restart the Guest Agent services by running the `net stop` and `net start` commands:

   ```cmd
   net stop RdAgent
   net stop WindowsAzureGuestAgent

   net start RdAgent
   net start WindowsAzureGuestAgent
   ```

</details>

### Installing Guest Agent fails

<details>
<summary>Click here for troubleshooting details</summary>

If trying to install Guest Agent fails, make sure that all [prerequisites for Guest Agent](/azure/virtual-machines/extensions/agent-windows#prerequisites) are satisfied.

### Uninstall and reinstall Windows Guest Agent

1. Check in Add/Remove Programs whether Guest Agent is installed. 

**Note:**  If Guest Agent was installed manually through the .msi installer, the agent appears in Add/Remove Programs. If Guest Agent was installed during image provisioning, the agent doesn't appear in Add/Remove Programs.
1. If Guest Agent exists in Add/Remove programs, uninstall it from there. Then, you can install it through the .msi file by using the command line arguments in this step.
1. If the agent is installed but doesn't appear in Add/Remove programs, follow these steps:
   1. Open an elevated Command Prompt window.
   1. Stop the Guest Agent Services. If the services don't stop, you must set the services to manual startup, and then restart the VM:

     ```
     net stop rdagent
     net stop WindowsAzureGuestAgent
     ```
   1. Delete the Guest Agent Services

     ```
     sc delete rdagent
     sc delete WindowsAzureGuestAgent
     ```
   1. Under C:\WindowsAzure, create a folder that's named OLD.
   1. Move any folders that are named Packages or GuestAgent into the OLD folder.
   1. Create a new folder for the .msi install location (C:\VMAgentMSI).
1. Download the latest [.msi file](https://github.com/Azure/WindowsVMAgent/releases) from the GitHub Releases for Windows Guest Agent.
1. Install Guest Agent by using the .msiexec command line + arguments:

     ```
     msiexec.exe /i c:\VMAgentMSI\WindowsAzureVmAgent.2.7.<version>.fre.msi /L*v C:\Windows\Panther\msiexec.log
     ```
1. If the installation fails, collect the following files to investigate why it failed:

    - C:\Windows\Panther\msiexec.log
    - C:\Windows\Panther\VmAgentInstaller.xml

</details>

### Guest Agent installation fails because of faulty WMI

<details>
<summary>Click here for troubleshooting details</summary>

1. Download the latest [.msi file](https://github.com/Azure/WindowsVMAgent/releases) from the GitHub Releases for Windows Guest Agent.
1. Install Guest Agent by using the msiexec command line + arguments

     ```
     msiexec.exe /i c:\VMAgentMSI\WindowsAzureVmAgent.2.7.<version>.fre.msi /L*v C:\Windows\Panther\msiexec.log
     ```
1. If the installation fails, collect the following files to investigate why it failed:

    - C:\Windows\Panther\msiexec.log
    - C:\Windows\Panther\VmAgentInstaller.xml

You can find the following error messages on MSIEXEC.log and VmAgentInstaller.xml when you try to install the Guest Agent.

MSIEXEC.log:
```
Action start 12:11:03: CA2.
MSI (s) (7C:A8) [12:27:20:328]: Note: 1: 1722 2: CA2 3: wscript.exe 4: "C:\Program Files\Windows Azure VM Agent v2.7.41491.949\\InstallOrUpdateGA.vbs"
MSI (s) (7C:A8) [12:27:20:328]: Note: 1: 2205 2:  3: Error
MSI (s) (7C:A8) [12:27:20:328]: Note: 1: 2228 2:  3: Error 4: SELECT `Message` FROM `Error` WHERE `Error` = 1722
CustomAction CA2 returned actual error code 1 (note this may not be 100% accurate if translation happened inside sandbox)
MSI (s) (7C:A8) [12:27:22:707]: Note: 1: 2205 2:  3: Error
MSI (s) (7C:A8) [12:27:22:707]: Note: 1: 2228 2:  3: Error 4: SELECT `Message` FROM `Error` WHERE `Error` = 1709
MSI (s) (7C:A8) [12:27:22:707]: Product: Windows Azure VM Agent - 2.7.41491.949 -- Error 1722. There is a problem with this Windows Installer package. A program run as part of the setup did not finish as expected. Contact your support personnel or package vendor.  Action CA2, location: wscript.exe, command: "C:\Program Files\Windows Azure VM Agent v2.7.41491.949\\InstallOrUpdateGA.vbs"
```

C:\Windows\Panther\VmAgentInstaller.xml:  
```
Event time="2019-12-12T12:49:05.123Z" category="INFO" source="GuestAgent"><SetRdAgentServicePathInRegistry ServiceName="RdAgent" ServiceImagePath="C:\WindowsAzure\Packages_20191212_124856\WaAppAgent.exe"/></Event>
<Event time="2019-12-12T12:49:05.163Z" category="ERROR" source="GuestAgent"><UnhandledError><Message>Setting the new RdAgent service path in registry failed.</Message><Number>424</Number><Description>Object required</Description><Source>Microsoft VBScript runtime error</Source></UnhandledError></Event>
<Event time="2019-12-12T12:49:05.203Z" category="ERROR" source="GuestAgent"><ConfigureRdAgentService/></Event>
<Event time="2019-12-12T12:49:05.258Z" category="ERROR" source="GuestAgent"><UnhandledError><Message>Installing the RdAgent service failed.</Message><Number>-2147467259</Number><Description>This name may not contain the ' ' character:
```

The VM agent .msi file uses WMI StdRegProv to access the registry. If WMI isn't working correctly, the .msi file can't set the RdAgent service path from the registry. Therefore, the .msi file installation fails.

### Solution

1. Open an elevated Command Prompt window.
2. To test whether WMI StdRegProv is working, run the following WMIC command, and copy the output to a text file:

```
wmic /namespace:\\root\default Class StdRegProv Call GetDWORDValue hDefKey="&H80000002" sSubKeyName="SYSTEM\CurrentControlSet\Services\Winmgmt" sValueName=Start
```
If you're using Windows Server 2025 or later, and you didn't manually install WMIC, open an elevated PowerShell window to test StdRegProv:

```
Invoke-CimMethod -ClassName StdRegProv -MethodName GetDWORDValue -Arguments @{sSubKeyName = 'SYSTEM\CurrentControlSet\Services\Winmgmt';sValueName = 'Start'}
```

3.  Run the following WINMGMT command to verify the WMI repository, and copy the output to a text file:

```
winmgmt /verifyrepository
```

4. Back up the WMI repository:

```
xcopy c:\windows\system32\wbem\repository c:\windows\system32\wbem\repository.bak /e /i
```

5. Run the following command to fix the WMI issue, and copy the output to a text file:

```
winmgmt /salvagerepository
```

6. Try the VM agent .msi installation again. If it finishes successfully, wait for a minute or two, and then check whether the **RdAgent** service is running.

```
wmic service rdagent list brief
```

7. If the **WMIC** command shows **RdAgent** is running, the issue should be resolved. If the **WMIC** command fails or shows that **RdAgent** isn't running, go to the next step.

8. Run the following commands to reset the WMI repository:

```
net stop winmgmt /y
winmgmt /resetrepository
net start winmgmt
```

9. Try the VM agent .msi installation again. If it finishes successfully, wait for a minute or two, and then check whether the **RdAgent** service is running:

```
wmic service rdagent list brief
```

10. At this point, if the **WMIC** command fails or still doesn't show that **RdAgent** is running, send the **C:\Windows\Panther\VMAgentInstall.xml** file to Microsoft Support for review.

</details>

### Windows Azure Guest Agent service or the RdAgent service stops responding on startup 

<details>
<summary>Click here for troubleshooting details</summary>

System event errors 7031 or 7034 is logged, and the C:\WindowsAzure\logs\TransparentInstaller.log shows the following entry:

```
[ERROR] System.Configuration.ConfigurationErrorsException: The type 'Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior, Microsoft.VisualStudio.Diagnostics.ServiceModelSink, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a' registered for extension 'Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior' could not be loaded.

(C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config line 242)
```

### Solution

This issue might occur if Windows Communication Framework (WCF) profiling is enabled. WCF profiling should be enabled only while you debug a WCF issue. It shouldn't be left enabled while you run a production workload.

To disable WCF profiling:

 - Open an elevated Command Prompt window.
 - To back up the existing `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config` file, run the following commands:

```
cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config
copy machine.config machine.config.bak
```

 - To edit the file in Notepad, Run `notepad machine.config`. Remove the following text (but be careful not to also remove any other text that might be on the same line):

```
<add name="Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior" type="Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior, Microsoft.VisualStudio.Diagnostics.ServiceModelSink, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"/>
```

Remove the following text (but be careful not to also remove any other text that might be on the same line):

```
<commonBehaviors><endpointBehaviors><Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior/></endpointBehaviors><serviceBehaviors><Microsoft.VisualStudio.Diagnostics.ServiceModelSink.Behavior/></serviceBehaviors></commonBehaviors>
```

 - Save and close the file.
 - Restart the Guest Agent services:

```cmd
net stop Rdagent
net stop WindowsAzureGuestAgent

net start Rdagent
net start WindowsAzureGuestAgent
```

 - In some cases, the VM might have to be restarted for the WCF disablement to take effect.

</details>

## Next steps

Other known issues that are associated with the Azure VM Agent are listed in its [GitHub repository](https://github.com/Azure/WindowsVMAgent/wiki/Known-Issues).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
