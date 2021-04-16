---
title: How to enable tracing in Dynamics CRM
description: Describes how to create managed and unmanaged trace files in Microsoft Dynamics CRM.
ms.reviewer: clintwa, danhamre, tlemar
ms.topic: how-to
ms.date: 3/31/2021
---
# How to enable tracing in Microsoft Dynamics CRM 2013 and 2011

This article describes how to enable tracing in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 907490

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Microsoft Dynamics CRM lets you create trace files that monitor the actions that are performed by Microsoft Dynamics CRM. Trace files are helpful when you have to troubleshoot error messages or other issues in Microsoft Dynamics CRM.

You can create unmanaged trace files and managed trace files. The information in the unmanaged and managed trace files is determined by required and optional registry entries that you create manually. You create these registry entries on the Microsoft Dynamics CRM server or on the computer that is running the Microsoft Dynamics CRM client for Microsoft Office Outlook after you install Microsoft Dynamics CRM or the Microsoft Dynamics CRM client for Outlook.

In Microsoft Dynamics CRM 2011 and 2013, you can also enable tracing by using Windows PowerShell applets. See the [Enable trace settings through Windows PowerShell](#enable-trace-settings-through-windows-powershell) section for more information.

## Required registry entries

The following are the required registry entries. For more information about the location of these registry entries, see the [Registry entry locations](#registry-entry-locations) section.

|Name|Type|Data value|Notes|
|---|---|---|---|
|TraceEnabled|DWORD|A value of 0 or 1|If you use a value of 0, tracing is disabled. If you use a value of 1, tracing is enabled.|
|TraceDirectory|String| **C:\CRMTrace**|The TraceDirectory registry entry specifies the directory for the trace log files. The directory must exist, and the user who starts the Microsoft CRMAppPool must have full control over this directory. When you install Microsoft Dynamics CRM, the default user is NT AUTHORITY\NETWORK SERVICE. This entry is only required for Microsoft Dynamics CRM 3.0. For later versions, the trace directory is set to the install location of the Microsoft Dynamics CRM program files, C:\Program Files\Microsoft Dynamics CRM\Trace|
|TraceRefresh|DWORD|A number between zero and 99|When the data is changed, the trace settings in the other trace registry entries are applied.|

## Optional registry entries

The following are the optional registry entries.

|Name|Type|Data value|Notes|
|---|---|---|---|
|TraceCategories|String| **Category.Feature:TraceLevel**|The TraceCategories registry entry is a combination of a category, a feature, and a trace level. You can specify multiple categories, features, and trace levels. Separate each combination by using a semicolon. For a list of categories, features, and trace levels and for sample combinations that are valid, see the [Trace level values](#trace-level-values) section.|
|TraceCallStack|DWORD|A value of 0 or 1|If you use a value of 0, the call stack is not included in the trace file. If you use a value of 1, the call stack is included in the trace file.|
|TraceFileSizeLimit|DWORD|A size between 1 MB and 100 MB|The TraceFileSizeLimit registry entry specifies the maximum size of trace files. New files are created when the limit is reached.|

If you do not create the optional registry entries, the default data values are used. For more information about the default data values, see the [Default data values for optional registry entries](#default-data-values-for-optional-registry-values) section. If you create the registry entries but do not specify data values for the registry entries, tracing will not work.

## Enable trace settings through Windows PowerShell

> [!NOTE]
> These changes made in Windows PowerShell do not update the Registry. These changes update the DeploymentProperties and ServerSettingsProperties tables in the MSCRM_CONFIG database.

### Register the cmdlets

1. Sign in to the administrator account on your Microsoft Dynamics CRM server.
2. In a Windows PowerShell window, type the command: `Add-PSSnapin Microsoft.Crm.PowerShell`.

This command adds the Microsoft Dynamics CRM Windows PowerShell snap-in to the current session. The snap-in is registered during the installation and setup of the Microsoft Dynamics CRM server.

To obtain a list of the current settings, type the command: `Get-CrmSetting TraceSettings`.

The output will resemble the following:

> CallStack : True Categories : *:Error Directory : c:\crmdrop\logs Enabled : False FileSize : 10 ExtensionData : System.Runtime.Serialization.ExtensionDataObject

### Set the trace settings

1. Type the command: `$setting = Get-CrmSetting TraceSettings`.
2. Type the command to enable tracing: `$setting.Enabled=$True`.
3. Type the command to set the trace settings: `Set-CrmSetting $setting`.
4. Type the command to get a current list of the trace settings: `Get-CrmSetting TraceSettings`.

To disable tracing through Windows PowerShell, follow these same steps, except use the command in step 2: `$setting.Enabled=$False`.

> [!NOTE]
> The format of the example commands for each value should be as follows:
>
> - $setting.Enabled= $EnabledValue ($True or $False)
> - $setting.CallStack= $StackValue ($True or $False)
> - $setting.Categories ="*:Verbose"
> - $setting.Directory ="C:\Program Files\Microsoft Dynamics CRM\Trace"
> - $setting.FileSize= 10

The output will resemble the following:

> CallStack : True Categories : *:Error Directory : c:\crmdrop\logs Enabled : True FileSize : 10 ExtensionData : System.Runtime.Serialization.ExtensionDataObject

## Microsoft Dynamics CRM 2011 and 2013 trace log file locations

When you create a trace in Microsoft Dynamics CRM, the Trace Directory registry key is ignored. For tracing on the Microsoft Dynamics CRM, the trace log file is created in the following folder:

**Drive**:\Program Files\Microsoft Dynamics CRM\Trace

For tracing on the Microsoft Dynamics CRM 2011 or 2013 client for Microsoft Office Outlook, the trace log file is created in the following folder if you have Update Rollup 7 or a later cumulative update installed:

**DriveName**:\ InstallingUser \Local Settings\Application Data\Microsoft\MSCRM\Traces

## Registry entry locations

The Microsoft Dynamics CRM server tracing registry entries are located in the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\MSCRM`

The Microsoft Dynamics CRM client for Outlook tracing registry entries are located in the following registry subkey:

`HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\MSCRMClient`

The Microsoft Dynamics CRM SSRS Data Connector tracing registry entries are located in following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\MSCRMBidsExtensions`

The Microsoft Dynamics CRM Data Migration Manager tracing registry entries are located in the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\DATA MIGRATION WIZARD`

## Complete list of category values for the TraceCategories registry entry

### Microsoft Dynamics CRM 2011 and 2013

- ADUtility
- Application
- Application.Outlook
- DataMigration
- Deployment
- Deployment.Provisioning
- Deployment.Sdk
- Exception
- Etm
- Live
- Live.AggregationDataExport
- Live.PartnerInteraction
- Live.Platform
- Live.Portal
- Live.Provisioning
- Live.Support
- Live.SyncDaemon
- Monitoring
- NewOrgUtility
- ObjectModel
- ParameterFilter
- Platform
- Platform.Async
- Platform.ImportExportPublish
- Platform.Import
- Platform.Metadata
- Platform.Sdk
- Platform.Soap
- Platform.Sql
- Platform.Workflow
- Reports
- Sandbox
- Sandbox.AssemblyCache
- Sandbox.LoadBalancer
- Sandbox.CallReturn
- Sandbox.EnterExit
- Sandbox.StartStop
- Sandbox.Performance
- Sandbox.Monitoring
- SchedulingEngine
- ServiceBus
- Shared
- SharePointCollaboration
- Solutions
- Unmanaged.Outlook
- Unmanaged.Platform
- Unmanaged.Sql
- Visualizations

## Trace level values

### Complete list of valid trace level values for TraceLevel

- Off
- Error
- Warning
- Info
- Verbose

> [!NOTE]
> A message is logged only if the trace level for the category is equal to or greater than the level of the message. For example, a trace level of Warning logs messages that have a level of Warning and of Error. A trace level of Info logs messages that have a level of Info, of Warning, and of Error. A trace level of Verbose logs all messages. You should use a trace level of Verbose only for short durations.

### Sample category and trace level combinations

- `*:Verbose`

  > [!NOTE]
  > The `*:Verbose` combination logs all messages in all categories. You should only use the `*:Verbose` combination for short durations.

- `Application.*:Error`

  > [!NOTE]
  > The `Application.*:Error` combination logs all messages that have a level of Error for the `Application.*` category.

- `Platform.*:Warning`

  > [!NOTE]
  > The `Platform.*:Warning` combination logs all messages that have a level of Warning or Error for the `Platform.*` category.

## Default data values for optional registry values

- TraceCategories: *:Error
- TraceCallStack: 0
- TraceFileSizeLimit: 5

## Microsoft Dynamics CRM E-mail Router service tracing

For more information, see [How to enable tracing for the Microsoft Dynamics CRM E-mail Router](https://support.microsoft.com/help/2862024).

## How to enable scheduled tracing for Microsoft Dynamics CRM Server

For more information, see [How to enable Scheduled Tracing for Microsoft Dynamics CRM](https://support.microsoft.com/help/2862025).

## How to enable tracing for the Microsoft Dynamics CRM for Outlook client

For more information, see [How to enable tracing for the Microsoft Dynamics CRM for Outlook client](https://support.microsoft.com/help/2862031).
