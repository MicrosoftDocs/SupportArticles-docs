---
title: Outlook calendar scan with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant to scan Outlook calendar.
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
# Scenario: Outlook Calendar Scan

The Outlook Calendar Scan scenario scans an Outlook calendar to identify and report issues such as permissions, free or busy publishing, delegate configuration, and automatic booking. For more information, see [Scan Outlook calendar by using Microsoft Support and Recovery Assistant](/outlook/troubleshoot/calendaring/scan-outlook-calendar-using-sara).

In the full version of the Assistant, the equivalent scene entry point is *Advanced diagnostics \ Outlook \ Create a detailed scan of my Outlook Calendar to identify and resolve issues*.

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
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Outlook Calendar Scan scenario, use `OutlookCalendarCheckTask` as the value of `scenarioname`.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-P <Profile Name>`|`Profile Name` identifies the Outlook profile that's scanned by the scenario.|Optional|
|`-LogFolder <Output Path>`|The `-LogFolder` switch forces *SaraCmd.exe* to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|
|`-HideProgress`|The `-HideProgress` switch hides the progress display for these scenarios. The default feature of the Assistant is to always display the progress of tasks in the console.|Optional|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for *SaRAcmd.exe*. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here is a sample combination of switches to run this scenario:

- Sample 1

  To scan a calendar for the profile that's used in the open instance of Outlook, run the following command from a non-elevated command prompt.
  
  **Note** If Outlook isn't running, the calendar for the default Outlook profile will be scanned.

  ```console
  SaRAcmd.exe -S OutlookCalendarCheckTask -AcceptEula
  ```

- Sample 2

  To scan a calendar for the profile called *MyProfile* that's used for the running instance of Outlook, run the following command from a non-elevated command prompt.

  > [!NOTE]
  >
  > - If Outlook is running and the active profile isn't called *MyProfile*, the scenario will return an error result.
  > - If Outlook isn't running, the profile called *MyProfile* must exist.

  ```console
  SaRAcmd.exe -S OutlookCalendarCheckTask -AcceptEula -P MyProfile
  ```

- Sample 3

  To scan a calendar for the profile that's used in the open instance of Outlook and output log files to the *C:\temp* folder, run the following command from a non-elevated command prompt.

  **Note** The folder that's specified with the `-LogFolder` switch must exist and be writeable.

  ```console
  SaRAcmd.exe -S OutlookCalendarCheckTask -AcceptEula -LogFolder C:\temp
  ```

- Sample 4

  To scan a calendar for the profile called *MyProfile* that's used for the running instance of Outlook and hide the progress display in the console, run the following command from a non-elevated command prompt.

  ```console
  SaRAcmd.exe -S OutlookCalendarCheckTask -AcceptEula -P MyProfile -HideProgress
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

|Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
|---|---|---|
|Scan completed successfully|Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at *%localappdata%\saralogs\uploadlogs* location.|
|Scan completed successfully with custom location (`-LogFolder`)|Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at the location specified by you.|
|User doesn't include the `-AcceptEULA` switch|Exit the scenario|01: Please provide `-AcceptEula` to continue with this scenario. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
|Outlook isn't installed|Exit the scenario|40: To run diagnostics for this scenario, please download and install Microsoft Outlook. For additional information, please visit [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Unable to identify user's profile|Exit the scenario|41: Unable to complete this scenario as Microsoft Outlook profile is missing. For additional information, please visit [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Failure to complete the scenario (for any reason)|Exit the scenario|42: An error occurred while running this scenario. You can also try using the full SaRA version. For additional information, please see this article [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Current active Outlook profile isn't the same as the profile specified with the `-P` switch|Exit the scenario|44: Unable to complete this scenario because the profile specified using the `-P` switch does not match the profile currently running in Outlook. Please close the Outlook application and try again. For additional information, please see this article [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|An installed version of Outlook isn't detected|Exit the scenario|45: To run diagnostics for this scenario, please download and install Microsoft Outlook.|
