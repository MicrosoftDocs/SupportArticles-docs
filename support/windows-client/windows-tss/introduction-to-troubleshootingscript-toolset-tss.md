---
title: Introduction to TroubleShootingScript toolset (TSS)
description: Introduces the TroubleShootingScript (TSS) toolset and provides answers to frequently asked questions about the toolset.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, muratka, waltere
ms.custom: sap:windows-tss, csstroubleshoot
---
# Introduction to TroubleShootingScript toolset (TSS)

This article introduces the TroubleShootingScript (TSS) toolset and provides answers to frequently asked questions.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

The TSS toolset includes PowerShell-based tools and a framework for data collection and diagnostics. The toolset aims to simplify data collection and help resolve cases efficiently and securely.

The toolset includes several PowerShell scripts and executable files, which are all signed by Microsoft. Based on the selected switches, TSS uses one or more scripts and executable files to collect the desired logs.

You can download the toolset as a zip file (*TSS.zip*) from https://aka.ms/getTSS.

## Prerequisites

Here are some prerequisites for the toolset to run properly:

- The TSS toolset must be run in an elevated PowerShell window by accounts with administrator privileges on the local system. Running the TSS toolset in the Windows PowerShell Integrated Scripting Environment (ISE) isn't supported. The end-user license agreement (EULA) must be accepted. Once the EULA is accepted, the TSS toolset won't prompt for the EULA again.

- The PowerShell script execution policy should be set to `RemoteSigned` at the process level by running the cmdlet `Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned -Force` from an elevated PowerShell command prompt.

    > [!NOTE]  
    > The process level changes only affect the current PowerShell session.

## How to start the TSS toolset

You can start *TSS.ps1* with different switches depending on the scenario. The `-Start` verb is the default and optional verb, and can be replaced with a complementary verb as needed. The complementary `-Start` verbs are `-StartAutoLogger`, `-StartDiag`, `-StartNoWait`, and `-CollectLog`.

|Verb  |Description  |
|---------|---------|
|`-Start`     |The `-Start` verb starts Event Tracing for Windows (ETW) component traces or support tools such as Windows Performance Recorder (WPR).<br><br>The `[-Start]` verb is optional but can be replaced with complementary `-start` options.         |
|`-StartAutoLogger`     |To collect these logs at the boot time, use `-StartAutoLogger` to replace `-Start`.<br><br>Use it in combination with the `.\TSS.ps1 -Stop` cmdlet to stop the traces once the issue is reproduced.         |
|`-StartDiag`     |While this switch doesn't have much use in the present, it's meant to be used in the future in multiple scenarios. As of today, it can be combined with other arguments like `NET_DFSn` to get diagnostics of the DFSN namespace.         |
|`-StartNoWait`     |This parameter allows the traces to remain active even when you sign out.<br><br>Use it in combination with the `.\TSS.ps1 -Stop` cmdlet to stop the traces once the issue is reproduced.        |
|`-CollectLog`     |This parameter is commonly used along with the argument `DND_SetupReport`.<br><br>Example:<br>`.\TSS.ps1 -Collectlog DND_SetupReport`         |

Logs related to the traces are also automatically collected when you stop data collection.

## Syntax to use TSS toolset

|Parameter  |Description  |
|---------|---------|
|`<placeholder>`     |The string in angle brackets (\< \>) for placeholders needs to be substituted with an actual scenario name, trace component, command, or value.         |
|`[optional]`     |The keyword or value in square brackets ([ ]) is optional. For example, `[module:int]` means the module and interval are optional. The default value is used if `[<xx>:<yy>]` is omitted.         |
|\|     |This parameter means `'OR'`. You can choose one of the available options.         |
|`:`     |The separator character between two values.         |

## Cmdlet examples

|PowerShell cmdlet  |Description  |
|---------|---------|
|`.\TSS.ps1 -PerfMon [General:10]`     |This parameter means `PerfMon CounterSetName`= `General` and `Interval`= `10` seconds. When `[General:10]` is omitted, the default kicks in, so `-PerfMon` has the same effect as `-PerfMon General -PerfIntervalSec 10`.         |
|`.\TSS.ps1 [-StopWaitTimeInSec <N>]`      |This parameter means that the argument `-StopWaitTimeInSec` is optional, but if it's specified, a value for `<N>` ="the number of seconds" is mandatory.         |

## Event Tracing for Windows (ETW) trace

