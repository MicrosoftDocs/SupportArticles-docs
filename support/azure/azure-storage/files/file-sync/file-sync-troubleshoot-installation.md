---
title: Troubleshoot Azure File Sync agent installation and server registration
description: Troubleshoot common issues with installing the Azure File Sync agent and registering Windows Server with the Storage Sync Service. 
author: khdownie
ms.service: azure-file-storage
ms.date: 07/11/2025
ms.author: kendownie
ms.custom: sap:File Sync
---

# Troubleshoot Azure File Sync agent installation and server registration

After deploying the Storage Sync Service, the next steps in deploying Azure File Sync are installing the Azure File Sync agent and registering Windows Server with the Storage Sync Service. This article helps you troubleshoot and resolve issues that you might encounter during these steps.

## Agent installation

<a id="agent-installation-restart"></a>**How to check if an Azure File Sync agent installation requires a restart**

Installing an Azure File Sync agent might need a restart to finish. For example, Azure File Sync agent version 19.1.0.0 requires a restart on servers if updating from a version earlier than 18.2.0.0.

If the agent is updated using the auto-upgrade feature, run the following PowerShell commands to check if a restart is required to complete the agent auto-upgrade:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Get-StorageSyncServer
```

If the value for the `RebootNeeded` property is `True`, a restart is required.

<a id="agent-update-hangs"></a>**Agent update does not complete**

When upgrading the Azure File Sync agent, you might experience one of the following symptoms:

- *AfsUpdater.exe* hangs at "installing updates."
- Agent installation hangs at "Stopping monitoring agent."

This issue occurs if the currently installed Azure File Sync agent version is earlier than v16.2 and the *Logman.exe* process fails to shut down.

To resolve this issue, perform the following steps:

1. Open **Task Manager**.
1. Right-click the **LogMan** process and select **End task**. Repeat this step until all LogMan processes are stopped and the agent update completes successfully.

<a id="agent-installation-failures"></a>**Troubleshoot agent installation failures**

If the Azure File Sync agent installation fails, locate the installation log file that's located in the agent installation directory. If the Azure File Sync agent is installed on the *C:* volume, the installation log file is located under *C:\Program Files\Azure\StorageSyncAgent\InstallerLog*.

> [!Note]  
> If the Azure File Sync agent is installed from the command line and the `/l\*v` switch is used, the log file will be located in the path where the agent installation was executed.

The log file name for agent installations using the MSI package is *AfsAgentInstall*. The log file name for agent installations using the MSP package (update package) is *AfsUpdater*.

Once you have located the agent installation log file, open the file and search for the failure code at the end of the log. If you search for "error code 1603" or "sandbox," you should be able to locate the error code.

Here's a snippet from an agent installation that failed:

```output
CAQuietExec64:      + CategoryInfo          : SecurityError: (:) , PSSecurityException  
CAQuietExec64:      + FullyQualifiedErrorId : UnauthorizedAccess  
CAQuietExec64:  Error 0x80070001: Command line returned an error.  
CAQuietExec64:  Error 0x80070001: QuietExec64 Failed  
CAQuietExec64:  Error 0x80070001: Failed in ExecCommon64 method  
CustomAction SetRegPIIAclSettings returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)  
Action ended 12:23:40: InstallExecute. Return value 3.  
MSI (s) (0C:C8) [12:23:40:994]: Note: 1: 2265 2:  3: -2147287035
```

For this example, the agent installation failed with error code -2147287035 (ERROR_ACCESS_DENIED).

<a id="agent-installation-gpo"></a>**Agent installation fails with error ERROR_NO_SYSTEM_RESOURCES and error code 0x800705AA**

The agent installation failed due to insufficient system resources. To resolve this issue, free up memory on the server and retry installation.

<a id="agent-installation-gpo"></a>**Agent installation fails with error: Storage Sync Agent Setup Wizard ended prematurely because of an error**

In the agent installation log, the following error is logged:

```output
CAQuietExec64:      + CategoryInfo          : SecurityError: (:) , PSSecurityException  
CAQuietExec64:      + FullyQualifiedErrorId : UnauthorizedAccess  
CAQuietExec64:  Error 0x80070001: Command line returned an error.  
CAQuietExec64:  Error 0x80070001: QuietExec64 Failed  
CAQuietExec64:  Error 0x80070001: Failed in ExecCommon64 method  
CustomAction SetRegPIIAclSettings returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)  
Action ended 12:23:40: InstallExecute. Return value 3.  
MSI (s) (0C:C8) [12:23:40:994]: Note: 1: 2265 2:  3: -2147287035 
```

This issue occurs if the [PowerShell execution policy](/powershell/module/microsoft.powershell.core/about/about_execution_policies#use-group-policy-to-manage-execution-policy) is configured using group policy and the policy setting is "Allow only signed scripts." All scripts included with the Azure File Sync agent are signed. The Azure File Sync agent installation fails because the installer is performing the script execution using the Bypass execution policy setting.

To resolve this issue, temporarily disable the [Turn on Script Execution](/powershell/module/microsoft.powershell.core/about/about_execution_policies#use-group-policy-to-manage-execution-policy) group policy setting on the server. Once the agent installation completes, the group policy setting can be re-enabled.

<a id="agent-installation-on-DC"></a>**Agent installation fails on Active Directory Domain Controller**

In the agent installation log, the following error is logged:

```output
CAQuietExec64:  Error 0x80070001: Command line returned an error.
CAQuietExec64:  Error 0x80070001: CAQuietExec64 Failed
CustomAction InstallHFSRequiredWindowsFeatures returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)
Action ended 8:51:12: InstallExecute. Return value 3.
MSI (s) (EC:B4) [08:51:12:439]: Note: 1: 2265 2:  3: -2147287035
```

This issue occurs if you try to install the sync agent on an Active Directory domain controller where the PDC role owner is on a Windows Server 2008 R2 or earlier OS version.

To resolve, transfer the PDC role to another domain controller running Windows Server 2012 R2 or more recent, then install sync.

<a id="parameter-is-incorrect"></a>**Accessing a volume on Windows Server 2012 R2 fails with error: The parameter is incorrect**

After creating a server endpoint on Windows Server 2012 R2, the following error occurs when accessing the volume:

> drive letter:\ is not accessible.  
> The parameter is incorrect.

To resolve this issue, install [KB2919355](https://support.microsoft.com/help/2919355/windows-rt-8-1-windows-8-1-windows-server-2012-r2-update-april-2014) and restart the server. If this update can't install because a later update is already installed, go to **Windows Update**, install the latest updates for Windows Server 2012 R2, and restart the server.

## Agent installation via Azure Arc extension

To learn about installing the Azure File Sync Agent for Windows, see [Install and manage the Azure File Sync agent extension on Azure Arc-enabled Windows servers](/azure/storage/file-sync/file-sync-extension).

### Troubleshoot installation failure

1. Navigate to your **Arc Server** in the Azure portal.
1. Go to the **Extensions** blade for the server.
1. Locate `AzureFileSyncAgentExtension` and select **View Details** under the **Status** column.
1. Review the **Error Message** field for detailed information on why the extension deployment failed.

> [!IMPORTANT]
> The failed extension must be uninstalled and then reinstalled **after** performing the required remediation steps. Save the error message details for troubleshooting or when contacting Azure File Sync support. Uninstalling the extension will remove these details.

#### Error code reference and remediation
 
| **Error Message** | **Error Code** | **Remediation Steps** |
|-------------------|----------------|------------------------|
| Cannot install Azure File Sync agent because .NET Framework 4.7.2 or later is required. Install the latest .NET Framework and try again | 206 | Install .NET Framework 4.7.2 or higher. Reboot the machine afterward. |
| Azure File Sync agent is already installed. No further action needed. | 0 | No action required. The extension is installed, but no customization is applied. |
| The Azure File Sync agent is only supported on RTM (Release to Manufacturing) versions of supported operating systems. | 51 | Azure File Sync agent and extension are supported only on RTM versions of Windows Server 2016, 2019, 2022, and 2025. |
| Proxy settings error. `UseCustomProxy` is enabled but ProxyAddress is missing or invalid. ProxyAddress must be specified without port and length must be less than 255 characters. | 201 | Ensure `ProxyAddress` is specified. Must be under 255 characters. |
| Proxy settings error. `UseCustomProxy` is enabled but ProxyPort is missing or invalid. Proxy port must be a number between 1 and 65535 | 202 | Provide a valid `ProxyPort` (numeric value between 1 and 65535) when `UseCustomProxy` is enabled. |
| Proxy settings error. `ProxyAuthRequired` is enabled but ProxyUsername is missing or invalid. `ProxyUsername` length must be between 3 and 255 characters | 203 | Ensure `ProxyUsername` is specified and its length is between 3 and 255 characters. |
| Proxy settings error. `ProxyAuthRequired` is enabled but ProxyPassword is missing or empty | 204 | Provide a non-empty `ProxyPassword` when `ProxyAuthRequired` is enabled. |
| A system reboot is pending due to Storage Sync file rename operations. Restart your server before installing the Azure File Sync agent. | 83 | A reboot is required. Restart the server before attempting agent installation again. |
| The file signature is not valid. Or Signature validation failed for the downloaded MSI file | 86 | The installer file might be corrupted or tampered with. Re-download the MSI file from a trusted source. |
| Certificate chain validation failed. | 86 | Ensure the required root certificates are installed. Refer to [this documentation](/azure/aks/aksarc/aks-edge-howto-offline-install).<br><br>**If using a proxy**, ensure the following domains are bypassed:<br>`login.microsoftonline.com`, `management.azure.com`, `go.microsoft.com`, `download.microsoft.com`, `download.windowsupdate.com`, `crl.microsoft.com`, `oneocsp.microsoft.com`, `ocsp.msocsp.com`, `www.microsoft.com`.<br><br>Restart the machine to apply any updates. |
| Azure File Sync agent download or configuration failed. Details: Failed to configure auto update settings: Agent install directory not found in registry. Please check the installation. | 214 | 1. Open an elevated PowerShell session and check if .NET 4.7.2 or higher is installed:<br>```$releaseKey = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue).Release```<br>2. If `$releaseKey` is less than `461808`, .NET 4.7.2 isn't installed.<br>3. Download and install .NET Framework 4.7.2 or later from the [official .NET download site](https://dotnet.microsoft.com/download/dotnet-framework). |

## Server registration

<a id="server-registration-failed"></a>**Troubleshoot server registration failures**

If server registration fails, open the *AfsSrvRegistration\*.log* file located under *%LocalAppData%\Temp* and search for "ErrorMessage" to get the error details.

If you can't identify the cause based on the error message, use the `Debug-StorageSyncServer` cmdlet to help diagnose if server registration fails due to a network issue or server certificate.

To run diagnostics on the server, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -Diagnose
```

