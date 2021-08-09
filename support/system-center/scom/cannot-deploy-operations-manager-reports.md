---
title: Operations Manager reports fail to deploy
description: Describes an issue in which a DeploymentException error occurs when you deploy Operations Manager reports together with SQL Server Reporting Services.
ms.date: 06/23/2020
ms.prod-support-area-path: Reporting server installation
---
# Operations Manager 2019 and 1807 reports fail to deploy

This article helps you fix an issue in which deploying Operations Manager reports fails with event 31567 in Operations Manager 2019 and version 1807.

_Original product version:_ &nbsp; System Center 2019 Operations Manager, System Center Operations Manager, version 1807  
_Original KB number:_ &nbsp; 4519161

## Symptoms

When you install System Center 2019 Operations Manager together with the latest version of SQL Server Reporting Services (SSRS) 2017, Operations Manager reports don't deploy.

When you open the **Reporting** view in the Operations console, and select any of the folders, the list of reports is empty. Additionally, error messages that resemble the following are logged in the Operations Manager event log:

> Log Name:      Operations Manager  
Source:        Health Service Modules  
Date:          \<Date> \<Time>  
Event ID:      31567  
Task Category: Data Warehouse  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      \<FQDN>  
Description:  
Failed to deploy reporting component to the SQL Server Reporting Services server. The operation will be retried.
Exception 'DeploymentException': Failed to deploy reports for management pack with version dependent id '\<ID>'. System.Web.Services.Protocols.SoapException: Uploading or saving files with .CustomConfiguration extension is not allowed. Contact your administrator if you have any questions. --->  
Microsoft.ReportingServices.Diagnostics.Utilities.ResourceFileFormatNotAllowedException: Uploading or saving files with .CustomConfiguration extension is not allowed. Contact your administrator if you have any questions.  
   at Microsoft.ReportingServices.Library.ReportingService2005Impl.CreateResource(String Resource, String Parent, Boolean Overwrite, Byte[] Contents, String MimeType, Property[] Properties, Guid batchId)  
   at Microsoft.ReportingServices.WebServer.ReportingService2005.CreateResource(String Resource, String Parent, Boolean Overwrite, Byte[] Contents, String MimeType, Property[] Properties)  
One or more workflows were affected by this.  
Workflow name: Microsoft.SystemCenter.DataWarehouse.Deployment.Report  
Instance name: Data Warehouse Synchronization Service  
Instance ID: {GUID}  
Management group: \<Management Group Name>

> [!NOTE]
> This issue also occurs in System Center Operations Manager version 1807 when you upgrade to SSRS 2017, and then you remove and reinstall Operations Manager Reporting.

## Cause

SSRS 2017 version 14.0.600.1274 and later versions include a new advanced setting **AllowedResourceExtensionsForUpload**. This setting restricts the set of extensions of resources files that can be uploaded to the report server. This issue occurs because Operations Manager Reporting uses extensions that aren't included in the default set in **AllowedResourceExtensionsForUpload**.

## Resolution 1

Add \*.\* to the list of extensions. To do this, follow these steps:

1. Start SQL Server Management Studio, and then connect to a report server instance that Operations Manager uses.
2. Right-click the report server name, select **Properties**, and then select **Advanced**.
3. Locate the **AllowedResourceExtensionsForUpload** setting, add \*.\* to the list of extensions, and then select **OK**.
4. Restart SSRS.

## Resolution 2

Use PowerShell script to add the extensions. To do this, run the following PowerShell script:

```powershell
$ExtensionAdd = @(

    'CustomConfiguration'
    'Report'
    'AvailabilityMonitor'
    'TopNApplications'
    'Settings'
    'License'
    'ServiceLevelTrackingSummary'
    'CustomPerformance'
    'MostCommonEvents'
    'PerformanceTop'
    'Detail'
    'DatabaseSettings'
    'ServiceLevelObjectiveDetail'
    'PerformanceDetail'
    'ConfigurationChange'
    'TopNErrorGroupsGrowth'
    'AvailabilityTime'
    'rpdl'
    'mp'
    'TopNErrorGroups'
    'Downtime'
    'TopNApplicationsGrowth'
    'DisplayStrings'
    'Space'
    'Override'
    'Performance'
    'AlertDetail'
    'ManagementPackODR'
    'AlertsPerDay'
    'EventTemplate'
    'ManagementGroup'
    'Alert'
    'EventAnalysis'
    'MostCommonAlerts'
    'Availability'
    'AlertLoggingLatency'
    'PerformanceTopInstance'
    'rdl'
    'PerformanceBySystem'
    'InstallUpdateScript'
    'PerformanceByUtilization'
    'DropScript'
)

Write-Verbose -Message '***'
$Message = 'Step 12 of 12.  Allowed Resource Extensions for Upload'
Write-Verbose -Message $Message

$Uri = [System.Uri]"https://$ServiceAddress/ReportServer/ReportService2010.asmx"

$Proxy = New-WebServiceProxy -Uri $Uri -UseDefaultCredential

$Type = $Proxy.GetType().Namespace + '.Property'

$Property = New-Object -TypeName $Type
$Property.Name = 'AllowedResourceExtensionsForUpload'

$Current = $Proxy.GetSystemProperties( $Property )

$ValueCurrent = $Current.Value -split ','

$ValueAdd = $ExtensionAdd | ForEach-Object -Process {

    "*.$psItem"
}

$ValueSet = $ValueCurrent + $ValueAdd | Sort-Object -Unique

$Property.Value = $ValueSet -join ','

$Proxy.SetSystemProperties( $Property )
```

> [!NOTE]
> You have to populate the `$ServiceAddress` variable by using a valid address of your report service for HTTPS. If you don't use HTTPS at all, change the script to use HTTP. The list of extensions in the script may not be exhaustive. Include your own extensions as appropriate.