|ETW trace  |PowerShell cmdlet  |Description  |
|---------|---------|---------|
|Enable a scenario trace.     |`.\TSS.ps1 -Scenario <ScenarioName>`         |The supported scenario names are listed using the `TSS.ps1 -ListSupportedScenarioTrace` cmdlet.         |
|Enable component traces.     |`.\TSS.ps1 <-ComponentName> <-ComponentName> ...`         |The supported `<-componentName>` is listed using the `TSS.ps1 -ListSupportedTrace` cmdlet.         |
|Start traces with no-wait mode.     |`.\TSS.ps1 -StartNoWait -Scenario <ScenarioName>`<br><br>`.\TSS.ps1 -Stop`         |The prompt returns immediately, so you can sign out or use a cmdlet like `Shutdown`.<br><br>The cmdlet `.\TSS.ps1 -Stop` stops the trace.         |

> [!NOTE]  
> To list all provider GUIDs of components and/or scenarios, use the `-ListETWProviders` cmdlet. For example:
>
> ```PowerShell
> .\TSS.ps1 -ListETWProviders <component-/scenario-name>
> ```

## Support tools and commands

Start support tools or commands (for example, ProcMon, ProcDump, netsh, Performance Monitor (PerfMon), WPR, or Radar) to enhance log collection with additional tools for specialized captures.

