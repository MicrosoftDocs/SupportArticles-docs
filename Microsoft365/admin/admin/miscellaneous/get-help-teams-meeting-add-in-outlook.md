---
title: Fix Teams meeting add-in for Outlook issues with the command line version of Get Help
description: Describes available switches and conditions when using the command line version of Get Help to fix Teams meeting add-in issues in Outlook.
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
# Scenario: Teams Meeting Add-in for Outlook

The Teams Meeting Add-in for Outlook scenario automates all the check and recovery actions (except the two checks under [Verify registry settings](/microsoftteams/troubleshoot/meetings/resolve-teams-meeting-add-in-issues#verify-registry-settings)) that are described in [Resolve issues that affect the Teams Meeting add-in for classic Outlook](/microsoftteams/troubleshoot/meetings/resolve-teams-meeting-add-in-issues).

**Note:** This scenario doesn't require that you use an elevated Command Prompt window.

## Download the command line version of Get Help

Select the following button:

> [!div class="nextstepaction"]
> [Download Command line Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the command line version of Get Help, see [Command line version of Get Help](get-help-command-line-overview.md).

## Available switches for the Teams Meeting Add-in for Outlook scenario

The following switches are available for this scenario. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Specify this switch and `OfficeSharedComputerScenario` as the value of the `scenarioname` parameter to run this scenario.|Required|
|`-AcceptEula`|Specify this switch to accept the End User License Agreement (EULA) and to run this scenario.|Required|
|`-CloseOutlook`|Specify this switch to close Outlook if it's running.|Required|

## Sample commands

Here's a sample combination of switches to run this scenario:

- To resolve issues that affect the Teams meeting add-in for Outlook, run the following command in a nonelevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S TeamsAddinScenario -AcceptEula -CloseOutlook
  ```

## Detected conditions and results

When you run the Teams Meeting Add-in for Outlook scenario by using the command line version of Get Help, you don't receive any prompts. This is a different experience from the full version of Get Help. The following table describes the actions that the command line version of Get Help takes for each condition that is encountered in this scenario, and the corresponding output that is displayed.

|Condition|Action taken by the command line version|Output shown in the Command Prompt window|
|---|---|---|
|Scan completed successfully|None|00: Scenario completed successfully. Please exit and restart Outlook.|
|The user didn't include the `-CloseOutlook` switch|Exit the scenario|01: This scenario requires the `-CloseOutlook` switch. Note, if Outlook is running, the `-CloseOutlook` switch closes Outlook. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/get-help-command-line-overview).|
|The user didn't include the `-AcceptEula` switch|Exit the scenario|01: Please provide `-AcceptEula` to continue with this scenario. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/get-help-command-line-overview).|
|Teams isn't installed|Exit the scenario|20: Could not find an installed version of Teams. Please see [https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b](https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b).|
|Outlook 2013 or later isn't installed|Exit the scenario|21: Could not find an installed version of Outlook 2013, or later. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032).|
|Windows 7 user doesn't have the [Update for Universal C Runtime in Windows](https://support.microsoft.com/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c) installed|Exit the scenario|22: Prerequisites not met. Update from KB2999226 needs to be installed. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032)|
|Registry issues detected: <br/><br/>LoadBehavior<>3 or add-in listed under the `DisabledItems` key or `TeamsAddin.Connect`<>1 under the `DoNotDisableAddinList` key|Run the registry recovery action, and then exit the scenario.|23: The registry was updated to address missing or incorrect values. Please exit and restart Outlook.<br/><br/>17: An error occurred while running this scenario. You can also try using the full version of Get Help.|
|None of the listed conditions were detected|Run the re-register dll recovery action, and then exit the scenario.|24: The Microsoft.Teams.AddinLoader.dll was re-registered. Please exit and restart Teams. Then, exit and restart Outlook.|
|Failure to complete the scenario (for any reason)|Exit the scenario|17: An error occurred while running this scenario. You can also try using the full version of Get Help.|
