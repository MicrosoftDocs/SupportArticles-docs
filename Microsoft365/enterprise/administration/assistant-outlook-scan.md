---
title: Outlook scan with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant to scan Outlook.
author: helenclu    
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: zebamehdi; brandisi
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 10/25/2022
---
# Scenario: Outlook Scan

The Outlook Scan scenario scans and creates a detailed report of Outlook, Office, Windows and mailbox configurations.

In the full version of the Assistant, the equivalent scenario entry point is *Advanced diagnostics \ Outlook \ Create a detailed report of my Outlook, Office, Windows, and mailbox configuration*.

**Note** This scenario doesn't require an elevated command prompt.

## Download the Assistant

Download the Assistant by selecting the button below:

> [!div class="nextstepaction"]
> [Download the Assistant (Enterprise version)](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the Enterprise version of the Assistant, see [Enterprise version of Microsoft Support and Recovery Assistant](sara-command-line-version.md).

## Available switches for this scenario

The following switches are available for this scenario. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Outlook Scan scenario, use `ExpertExperienceAdminTask` as the value of `scenarioname`.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-LogFolder <Output Path>`|The `-LogFolder` switch forces *SaraCmd.exe* to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|
|`-HideProgress`|The `-HideProgress` switch hides the progress display for this scenario. The default feature of the Assistant is to always display the progress of tasks in the console.|Optional|
|`-OfflineScan`|This switch forces Outlook to be scanned as an offline scan while the Outlook application is running.|Optional|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for *SaRAcmd.exe*. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here are some sample combinations of switches to run this scenario:

- Sample 1

  To scan Outlook, run the following command from a non-elevated command prompt.

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula
  ```

- Sample 2

  To scan Outlook in an offline mode when the Outlook application is running and hide the progress display in the console, run the following command from a non-elevated command prompt.

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -OfflineScan -HideProgress
  ```

- Sample 3

  To scan Outlook and output log files to the *C:\temp* folder, run the following command from a non-elevated command prompt.

  **Note** The folder that's specified with the `-LogFolder` switch must exist and be writeable.

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -LogFolder C:\temp
  ```

- Sample 4 (all optional switches are used)

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -LogFolder C:\temp -HideProgress -OfflineScan
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

|Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
|---|---|---|
|Outlook isn't running|Run an Offline scan of Outlook|01: An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running|Run a full scan of Outlook|02: A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|More than one Outlook version is detected|Run a scan of the latest version of Outlook|(Depending on the situation, this output could be *01*, *02*, *04*, or *05*)|
|Both Outlook and the Assistant's command prompt are elevated|Run a full scan of Outlook|02: A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running as elevated but the Assistant's Command Prompt window isn't elevated|Run an offline scan of Outlook|01: An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook isn't running as elevated but the Assistant's Command Prompt window is elevated|None|04: Outlook isn't running elevated. Don't use an elevated command-prompt.|
|Failure to run a scan for reasons such as:<ol><li>Outlook isn't installed.</li><li>The Outlook version detected is older than 2007.</li><li>An exception occurs during the scan.</li></ol>|Scan initiated but not completed|05: An error occurred while performing a scan of Outlook. You might be able to perform an Offline scan if you exit Outlook and rerun this scenario. You can also try using the full SaRA version.|
