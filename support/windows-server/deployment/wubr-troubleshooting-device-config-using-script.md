---
title: How to use the configuration script to troubleshoot device configuration
description: 
ms.date: 12/19/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.prod: windows-server
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
keywords: 
---

# Windows Update for Business reports: : How to use the configuration script to troubleshoot device configuration

_Applies to:_ &nbsp; Windows Server, all supported versions

When you're troubleshooting, you can use the Windows Update for Business reports configuration script to test endpoint connectivity, ensure the right services are running, and check for common issues.  

You can download the script from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=101086).  

For more information about the script, including the available parameters, see [Configuring devices through the Windows Update for Business reports configuration script](/windows/deployment/update/wufb-reports-configuration-script).  

> [!NOTE]  
> If you don't find any issues in the device configuration, and you determine that the Windows Update for Business reports are correctly configured, your issue is likely related to data transmission. For more information, see [Windows Update for Business reports: How to troubleshoot diagnostic data transmission](wubr-troubleshooting-data-transmission.md).

## Configuring the script

The device must have Windows 10 or a later version, and the latest version of Windows PowerShell. To run the script, you have to use an elevated PowerShell windowon the device (the script itself runs in the System context).  

> [!IMPORTANT]  
>  - The script package includes *PSExec.exe*. If you use a mobile device manager such as Microsoft Intune, and you've implemented attack surface reduction (ASR) rules beyond the standard ASR rules, they may block the script. For more information, see [Block process creations originating from PSExec and WMI commands](/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-reference#block-process-creations-originating-from-psexec-and-wmi-commands).
> - After you finish troubleshooting the device, remove *PSExec.exe*.

## Running the script

To use the script to troubleshoot a client device:  

1. Sign in to the device as an administrator.
1. Download the script package to the device that you're troubleshooting, and expand the script package.
1. Create a folder on the device for log data. The default name and path that the script uses is *The default value is *.\UCLogs*.
1. Edit *RunConfig.bat* to set the following required parameters:  

    - `runMode=Pilot`
    - `logPath=<path the folder that you created for log data>`

     > [!NOTE]  
     > - Pilot mode is a verbose mode. The script has another mode, Deployment, that runs silently.
     > - Don't modify the `Commercial ID` parameters. They're used for the earlier version of Windows Update for Business reports (Update Compliance).  

1. If you want to set additional parameters, the following *RunConfig.bat* parameters are optional:

   | Parameter| Allowed values and description | Example |
   | - | - | - |
   | logMode | **0**: Log only to the console.</br>**1** (default): Log to file and console.</br>**2**: Log only to file. | `logMode=2` |
   | DeviceNameOptIn | **true** (default): Device name is sent to Microsoft. </br> **false**: Device name isn't sent to Microsoft. | `DeviceNameOptIn=true` |
   | ClientProxy | **Direct** (default): The device connects directly to the endpoints. </br>**System**: The device connects by using a system proxy, without authentication.</br>**User**: The device connects by using the user account's internet configuration. The connection might or might not require user authentication.</br></br>For more information, see [How the Windows Update client determines which proxy server to use to connect to the Windows Update website](https://support.microsoft.com/topic/how-the-windows-update-client-determines-which-proxy-server-to-use-to-connect-to-the-windows-update-website-08612ae5-3722-886c-f1e1-d012516c22a1) | `ClientProxy=Direct` |  

1. Save the changes to *RunConfig.bat*, and then close the file.
1. Open an elevated PowerShell window, navigate to the folder that contains the script files, and then run *RunConfig.bat*.

## Reviewing the script ouput

The script creates a working folder in the folder that you identified in the `logPath` parameter in *RunConfig.bat*. The default folder name is *UA_yy_MM_dd_HH_mm_ss_GUID*, where *yy_MM_dd_HH_mm_ss* represents the date and time that you ran the script. The script saves all output files and other diagnostic files in this working folder.

### Analyzing the script log file and error codes

The script log file, *UA_yy_MM_dd_HH_mm_ss_GUID.txt*, has the same name as the working folder. You should review this file first. You can use the following table to interpret any error codes that're listed in the file.  

| Error  | Description|
| - | - |
| 1    | Unexpected error |
| 12    | CheckVortexConnectivity failed, check the log output for more information. |
| 12    | Unexpected failure when running CheckVortexConnectivity.|
| 16    | Reboot is pending on device. Restart the device then re rerun the script.|
| 17    | Unexpected exception in CheckRebootRequired.|
| 27    | Not system account. |
| 30    | Unable to disable Enterprise Auth Proxy. This registry value must be 0 for UTC to operate in an authenticated proxy environment.|
| 34    | Unexpected exception when attempting to check proxy settings.|
| 35    | Unexpected exception when checking user proxy.|
| 37    | Unexpected exception when collecting logs.|
| 40    | Unexpected exception when checking and setting telemetry.|
| 41    | Unable to impersonate logged-on user.|
| 42    | Unexpected exception when attempting to impersonate logged-on user.|
| 43    | Unexpected exception when attempting to impersonate logged-on user.|
| 44    | Error when running CheckDiagTrack service.|
| 45    | DiagTrack.dll not found.|
| 50    | DiagTrack service not running.|
| 51    | Unexpected exception when attempting to run Census.exe. |
| 52    | Couldn't find Census.exe. |
| 54    | Microsoft Account Sign In Assistant (MSA) Service disabled.|
| 55    | Failed to create new registry path for SetDeviceNameOptIn.|
| 56    | Failed to create property for SetDeviceNameOptIn at registry path.|
| 57    | Failed to update value for SetDeviceNameOptIn. |
| 58    | Unexpected exception in SetDeviceNameOptIn.|
| 59    | Failed to delete LastPersistedEventTimeOrFirstBoot property at registry path when attempting to clean up OneSettings.|
| 60    | Failed to delete registry key when attempting to clean up OneSettings.|
| 61    | Unexpected exception when attempting to clean up OneSettings.|
| 62    | AllowTelemetry registry key isn't the correct type of REG_DWORD.|
| 63    | AllowTelemetry isn't set to the appropriate value and it couldn't be set by the script.|
| 64    | AllowTelemetry isn't the correct type of REG_DWORD.|
| 66    | Failed to verify UTC connectivity and recent uploads.|  
| 67    | Unexpected failure when verifying UTC CSP.|
| 99    | Device isn't Windows 10 or Windows 11.|
| 100   | Device must be Microsoft Entra joined or Microsoft Entra hybrid joined to use Windows Update for Business reports.|
| 101   | Check Microsoft Entra join failed with unexpected exception.|
| 102   | DisableOneSettingsDownloads policy shouldn't be enabled. Please disable this policy.|

