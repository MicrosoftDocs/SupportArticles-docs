---
title: Troubleshoot Azure Windows VM Agent issues
description: Understand how to troubleshoot issues that prevent the Azure Windows VM Agent from running successfully.
services: virtual-machines
ms.service: azure-virtual-machines
ms.collection: windows
author: kegregoi
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 03/17/2025
ms.author: kegregoi
editor: v-jsitser
ms.reviewer: v-leedennis, scotro
ms.custom: sap:VM Extensions not operating correctly
---
# Troubleshoot Azure Windows VM Agent issues

**Applies to:** :heavy_check_mark: Windows VMs

[!INCLUDE [Feedback](../../../includes/feedback.md)]

Azure VM Agent is a virtual machine (VM) agent. It enables the VM to communicate with the Fabric Controller (the underlying physical server on which the VM is hosted) on IP address `168.63.129.16`. This address is a virtual public IP address that facilitates communication. For more information, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16).

The VM that is migrated to Azure from an on-premises environment or created by using a customized image doesn't have Azure VM Agent installed. In these scenarios, you have to manually install VM Agent. For more information about how to install the VM Agent, see [Azure Virtual Machine Agent overview](/azure/virtual-machines/extensions/agent-windows).

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

1. If the VM isn't turned on already, locate the list of actions at the top of the **Overview** page, and then select the **Start** link.

Also, verify that the operating system (OS) is started and running successfully.

### Step 2: Check whether Guest Agent is ready

While you're still on the VM overview page of the Azure portal, select the **Properties** tab. If the **Agent status** field has a value of **Ready**, verify that the **Agent version** field value satisfies the [minimum supported version](./support-extensions-agent-version.md). The following screenshot shows where you can find these fields.

:::image type="content" source="./media/windows-azure-guest-agent/guest-agent-portal-status.png" alt-text="Azure portal screenshot that shows the virtual machine (VM) properties. The agent status is Ready, and the Agent version is 2.7.41491.1083." lightbox="./media/windows-azure-guest-agent/guest-agent-portal-status.png" border="false":::

If the Guest Agent status is **Ready** but you have an issue that involves a VM extension, see [Azure virtual machine extensions and features](/azure/virtual-machines/extensions/overview) to review troubleshooting suggestions.

If the Guest Agent status is **Not ready** or blank, then either Guest Agent isn't installed or it isn't working correctly.

### Step 3: Check whether the Guest Agent services are running

1. [Use Remote Desktop Protocol (RDP) to connect to your VM](/azure/virtual-machines/windows/connect-rdp).

   > [!NOTE]  
   > The Guest Agent isn't necessary for RDP connectivity to work successfully. If you experience issues that affect RDP connectivity to your VM, see [Troubleshoot Remote Desktop connections to an Azure virtual machine](./troubleshoot-rdp-connection.md).

1. On your VM, select **Start**, search for *services.msc*, and then select the **Services** app.
1. In the **Services** window, select the **RdAgent** service.
1. Select the **Action** menu, and then select **Properties**.
1. On the **General** tab of the **Properties** dialog box, make sure that the following conditions are true, and then select the **OK** or **Cancel** button:

   - The **Startup type** drop-down list is set to **Automatic**.
   - The **Service status** field has a value of **Running**.

   :::image type="content" source="./media/windows-azure-guest-agent/guest-agent-checking-rdagent-service.png" alt-text="Screenshot of the RdAgent Properties dialog box. The dialog box shows the RdAgent service status as Running and the startup type as Automatic.":::

1. In the **Services** window, select the **WindowsAzureGuestAgent** service.
1. Repeat steps 4 and 5.