To test the network connectivity on the server, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -TestNetworkConnectivity
```

<a id="server-registration-catastrophic-error"></a>**Server registration using the `Register-AzStorageSyncServer` cmdlet fails with the error: Catastrophic failure (0x8000FFFF)**

A server registration using the `Register-AzStorageSyncServer` cmdlet fails with the following error:

> Catastrophic failure (0x8000FFFF (E_UNEXPECTED)) 'No system-assigned Managed Identity was found for this resource'
 
This issue occurs when the Azure Files Sync agent is upgraded from version 17.x to 18.x and the `ServerType` registry value is set to an unexpected value.
 
To resolve this issue, delete the `ServerType` registry value by running the following commands from an elevated command prompt:

```console
reg delete HKLM\SOFTWARE\Microsoft\Azure\StorageSync /v ServerType /f  
net stop filesyncsvc  
net start filesyncsvc  
```

Once the `ServerType` registry value is deleted, retry the server registration.

<a id="server-registration-missing-subscriptions"></a>**Server Registration does not list all Azure Subscriptions**

When registering a server using *ServerRegistration.exe*, subscriptions are missing when you select the **Azure Subscription** drop-down.

This issue occurs because *ServerRegistration.exe* will only retrieve subscriptions from the first five Microsoft Entra tenants.

To increase the Server Registration tenant limit on the server, create a DWORD value called `ServerRegistrationTenantLimit` under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure\StorageSync` with a value greater than 5.