|PowerShell cmdlet|Description|
|---------|---------|
|`-Fiddler`|Collect Fiddler trace. It requires Fiddler to be installed.<br><br>Enable the traffic decryption option by selecting **Tools** > **Options** and selecting **Decrypt HTTPS Traffic** on the **HTTPS** tab.|
|`-GPresult` \<`Start`\|`Stop`\|`Both`>|Collect SysInternals *Handle.exe* output on phase `start`, `stop`, or `both`.|
|`-Handle` \<`Start`\|`Stop`\|`Both`>|Collect SysInternals *Handle.exe* output on phase `start`, `stop`, or `both`.|
|`-LiveKD` \<`Start`\|`Stop`\|`Both`>|Start SysInternals LiveKD `-ml` (live kernel dump).<br>`<Start>`: the dump is taken at the start of the repro.<br>`<Stop>`: the dump is taken at stop.<br>`<Both>`: the dump is taken at both start and stop.|
|`-Netsh`<br>1. `-NetshOptions '<Option string>'`<br>2. `-NetshMaxSizeMB <Int>`<br>3. `-noPacket`|Start network packet capturing.<br><br>1. Specify additional options for `Netsh`. For example, `'capturetype=both captureMultilayer=yes provider=Microsoft-Windows-PrimaryNetworkIcon provider={<GUID>}'`.<br>2. The maximum log size for `Netsh` in megabytes (MB) (for example, `-NetshMaxSizeMB 4096`). The default value is 2048.<br>3. Prevent packets from being captured with `Netsh` (only ETW traces in the `ScenarioName` will be captured).|
|`-NetshScenario`<br>1. `-NetshOptions '<Option string>'`<br>2. `-NetshMaxSizeMB <Int>`<br>3. `-noPacket`|Start the `Netsh` scenario trace. The supported `<ScenarioName>` is listed using the `-ListSupportedNetshScenario` cmdlet.<br><br>1. Specify additional options for `Netsh`. For example, `'capturetype=both captureMultilayer=yes provider=Microsoft-Windows-PrimaryNetworkIcon provider={<GUID>}'`.<br>2. The maximum log size for `Netsh` in MB (for example, `-NetshMaxSizeMB 4096`). The default value is 2048.<br>3. Prevent packets from being captured with `Netsh` (only ETW traces in the scenario name will be captured).|
|`-PerfMon <CounterSetName> [-PerfIntervalSec N] [-PerfMonMaxMB <N>] [-PerfMonCNF <[[hh:]mm:]ss>]`<br>1. `-PerfIntervalSec <Interval in sec>`<br>2. `-PerfMonMaxMB <N>`<br>3. `-PerfMonCNF <[[hh:]mm:]ss>`|Start Performance Monitor logs. The `<CounterSetName>` can be listed using the `-ListSupportedPerfCounter` cmdlet.<br><br>1. Set the interval for the `PerfMon` log (the default value is 10 seconds).<br>2. Specify an int value for the maximum `Perfmon` log size in MB (the default value is 2048).<br>3. Create a new file when the specified time has elapsed or when the max size of `<PerfMonMaxMB>` is exceeded.|
|`-PerfMonLong <CounterSetName> [-PerfLongIntervalMin N] [-PerfMonMaxMB <N>] [-PerfMonCNF <[[hh:]mm:]ss>]`<br>1. `-PerfLongIntervalMin <Interval in min>`|Performance Monitor with a long interval.<br><br>1. Set the interval for the `PerfMonLong` log (the default value is 10 minutes).|
|`-PktMon`|Collect packet monitoring data (on Windows Server 2019, Windows 10, version 1809, and later versions). `PktMon:Drop` collects only dropped packets.|
|`-PoolMon` \<`Start`\|`Stop`\|`Both`>|Collect `PoolMon` on `start`, `stop`, or `both`.|
|`-ProcDump` \<`PID[]`\|`ProcessName.exe[]`\|`ServiceName[]`><br>1. `-ProcDumpOption` \<`Start`\|`Stop`\|`Both`> `-ProcDumpInterval <N>:<Interval in sec>`<br>2. `-ProcDumpInterval <N>:<Interval in sec>`<br>3. `-ProcDumpAppCrash`|Capture user dumps of a single item or comma-separated list of items using SysInternals *ProcDump.exe*. By default, the dump is taken at the start of the repro and stop. Enter `ProcessName`(s) with the `.exe` extension.<br><br>1. `Start`: the dump is taken at the start of the repro.<br>`Stop`: the dump is taken at stop.<br>`Both` (default): the dump is taken at both start and stop.<br>2. Use this option when the dump needs to be captured repeatedly.<br>`N`: the number of dumps<br>`Int`: the interval in seconds<br>The default value is 3:10.<br>3. This switch enables `ProcDump -ma -e`, which writes a full dump when the process encounters an unhandled exception.|
|`-ProcMon`<br>1. `-ProcmonAltitude <N>`<br>2. `-ProcmonPath <folder path to Procmon.exe>`<br>3. `-ProcmonFilter <filter-file.pmc>`|Start SysInternals *Procmon.exe*.<br><br>1. Specify a string value for `ProcmonAltitude` (the default value is 385200). Use `fltmc instances` to show filter driver altitude. Use a lower number than the suspected specific driver. Value 45100 will show you virtually everything.<br>2. Specify a path to *Procmon.exe* (by default, TSS uses the built-in Procmon).<br>3. Specify a config file for Procmon (for example, *ProcmonConfiguration.pmc*) located in the *\\config* folder.|
|`-PSR`|Start Problems Steps Recorder.|
|`-Radar` \<`PID[]`\|`ProcessName[]`\|`ServiceName[]`>|Collect the leak diagnostic information (*rdrleakdiag.exe*).<br><br>For example, `-Radar AppIDSvc`.|
|`-RASdiag`|Collect trace. The `Netsh` Ras diagnostics set trace is enabled.|
|`-SDP <SpecialityName[]>`<br>1. `-SkipSDPList "<xxx>","<yyy>"`<br>2. `<SpecialityName>`|Collect Support Diagnostic Package (SDP) for the specified specialty. For the complete list of `SpecialityNames` and `SkipSDPList`, use the `.\tss -help` cmdlet.<br><br>Skip the comma-separated list of SDP module names that hang in your environment while running the SDP report.|
|`-SysMon`|Collect SysInternals System Monitor (SysMon) logs (*sysmonConfig.xml* in the config folder by default).|
|`-TTD` \<`PID[]`\|`ProcessName.exe[]`\|`ServiceName[]`><br>1. `-TTDPath <Folder path to tttracer.exe>`<br>2. `-TTDMode` \<`Full`\|`Ring`\|`onLaunch`><br>3. `-TTDMaxFile <size in MB>`<br>4. `-TTDOptions '<String of TTD options>'`|Start Time Travel Debugging (TTD) (TTT/iDNA) with the default `-Full` mode. Enter the `ProcessName`(s) with the `.exe` extension, a single item (PID/name) or a comma-separated list of items.<br><br>Note: <br>Down-level operating system before Windows 10, version 1703 requires the *TSS_TTD.zip* package.<br><br>1. Specify the folder path containing *tttracer.exe* (PartnerTTD). Typically, this switch is only needed if you want to force a specific path.<br>2. `Full` = -dumpfull (=default)<br>`Ring` = ring buffer mode<br>`onLaunch` = -onLaunch (requires TSS_TTD)<br>3. The maximum log file size. The operation depends on `-TTDMode`. `Full` stops when the maximum size is reached, and `Ring` keeps the maximum size in the ring buffer.<br>4. Use this option to add any additional options for TTD (TTT/iDNA).|
|`-Video`|Start video capturing (requires .NET 3.5 to be installed).|
|`-WFPdiag`|Collect traces with the `netsh Wfp capture` command.|
|`-WireShark`|Start WireShark. The following parameters are configurable through the *tss_config.cfg* file. <br><br>1. `WS_IF`: used for `-i`. Specify the interface number (for example, `_WS_IF=1`).<br>2. `WS_Filter`: used for `-f`. Filter for the interface (for example, `_WS_Filter="port 443"`).<br>3. `WS_Snaplen`: used for `-s`. Limit the amount of data for each frame. This parameter has better performance and is helpful for high-load situations (for example, `_WS_Snaplen=128`).<br>4. `WS_TraceBufferSizeInMB`: used for `-b FileSize` (multiplied by 1024). Switch to the next file after the number of megabytes. (for example, `_WS_TraceBufferSizeInMB=512`, default=512 MB)<br>5. `WS_PurgeNrFilesToKeep`: used for `-b files`. Replace after the number of the files. (for example, `_WS_PurgeNrFilesToKeep=20`)<br>6. `WS_Options`: any other options for `-i` (for example, `_WS_Options="-P"`).<br><br>Example:<br>To collect WireShark on interfaces 15 and 11, input when TSS prompts for an interface number: `15 -i 11`.<br><br>By default, Wireshark starts `dumpcap.exe -i <all NICs> -B 1024 -n -t -w _WireShark-packetcapture.pcap -b files:10 -b filesize:524288`.|
|`-WPR <WPRprofile>`<br>1. `-SkipPdbGen`<br>2. `-WPROptions '<Option string>'`|Start a WPR profile trace. `<WPRprofile>` is one of `General`\|`BootGeneral`\|`CPU`\|`Device`\|`Memory`\|`Network`\|`Registry`\|`Storage`\|`Wait`\|`SQL`\|`Graphic`\|`Xaml`\|`VSOD_CPU`\|`VSOD_Leak`.<br><br>1. Skip generating symbol files (PDB files).<br>2. Specify options for *WPR.exe*. For example, `-WPROptions '-onoffproblemdescription "test description"'`.<br><br>Example 1:<br>`.\TSS.ps1 -StartAutoLogger -WPR BootGeneral -WPROptions '-addboot CPU'` will capture WPR boot traces with the `General` and `CPU` profiles.<br><br>Example 2:<br>`.\TSS.ps1 -WPR General -WPROptions '-Start CPU -start Network -start Minifilter'` will combine profiles (`General`, `CPU`, `Network`, and `Minifilter`).|
|`-Xperf <Profile>`<br>1. `-XperfMaxFileMB <Size>`<br>2. `-XperfTag <Pool Tag>`<br>3. `-XperfPIDs <PID>`<br>4. `-XperfOptions <Option string>`|Start Xperf. `<Profile>` is one of `General`\|`CPU`\|`Disk`\|`Leak`\|`Memory`\|`Network`\|`Pool`\|`PoolNPP`\|`Registry`\|`SMB2`\|`SBSL`\|`SBSLboot`.<br><br>1. Specify the maximum log size in MB (the default value is 2048 MB). The default value for SBSL\* scenarios is 16384 (same for ADS_\/NET_SBSL).<br>2. Specify `PoolTag` to be logged. This parameter is used with the `Pool` or `PoolNPP` profile (for example, `-Xperf Pool -XperfTag TcpE+AleE+AfdE+AfdX`).<br>3. Specify `ProcessID`. This parameter is used with the `Leak` profile (for example, `-Xperf Leak -XperfPIDs <PID>`).<br>4. Specify other option strings for `Xperf`.|
|`-xray`|Start xray to diagnose a system for known issues.|