If the services don't exist, the Guest Agent probably isn't installed. In this case, you can [manually install the Guest Agent](/azure/virtual-machines/extensions/agent-windows#manual-installation). Before you do a manual installation, [check the installation prerequisites](/azure/virtual-machines/extensions/agent-windows#prerequisites).

### Step 4: Test WireServer connectivity

To run successfully, Guest Agent requires connectivity to the WireServer IP (host IP) address `168.63.129.16` on ports `80` and `32526`. For instructions about how to test connectivity to this IP address, see the [Troubleshoot connectivity](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-connectivity) section of [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

If any of the tests in that section don't connect, check for issues that might cause any of the following components to block access to IP address `168.63.129.16`:

- A firewall
- A proxy
- An application

### Step 5: Review log files

Check the following log locations for any notable errors:

- *C:\\WindowsAzure\\Logs\\WaAppAgent.log*
- *C:\\WindowsAzure\\Logs\\TransparentInstaller.log*

Compare any errors that you find to the following common scenarios that can cause the Azure VM Agent to show a **Not ready** status or stop working as expected.

## Cause 1: Windows VMs that use Azure VM agent version 2.7.41491.1004 experience issues involving Sysprep

Running Sysprep on these VMs might cause the following errors:

- When you run Sysprep for the first time, you see the following error message:

  > ADMINISTRATOR: Error Handler

- When you run Sysprep more than one time, you see the following error message:

  > A fatal error occurred while trying to sysprep the VM

### Solution 1: Reset the Sysprep state of the VM, and then upgrade the Azure VM Agent to a later version

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

First, reset the Sysprep state of the VM. The reset involves [modifying some registry keys](https://www.wintips.org/fix-sysprep-fatal-error-dwret-31-machine-invalid-state-couldnt-update-recorded-state/). Then, you can upgrade the Azure VM Agent to a later version. Because the issue occurs only in version 2.7.41491.1004, you can try upgrading the agent to the latest agent version.

## Cause 2: Agent is stuck in the "Starting" process

In the *WaAppAgent.log* file, you can see that the agent is stuck in the "Starting" process and can't start:

```output
[00000007] [05/28/2019 12:58:50.90] [INFO] WindowsAzureGuestAgent starting. Version 2.7.41491.901
```

The VM is still running the older version of Azure VM Agent. In the *C:\\WindowsAzure* folder, you might notice that many Azure VM Agent instances are installed, including several instances that have the same version. Because more than one agent instance is installed, the VM doesn't start the latest version of Azure VM Agent.

### Solution 2: Manually uninstall and reinstall the Azure VM Agent

Manually uninstall the Azure VM Agent, and then reinstall it by following these steps:

1. Open **Control Panel** > **Programs and Features**, and uninstall Azure VM Agent.
1. Start Task Manager, and then stop the following services:

   - Azure VM Agent service
   - RdAgent service
   - Windows Azure Telemetry service
   - Windows Azure Network Agent service

1. Under *C:\\WindowsAzure*, create a folder that's named *OLD*.
1. Move any folders that are named *Packages* or *GuestAgent* to the *OLD* folder. Also, move any of the *GuestAgent* folders in *C:\\WindowsAzure\\logs* that start as *GuestAgent_x.x.xxxxx* to the *OLD* folder.
1. Download and install the latest version of the Windows Installer (MSI) agent from [the GitHub page for Azure Windows VM Agent releases](https://github.com/Azure/WindowsVMAgent/releases). You must have administrator rights to complete the installation.
1. Install Guest Agent by running the following [msiexec](/windows-server/administration/windows-commands/msiexec) command:

    ```cmd
    msiexec.exe /i c:\VMAgentMSI\WindowsAzureVmAgent.2.7.<version>.fre.msi /quiet /L*v c:\VMAgentMSI\msiexec.log
    ```

1. Verify that the RdAgent, Azure VM Agent, and Windows Azure Telemetry services are now running.

1. Check the *WaAppAgent.log* file to make sure that the latest version of Azure VM Agent is running.

1. Delete the *OLD* folder under *C:\\WindowsAzure*.

## Cause 3: Can't connect to WireServer IP (Host IP)

You notice the following error entries in the *WaAppAgent.log* and *Telemetry.log* files:

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

These error entries indicate that VM can't reach the WireServer host server.

### Solution 3: Enable DHCP, and make sure that the server isn't blocked by firewalls, proxies, or other sources

1. Because WireServer isn't reachable, connect to the VM by using Remote Desktop, and then try to access the URL, `http://168.63.129.16/?comp=versions`, in a web browser.
1. If you can't reach the URL from step 1, check the network interface to determine whether it is enabled to use the Dynamic Host Configuration Protocol (DHCP) and has DNS. To check the DHCP status of the network interface, run the following [network shell](/windows-server/networking/technologies/netsh/netsh) (`netsh`) interface IP command for [show config](/previous-versions/windows/it-pro/windows-server-2003/cc738592(v=ws.10)#show-config):

   ```cmd
   netsh interface ip show config
   ```

1. If DHCP is disabled, run the following `netsh` interface IP command for [set address](/previous-versions/windows/it-pro/windows-server-2003/cc738592(v=ws.10)#set-address):

   ```cmd
   netsh interface ip set address name="<name-of-the-interface>" source=dhcp
   ```

   **Note:** In this command, change the placeholder value to the name of your interface.

1. Check for any issues that a firewall, a proxy, or another source might cause that could block access to the IP address, `168.63.129.16`.
1. Check whether Windows Firewall or a third-party firewall is blocking access to ports `80` and `32526`. For more information about why this address shouldn't be blocked, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

## Cause 4: Guest Agent is stuck in the "Stopping" process  

You notice the following error entries in the *WaAppAgent.log* file:

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

### Solution 4a: Start WaAppAgent.exe and stop WindowsAzureGuest.exe

Make sure that *WaAppAgent.exe* is running on the VM. If it isn't running, restart the RdAgent service, and then wait five minutes. After *WaAppAgent.exe* starts running, end the *WindowsAzureGuest.exe* process.

### Solution 4b: Upgrade to the latest version of the Azure VM agent

If Solution 4a doesn't resolve the issue, remove the currently installed version, and then install the latest version of the agent manually.

## Cause 5: The Npcap loopback adapter is installed

You notice the following error entries in the *WaAppAgent.log* file:

```output
[00000006] [06/20/2019 07:44:28.93] [INFO]  Attempting to discover fabric address on interface Npcap Loopback Adapter.
[00000024] [06/20/2019 07:44:28.93] [WARN]  Empty DHCP option data returned
[00000006] [06/20/2019 07:44:28.93] [ERROR] Did not discover fabric address on interface Npcap Loopback Adapter
```

These error entries indicate that [Wireshark](https://www.wireshark.org) installed the packet capture ([Npcap](https://npcap.com)) loopback adapter of the Network Mapper ([Nmap](https://nmap.org)) Project on the VM. Wireshark is an open-source tool for profiling network traffic and analyzing packets. Such a tool is often referred to as a network analyzer, network protocol analyzer, or sniffer.

### Solution 5: Disable the Npcap loopback adapter

Try to disable the Npcap loopback adapter, and then check whether the problem is resolved.

## Cause 6: Remote Procedure Call (RPC) issues

You notice the following error entries in the *WaAppAgent.log* file:

```output
[00000004] [01/12/2019 00:30:47.24] [ERROR] RdCrypt Initialization failed. Error Code: -2147023143.
[00000004] [01/12/2019 00:30:47.24] [ERROR] Failed to get TransportCertificate. Error: System.AccessViolationException
Microsoft.Cis.Fabric.CertificateServices.RdCertificateFactory.Shutdown()
[00000004] [01/12/2019 00:30:47.24] [WARN]  Could not get transport certificate from agent runtime for subject name: 12345678-d7c8-4387-8cf3-d7ecf62544e5. Installing certificates in the LocalMachine store failed.
[00000004] [01/12/2019 00:30:47.24] [WARN] Fetching certificate blob from the cert URI: http://168.63.129.16/machine/12345678-d7c8-4387-8cf3-d7ecf62544e5/12345678-d447-4b10-a5da-1ba1581cd7d7._VMName?comp=certificates&incarnation=2 failed with exception: System.NullReferenceException
-2147023143 = 0x6d9 = EPT_S_NOT_REGISTERED
```

These error entries are probably caused by Remote Procedure Call (RPC) issues. For example, the RPC endpoint might not be listening, or the RPC process might be missing on the opposite end.

### Solution 6: Start the CNG Key Isolation service

Check whether the [Cryptography Next Generation (CNG) Key Isolation](/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server#cng-key-isolation) (`CNGKEYISO`) Windows service is in the list of RPC endpoints by running the following [portqry](../../../windows-server/networking/portqry-command-line-port-scanner-v2.md) command:

```cmd
portqry -n <VMName> -e 135
```

If you don't see the `CNGKEYISO` process, start it from the Windows Services console (CNG Key Isolation = `KeyIso`), and then restart *WaAppAgent.exe* or *WindowsAzureGuestAgent.exe*.

## Cause 7: PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86

Windows Guest Agent is running, but extensions aren't working. You notice the following error entries in the *WaAppAgent.log* file:

```output
PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86

[00000003] [10/21/2020 02:37:45.98] [WARN]  Could not get transport certificate from agent runtime for subject name: 12345678-dae3-4c2f-be57-55c0ab7a44e5. Installing certificates in the LocalMachine store failed.
[00000003] [10/21/2020 02:37:45.98] [ERROR] Installing certificates in the LocalMachine store failed with exception: Microsoft.WindowsAzure.GuestAgent.CertificateManager.CryptographyNative+PInvokeException: PInvoke PFXImportCertStore failed and null handle is returned. Error Code: 86.
```

These error entries are probably caused by a lack of permissions on the *Crypto* folders for the SYSTEM account. If you collect a [Process Monitor](/sysinternals/downloads/procmon) (ProcMon) trace while you restart the Guest Agent services (RdAgent or WindowsAzureGuestAgent), you should be able to see some "Access Denied" errors.

### Solution 7: Add full control of Crypto folders to the SYSTEM account

Make sure that the SYSTEM account has **Full Control** permissions on the following folders:

- *C:\\ProgramData\\Microsoft\\Crypto\\Keys*

- *C:\\ProgramData\\Microsoft\\Crypto\\RSA*

- *C:\\ProgramData\\Microsoft\\Crypto\\SystemKeys*

## Cause 8: System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)

You notice the following error entries in the *WaAppAgent.log* file that indicate that Guest Agent isn't responding:

```output
[00000018] 2021-01-12T16:35:45Z [INFO]  Test extract the plugin zip file to the temp folder C:\TEMP\12345678-5f85-45dc-9f17-55be1fde7b10
[00000010] 2021-01-12T16:35:45Z [ERROR] InstallPlugins() failed with exception: System.AggregateException: One or more errors occurred. ---> System.BadImageFormatException: An attempt was made to load a program with an incorrect format. (Exception from HRESULT: 0x8007000B)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.PackageExpand(String packageFilePath, String destinationPath)
   at Microsoft.WindowsAzure.GuestAgent.ExtensionStateMachine.PluginInstaller.ValidateExtensionZipFile(String pluginName, String pluginVersion, String& pluginZipFile)

```

Most likely, these error entries occur because a third-party application was installed on the VM, and it modified the behavior of 32-bit or 64-bit .NET applications.

A `BadImageFormatException` error occurs when a 64-bit application is loading a 32-bit DLL.

### Solution 8: Set the Enable64Bit registry entry for .NET Framework and restart the VM

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

Open the registry, locate the **HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\.NETFramework** registry subkey, and then view the **Enable64Bit** registry entry.

If the **Enable64Bit** registry entry is set to **0**, then 64-bit .NET applications are considered as 32-bit applications. Therefore, Azure VM Agent doesn't work.

The solution is to set the **Enable64Bit** key to **1**, and then restart the VM.

## Cause 9: Windows Guest Agent doesn't start because of a ConfigurationErrorsException or TypeInitializationException error

Windows Guest Agent stops responding upon startup, and the following Application log entries are displayed:

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

### Solution 9: Copy a working machine.config file to the VM, and then restart the Guest Agent services

To resolve the issue, follow these steps:

1. Copy the *machine.config* file from a working VM, and then paste the file into the *C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\Config* folder on the problematic VM.
1. Restart the Guest Agent services by running the `net stop` and `net start` commands:

   ```cmd
   net stop RdAgent
   net stop WindowsAzureGuestAgent

   net start RdAgent
   net start WindowsAzureGuestAgent
   ```

## Next steps

Other known issues that are associated with the Azure VM Agent are listed in its [GitHub repository](https://github.com/Azure/WindowsVMAgent/wiki/Known-Issues).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
