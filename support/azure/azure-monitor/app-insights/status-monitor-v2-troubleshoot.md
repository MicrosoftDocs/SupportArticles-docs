---
title: Azure Application Insights Agent troubleshooting and known issues
description: Review Application Insights Agent known issues and troubleshooting examples. Works with ASP.NET web apps hosted on-premises, in virtual machines, or on Azure.
ms.topic: conceptual
ms.date: 06/21/2022
editor: v-jsitser
ms.reviewer: aaronmax, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Application Insights user I want to understand known issues for the Application Insights Agent and how to troubleshoot common issues so I can use Application Insights and the Agent effectively.
---

# Troubleshoot Azure Application Insights Agent (formerly Status Monitor v2)

This article provides troubleshooting information to help resolve data collection issues you might experience when Application Insights monitoring is enabled.

## Known issues

#### Conflicting DLLs in an app's bin directory

If any of these dynamic-link libraries (DLLs) are present in the *bin* directory, monitoring might fail:

- *Microsoft.ApplicationInsights.dll*
- *Microsoft.AspNet.TelemetryCorrelation.dll*
- *System.Diagnostics.DiagnosticSource.dll*

Some of these DLLs are included in the Visual Studio default app templates, even if your app doesn't use them. You can use troubleshooting tools, such as the following tools, to see symptomatic behavior:

- PerfView:

  ```output
  ThreadID="7,500" 
  ProcessorNumber="0" 
  msg="Found 'System.Diagnostics.DiagnosticSource, Version=4.0.2.1, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51' assembly, skipping attaching redfield binaries" 
  ExtVer="2.8.13.5972" 
  SubscriptionId="" 
  AppName="" 
  FormattedMessage="Found 'System.Diagnostics.DiagnosticSource, Version=4.0.2.1, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51' assembly, skipping attaching redfield binaries" 
    ```

- IISReset and app load (without telemetry). Investigate with Sysinternals (*Handle.exe* and *ListDLLs.exe*):

  ```output
  .\handle64.exe -p w3wp | findstr /I "InstrumentationEngine AI. ApplicationInsights"
  E54: File  (R-D)   C:\Program Files\WindowsPowerShell\Modules\Az.ApplicationMonitor\content\Runtime\Microsoft.ApplicationInsights.RedfieldIISModule.dll

  .\Listdlls64.exe w3wp | findstr /I "InstrumentationEngine AI ApplicationInsights"
  0x0000000009be0000  0x127000  C:\Program Files\WindowsPowerShell\Modules\Az.ApplicationMonitor\content\Instrumentation64\MicrosoftInstrumentationEngine_x64.dll
  0x0000000009b90000  0x4f000   C:\Program Files\WindowsPowerShell\Modules\Az.ApplicationMonitor\content\Instrumentation64\Microsoft.ApplicationInsights.ExtensionsHost_x64.dll
  0x0000000004d20000  0xb2000   C:\Program Files\WindowsPowerShell\Modules\Az.ApplicationMonitor\content\Instrumentation64\Microsoft.ApplicationInsights.Extensions.Base_x64.dll
  ```

#### PowerShell versions