The following example illustrates how to activate multiple support tools (commands) during the same trace.

```PowerShell
.\TSS.ps1 -WPR <WPRprofile> -Procmon -Netsh|-NetshScenario <NetshScenario> -PerfMon <CounterSetName> -ProcDump <PID> -PktMon -SysMon -SDP <specialty> -xray -PSR -Video -TTD <PID[]|ProcessName[]|ServiceName[]>  
```

## Parameters within TSS options

Defines specific parameters within the TSS options to control, enhance, or simplify data collection.

|Parameter  |Description  |
|---------|---------|
|`-AcceptEula`     |Don't ask at first; run to accept the Disclaimer (useful for the `-RemoteRun` execution).         |
|`-AddDescription <description>`     |Add a brief description of the repro issue. The name of the resulting zip file will include such a description.         |
|`-Assist`     |Accessibility mode.         |
|`-BasicLog`     |Collect the full basic log (the mini basic log is always collected by default).         |
|`-CollectComponentLog`     |Use with `-Scenario`. By default, component collect functions aren't called in the `-Scenario` trace. This switch enables the component collect functions to be called.         |
|`-CollectDump`     |Collect system dump (*memory.dmp*) after stopping all traces. `-CollectDump` can be used with `-Start` and `-Stop`.         |
|`-CollectEventLog <Eventlog[]>`     |Collect specified event logs. The asterisk (\*) wildcard character can be used for the event log name.<br><br>Example:<br>`-CollectEventLog Security,*Cred*`<br>Collect security and all event logs that match `*Cred*` like `'Microsoft-Windows-CertificateServicesClient-CredentialRoaming/Operational'`.         |
|`-CommonTask` \<`<POD>`\|`Full`\|`Mini`>     |Run common tasks before starting and after stopping the trace.<br><br>`<POD>`: currently, only "NET" is available. Collect additional information before starting and after stopping the trace.<br>`Full`: the full basic log is collected after stopping the trace.<br>`Mini`: the mini basic log is collected after stopping the trace.         |
|`-Crash`     |Trigger a system crash with `NotMyFault` at the stop of repro, or after all events are signaled if used with `-WaitEvent`.<br><br>Caution:<br>This switch will force a memory dump (the system will restart), so open files won't be saved.          |
|`-CustomETL`     |Add custom ETL trace providers. For example, `.\TSS.ps1 -WIN_CustomETL -CustomETL '{<GUID>}','Microsoft-Windows-PrimaryNetworkIcon'` (a comma-separated list of single-quoted `'{GUID}'` and/or `'Provider-Name'`).         |
|`-DebugMode`     |Run with debug mode for a developer.         |
|`-VerboseMode`     |Show more verbose or informational output while processing TSS functions.         |
|`-Discard`     |Used to discard a dataset at phase `-Stop`. `*Stop-` or `*Collect-` functions won't run. `xray` and `psSDP` will be skipped.         |
|`-EnableCOMDebug`     |Module to turn on COM debug mode.         |
|`-ETLOptions` \<`circular`\|`newfile`>:\<`ETLMaxSizeMB`>:\<`ETLNumberToKeep`>:\<`ETLFileMax`>     |Set options passed to `logman` commands. The default value for `circular ETLMaxSizeMB` is 1024, and the default value for `newfile ETLMaxSizeMB` is 512.<br><br>`-StartAutologger` only supports `-ETLOptions circular:<ETLMaxSize>:<ETLNumberToKeep>:<ETLFileMax>`, but `ETLNumberToKeep` won't be executed expectedly.<br><br>Example.1:<br>`-ETLOptions newfile:2048:5`<br><br>Run `newfile` logs with a size of 2048 MB. Keep only the last five `*.etl` files. The default setting for circular mode is `circular:1024`, and for newfile mode is `newfile:512:10`.<br><br>Example 2:<br>`-StartAutologger -ETLOptions circular:4096`<br>`Autologger` won't obey `:<ETLNumberToKeep>` and it only accepts mode circular.<br><br>Example 3:<br>`-StartAutologger -ETLOptions circular:4096:10:3`<br>`Autologger` won't obey `:<ETLNumberToKeep>` and it only accepts mode circular and "3" as the number of `autologger` generations.          |
|`-ETWlevel` \<`Info`\|`Warning`\|`Error`>     |Set Event Tracing Level. The default value is 0xFF.         |
|`-EvtDaysBack <N>`     |Convert event logs only for the last N days. The default value is 30 days. It also applies to the SDP report.<br><br>Note:<br>Security event logs will be skipped.          |
|`-ExternalScript <path to external PS file>`     |Run the specified PowerShell script before starting the trace.         |
|`-LogFolderPath <Drive:\path to log folder>`     |Use a different log folder path for the resulting output data instead of the default location (*C:\\MS_DATA*). It's useful when drive *C:* is low on free disk space.         |
|`-MaxEvents <N>`     |As an argument for `'-WaitEvent Evt:..'`, the parameter will investigate the last N number of events with the same event ID (the default value is 1).         |
|`-Mini`     |Collect only minimal data. Skip `noPSR`, `noSDP`, `noVideo`, `noXray`, `noZip`, and `noBasicLog`.         |
|`-Mode` \<`Basic`\|`Medium`\|`Advanced`\|`Full`\|`Verbose`\|`VerboseEx`\|`Hang`\|`Restart`<br>\|`Swarm`\|`Kube`\|`GetFarmdata`\|`Permission`\|`traceMS`>     |Run scripts in `Basic`, `Medium`, `Advanced`, `Full`, or `Verbose(Ex)` mode for data collection. `Restart` will restart the associated service.         |
|`-RemoteRun`     |Use when TSS is being executed on a remote host, for example, via PsExec, in the Azure Serial Console, or with PowerShell remoting. This parameter will inhibit PSR, video recording, starting TssClock, and opening Explorer with final results. In such a case, also consider `-AcceptEula`.         |
|`-StartNoWait`     |Don't wait, and prompt will return immediately. This parameter is useful for the scenario where a user needs to log off.         |
|`-WaitEvent`     |Monitor for the specified event or stop-trigger; if it's signaled, traces will be stopped automatically.<br><br>There's a wide variety of options to trigger an automatic stop. Run `.\TSS.ps1 -Find Monitoring` to see the usage.         |
|`-Update`<br>1. `-UpdMode` \<`Online`\|`Lite`>      |Update the TSS package. It can be used together with `-UpdMode Online|Lite`.<br><br>`Online` is the default, and `Lite` is the `Upd` lite version.         |
|`-Help`<br>1. `Common`<br>2. `ALL`<br>3. `Monitoring`<br>4. `Config`<br>5. `Keyword`     |Provide help messages on various scenarios.<br><br>1. Common general help message.<br>2.    All available options.<br>3. Show help messages for monitoring and remote features.<br>4. Help with all config parameters.<br>5. You can enter any keyword, and it will show the help information about that keyword.          |
|`-Status`     |Show the status of the running trace, if any.        |

