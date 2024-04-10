---
title: Internet Explorer WPAD Diagnostic
description: This article describes the actions that may occur and the information that may be collected from a machine when running Internet Explorer WPAD Data Collection.
ms.date: 04/21/2020
ms.reviewer: aanders
---
# Internet Explorer WPAD Diagnostic - All versions

[!INCLUDE [](../../../includes/browsers-important.md)]

The Internet Explorer WPAD Diagnostic was designed to reset and collect data related to Internet Explorer's Automatically Detect Settings activity used to troubleshoot Internet Explorer connectivity issues related to Proxy Automatic Discovery.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2668985

## Actions performed by Internet Explorer WPAD Data Collection

Internet Explorer WPAD Data Collection will perform the following actions:

- Prompt to choose the affected user
- Prompt for user credentials
- Clear Temporary Internet Files on Internet Explorer+, delete .pac/.dat files on Internet Explorer 6
- Start network trace (`netsh` for Win7/2k8r2, `nmcap` for Vista/2k8, `netcap` for XP 2k3)

  > [!NOTE]
  > It will prompt and open browser to NM3.4 download on Vista/2k8 if not already installed.

- Prompt that includes information on the deletion of the contents of Internet Explorer Connections registry keys
- Save connections keys to user's desktop
- Delete HKLM/HKCU/, HKLM\Wow6432Node, and HKCU\Wow6432Node Connections key contents if they exist
- Release and renew IP address
- Launch Internet Explorer as selected user
- Stop and collect network traces

## Information collected by Internet Explorer WPAD Data Collection

_Internet Explorer Connections Key Activity Log_

|Description|File Name|
|---|---|
|Connections Key:|{ComputerName}_{UserName}_Connections.txt|
|Connections Key:|{ComputerName}_{UserName}_Connections.txt|
  
_IPConfig Activity Log_

|Description|File Name|
|---|---|
|IPConfig Output:|{ComputerName}_ReleaseRenewIP.txt|
  
_Network Trace Files (Windows 7, Windows Server 2008 R2)_

|Description|File Name|
|---|---|
|Network Trace Log:|{ComputerName}_Netsh.txt|
|Network Trace File:|InternetClient.etl|
|Network Trace Cab:|InternetClient.cab|
  
_Network Trace Files (Windows Vista, Windows Server 2008)_

|Description|File Name|
|---|---|
|Network Trace Log:|{ComputerName}_{UserName}_NMcap_Trace_DisplayNet.txt|
|Network Trace File:|{ComputerName}_NMcap.cap|
  
_Network Trace Files (Windows XP, Windows Server 2003)_

|Description|File Name|
|---|---|
|Network Trace Log:|{ComputerName}_{UserName}_NMcap_Trace_DisplayNet.txt|
|Network Trace File:|{ComputerName}_capture0.cap|
|Network Trace File:|{ComputerName}_capture1.cap|
|Network Trace File:|{ComputerName}_capture2.cap|
|Network Trace File:|{ComputerName}_capture3.cap|
|Network Trace File:|{ComputerName}_capture4.cap|
|Network Trace File:|{ComputerName}_capture5.cap|
  
_Internet Explorer 6 Autoproxy Files_

|Description|File Name|
|---|---|
|Internet Explorer 6 Autoproxy File Log:|{ComputerName}_{UserName}_IE6_Autoproxy_file_log.txt|
  
### Additional information

In addition to the files collected as part of this diagnostic, the following files are also saved to the selected user's desktop if the related registry keys are present:

_Internet Explorer Connections Key Exported Registry Keys Saved to User's Desktop_

|Description|File Name|
|---|---|
|Connections Key:|{ComputerName}_{UserName}_ HKU_Connections\<YearDayMonth-HourMinute>.REG.txt|
|Connections Key:|{ComputerName}_{UserName}_ HKU_Wow6432Node_Connections\<YearDayMonth-HourMinute >.REG.txt|
|Connections Key:|{ComputerName}_{UserName}_ HKLM_Connections\<YearDayMonth-HourMinute >.REG.txt|
|Connections Key:|{ComputerName}_{UserName}_ HKLM_Wow6432Node_Connections\<YearDayMonth-HourMinute >.REG.txt|
  
## References

For more information, see [Frequently asked questions about the Microsoft Support Diagnostic Tool (MSDT)](https://support.microsoft.com/help/926079).