### Analyzing the other output and diagnostic data

These files record information that the script exports from the registry.

#### RegAppCompatFlags.txt

This file records appraiser (sometimes referred to as Device Appraiser or Microsoft Compatibility Appraiser) information. Appraiser is the Windows component that corresponds to the compatibility updates. It assesses the apps and drivers on the device for compatibility with the latest version of Windows. Appraiser depends on the following files:

- *%windir%\System32\appraiser.dll*. The file version must be 10.0.17763 or higher.
- *%windir%\System32\CompatTelRunner.exe*. If the file does not exist, make sure that all compatibility updates have been installed on the device.

#### RegDataCollection.txt

This file records the DataCollection settings. This data represents the current telemetry configuration of the device, as per applied policies.

You can use this data to verify that the appropriate values are applied to transmit diagnostic data to Microsoft. This data resembles the following excerpt:  

```output
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"AllowDeviceNameInTelemetry"=dword:00000001
"AllowUpdateComplianceProcessing"=dword:00000010
"AllowCommercialDataPipeline"=dword:00000001
```

#### RegPoliciesDataCollection.txt

This file records device-level and user-level settings for controlling diagnostic data. The device-level configuration data resembles the following excerpt:

```output
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"AllowTelemetry"=dword:00000003
"MaxTelemetryAllowed"=dword:00000003
```

The `AllowTelemetry` entry controls the type (if any) of diagnostic data to transmit. The entry has the following allowed values:

- **0** &ndash; Security (This value is only supported on Enterprise, Education, and Server editions of Windows.)
- **1** &ndash; Basic (required) telemetry
- **2** &ndash; Enhanced telemetry
- **3** &ndash; Full telemetry

The user-level configuration data resembles the following excerpt:

```output
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\Users]
```

#### RegSQM.txt

This information is primarily for use regarding Windows 7 devices. If you're working with later Windows versions, you can use this information as a fallback identifier for the device.

#### RegDiagTrack.txt

This file records all the registry settings for the Connected User Experiences and Telemetry (DiagTrack) (UTC) service. The entries that store these settings all reside under the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\' subkey. The following excerpt shows such a report:

```output
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack]
"TimeStampInterval"=dword:00000001
"Capabilities"=hex:c6,f6,43,15,00,00,00,00
"mspflags"=hex(b):11,00,00,00,00,00,00,00
"DiagTrackAuthorization"=dword:00000f9f
"LaunchCount"=hex(b):03,00,00,00,00,00,00,00
"DiagTrackStatus"=dword:00000003
"LastFreeNetworkLossTime"=hex(b):00,00,00,00,00,00,00,00
"LastConnectivityHeartBeatTime"=hex(b):00,00,00,00,00,00,00,00
"LastConnectivityState"=dword:00000002
"ConnectivityNoNetworkTime"=dword:00000001
"ConnectivityRestrictedNetworkTime"=dword:00000000
"LastPersistedEventTime"=hex(b):40,e5,64,27,cb,8a,d9,01
"LatencyDataLastUploadTime"=hex(b):00,00,00,00,00,00,00,00
"TriggerCount"=hex(b):00,04,00,00,00,00,00,00
"HttpRequestCount"=hex(b):07,00,00,00,00,00,00,00
"TriggerLatency"="0.088490"
"HttpRequestLatency"="0.077600"
"LastSuccessfulUploadTime"=hex(b):7a,96,6c,2b,cb,8a,d9,01
"LastSuccessfulRealtimeUploadTime"=hex(b):7a,96,6c,2b,cb,8a,d9,01
"LastSuccessfulNormalUploadTime"=hex(b):55,2a,aa,a7,ca,8a,d9,01
```

##### Using the DCode tool to convert hexadecimal values to date-time format

As shown by the previous excerpt, many of these entries use big-endian hexadecimal format. To convert them to UTC dates and times, use a tool such as [DCode](https://www.digital-detective.net/dcode/). This tool is available as a free download.

The DCode tool uses input values that have a slightly different format than the one that the file uses. You have to reverse the sequence of the segments, and then remove all non-numeric characters.
For example, consider the following value from the excerpt:

```console
hex(b):55,2a,aa,a7,ca,8a,d9,01
```

To use DCode to convert this value, in DCode, select **Format** and then select **Hexadecimal (Big Endian). In **Value**, enter the following:

```console
01d98acaa7aa2a55
```

Then select **Decode**. The list of results includes a **Windows FileTime (UTC)** entry that has the value **2023-05-20 03:24:58.5114197 Z**.  

> [!NOTE]  
> By default, all dates and times are Coordinated Universal Time (UTC) values. You can use DCode's **Time Zone** setting to display the time stamp in a different time zone.