## Helper scripts and tools included

|Helper script and tool  |Description  |
|---------|---------|
|`\scripts\tss_EventCreate.ps1`     |Create an event log entry in event log files with event IDs.         |
|`\scripts\tss_SMB_Fix-SmbBindings.ps1`     |Useful for fixing corrupted SMB bindings (LanmanServer, LanmanWorkstation, or NetBT). See also `-Collect NET_SMBsrvBinding`.         |
|`\BINx64\kdbgctrl.exe`     |Use the switch `-sd <dump type>`  to set the kernel crash dump type `Full|Kernel`, for example, `kdbgctrl -sd Full`.         |
|`\BINx64\NTttcp.exe`     |Performance tests. For more information, see [Test VM network throughput by using NTTTCP](/azure/virtual-network/virtual-network-bandwidth-testing).         |
|`\BINx64\latte.exe`     |Latency tests. For more information, see [Test network latency between Azure VMs](/azure/virtual-network/virtual-network-test-latency).         |
|`\BINx64\notmyfaultc.exe`     |Force a memory dump. See [NotMyFault v4.21](/sysinternals/downloads/notmyfault) if the TSS command line includes `-Crash`.         |

## Troubleshoot unexpected PowerShell errors

1. Run this cmdlet after a failure:

    ```PowerShell
    .\TSS.ps1 -Stop -noBasiclog -noXray
    ```

