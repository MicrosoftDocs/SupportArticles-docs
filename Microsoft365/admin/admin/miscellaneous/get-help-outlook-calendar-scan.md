---
title: Outlook calendar scan with the command line version of Get Help
description: Describes available switches and conditions when using the command line version of Get Help to scan an Outlook calendar.
author: Cloud-Writer    
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User and Domain Management\Manage my users, groups and resources  
  - CSSTroubleshoot
  - CI 10042
ms.reviewer: smogali, spatra
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 03/24/2026
---
# Scenario: Outlook Calendar Scan

> [!NOTE]
> The Outlook Calendar Scan scenario in the command line version of Get Help is not available for new Outlook for Windows.

The Outlook Calendar Scan scenario scans a Microsoft Outlook calendar to identify and report issues that involve general settings such as permissions, free/busy publishing, delegate configuration, and Direct Booking settings.

**Note:** This scenario doesn't require that you use an elevated Command Prompt window.

## Download the command line version of Get Help

Select the following button:

> [!div class="nextstepaction"]
> [Download Command line Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the command line version of Get Help, see [Command line version of Get Help](get-help-command-line-overview.md).

## Available switches for the Outlook Calendar Scan scenario

The following switches are available for this scenario. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Specify this switch and `OutlookCalendarCheckTask` as the value for the `scenarioname` parameter to run this scenario.|Required|
|`-AcceptEula`|Specify this switch to accept the End User License Agreement (EULA) and to run this scenario.|Required|
|`-P <Profile Name>`|Specify this switch and use the `<Profile Name>` parameter to identify the Outlook profile that the scenario has to scan.|Optional|
|`-LogFolder <Output Path>`|Specify this switch to force *GetHelpCmd.exe* to output scenario-specific logs to the folder that's specified by the `<Output Path>` parameter.|Optional|
|`-HideProgress`|Specify this switch to hide the progress display for this scenario. By default, Command line Get Help always displays the progress of tasks in the console.|Optional|

## Sample commands

Here are some sample combinations of switches to run this scenario.

- Sample 1

  To scan a calendar for the active profile in the instance of Outlook that's running, run the following command in a non-elevated Command Prompt window.
  
  **Note:** If Outlook isn't running, the calendar for the default Outlook profile will be scanned.

  ```console
  GetHelpCmd.exe -S OutlookCalendarCheckTask -AcceptEula
  ```

- Sample 2

  To scan a calendar for the profile named *MyProfile* in the instance of Outlook that's running, run the following command in a non-elevated Command Prompt window.

  **Note:**

  - If Outlook is running, and the active profile isn't named *MyProfile*, the scenario will return an error result.
  - If Outlook isn't running, the profile that's named *MyProfile* must exist.

  ```console
  GetHelpCmd.exe -S OutlookCalendarCheckTask -AcceptEula -P MyProfile
  ```

- Sample 3

  To scan a calendar for the active profile in the instance of Outlook that's running, and output log files to the *C:\temp* folder, run the following command in a non-elevated Command Prompt window.

  **Note:** The folder that's specified with the `-LogFolder` switch must exist and be writeable.

  ```console
  GetHelpCmd.exe -S OutlookCalendarCheckTask -AcceptEula -LogFolder C:\temp
  ```

- Sample 4

  To scan a calendar for the profile that's named *MyProfile* in the instance of Outlook that's running, and hide the progress display in the console, run the following command in a non-elevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S OutlookCalendarCheckTask -AcceptEula -P MyProfile -HideProgress
  ```

## Detected conditions and results

When you run the Outlook Calendar Scan scenario by using the command line version of Get Help, you don't receive any prompts. This is a different experience from the full version of Get Help. The following table describes the actions that the command line version of Get Help takes for each condition that's encountered by this scenario, and the corresponding output that's displayed.

|Condition|Action taken by the command line version|Output shown in the Command Prompt window|
|---|---|---|
|Scan completed successfully|Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at *%localappdata%\saralogs\uploadlogs* location.|
|Scan completed successfully by using a custom location (`-LogFolder`)|Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at the location specified by you.|
|The user didn't include the `-AcceptEULA` switch|Exit the scenario|01: Please provide `-AcceptEula` to continue with this scenario. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/get-help-command-line-overview).|
|Outlook isn't installed|Exit the scenario|40: To run diagnostics for this scenario, please download and install Microsoft Outlook. For additional information, please visit [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Can't identify user's profile|Exit the scenario|41: Unable to complete this scenario as Microsoft Outlook profile is missing. For additional information, please visit [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Failure to complete the scenario (for any reason)|Exit the scenario|42: An error occurred while running this scenario. You can also try using the full UI version of Get Help. For additional information, please see this article [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|Current active Outlook profile isn't the same as the profile that's specified by using the `-P` switch|Exit the scenario|44: Unable to complete this scenario because the profile specified using the `-P` switch does not match the profile currently running in Outlook. Please close the Outlook application and try again. For additional information, please see this article [https://aka.ms/SaRA-CalCheckDocs](https://aka.ms/SaRA-CalCheckDocs).|
|An installed version of Outlook isn't detected|Exit the scenario|45: To run diagnostics for this scenario, please download and install Microsoft Outlook.|
