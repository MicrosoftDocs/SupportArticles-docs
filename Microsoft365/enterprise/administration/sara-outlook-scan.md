---
title: Outlook scan with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the command-line version of Microsoft Support and Recovery Assistant to scan Outlook.
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
  - Office 365
search.appverid: MET150
ms.date: 06/09/2022
---
# Scenario: Outlook Scan

Select the appropriate option for a list of the mandatory and optional switches that are available, learn about the conditions under which you'll see messages displayed, and see some sample commands to run this scenario.

**Note** This scenario doesn't require an elevated command prompt.

## Download the command-line version of the Assistant

Download the Assistant by selecting the button below:
> [!div class="nextstepaction"]
> [Download Command-line Assistant](https://aka.ms/SaRA_CommandLineVersionFiles)

For complete details about how to run the command-line version of the Assistant, see [Command-line version of Microsoft Support and Recovery Assistant](./sara-command-line-version.md).

## Available switches

The following switches are available for this scenario. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-LogFolder <Output Path>`| Use the `-LogFolder` switch to force SaraCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|
|`-HideProgress`|The default feature is to always display the progress of the scenario. Use this switch to hide the progress display for the Outlook Scan scenario.|Optional|
|`-OfflineScan`|This switch forces Outlook to be scanned as an Offline scan while the Outlook application is running.|Optional|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here are some sample combinations of switches to run this scenario:

- Sample 1

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula
  ```

- Sample 2

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -OfflineScan -HideProgress
  ```

- Sample 3

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -LogFolder C:\temp
  ```

- Sample 4

  ```console
  SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -LogFolder C:\temp -HideProgress -OfflineScan
  ```

## Detected conditions and Results

When you run a scenario by using the command-line version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the command-line version of the Assistant takes for each condition that's encountered by this scenario, and the corresponding output that it displays.

|Detected condition|Action taken by the command-line version|Output in the Command Prompt window (Results)|
|---|---|---|
|Outlook isn't running|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|More than one Outlook version is detected|Run a scan of the latest version of Outlook|(Depending on the situation, this output could be *01*, *02*, *04*, or *05*)|
|Both Outlook and the Assistant's command prompt are elevated|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running as elevated but the Assistant's Command Prompt window isn't elevated|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook isn't running as elevated but the Assistant's Command Prompt window is elevated|None|*04:* Outlook isn't running elevated. Don't use an elevated command-prompt.|
|Failure to run a scan for reasons such as:<ol><li>Outlook isn't installed</li><li>The Outlook version detected is older than 2007</li><li>An exception occurs during the scan</li></ol>|Scan initiated but not completed|*05:* An error occurred while performing a scan of Outlook. You might be able to perform an Offline scan if you exit Outlook and rerun this scenario. You can also try using the full SaRA version.|

For more information, see [Command-line version of Microsoft Support and Recovery Assistant](./sara-command-line-version.md).