This product was written and tested using PowerShell version 5.1.
This module isn't compatible with PowerShell versions 6 or 7.
We recommend using PowerShell 5.1 alongside newer versions. 
For more information, see [Using PowerShell 7 side-by-side with PowerShell 5.1](/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7#using-powershell-7-side-by-side-with-windows-powershell-51).

#### Conflict with IIS shared configuration

If you have a cluster of web servers, you might be using a [shared configuration](/iis/web-hosting/configuring-servers-in-the-windows-web-platform/shared-configuration_211).
The HttpModule can't be injected into this shared configuration.
Run the Enable command on each web server to install the DLL into each server's global assembly cache (GAC).

After you run the Enable command, complete these steps:

1. Go to the shared configuration directory and find the *applicationHost.config* file.
2. Add this XML code to the **\<modules>** section of your configuration:

    ```xml
    <modules>
        <!-- Registered global managed http module handler. The 'Microsoft.AppInsights.IIS.
        ManagedHttpModuleHelper.dll' must be installed in the GAC before this config is applied. -->
        <add name="ManagedHttpModuleHelper" type="Microsoft.AppInsights.IIS.ManagedHttpModuleHelper.
        ManagedHttpModuleHelper, Microsoft.AppInsights.IIS.ManagedHttpModuleHelper, Version=1.0.0.0, 
        Culture=neutral, PublicKeyToken=31bf3856ad364e35" preCondition="managedHandler,runtimeVersionv4.0" />
    </modules>
    ```

#### IIS nested applications

We don't instrument nested applications in Internet Information Services (IIS) in version 1.0.

#### Advanced SDK configuration isn't available

The SDK configuration isn't exposed to the end user in version 1.0.

## Troubleshoot PowerShell  

#### Determine which modules are available

You can use the `Get-Module -ListAvailable` command to determine which modules are installed.

#### Import a module into the current session

If a module hasn't been loaded into a PowerShell session, you can manually load it by running the `Import-Module <path to psd1>` command.

## Troubleshoot the Application Insights Agent module

#### List the commands available in the Application Insights Agent module

Run the `Get-Command -Module Az.ApplicationMonitor` command to get the available commands:

```output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-ApplicationInsightsMonitoring              0.4.0      Az.ApplicationMonitor
Cmdlet          Disable-InstrumentationEngine                      0.4.0      Az.ApplicationMonitor
Cmdlet          Enable-ApplicationInsightsMonitoring               0.4.0      Az.ApplicationMonitor
Cmdlet          Enable-InstrumentationEngine                       0.4.0      Az.ApplicationMonitor
Cmdlet          Get-ApplicationInsightsMonitoringConfig            0.4.0      Az.ApplicationMonitor
Cmdlet          Get-ApplicationInsightsMonitoringStatus            0.4.0      Az.ApplicationMonitor
Cmdlet          Set-ApplicationInsightsMonitoringConfig            0.4.0      Az.ApplicationMonitor
Cmdlet          Start-ApplicationInsightsMonitoringTrace           0.4.0      Az.ApplicationMonitor
```

#### Determine the current version of the Application Insights Agent module

Run the `Get-ApplicationInsightsMonitoringStatus -PowerShellModule` command to display the following information about the module:

- PowerShell module version
- Application Insights SDK version
- File paths of the PowerShell module

Review the [Get-ApplicationInsightsMonitoringStatus reference](/azure/azure-monitor/app/status-monitor-v2-api-reference#get-applicationinsightsmonitoringstatus) for a detailed description of how to use this cmdlet.

## Troubleshoot running processes

You can inspect the processes on the instrumented computer to determine if all DLLs are loaded and environment variables are set.
If monitoring is working, at least 12 DLLs should be loaded.

- Use the `Get-ApplicationInsightsMonitoringStatus -InspectProcess` command to check the DLLs.
- Use the `(Get-Process -id <process-identifier>).StartInfo.EnvironmentVariables` command to check the environment variables. The following environment variables are set in the worker process or the .NET Core process:

```output
COR_ENABLE_PROFILING=1
COR_PROFILER={324F817A-7420-4E6D-B3C1-143FBED6D855}
COR_PROFILER_PATH_32=<path-to-MicrosoftInstrumentationEngine_x86.dll>
COR_PROFILER_PATH_64=<path-to-MicrosoftInstrumentationEngine_x64.dll>
MicrosoftInstrumentationEngine_Host={CA487940-57D2-10BF-11B2-A3AD5A13CBC0}
MicrosoftInstrumentationEngine_HostPath_32=<path-to-Microsoft.ApplicationInsights.ExtensionsHost_x86.dll>
MicrosoftInstrumentationEngine_HostPath_64=<path-to-Microsoft.ApplicationInsights.ExtensionsHost_x64.dll>
MicrosoftInstrumentationEngine_ConfigPath32_Private=<path-to-Microsoft.InstrumentationEngine.Extensions.config>
MicrosoftInstrumentationEngine_ConfigPath64_Private=<path-to-Microsoft.InstrumentationEngine.Extensions.config>
MicrosoftAppInsights_ManagedHttpModulePath=<path-to-Microsoft.ApplicationInsights.RedfieldIISModule.dll>
MicrosoftAppInsights_ManagedHttpModuleType=Microsoft.ApplicationInsights.RedfieldIISModule.RedfieldIISModule
ASPNETCORE_HOSTINGSTARTUPASSEMBLIES=Microsoft.ApplicationInsights.StartupBootstrapper
DOTNET_STARTUP_HOOKS=<path-to-Microsoft.ApplicationInsights.StartupHook.dll>
```

Review the [Get-ApplicationInsightsMonitoringStatus reference](/azure/azure-monitor/app/status-monitor-v2-api-reference) for a detailed description of how to use this cmdlet.

## Collect ETW logs by using PerfView

#### Setup

1. Download *PerfView.exe* and *PerfView64.exe* from [GitHub](https://github.com/Microsoft/perfview/releases).
2. Run *PerfView64.exe*.
3. Expand **Advanced Options**.
4. Clear these check boxes:
    - **Zip**
    - **Merge**
    - **.NET Symbol Collection**
5. Set these **Additional Providers**:

   `*Microsoft-ApplicationInsights-AspNetCore,*Microsoft-ApplicationInsights-AspNetCore-AiHostingStartup,*Microsoft-ApplicationInsights-AspNetCore-StartupBootstrapper,*Microsoft-ApplicationInsights-AspNetCore-StartupHook,*Microsoft-ApplicationInsights-Core,*Microsoft-ApplicationInsights-Data,*Microsoft-ApplicationInsights-Extensibility-AppMapCorrelation-Dependency,*Microsoft-ApplicationInsights-Extensibility-AppMapCorrelation-Web,*Microsoft-ApplicationInsights-Extensibility-DependencyCollector,*Microsoft-ApplicationInsights-Extensibility-EventCounterCollector,*Microsoft-ApplicationInsights-Extensibility-EventSourceListener,*Microsoft-ApplicationInsights-Extensibility-HostingStartup,*Microsoft-ApplicationInsights-Extensibility-PerformanceCollector,*Microsoft-ApplicationInsights-Extensibility-PerformanceCollector-QuickPulse,*Microsoft-ApplicationInsights-Extensibility-Web,*Microsoft-ApplicationInsights-Extensibility-WindowsServer,*Microsoft-ApplicationInsights-FrameworkLightup,*Microsoft-ApplicationInsights-IIS-ManagedHttpModuleHelper,*Microsoft-ApplicationInsights-Java-IPA,*Microsoft-ApplicationInsights-LoggerProvider,*Microsoft-ApplicationInsights-Nodejs-IPA,*Microsoft-ApplicationInsights-RedfieldIISModule,*Microsoft-ApplicationInsights-SnapshotCollectorLightup,*Microsoft-ApplicationInsights-WindowsServer-Core,*Microsoft-ApplicationInsights-WindowsServer-TelemetryChannel,*Redfield-Microsoft-ApplicationInsights-AspNetCore,*Redfield-Microsoft-ApplicationInsights-Core,*Redfield-Microsoft-ApplicationInsights-Data,*Redfield-Microsoft-ApplicationInsights-Extensibility-AppMapCorrelation-Dependency,*Redfield-Microsoft-ApplicationInsights-Extensibility-AppMapCorrelation-Web,*Redfield-Microsoft-ApplicationInsights-Extensibility-DependencyCollector,*Redfield-Microsoft-ApplicationInsights-Extensibility-EventCounterCollector,*Redfield-Microsoft-ApplicationInsights-Extensibility-EventSourceListener,*Redfield-Microsoft-ApplicationInsights-Extensibility-PerformanceCollector,*Redfield-Microsoft-ApplicationInsights-Extensibility-PerformanceCollector-QuickPulse,*Redfield-Microsoft-ApplicationInsights-Extensibility-Web,*Redfield-Microsoft-ApplicationInsights-Extensibility-WindowsServer,*Redfield-Microsoft-ApplicationInsights-LoggerProvider,*Redfield-Microsoft-ApplicationInsights-WindowsServer-TelemetryChannel`

#### Collect logs

1. In a command console with admin privileges, run the `iisreset /stop` command to turn off IIS and all web apps.
2. In PerfView, select **Start Collection**.
3. In a command console with admin privileges, run the `iisreset /start` command to start IIS.
4. Try to browse to your app.

5. After your app is loaded, return to PerfView and select **Stop Collection**.

## Next steps

- Review the [API reference](/azure/azure-monitor/app/status-monitor-v2-overview#powershell-api-reference) to learn about parameters you might have missed.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
