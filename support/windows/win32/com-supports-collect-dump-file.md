---
title: COM+ supports collect dump file and process termination
description: This article introduces the Microsoft COM+ new functionalities that automatic collection of process dump file and process termination.
ms.date: 6/25/2021
ms.prod-support-area-path: Component development
ms.reviewer: dave.anderson
---
# COM+ in Windows Server supports automatic collection of process dump file and process termination

_Applies to:_ &nbsp; Windows SDK for Windows 10  
_Original KB number:_ &nbsp; 910904

## Introduction

The system logs an event when a COM+ component experiences an unusually high call time. The event log identifies the COM+ component that experiences the problem. Additionally, the event log mentions this article. The system can be configured to perform one or both of these actions:

- Automatically collect a process dump file for root cause analysis of the problem.
- Terminate the process to help recover from the problem without manual intervention.

After the system has collected a dump file, use the [Debug Diagnostics Tool](https://www.microsoft.com/download/details.aspx?id=58210) (DebugDiag) to generate a report that describes the problem and provides known solutions.

## More information

### Default behavior

Consider the following scenario:

- The call time for a COM+ component exceeds 10 minutes.
- You open the Component Services Microsoft Management Console (MMC) snap-in while the application that hosts this long-running COM+ component is running.

In this scenario, the following event is logged in the Application log: **Collect a process dump file**

### Configuration options

> [!IMPORTANT]
> This section involves modifications to the registry. Follow the steps carefully. Serious problems might occur if you modify the registry incorrectly. Back up the registry as a precaution. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

The system can be configured to perform one or both of the following actions when a long-running COM+ component is detected:

- Automatically collect a process dump file.
- Terminate the process.

To do this, use the following registry values:

|Value name|Data type|Description|Default value
|---|---|---|---|
|`AverageCallThreshold`|`REG_DWORD`|Threshold, in seconds, when the appropriate actions will be taken|**0**|
|`DumpType`|`REG_DWORD`|0 = Generate a full dump file; 1 = Generate a minidump file; 2 = No dump file|**0**|
|`Terminate`|`REG_DWORD`|0 = Process will continue; 1 = Process will be terminated|**0**|
|||||

- To globally define actions for all COM+ components on the computer, add the configuration values under the following registry key:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\COM3\AutoDump`

- To define actions to be taken for a specific COM+ component regardless of the global settings, add the configuration values under the following registry key:  
`HKEY_CLASSES_ROOT\AppId\{<YourAppID>}\AutoDump\{<YourCLSID>}`

## Recommendations

### Collect full dump files

Collect a full dump file when a COM+ component experiences an unusually high call time. For example, create the following single registry value:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\COM3\AutoDump AverageCallThreshold = 300`

See the [Considerations](#considerations) section for more information about how to select an appropriate AverageCallThreshold registry value for your particular environment.

Similarly, collect a full dump file when an unhandled exception occurs in a COM+ application. To do so, check the **Enable Image Dump on Application Fault** check box on the **Dump** tab in the properties of each COM+ application.

### Analyze the dump files

Here's how to analyze a dump file:

1. Download and install the appropriate version of the Microsoft Internet Information Services (IIS) Diagnostics Toolkit.

1. Use the Debug Diagnostics Tool of the IIS Diagnostics Toolkit to generate an analysis report for the dump file by following these steps:
    1. Click **Start**, point to **Programs**, point to **IIS Diagnostics (32 bit)**, point to **Debug Diagnostics Tool**, and then click **Debug Diagnostics Tool 1.0**.
    1. If the **Select Rule Type** dialog box opens, click **Cancel**.
    1. On the **Tools** menu, click **Options And Settings**.
    1. Click the **Folders and Search Paths** tab.
    1. In the **Symbol Search Path For Analysis** box, type `srv*C:\symbols\*http://msdl.microsoft.com/download/symbols`.
    1. Click the **Advanced Analysis** tab.
    1. In the **Available Analysis Scripts** list, click **IISAnalysis.asp**.
    1. Click **Add Data Files**.
    1. Select the dump file that you want to analyze, and click **OK**.
    1. Click **Start Analysis**.

    The resulting HTML report is displayed in a new Microsoft Internet Explorer window on the desktop and saved to the DebugDiag Reports directory. The default location for this directory is *C:\Program Files\IIS Resources\DebugDiag\Reports*.

1. To resolve the problem, follow the guidance that is provided in the [Recommendation](#recommendation) section of the report. This section of the report may recommend the following things:
    - It may direct you to a Microsoft Knowledge Base article that describes known issues.
    - It may provide the developers of the application with information that they can use to make corrections.
    - It may suggest that you follow up with the appropriate vendor or with Microsoft Support. When you contact Microsoft Support for more help, provide the report file to speed the analysis process. The full dump file might also be required.

## Considerations

### AverageCallThreshold registry value

A value of 300 seconds is an appropriate threshold for most environments. The ideal value depends on the particular environment. To ensure action is taken as quickly as possible, but only when a legitimate problem occurs, select the smallest possible value that is exceeded only in a problematic scenario.

### TerminateProcess registry value

Terminating the process when high call times occur may help the COM+ component to automatically recover from certain problems. This is desirable in environments where high availability is important. When using this feature, select an appropriate `AverageCallThreshold` registry value to avoid unintentionally terminating the process.

### DumpType registry value

Minidump files can be created faster and occupy less disk space than full dump files. However, they aren't as useful to analyze problems because they frequently lack the required data. The typical size of full dump files for a *Dllhost.exe* process ranges from 10 megabytes (MB) to 50 MB. Their actual size depends on the size of the working set of the dumped process. The files are normally generated within seconds.

### Dump file options

By default, the dump files are stored in the *%systemroot%\system32\com\dmp* directory. Use the settings in the **Image Dump Directory** box and under the **Maximum Number of Dump Images** area for the appropriate COM+ application to control the location and the number of dump files.

### Call time

The call time for a COM+ component is a running average for all instances of the COM+ component. The call time is calculated by the COM+ System Application and is displayed in the **Call Time (ms)** column of the Status View in the Component Services MMC snap-in.
