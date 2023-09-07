---
title: Use Application Insights to track free space on a logical drive
description: Learn how to use an Application Insights performance counter to track free space on a logical drive in Cloud Services.
ms.date: 01/13/2023
editor: v-jsitser
ms.reviewer: maheshallu, wu.ping, prpillai, v-leedennis
ms.topic: how-to
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
---
# Use an Application Insights performance counter to track free space on a logical drive

> [!NOTE]
> This article applies to both Cloud Services (classic) and Cloud Services (extended support).

You can use a performance counter in Application Insights to get diagnostics data that shows the amount of free space on drive C over time. This technique can be useful if you want Cloud Services to set an alert whenever the free space for drive C is less than a certain threshold value. You can also get diagnostics data and set alerts for another drive or all logical drives.

## Overview

In Application Insights, the specific performance counter that monitors free space on drive C is titled **\LogicalDisk(C:)% Free Space**. (Make sure that you include the space after the percent sign within the string.) This performance counter isn't included in the Application Insights default configuration. Therefore, you have to add it yourself.

> [!NOTE]
> To get information about a different logical drive, replace `C` with the applicable drive letter. To get information about all logical drives, replace `C` with an asterisk (`*`).

There are two ways to add the performance counter:  

- Modify the *ApplicationInsights.config* file.
- Update and apply a diagnostics extension file.

## Option 1: Modify the ApplicationInsights.config file

After you [enable Application Insights from Microsoft Visual Studio](/azure/azure-monitor/app/asp-net-core#enable-application-insights-server-side-telemetry-visual-studio), Visual Studio generates the *ApplicationInsights.config* file. By default, the file is put into the *\<cloud-service-name>\\\<role-name>* folder. Open this configuration file, and modify the [performance collector](/azure/azure-monitor/app/configuration-with-applicationinsights-config#performance-collector) directive by adding the following XML snippet to the configuration file:

```xml
<Add Type="Microsoft.ApplicationInsights.Extensibility.PerfCounterCollector.PerformanceCollectorModule, Microsoft.AI.PerfCounterCollector">
  <Counters>
    <Add PerformanceCounter="\LogicalDisk(C:)\% Free Space" ReportAs="Disk Free % (C:)" />
  </Counters>
</Add>
```

After you add the code, you can publish the application. You can find the new performance counter within Application Insights.

## Option 2: Apply an updated diagnostics extension file

Update an existing extension configuration file and then run a PowerShell script. The following Windows Azure diagnostics extension file is updated to include the `\LogicalDisk(C:)\% Free Space` string in the `counterSpecifier` attribute of the final `PerformanceCounterConfiguration` element:

```xml
<?xml version="1.0" encoding="utf-8"?>
<PublicConfig xmlns="http://schemas.microsoft.com/ServiceHosting/2010/10/DiagnosticsConfiguration">
  <WadCfg>
    <DiagnosticMonitorConfiguration overallQuotaInMB="4096" sinks="applicationInsights.errors">
    <DiagnosticInfrastructureLogs scheduledTransferLogLevelFilter="Error" />
    <Directories scheduledTransferPeriod="PT1M">
      <IISLogs containerName="wad-iis-logfiles" />
      <FailedRequestLogs containerName="wad-failedrequestlogs" />
    </Directories>
    <PerformanceCounters scheduledTransferPeriod="PT1M">
      <PerformanceCounterConfiguration counterSpecifier="\Memory\Available MBytes" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\ISAPI Extension Requests/sec" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Bytes Total/Sec" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\ASP.NET Applications(__Total__)\Requests/Sec" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\ASP.NET Applications(__Total__)\Errors Total/Sec" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\ASP.NET\Requests Queued" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\ASP.NET\Requests Rejected" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\Processor(_Total)\% Processor Time" sampleRate="PT3M" />
      <PerformanceCounterConfiguration counterSpecifier="\LogicalDisk(C:)\% Free Space" sampleRate="PT3M" />
    </PerformanceCounters>
    <WindowsEventLog scheduledTransferPeriod="PT1M">
      <DataSource name="Application!*[System[(Level=1 or Level=2 or Level=3)]]" />
      <DataSource name="Windows Azure!*[System[(Level=1 or Level=2 or Level=3 or Level=4)]]" />
    </WindowsEventLog>
    <CrashDumps>
      <CrashDumpConfiguration processName="WaIISHost.exe" />
      <CrashDumpConfiguration processName="WaWorkerHost.exe" />
      <CrashDumpConfiguration processName="w3wp.exe" />
    </CrashDumps>
    <Logs scheduledTransferPeriod="PT1M" scheduledTransferLogLevelFilter="Error" />
    </DiagnosticMonitorConfiguration>
    <SinksConfig>
      <Sink name="applicationInsights">
        <ApplicationInsights>Instrumentation-Key</ApplicationInsights>
        <Channels>
          <Channel logLevel="Error" name="errors" />
        </Channels>
      </Sink>
    </SinksConfig>
  </WadCfg>
  <StorageAccount>storageaccountname</StorageAccount>
</PublicConfig>
```

Apply your updated extension file by using the following PowerShell script. Before you run the script, replace the placeholder names for the resource group, storage account, cloud service, and XML configuration file.

```powershell
# Enter placeholder values here.
$rgName = @{ResourceGroupName = "<resource-group-name>"}
$saName = @{StorageAccountName = "<storage-account-name>"}
$csName = @{CloudServiceName = "<cloud-service-name>"}
$configFile = "<xml-file-name>"

# Apply the new extension file.
$storageAccountKey = Get-AzStorageAccountKey @rgName @saName
$extParameters = @{
    Name = "Microsoft.Insights.VMDiagnosticsSettings_WebRole1"
    DiagnosticsConfigurationPath = $configFile
    StorageAccountKey = $storageAccountKey[0].Value
    TypeHandlerVersion = "1.21.0.1"
    AutoUpgradeMinorVersion = $true
}
$extension = New-AzCloudServiceDiagnosticsExtension @rgName @csName @saName @extParameters
$cloudService = Get-AzCloudService @rgName @csName
$cloudService.ExtensionProfile.Extension = $cloudService.ExtensionProfile.Extension + $extension
$cloudService | Update-AzCloudService
```

For more information about this option, see [Apply the diagnostics extension in Cloud Services (extended support)](/azure/cloud-services-extended-support/enable-wad).

## More information

- [System performance counters in Application Insights](/azure/azure-monitor/app/performance-counters)
- [Send Cloud Service diagnostic data to Application Insights](/azure/azure-monitor/agents/diagnostics-extension-to-application-insights)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