2. Close the opened elevated PowerShell window and start a new elevated PowerShell window.
3. Allow PowerShell scripts to run on your system with the proper `ExecutionPolicy`.
4. If you encounter an error indicating that the running script is disabled, try the following methods.

### Method 1

1. Run the following cmdlet:
  
      ```PowerShell
      Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -force -Scope Process
      ```

2. Verify the settings with the `Get-ExecutionPolicy -List` cmdlet that no `ExecutionPolicy` with higher precedence is blocking the execution of this script.
3. Run the `.\TSS.ps1 <Desired Parameters>` cmdlet again.

### Method 2 (alternative)

If scripts are blocked by `MachinePolicy`, run the following cmdlets in an elevated PowerShell window:

1. ```PowerShell
   Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell -Name ExecutionPolicy -Value RemoteSigned
   ```

2. ```PowerShell
   Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell -Name EnableScripts  -Value 1 -Type DWord
   ```

### Method 3 (alternative)

If scripts are blocked by `UserPolicy`, run the following cmdlets in an elevated PowerShell window:

1. ```PowerShell
   Set-ItemProperty -Path HKLM:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell -Name ExecutionPolicy -Value RemoteSigned
   ```

2. ```PowerShell
   Set-ItemProperty -Path HKLM:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell -Name EnableScripts  -Value 1 -Type DWord
   ```

