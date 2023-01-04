---
title: Microsoft Support and Recovery Assistant Enterprise version
description: Describes the Enterprise version of Microsoft Support and Recovery Assistant.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 148047
  - CSSTroubleshoot
  - CI 163053
ms.reviewer: gregmans; zebamehdi
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 10/26/2022
---
# Enterprise version of Microsoft Support and Recovery Assistant

> [!NOTE]
> This article is for Microsoft 365 administrators only. For help to diagnose and fix issues that affect Office, Microsoft 365 or Outlook on your computer, see [About the Microsoft Support and Recovery Assistant](https://aka.ms/SaRA_Home).

The Enterprise version of Microsoft Support and Recovery Assistant is a self-contained, enterprise-ready diagnostic tool that you can use to troubleshoot specific client issues that affect Microsoft 365 apps, such as Microsoft Teams and Microsoft Outlook. This version of the Assistant runs at a command line or through a script such as PowerShell. Administrators will find this version of the Assistant useful when they have to run it on computers in their organization remotely.

To fix issues on a single computer, we recommend that you use the [full version of the Assistant](https://aka.ms/SaRA_Home). If multiple devices are affected by an issue, use the Enterprise version of the Assistant.

## Supported scenarios

You can use the Enterprise version of the Assistant to resolve issues for the following scenarios. Select a scenario for details about how to run it.

|Scenario|Description|\<Scenarioname\>|
|---|---|---|
|[Outlook Scan](assistant-outlook-scan.md)|Scans Outlook for known issues and generates a comprehensive configuration report for Outlook, Office, and Windows. A full or offline scan can be run.|`ExpertExperienceAdminTask`|
|[Office Uninstall](assistant-office-uninstall.md)|Scrubs any version of Office from a device. Use when you can't fully remove Office through Control Panel.|`OfficeScrubScenario`|
|[Office Activation](assistant-office-activation.md)|Automated checks and recoveries to reset activation-related settings so you can successfully activate a subscription version of Office.|`OfficeActivationScenario`|
|[Office Shared Computer Activation](assistant-office-shared-computer-activation.md)|Automated checks and recoveries to either enable or disable Office Shared Computer Activation.|`OfficeSharedComputerScenario`|
|[Outlook Calendar Scan](assistant-outlook-calendar-scan.md)|Scans your Outlook calendar with the Calendar Checking tool (CalCheck) for dozens of known problems.|`OutlookCalendarCheckTask`|
|[Teams Meeting Add-in for Outlook](assistant-teams-meeting-add-in-outlook.md)|Automated checks and recoveries to help you get the Teams Meeting Add-in for Outlook up and running.|`TeamsAddinScenario`|
|[Reset Office Activation](assistant-reset-office-activation.md)|Clear prior activations of Microsoft 365 Apps for Enterprise to remove related licenses and cached Office account information. This resets Office applications to a clean state and you can then activate them with a different Office account or change to a different license mode.|`ResetOfficeActivation`|

## Download and run the Enterprise version of the Assistant

1. Download the Assistant by selecting the following button.
   > [!div class="nextstepaction"]
   > [Download the Assistant](https://aka.ms/SaRA_EnterpriseVersionFiles)
1. In the downloaded *.zip* file, extract the files to a folder that you can access from the user's computer on which you'll run the Assistant.
1. On the user's computer, select **Start**, enter *cmd*, and then press Enter to open a Command Prompt window.

   **Note:** If the scenario that you want to run requires an elevated Command Prompt window, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

1. At the command prompt, navigate to the folder in which you extracted the files from step 2.
1. Run the Assistant by using the appropriate switches for the scenario.

> [!IMPORTANT]
> Updates to the Enterprise version of the Assistant are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application will stop working 90 days after the **Created** date that's listed for the SaRAcmd.exe file. Use the link that's provided in step 1 to always download the latest version available.

## Scripting the Enterprise version of the Assistant

Because the Enterprise version of the Assistant is a command-line executable, it can be scripted to simplify the experience and add functionality not built directly into the Assistant. To give you some ideas on how to script the Assistant, we’ve created several sample Windows PowerShell scripts for you to try and hopefully to modify to better fit your company’s workflows.

> [!NOTE]
> Detailed instructions for each script are provided in the comments included with the scripts.

Both of the following sample scripts provide the following basic capabilities:

1. Copy SaRA Enterprise files to the client from the location specified in the script

   The default download location referenced in the script is https://aka.ms/SaRA_EnterpriseVersionFiles, which is the Internet download location for the Assistant. However, you can modify the script to use either a path to the .zip file for the Assistant download or a folder location containing the files extracted from the Assistant download.

2. Gather log files generated during the scenario

   The script collects all log files generated by the Assistant.

3. Create a consolidated zip file with all of the logs

   All of the log files generated by the Assistant are then compressed into a zip file, whose name is customizable.

The sample scripts also provide capabilities that differ between the scripts.

### Example 1: Non-interactive session

[Download the non-interactive session script](https://aka.ms/SaRAEnterpriseHelper)

This script provides the following additional capability:

 - Launch SaraCmd.exe to run the specified scenario with the specified switches and parameters
  
   You will need to update the script to include the switches and parameters required to run the desired scenario. The script contains examples for each scenario.

### Example 2: Interactive session

[Download the interactive session script](https://aka.ms/SaRAEnterpriseInteractiveHelper)

This script provides the following additional capabilities:

 - Prompt for the scenario to be run by the Assistant
   
   By default, you do not need to modify the script with any switches or parameters. When the script is run, you are prompted to enter the name of the scenario that you want the script to execute.
 - Launch SaraCmd.exe to run the specified scenario with the specified switches and parameters
   
   After the scenario name is entered at the prompt, the script executes the scenario with the minimum required switches and parameters. Note, if desired, you can modify the script to use optional switches and parameters.
 - Create a draft email message for unsuccessful sessions
   
   Optionally, if the Assistant is unable to successfully complete a scenario, a draft email message is opened with the zip file, containing all of the session logs, attached to the email message.

   Note, to implement this feature, you need to update the script with an email address, message subject, and message body.

## Switches available for all scenarios

The following switches are available for the Enterprise version of the Assistant. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|Applicable scenarios|
|---|---|---|---|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use the `-?` switch together with other switches, it will override the other switches.|Optional|All|
|`-Help`|The `-Help` switch displays a link to online content for more information. If you use the `-Help` switch together with other switches, it will override all the others except the `-?` switch.|Optional|All|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the End User License Agreement (EULA). You can save the EULA text to a file by specifying a path to the file by using the switch. If you use the `-DisplayEULA` switch together with other switches, it will override the other switches. |Optional|All|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run.|Required|All|
|`-AcceptEula`|Use the `-AcceptEula` switch to accept the EULA. This is required before a scenario can be run.|Required|All|
|`-LogFolder <Output Path>`| Use the `-LogFolder` switch to force SaraCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-HideProgress`|By default, the Assistant always displays the progress of the scenario. Use `-HideProgress` switch to hide the progress display for the listed scenarios.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-OfflineScan`|Use the `-OfflineScan` switch to specify an offline scan of Outlook while the Outlook application is running.|Optional|`ExpertExperienceAdminTask`|
|`-OfficeVersion`|Use the `-OfficeVersion` switch to remove only the Office version that's specified by the `<version>` parameter. If you use **All** as a parameter, all Office versions will be removed from the computer.|Optional|`OfficeScrubScenario`|
|`-RemoveSCA`|Use the `-RemoveSCA` switch to remove Shared Computer Activation (SCA) and to configure non-SCA activation for Office.|Optional|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`|
|`-CloseOffice`|Use the `-CloseOffice` switch to close all Office apps that are open.|Required|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`<br/>`ResetOfficeActivation`|
|`-CloseOutlook`|Use the `-CloseOutlook` switch to close Outlook if it's open.|Required|`TeamsAddinScenario`|
|`-P <profile name>`|Use the `-P` switch together with the \<Profile name\> parameter to specify the Outlook profile that you want the `OutlookCalendarCheckTask` scenario to scan.|Optional|`OutlookCalendarCheckTask`|

## Version history of the Enterprise version of the Assistant

Throughout the year, a new build of the Enterprise version of the Assistant is available through the download link that's provided in [Download and run the command-line version of the Assistant](#download-and-run-the-enterprise-version-of-the-assistant). Because each build stops working after 90 days, we recommend that you keep the Assistant updated by replacing your existing files with the latest version files.

The following table provides the versions of the Enterprise version of the Assistant that were made available on the specified date.

|Release date|Version|
|----------|-----------|
|October 28, 2022|17.00.9246.000 |
|September 13, 2022|17.00.9001.001 |
|July 8, 2022|17.00.8713.001 |
|May 18, 2022|17.00.8433.005 |
|April 7, 2022|17.00.8256.000|
|February 8, 2022|17.00.7971.000|
|November 9, 2021|17.00.7513.000|
|May 26, 2021|17.00.6665.000|