You can also work around this issue by using the following PowerShell commands to register the server:

```powershell
Connect-AzAccount -Subscription "<guid>" -Tenant "<guid>"
Register-AzStorageSyncServer -ResourceGroupName "<your-resource-group-name>" -StorageSyncServiceName "<your-storage-sync-service-name>"
```

<a id="server-registration-missing-resource-groups"></a>**Server registration doesn't list all resource groups**

When registering a server using *ServerRegistration.exe*, some resource groups are missing when you select the **Resource Group** drop-down.

This issue occurs due to a known issue that has been fixed in File Sync Agent v19.1. To resolve this issue, install the latest version of the agent.

**Server Registration displays the message: "System.Net.Http, Version=4.2.0.0, Culture=neutral, PublicKeyToken=..."**

This error occurs when the server lacks the required .NET Framework version. Azure File Sync's server registration requires .NET Framework 4.7.2 or a later version to function properly.

To resolve the issue, follow these steps:

1. Download and install .NET Framework 4.7.2 or a later version.
1. Restart the server after the installation.
1. Retry the server registration using the server registration UI or PowerShell.

**Server registration fails with error: operation returned an invalid status code 'Unauthorized'**

During server registration, you might encounter the following error:

> Operation returned an invalid status code 'Unauthorized'

This issue occurs due to a bug in the Azure File Sync v20 agent. To work around this issue, manually register the server by running the following PowerShell commands:

