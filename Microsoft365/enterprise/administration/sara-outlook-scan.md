---
title: Outlook san with Microsoft Support and Recovery Assistant
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
# Scenario: Outlook Scan (ExpertExperienceAdminTask)

Select the appropriate option for a list of the mandatory and optional switches that are available, learn about the conditions under which you will see messages displayed, and see some sample commands to run this scenario.

## Available switches

The following switches are available for this scenario. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario.

1. `-S <scenarioname>`

   Use the `-S` switch to specify the scenario that you want to run. The switch can't be run on its own. It must be followed by `-AcceptEula`.
1. `-AcceptEula`

   The End User License Agreement (EULA) must be accepted before a scenario can be run.
1. `-DisplayEULA <path_to_file>` (Optional)

   Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.
1. `-LogFolder <Output Path>` (Optional)

   Use the `-LogFolder` switch to force SaraCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.
1. `-HideProgress` (Optional)
  
   The default feature is to always display the progress of the scenario. Use this switch to hide the progress display for the Outlook Scan scenario.
1. `-OfflineScan` (Optional)
  
    This switch forces Outlook to be scanned as an Offline scan while the Outlook application is running.
1. `-Help`

    The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.
1. `-?`

    Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use the `-?` switch along with other switches, it will override the others.

## Conditions

When you run a scenario by using the command-line version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the command-line version of the Assistant takes for each condition, and the corresponding output that it displays.

|Condition|Action taken by the command-line version|Output in the Command Prompt window|
|---|---|---|
|Outlook isn't running|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|More than one Outlook version is detected|Run a scan of the latest version of Outlook|(Depending on the situation, this output could be *01*, *02*, *04*, or *05*)|
|Both Outlook and the Assistant's command prompt are elevated|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook is running as elevated but the Assistant's Command Prompt window isn't elevated|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename\> in *%localappdata%\saralogs\UploadLogs*.|
|Outlook isn't running as elevated but the Assistant's Command Prompt window is elevated|None|*04:* Outlook isn't running elevated. Don't use an elevated command-prompt.|
|Failure to run a scan for reasons such as:<ol><li>Outlook isn't installed</li><li>The Outlook version detected is older than 2007</li><li>An exception occurs during the scan</li></ol>|Scan initiated but not completed|*05:* An error occurred while performing a scan of Outlook. You might be able to perform an Offline scan if you exit Outlook and rerun this scenario. You can also try using the full SaRA version.|

## Sample commands

Here are some sample combinations of switches to run this scenario:

- Sample 1 `SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula`
- Sample 2 `SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula -OfflineScan`

[Run the Outlook Scan scenario](./sara-command-line-version.md#download-and-run-the-command-line-version-of-the-assistant)