> [!NOTE]
> Method 2 is only a workaround for the Policy `MachinePolicy - RemoteSigned`. If you also see `UserPolicy - RemoteSigned`, ask the domain admin for a temporary Group Policy Object (GPO) exemption.
>
> In rare situations, you can try the `-ExecutionPolicy Bypass` cmdlet.
>
> If your organization forces the GPO PowerShell constrained language mode (`System.Management.Automation.EngineIntrinsics.SessionState.LanguageMode -ne 'FullLanguage'`), ask the domain admin for a temporary GPO exemption.

## Frequently asked questions (FAQs)

- Q1: Does the TSS script change any setup or configuration of my system?

    A1: No, but a registry setting is required for enabling debug logging in some scenarios. The script sets the necessary key at the start of the data collection and reverts the key to the default value at the end of the data collection. It may also delete some caches (for example, the ARP cache or the name resolution cache) at the start of the data collection to observe the problem from the logs.

- Q2: Does the TSS toolset put an additional load on the server?

    A2: Some loggings (for example, network capturing, ETW tracing collection, and so on) that are started by the TSS toolset might put a minor load on the system. The load is usually at ignorable levels. Contact your support representative when you see high CPU, memory, or disk usage after starting the TSS toolset.

- Q3: Why can't we reproduce the issue when the TSS toolset is running?

    A3: The TSS toolset may delete all cached information at the start. It also starts the network capturing in a promiscuous mode, which changes the Network Interface Card (NIC) default behaviors. These changes might affect the issue, and the problems may disappear. Especially for particular timing issues, problems disappear because of the TSS toolset's data collection. The data collection starts logging, which might affect the issue indirectly and change the situation.

- Q4: Why is the TSS toolset not responding for a long time?

    A4: In some cases, the operating system's built-in commands run by the TSS toolset might not respond or take a long time to complete. Contact your support representative if you experience this issue.

- Q5: Do I need to worry about disk space or anything else when I run the TSS toolset for a long time?

    A5: All TSS tracing is configured to run with ring buffers, so you can run the toolset for a long time if needed. The TSS toolset also calculates disk space at the beginning of the data collection and may exit if there isn't sufficient disk space. If you see high disk usage after starting the TSS toolset or have any other concerns about the disk usage of the toolset, contact your support representative.

- Q6: What should I do if I receive the following security warning when running the *.\\TSS.ps1* script?

    `Security Warning: Run only scripts that you trust. While scripts from the Internet can be useful, this script can potentially harm your computer. Do you want to run .\TSS.ps1? [D] Do not run [R] Run once [S] Suspend [?] Help (default is "D")`

    A6: In rare situations, you may receive this security warning. You may unblock the script by using the cmdlet `PS C:\> Unblock-File -Path C:\TSS\TSS.ps1`. This script will unblock all other modules by using the cmdlet `Get-ChildItem -Recurse -Path C:\TSS\*.ps* | Unblock-File -Confirm:$false`.

## End User License Agreement (EULA)

Select below to view MICROSOFT SOFTWARE LICENSE TERMS.
<br>
<details>
<summary><b>Microsoft Diagnostic Scripts and Utilities</b></summary>

These license terms are an agreement between you and Microsoft Corporation (or one of its affiliates). IF YOU COMPLY WITH THESE LICENSE TERMS, YOU HAVE THE RIGHTS BELOW. BY USING THE SOFTWARE, YOU ACCEPT THESE TERMS.

1. INSTALLATION AND USE RIGHTS. Subject to the terms and restrictions set forth in this license, Microsoft Corporation ("Microsoft") grants you ("Customer" or "you") a non-exclusive, non-assignable, fully paid-up license to use and reproduce the script or utility provided under this license (the "Software"), solely for Customer's internal business purposes, to help Microsoft troubleshoot issues with one or more Microsoft products, provided that such license to the Software does not include any rights to other Microsoft technologies (such as products or services). "Use" means to copy, install, execute, access, display, run or otherwise interact with the Software.  

    You may not sublicense the Software or any use of it through distribution, network access, or otherwise. Microsoft reserves all other rights not expressly granted herein, whether by implication, estoppel or otherwise. You may not reverse engineer, decompile or disassemble the Software, or otherwise attempt to derive the source code for the Software, except and to the extent required by third party licensing terms governing use of certain open source components that may be included in the Software, or remove, minimize, block, or modify any notices of Microsoft or its suppliers in the Software. Neither you nor your representatives may use the Software provided hereunder: (i) in a way prohibited by law, regulation, governmental order or decree; (ii) to violate the rights of others; (iii) to try to gain unauthorized access to or disrupt any service, device, data, account or network; (iv) to distribute spam or malware; (v) in a way that could harm Microsoft's IT systems or impair anyone else's use of them; (vi) in any application or situation where use of the Software could lead to the death or serious bodily injury of any person, or to physical or environmental damage; or (vii) to assist, encourage or enable anyone to do any of the above.
