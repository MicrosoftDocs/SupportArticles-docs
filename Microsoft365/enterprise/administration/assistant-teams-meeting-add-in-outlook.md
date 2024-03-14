---
title: Fix Teams meeting add-in for Outlook issues with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the Enterprise version of Microsoft Support and Recovery Assistant to fix Teams meeting add-in for Outlook issues.
author: helenclu    
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: gregmans; zebamehdi
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 03/14/2024
---
# Scenario: Teams Meeting Add-in for Outlook

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../../includes/sara-note-new-teams.md)]

The Teams Meeting Add-in for Outlook scenario automates all the check and recovery actions (except the two checks under [Check policies](/microsoftteams/troubleshoot/meetings/resolve-teams-meeting-add-in-issues#check-policies)) that are described and provided in [Resolve issues with Teams Meeting add-in for Outlook](/microsoftteams/troubleshoot/meetings/resolve-teams-meeting-add-in-issues).

In the full version of the Microsoft Support and Recovery Assistant Assistant, the equivalent entry point for this scenario is *Teams \ The Teams meeting option isn't shown or the Teams Meeting add-in doesn't load in Outlook*.

**Note:** This scenario doesn't require that you use an elevated Command Prompt window.

## Download the Enterprise version of the Assistant

Select the following button:

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the Enterprise version of the Assistant, see [Enterprise version of Microsoft Support and Recovery Assistant](sara-command-line-version.md).

## Available switches for the Teams Meeting Add-in for Outlook scenario

The following switches are available for this scenario. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Specify this switch and `OfficeSharedComputerScenario` as the value of the `scenarioname` parameter to run this scenario.|Required|
|`-AcceptEula`|Specify this switch to accept the End User License Agreement (EULA) and to run this scenario.|Required|
|`-CloseOutlook`|Specify this switch to close Outlook if it's running.|Required|

## Sample commands

Here's a sample combination of switches to run this scenario:

- To resolve issues that affect the Teams meeting add-in for Outlook, run the following command in a non-elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S TeamsAddinScenario -AcceptEula -CloseOutlook
  ```

## Detected conditions and results

When you run the Teams Meeting Add-in for Outlook scenario by using the Enterprise version of the Assistant, you don't receive any prompts. This is a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition that's encountered by this scenario, and the corresponding output that's displayed.

|Condition|Action taken by the Enterprise version|Output shown in the Command Prompt window|
|---|---|---|
|Scan completed successfully|None|00: Scenario completed successfully. Please exit and restart Outlook.|
|The user didn't include the `-CloseOutlook` switch|Exit the scenario|01: This scenario requires the `-CloseOutlook` switch. Note, if Outlook is running, the `-CloseOutlook` switch closes Outlook. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion) |
|The user didn't include the `-AcceptEula` switch|Exit the scenario|01: Please provide `-AcceptEula` to continue with this scenario. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion) |
|Teams isn't installed|Exit the scenario|20: Could not find an installed version of Teams. Please see [https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b](https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b)|
|Outlook 2013 or later isn't installed|Exit the scenario|21: Could not find an installed version of Outlook 2013, or later. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032) |
|Windows 7 user doesn't have the [Update for Universal C Runtime in Windows](https://support.microsoft.com/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c) installed|Exit the scenario| 22: Pre-requisites not met. Update from KB2999226 needs to be installed. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032)|
|Registry issues detected: <br/><br/>LoadBehavior<>3 or add-in listed under the `DisabledItems` key or TeamsAddin.Connect<>1 under the `DoNotDisableAddinList` key|Run the registry recovery action, and then exit the scenario.|23: The registry was updated to address missing or incorrect values. Please exit and restart Outlook.<br/><br/>17: An error occurred while running this scenario. You can also try using the full SaRA version.|
|None of the listed conditions were detected| Run the re-register dll recovery action, and then exit the scenario.|24: The Microsoft.Teams.AddinLoader.dll was re-registered. Please exit and restart Teams. Then, exit and restart Outlook.|
|Failure to complete the scenario (for any reason)|Exit the scenario|17: An error occurred while running this scenario. You can also try using the full SaRA version.|