```powershell
Connect-AzAccount -Subscription "<your-subscription-guid>" -Tenant "<your-tenant-guid>"
Register-AzStorageSyncServer -ResourceGroupName "<your-resource-group-name>" -StorageSyncServiceName "<your-storage-sync-service-name>"
```

> [!NOTE]
> Replace the placeholder values with your subscription ID, tenant ID, resource group name, and Storage Sync Service name.

After completing the manual registration, verify that the server appears under **Registered servers** in the Azure portal.

<a id="server-already-registered"></a>**Server Registration displays the following message: "This server is already registered"**

:::image type="content" source="media/file-sync-troubleshoot-installation/server-already-registered-error.png" alt-text="Screenshot that shows the Server Registration dialog box with the 'server is already registered' error message.":::

This message with error code 0x80C80064 appears if the server was previously registered with a Storage Sync Service.  To unregister the server from the current Storage Sync Service and then register with a new Storage Sync Service, complete the steps in [Unregister a server with Azure File Sync](/azure/storage/file-sync/file-sync-server-registration#unregister-the-server-with-storage-sync-service).

If the server isn't listed under **Registered servers** in the Storage Sync Service, on the server that you want to unregister, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Reset-StorageSyncServer
```

> [!NOTE]
> If the server is part of a cluster, the `Reset-StorageSyncServer` `-CleanClusterRegistration` parameter will unregister all servers in the cluster.

<a id="web-site-not-trusted"></a>**When I register a server, I see numerous "web site not trusted" responses. Why?**

This issue occurs when the **Enhanced Internet Explorer Security** policy is enabled during server registration. For more information about how to correctly disable the **Enhanced Internet Explorer Security** policy, see [Prepare Windows Server to use with Azure File Sync](/azure/storage/file-sync/file-sync-deployment-guide#prepare-windows-server-to-use-with-azure-file-sync) and [How to deploy Azure File Sync](/azure/storage/file-sync/file-sync-deployment-guide).

<a id="server-registration-missing"></a>**Server is not listed under registered servers in the Azure portal**

If a server isn't listed under **Registered servers** for a Storage Sync Service:

1. Sign in to the server that you want to register.
1. Open File Explorer, and then go to the Storage Sync Agent installation directory (the default location is *C:\Program Files\Azure\StorageSyncAgent*).
1. Run *ServerRegistration.exe*, and complete the wizard to register the server with a Storage Sync Service.

## See also

- [Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)
- [Troubleshoot Azure File Sync sync errors](file-sync-troubleshoot-sync-errors.md)
- [Troubleshoot Azure File Sync cloud tiering](file-sync-troubleshoot-cloud-tiering.md)
- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files problems](../connectivity/files-troubleshoot.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
