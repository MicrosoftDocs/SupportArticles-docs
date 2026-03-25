---
title: Command line version of Get Help
description: Describes the command line version of Get Help, historically known as SaRA.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:User and Domain Management\Manage my users, groups and resources 
  - CI 10042
  - CSSTroubleshoot
ms.reviewer: smogali, spatra
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 03/24/2026
---
# Command line version of Get Help

> [!NOTE]  
> Microsoft and Recovery Assistant is deprecated. You can use the command line version of Get Help for all the tasks that you previously completed by using the Assistant.
> This article is for Microsoft 365 administrators only. For help to diagnose and fix issues that affect Microsoft Office, Microsoft 365, or Microsoft Outlook on your computer, you can [run troubleshooters in the full version of Get Help](https://support.microsoft.com/windows/running-troubleshooters-in-get-help-23bddffd-5495-47f6-a419-7efe166bf1a8).

The command line version of Get Help is a self-contained, enterprise-ready diagnostic tool that you can use to troubleshoot specific client issues that affect Microsoft 365 apps, such as Microsoft Teams and Outlook. This version of Get Help can run both at a command line and through a script such as PowerShell. It is particularly useful to run remotely on computers in your organization.

To resolve issues on a single computer, we recommend that you use the [full version of Get Help](https://aka.ms/SaRA_Home). If multiple devices are affected, use the command line version of Get Help.

## Supported scenarios

You can use the command line version of Get Help to resolve issues for the following scenarios. Select a scenario for details about how to run it.

> [!NOTE]
> The scenarios that are supported by the command line version of Get Help aren't available for new Outlook and new Teams.

|Scenario|Description|\<Scenarioname\>|
|---|---|---|
|[Outlook Scan](get-help-outlook-scan.md)|Scans Outlook for known issues and generates a comprehensive configuration report for Outlook, Office, and Windows. You can run either a full or an offline scan.|`ExpertExperienceAdminTask`|
|[Office Uninstall](get-help-office-uninstall.md)|Scrubs any version of Office from a device. Use when you can't fully remove Office through Control Panel.|`OfficeScrubScenario`|
|[Office Activation](get-help-office-activation.md)|Automates checks and recoveries to reset activation-related settings so that you can successfully activate a subscription version of Office.|`OfficeActivationScenario`|
|[Office Shared Computer Activation](get-help-office-shared-computer-activation.md)|Automates checks and recoveries to either enable or disable Office Shared Computer Activation.|`OfficeSharedComputerScenario`|
|[Outlook Calendar Scan](get-help-outlook-calendar-scan.md)|Scans your Outlook calendar by using the Calendar Checking tool (CalCheck) for many known issues.|`OutlookCalendarCheckTask`|
|[Teams Meeting Add-in for Outlook](get-help-teams-meeting-add-in-outlook.md)|Automates checks and recoveries to help you get the Teams Meeting add-in for Outlook running.|`TeamsAddinScenario`|
|[Reset Office Activation](get-help-reset-office-activation.md)|Clears previous activations of Microsoft 365 Apps for Enterprise to remove related licenses and cached Office account information. This action resets Office applications to a clean state. Then, you can activate the applications by using a different Office account or change to a different license mode.|`ResetOfficeActivation`|

## Download and run the command line version of Get Help

1. Download command line Get Help by selecting the following button.
   > [!div class="nextstepaction"]
   > [Download Command line Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles)
1. In the downloaded *.zip* file, extract the files to a folder that you can access from the user's computer on which you'll run Get Help.
1. On the user's computer, select **Start**, enter *cmd*, and then press Enter to open a Command Prompt window.

   **Note:** If the scenario that you want to run requires an elevated Command Prompt window, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

1. At the command prompt, navigate to the folder in which you extracted the files from step 2.
1. Run Get Help by using the appropriate switches for the scenario.

> [!IMPORTANT]  
> Updates to the command line version of Get Help are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application stops working 90 days after the **Created** date that's listed for the GetHelpCmd.exe file. Use the link that's provided in step 1 to always download the latest available version.

## Script the command line version of Get Help

You can script the command line version of Get Help to simplify the experience and add functionality. The following sample scripts can help you get started. These scripts provide different capabilities.

**Note**: Detailed instructions for each script are provided in the included comments.

Both sample scripts perform the following basic tasks:

1. Copy the files for the command line version of Get Help from the location that's specified in the script to the client.

   The script uses the internet download location for the [command line version of Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles) as the default option. However, you can modify the script to use either a path to the .zip file for the Get Help download or a folder location that contains the files that are extracted from the Get Help download.

2. Gather log files that are generated when a scenario is run.

   The script collects all the log files that are generated by the command line version of Get Help.

3. Create a consolidated .zip file that includes all the logs.

   All the log files that are generated by the command line version of Get Help are compressed into a .zip file. You can customize the name of this .zip file.

### Sample 1: Script to run a non-interactive session

[Download the script for a non-interactive session](https://aka.ms/SaRAEnterpriseHelper)

This script provides the following additional capability:

 - Start GetHelpCmd.exe to run the specified scenario by using the switches and parameters that are provided.
  
   You have to update the script to include the switches and parameters that are required to run a specific scenario, and then run it. The script contains examples for each scenario.

### Sample 2: Script to run an interactive session

[Download the script for an interactive session](https://aka.ms/SaRAEnterpriseInteractiveHelper)

This script provides the following additional capabilities:

 - Prompt for the scenario that Get Help needs to run.

   By default, you don't have to modify the script to include any switches or parameters for a specific scenario. When the script is run, you're prompted to enter the name of the scenario.

 - Start GetHelpCmd.exe to run the specified scenario by using the specified switches and parameters.

   After the scenario name is entered at the prompt, the script runs the scenario by using the minimum required switches and parameters. However, you can modify the script to use optional switches and parameters based on your requirements.

 - Create a draft email message for unsuccessful sessions.

   If Get Help can't successfully complete a scenario, a draft email message is created that includes a .zip file attachment that contains all the session logs.

   **Note**: To use this capability, you have to update the script to include an email address, message subject, and message body.

### Sample 3: Script to run back-to-back scenarios

[Download the script for back-to-back scenarios](https://aka.ms/SaRAEnterpriseMultiScenarioHelper)

This script provides the following additional capabilities:

 - Allows you to specify two scenarios to run one after the other.

   **Note**: The script contains the list of supported scenario pairs.

 - Start GetHelpCmd.exe to run the first scenario.

 - When the first scenario is finished, run a second scenario if the result code from the first scenario indicates a successful completion.

## Switches available for all scenarios

The following switches are available for the command line version of Get Help. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|Applicable scenarios|
|---|---|---|---|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for GetHelpCmd.exe. If you use the `-?` switch together with other switches, it will override the other switches.|Optional|All|
|`-Help`|The `-Help` switch displays a link to online content for more information. If you use the `-Help` switch together with other switches, it will override all the others except the `-?` switch.|Optional|All|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the End User License Agreement (EULA). You can save the EULA text to a file by specifying a path to the file by using the switch. If you use the `-DisplayEULA` switch together with other switches, it will override the other switches. |Optional|All|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run.|Required|All|
|`-AcceptEula`|Use the `-AcceptEula` switch to accept the EULA. This is required before a scenario can be run.|Required|All|
|`-LogFolder <Output Path>`| Use the `-LogFolder` switch to force GetHelpCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-HideProgress`|By default, Get help always displays the progress of the scenario. Use `-HideProgress` switch to hide the progress display for the listed scenarios.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-OfflineScan`|Use the `-OfflineScan` switch to specify an offline scan of Outlook while the Outlook application is running.|Optional|`ExpertExperienceAdminTask`|
|`-OfficeVersion`|Use the `-OfficeVersion` switch to remove only the Office version that's specified by the `<version>` parameter. If you use **All** as a parameter, all Office versions will be removed from the computer.|Optional|`OfficeScrubScenario`|
|`-RemoveSCA`|Use the `-RemoveSCA` switch to remove Shared Computer Activation (SCA) and to configure non-SCA activation for Office.|Optional|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`|
|`-CloseOffice`|Use the `-CloseOffice` switch to close all Office apps that are open.|Required|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`<br/>`ResetOfficeActivation`|
|`-CloseOutlook`|Use the `-CloseOutlook` switch to close Outlook if it's open.|Required|`TeamsAddinScenario`|
|`-P <profile name>`|Use the `-P` switch together with the \<Profile name\> parameter to specify the Outlook profile that you want the `OutlookCalendarCheckTask` scenario to scan.|Optional|`OutlookCalendarCheckTask`|
