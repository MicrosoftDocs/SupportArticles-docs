---
title: Troubleshoot data freshness alerts in Microsoft Entra Connect Health
description: Troubleshoot data freshness alerts in Microsoft Entra Connect Health. Use agents for Sync, Microsoft Entra Domain Services, and AD Federation Services.
ms.date: 11/09/2023
ms.reviewer: brheld, calazlo, v-leedennis
ms.service: active-directory
ms.subservice: hybrid
#Customer intent: As a Microsoft Entra Connect Health Service user, I want to troubleshoot data freshness alerts so that I can fix issues with Active Directory Federation Services (AD FS).
---
# Troubleshoot data freshness alerts in Microsoft Entra Connect Health

This article offers common diagnostic fixes for the data freshness alert "Health service data is not up to date", which is generated when the Microsoft Entra Connect Health Service hasn't received data in the last two hours. The alert occurs in the Health Service for the following services:

- Azure AD Sync service
- Microsoft Entra Domain Services
- Active Directory Federation Services (AD FS)

## Prerequisites

- [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594).
- The [Microsoft Entra Connect Health agent for AD DS](https://go.microsoft.com/fwlink/?LinkID=820540).
- The [Microsoft Entra Connect Health agent for Active Directory Federation Services](https://go.microsoft.com/fwlink/?LinkID=518973).
- The [PsExec](/sysinternals/downloads/psexec) tool.

## Symptoms

To view the data freshness alert, take the following steps:

1. In [the Azure portal](https://portal.azure.com), search for and select **Microsoft Entra Connect Health**.

1. In the **Microsoft Entra Connect Health | Quick start** menu pane, select **AD DS Services**.

1. Select your domain name, and then select **Alerts**.

1. In the **Active Directory Domain Services Alerts** pane, select **Health service data is not up to date.**

1. In the **Health service data is not up to date** pane, select the **Server Name**. The lists of properties for **Alert Details** and **Data Type Details** appear.

## Common diagnostic steps

Before you continue, see [Health service data is not up to date alert](/azure/active-directory/hybrid/how-to-connect-health-data-freshness).

## HTTP proxy troubleshooting steps

If you use an HTTP proxy, follow these steps:

1. If Secure Sockets Layer (SSL) inspection is turned on, make sure that you've added the policy key service endpoint (`policykeyservice.dc.ad.msft.net`) to the allow list.

1. Use a PowerShell cmdlet to find connectivity issues. You can [run the Test-AzureADConnectHealthConnectivity cmdlet](/azure/active-directory/hybrid/how-to-connect-health-agent-install#test-connectivity-to-azure-ad-connect-health-service) successfully as a regular user. However, if all data types are missing, the proxy setting might be correct for the user but not for **Local System** (the context that the service runs under). In that case, run the appropriate `Test-AzureADConnectHealthConnectivityAsSystem` cmdlet instead:

    ### [Sync](#tab/sync)

    ```powershell
    Test-AzureADConnectHealthConnectivityAsSystem -Role Sync
    ```

    ### [AD DS](#tab/azure-ad-ds)

    ```powershell
    Test-AzureADConnectHealthConnectivityAsSystem -Role ADDS
    ```

    ### [AD FS](#tab/ad-fs)

    ```powershell
    Test-AzureADConnectHealthConnectivityAsSystem -Role ADFS
    ```

    ---

1. To check whether the proxy settings are correct for **Local System**:

    1. Enter the following `PsExec` command to view the Windows settings remotely:

        ```console
        PsExec.exe -i -s "start ms-settings:"
        ```

    1. Select **Network & internet** > **Proxy**, and then select **Edit** under the **Manual proxy setup** heading.

    1. In the **Edit proxy server** dialog box, update the proxy server settings to match the current setup.

    1. Restart the services.

## Performance counter troubleshooting steps

Run the following PowerShell commands to check for the existence of certain performance counter categories.

### [Sync](#tab/sync)

```powershell
[System.Diagnostics.PerformanceCounterCategory]::Exists("Processor")
[System.Diagnostics.PerformanceCounterCategory]::Exists("TCPv4")
[System.Diagnostics.PerformanceCounterCategory]::Exists("Memory")
[System.Diagnostics.PerformanceCounterCategory]::Exists("Process")
```

### [AD DS](#tab/azure-ad-ds)

```powershell
[System.Diagnostics.PerformanceCounterCategory]::Exists("Processor")
[System.Diagnostics.PerformanceCounterCategory]::Exists("TCPv4")
[System.Diagnostics.PerformanceCounterCategory]::Exists("Memory")
[System.Diagnostics.PerformanceCounterCategory]::Exists("Process")
[System.Diagnostics.PerformanceCounterCategory]::Exists("DirectoryServices(NTDS)")
[System.Diagnostics.PerformanceCounterCategory]::Exists("Security System-Wide Statistics")
[System.Diagnostics.PerformanceCounterCategory]::Exists("LogicalDisk")
```

### [AD FS](#tab/ad-fs)

Microsoft is developing scripts that apply to AD FS, and will post those scripts in this article when they become available.

---

If any of these commands return **False**, run the following script to get more information about the performance counters:

### [Sync](#tab/sync)

```powershell
$perfCounters = @(
    "\Processor(_Total)\% Processor Time", 
    "\Memory\Available MBytes", 
    "\TCPv4\Connections Established", 
    "\Process(Microsoft.Identity.AadConnect.Health.AadSync.Host)\Private Bytes", 
    "\Process(Microsoft.Identity.Health.AadSync.MonitoringAgent.Startup)\Private Bytes"
)
foreach($counter in $perfCounters)
{
    try
    {
        $counterResult = Get-Counter -Counter $counter -MaxSamples 1 -ErrorAction SilentlyContinue
        if($counterResult -eq $null)
        {
            Write-Host $counter " ->  does not exist" -ForegroundColor Red
            if($counter -eq "\Process(Microsoft.Identity.AadConnect.Health.AadSync.Host)\Private Bytes")
            {
                Write-Host "     Please make sure Azure AD Connect Health Sync Insights Service is running." -ForegroundColor Magenta
            }
            elseif($counter -eq "\Process(Microsoft.Identity.Health.AadSync.MonitoringAgent.Startup)\Private Bytes")
            {
                Write-Host "     Please make sure Azure AD Connect Health Sync Monitoring Service is running." -ForegroundColor Magenta
            }
        }
        else
        {
            Write-Host $counter " -> exists " -ForegroundColor Green
        }
    }
    catch {}
}
```

### [AD DS](#tab/azure-ad-ds)

```powershell
$perfCounters = @(
    "\Processor(_Total)\% Processor Time", 
    "\Memory\Available MBytes", 
    "\TCPv4\Connections Established", 
    "\Process(Microsoft.Identity.Health.Adds.InsightsService)\Private Bytes", 
    "\Process(Microsoft.Identity.Health.Adds.MonitoringAgent.Startup)\Private Bytes", 
    "\Process(lsass)\% Processor Time", 
    "\DirectoryServices(NTDS)\LDAP Searches/sec", 
    "\DirectoryServices(NTDS)\LDAP Successful Binds/sec", 
    "\DirectoryServices(NTDS)\ATQ Estimated Queue Delay", 
    "\DirectoryServices(NTDS)\ATQ Outstanding Queued Requests", 
    "\DirectoryServices(NTDS)\ATQ Request Latency", 
    "\DirectoryServices(NTDS)\ATQ Threads LDAP", 
    "\DirectoryServices(NTDS)\ATQ Threads Other",
    "\DirectoryServices(NTDS)\ATQ Threads Total",
    "\Security System-Wide Statistics\Kerberos Authentications", 
    "\Security System-Wide Statistics\NTLM Authentications", 
    "\LogicalDisk(_Total)\% Free Space"
)
foreach($counter in $perfCounters)
{
    try
    {
        $counterResult = Get-Counter -Counter $counter -MaxSamples 1 -ErrorAction SilentlyContinue
        if($counterResult -eq $null)
        {
            Write-Host $counter " ->  does not exist" -ForegroundColor Red
            if($counter -eq "\Process(Microsoft.Identity.Health.Adds.InsightsService)\Private Bytes")
            {
                Write-Host "     Please make sure Azure AD Connect Health AD DS Insights Service is running." -ForegroundColor Magenta
            }
            elseif($counter -eq "\Process(Microsoft.Identity.Health.Adds.MonitoringAgent.Startup)\Private Bytes")
            {
                Write-Host "     Please make sure Azure AD Connect Health AD DS Monitoring Service is running." -ForegroundColor Magenta
            }
            elseif($counter.ToString().Contains("NTDS"))
            {
                Write-Host "     Please make sure NTDS Perf counters are loaded." -ForegroundColor Magenta
            }
        }
        else
        {
            Write-Host $counter " -> exists " -ForegroundColor Green
        }
    }
    catch {}
}
# We handle both cases. If "\NTDS\X" is missing, we check for "\DirectoryServices(NTDS)\X"
$ntdsPrefix = "NTDS"
$dsPrefix = "DirectoryServices(NTDS)"
$dupePerfCounters = @(
    "DRA Pending Replication Synchronizations", 
    "LDAP Bind Time", 
    "LDAP Active Threads", 
    "DS Threads in Use", 
    "DRA Outbound Bytes Total/sec", 
    "DRA Inbound Bytes Total/sec"
)
foreach($counter in $dupePerfCounters)
{
    try
    {
        $ntdsCounter = "\" + $ntdsPrefix + "\" + $counter
        $counterResult = Get-Counter -Counter $ntdsCounter -MaxSamples 1 -ErrorAction SilentlyContinue
        if($counterResult -eq $null)
        {
            $dsCounter = "\" + $dsPrefix + "\" + $counter
            Write-Host $ntdsCounter " ->  does not exist, checking for" $dsCounter -ForegroundColor Yellow
            $counterResult = Get-Counter -Counter $dsCounter -MaxSamples 1 -ErrorAction SilentlyContinue
            if($counterResult -eq $null)
            {
                Write-Host "     Please make sure NTDS or \DirectoryServices\NTDS Perf counters are loaded." -ForegroundColor Magenta
            }
            else
            {
                Write-Host $dsCounter " -> exists " -ForegroundColor Green
            }
        }
        else
        {
            Write-Host $counter " -> exists " -ForegroundColor Green
        }
    }
    catch {}
}
```

### [AD FS](#tab/ad-fs)

Microsoft is developing scripts that apply to AD FS, and will post those scripts in this article when they become available.

---

## Data type troubleshooting steps

This section includes troubleshooting steps for fixing data type issues.

### [Sync](#tab/sync)

| Data type | Troubleshooting steps |
| --------- | --------------------- |
| PerfCounter | <ul><li>Make sure that the performance counters exist.</li><li>Make sure that the Microsoft Entra Connect Health Sync Monitoring Service is running.</li></ul> |
| AadSyncService&#8209;Connectors<br/>AadSyncService&#8209;GlobalConfigurations<br/>AadSyncService&#8209;RunProfileResults<br/>AadSyncService&#8209;ServiceConfigurations<br/>AadSyncService&#8209;ServiceStatus<br/>AadSyncService&#8209;SynchronizationRules | Make sure that the Microsoft Entra Connect Health Sync Insights Service is running. |

### [AD DS](#tab/azure-ad-ds)

| Data type | Troubleshooting steps |
| --------- | --------------------- |
| PerfCounter | <ul><li>Make sure that the performance counters exist.</li><li>Make sure that the Microsoft Entra Connect Health AD DS Monitoring Service is running.</li></ul> |
| Adds&#8209;TopologyInfo&#8209;Json<br/>Common&#8209;TestData&#8209;Json | <ul><li>Make sure that the Microsoft Entra Connect Health AD DS Insights Service is running.</li><li>Make sure that the Microsoft Entra Connect Health AD DS Monitoring Service is running.</li></ul> |

### [AD FS](#tab/ad-fs)

Begin by following the instructions in [Connect Health for AD FS data freshness alert troubleshooting steps](https://adfshelp.microsoft.com/TroubleshootingGuides/Workflow/29afc119-3b45-4088-bfe5-4252f726900e).

| Data type | Troubleshooting steps |
| --------- | --------------------- |
| PerfCounter | <ul><li>Make sure that the performance counters exist.</li><li>Make sure that the Microsoft Entra Connect Health AD FS Monitoring Service is running.</li></ul> |
| TestResult | <ul><li>Make sure that the Microsoft Entra Connect Health AD FS Diagnostics Service is running.</li><li>Make sure that the Microsoft Entra Connect Health AD FS Monitoring Service is running. |
| Adfs&#8209;UsageMetrics | Make sure that the Microsoft Entra Connect Health AD FS Insights Service is running. |

---

## Collect logs for the Monitoring Agent and Insights Agent

If the dashboard isn't helping, collect the agent logs. The relevant service can be run in the console to get more information.

Begin by entering the following `PsExec` command to run the command prompt remotely:

```console
PsExec.exe -i -s cmd
```

Then, collect the agent logs for the Monitoring and Insights services of Sync, AD DS, or AD FS, as described in the next section.

> [!NOTE]
> AD FS also has a Diagnostics service. Instructions for collecting the corresponding Diagnostic Agent logs are shown after the log collection sections for Monitoring and Insights.

### Collect Monitoring Agent logs

To collect Monitoring Agent logs, follow these steps:

1. At the remote command prompt, enter `services.msc` to open the Services snap-in.

1. Stop the Monitoring Service for the appropriate service type.

    For example, for AD FS, select **Microsoft Entra Connect Health AD FS Monitoring Service** from the list of services, then select the **Stop Service** icon.

1. Change the current directory to the appropriate directory according to the service type. Then, open the configuration file of the Monitoring Agent service executable in a text editor (such as Notepad) for editing. The path name and executable file name for each service type is shown in the following table. The configuration file name simply appends the `.config` file name extension to the end of the executable file name.

    | Service type | Path                                                                       | Executable                                                      |
    | ------------ | -------------------------------------------------------------------------- | --------------------------------------------------------------- |
    | Sync         | *C:\\Program Files\\Microsoft Azure AD Connect Health Sync Agent\\Monitor* | *Microsoft.Identity.Health.AadSync.MonitoringAgent.Startup.exe* |
    | AD DS        | *C:\\Program Files\\Azure AD Connect Health Adds Agent\\Monitor*           | *Microsoft.Identity.Health.Adds.MonitoringAgent.Startup.exe*    |
    | AD FS        | *C:\\Program Files\\Azure AD Connect Health Adfs Agent\\Monitor*           | *Microsoft.Identity.Health.Adfs.MonitoringAgent.Startup.exe*    |

    For example, for AD FS, enter the following commands:

    ```console
    cd "C:\Program Files\Azure Ad Connect Health Adfs Agent\Monitor"
    notepad "Microsoft.Identity.Health.Adfs.MonitoringAgent.Startup.exe.config"
    ```

1. In the text editor, insert the following line to set the `ConsoleDebug` key to `true`:

    ```xml
    <add key="ConsoleDebug" value="true" />
    ```

1. Save and close the configuration file.

1. Run the Monitoring Agent service, and direct its output to a log file (*monitor.log*).

    For example, for AD FS, enter the following command:

    ```console
    Microsoft.Identity.Health.Adfs.MonitoringAgent.Startup.exe > monitor.log
    ```

1. Let the Monitoring Agent service run for 15 minutes. Then, press Ctrl+C to stop the service, and inspect the *monitor.log* file.

### Collect Insights Agent logs

To collect Insights Agent logs, follow these steps:

1. At the remote command prompt, enter `services.msc` to open the Services snap-in.

1. Stop the Insights service for the appropriate service type.

    For example, for AD FS, select **Microsoft Entra Connect Health AD FS Insights Service** from the list of services, then select the **Stop Service** icon.

1. Change the current directory to the appropriate directory according to the service type. Then, run the Insights Agent service executable by using the `/console` parameter and direct its output to a log file (*insights.log*). The path name and executable file name for each service type is shown in the following table.

    | Service type | Path                                                                        | Executable                                              |
    | ------------ | --------------------------------------------------------------------------- | ------------------------------------------------------- |
    | Sync         | *C:\\Program Files\\Microsoft Azure AD Connect Health Sync Agent\\Insights* | *Microsoft.Identity.AadConnect.Health.AadSync.Host.exe* |
    | AD DS        | *C:\\Program Files\\Azure AD Connect Health Adds Agent\\Insights*           | *Microsoft.Identity.Health.Adds.InsightsService.exe*    |
    | AD FS        | *C:\\Program Files\\Azure AD Connect Health Adfs Agent\\Insights*           | *Microsoft.Identity.Health.Adfs.InsightsService.exe*    |

    For example, for AD FS, enter the following commands:

    ```console
    cd "C:\Program Files\Azure Ad Connect Health Adfs Agent\Insights"
    Microsoft.Identity.Health.Adfs.InsightsService.exe /console > insights.log
    ```

1. Let the Insights Agent service run for 15 minutes. Then press Ctrl+C to stop the service, and inspect the *insights.log* file.

## Collect logs for the Diagnostics Agent (for AD FS only)

To collect Diagnostics Agent logs for AD FS, follow these steps:

1. In the remote command prompt, enter `services.msc` to open the Services snap-in.

1. Stop the Diagnostics service for the appropriate service type.

    For example, for AD FS, select **Microsoft Entra Connect Health AD FS Diagnostics Service** from the list of services, then select the **Stop Service** icon.

1. Change the current directory to the diagnostics directory for AD FS. Then, run the Diagnostics Agent service executable by using the `-Debug` parameter, and direct its output to a log file (*diagnostics.log*).

    ```console
    cd "C:\Program Files\Azure Ad Connect Health Adfs Agent\Diagnostics"
    Microsoft.Identity.Health.Adfs.DiagnosticsAgent.exe -Debug > diagnostics.log
    ```

1. Press Enter.

1. Let the Diagnostics Agent service run for 15 minutes. Then, press Ctrl+C to stop the service, and copy the console output into *diagnostics.log*.

1. Search for `Error` in the logs, and check whether any error entry indicates a specific problem (such as connectivity or proxy configuration).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