2. DATA. Customer owns all rights to data that it may elect to share with Microsoft through using the Software. You can learn more about data collection and use in the help documentation and the privacy statement at https://aka.ms/privacy. Your use of the Software operates as your consent to these practices.
3. FEEDBACK. If you give feedback about the Software to Microsoft, you grant to Microsoft, without charge, the right to use, share and commercialize your feedback in any way and for any purpose.  You will not provide any feedback that is subject to a license that would require Microsoft to license its software or documentation to third parties due to Microsoft including your feedback in such software or documentation.  
4. EXPORT RESTRICTIONS. Customer must comply with all domestic and international export laws and regulations that apply to the Software, which include restrictions on destinations, end users, and end use. For further information on export restrictions, visit https://aka.ms/exporting.
5. REPRESENTATIONS AND WARRANTIES. Customer will comply with all applicable laws under this agreement, including in the delivery and use of all data. Customer or a designee agreeing to these terms on behalf of an entity represents and warrants that it (i) has the full power and authority to enter into and perform its obligations under this agreement, (ii) has full power and authority to bind its affiliates or organization to the terms of this agreement, and (iii) will secure the permission of the other party prior to providing any source code in a manner that would subject the other party's intellectual property to any other license terms or require the other party to distribute source code to any of its technologies.
6. DISCLAIMER OF WARRANTY. THE SOFTWARE IS PROVIDED "AS IS," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL MICROSOFT OR ITS LICENSORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THE SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
7. LIMITATION ON AND EXCLUSION OF DAMAGES. IF YOU HAVE ANY BASIS FOR RECOVERING DAMAGES DESPITE THE PRECEDING DISCLAIMER OF WARRANTY, YOU CAN RECOVER FROM MICROSOFT AND ITS SUPPLIERS ONLY DIRECT DAMAGES UP TO U.S. .00. YOU CANNOT RECOVER ANY OTHER DAMAGES, INCLUDING CONSEQUENTIAL, LOST PROFITS, SPECIAL, INDIRECT, OR INCIDENTAL DAMAGES. This limitation applies to (i) anything related to the Software, services, content (including code) on third party Internet sites, or third party applications; and (ii) claims for breach of contract, warranty, guarantee, or condition; strict liability, negligence, or other tort; or any other claim; in each case to the extent permitted by applicable law. It also applies even if Microsoft knew or should have known about the possibility of the damages. The above limitation or exclusion may not apply to you because your state, province, or country may not allow the exclusion or limitation of incidental, consequential, or other damages.
8. BINDING ARBITRATION AND CLASS ACTION WAIVER. This section applies if you live in (or, if a business, your principal place of business is in) the United States.  If you and Microsoft have a dispute, you and Microsoft agree to try for 60 days to resolve it informally. If you and Microsoft can't, you and Microsoft agree to binding individual arbitration before the American Arbitration Association under the Federal Arbitration Act ("FAA"), and not to sue in court in front of a judge or jury. Instead, a neutral arbitrator will decide. Class action lawsuits, class-wide arbitrations, private attorney-general actions, and any other proceeding where someone acts in a representative capacity are not allowed; nor is combining individual proceedings without the consent of all parties. The complete Arbitration Agreement contains more terms and is at https://aka.ms/arb-agreement-4. You and Microsoft agree to these terms.  
9. LAW AND VENUE. If U.S. federal jurisdiction exists, you and Microsoft consent to exclusive jurisdiction and venue in the federal court in King County, Washington for all disputes heard in court (excluding arbitration). If not, you and Microsoft consent to exclusive jurisdiction and venue in the Superior Court of King County, Washington for all disputes heard in court (excluding arbitration).
10. ENTIRE AGREEMENT. This agreement, and any other terms Microsoft may provide for supplements, updates, or third-party applications, is the entire agreement for the software.
    
</details>
