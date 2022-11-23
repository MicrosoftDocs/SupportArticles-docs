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
ms.reviewer: zebamehdi; gregmans
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 10/26/2022
---
# Enterprise version of Microsoft Support and Recovery Assistant

> [!NOTE]
> This article is for Microsoft 365 administrators only. For help to diagnose and fix issues with Office, Microsoft 365 or Outlook on your computer, see [About the Microsoft Support and Recovery Assistant](https://aka.ms/SaRA_Home).

The Enterprise version of Microsoft Support and Recovery Assistant is a self-contained enterprise-ready diagnostic tool that you can use to troubleshoot specific client issues with Office, Teams, Outlook or through Advanced Diagnostics. This version of the Assistant runs at a command-line or through a script such as PowerShell. It's useful when administrators need to run the Assistant on computers in their organization remotely.

To fix issues on a single computer, we recommend that you use the [full version of the Assistant](https://aka.ms/SaRA_Home). If multiple devices are impacted by an issue, the Enterprise version of the Assistant is recommended.

## Supported scenarios

You can use the Enterprise version of the Assistant to resolve issues for the following scenarios. The Assistant requires specific switches to run these scenarios. Select a scenario to learn about the switches that are available for it. Then run the Enterprise version of the Assistant by using the appropriate switches for the scenario to resolve your issue.

|Scenario|Description|Command-line scenario name (specified with the `-S` switch)|
|---|---|---|
|[Outlook Scan](assistant-outlook-scan.md)|Scans Outlook for known issues and generates a comprehensive configuration report for Outlook, Office, and Windows. A full or offline scan can be run.|`ExpertExperienceAdminTask`|
|[Office Uninstall](assistant-office-uninstall.md)|Scrubs any version of Office from a device. Use when you can't fully remove Office through Control Panel.|`OfficeScrubScenario`|
|[Office Activation](assistant-office-activation.md)|Automated checks and recoveries to reset activation-related settings so you can successfully activate a subscription version of Office.|`OfficeActivationScenario`|
|[Office Shared Computer Activation](assistant-office-shared-computer-activation.md)|Automated checks and recoveries to either enable or disable Office Shared Computer Activation.|`OfficeSharedComputerScenario`|
|[Outlook Calendar Scan](assistant-outlook-calendar-scan.md)|Scans your Outlook calendar with the Calendar Checking tool (CalCheck) for dozens of known problems.|`OutlookCalendarCheckTask`|
|[Teams Meeting Add-in for Outlook](assistant-teams-meeting-add-in-outlook.md)|Automated checks and recoveries to help you get the Teams Meeting Add-in for Outlook up and running.|`TeamsAddinScenario`|
|[Reset Office Activation](assistant-reset-office-activation.md)|Clear prior activations of Microsoft 365 Apps for Enterprise to remove related licenses and cached Office account information. This resets Office applications to a clean state and you can then activate them with a different Office account or change to a different license mode.|`ResetOfficeActivation`|

## Download and run the Enterprise version of the Assistant

1. Download the Assistant by selecting the button below:
   > [!div class="nextstepaction"]
   > [Download the Assistant](https://aka.ms/SaRA_EnterpriseVersionFiles)
1. In the downloaded *.zip* file, extract the files to a folder that you can access from the user's computer on which you'll run the Assistant.
1. On the user's computer, select **Start**, enter *cmd*, and then press Enter to open a Command Prompt window.

   **Note** If the scenario you want to run requires an elevated command prompt, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

1. In the Command Prompt window, navigate to the folder in which you extracted the files from step 2.
1. Run the Assistant by using the appropriate switches for the scenario.

> [!IMPORTANT]
> Updates to the Enterprise version of the Assistant are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application will stop working 90 days after the **Created** date listed for the SaRAcmd.exe file. Use the link provided in step 1 to always download the latest version available.

## Switches available for all scenarios

The following switches are available for the Enterprise version of the Assistant. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|Applicable scenarios|
|---|---|---|---|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use the `-?` switch along with other switches, it will override the other switches.|Optional|All|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|All|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch. If you use the `-DisplayEULA` switch along with other switches, it will override the other switches. |Optional|All|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run.|Required|All|
|`-AcceptEula`|Use the `-AcceptEula` switch to accept the End User License Agreement (EULA) which is required before a scenario can be run.|Required|All|
|`-LogFolder <Output Path>`| Use the `-LogFolder` switch to force SaraCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-HideProgress`|The default feature is to always display the progress of the scenario. Use `-HideProgress` switch to hide the progress display for the listed scenarios.|Optional|`ExpertExperienceAdminTask`<br/>`OutlookCalendarCheckTask`|
|`-OfflineScan`|Use the `-OfflineScan` switch to specify an offline scan of Outlook while the Outlook application is running.|Optional|`ExpertExperienceAdminTask`|
|`-OfficeVersion`|Use the `-OfficeVersion` switch to only remove the Office version that's specified by the `<version>` parameter. If you use **All** as a parameter, all Office versions will be removed from your machine.|Optional|`OfficeScrubScenario`|
|`-RemoveSCA`|Use the `-RemoveSCA` switch to remove Shared Computer Activation (SCA) and configure non-SCA activation for Office.|Optional|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`|
|`-CloseOffice`|Use the `-CloseOffice` switch to close all Office apps that're open.|Required|`OfficeActivationScenario`<br/>`OfficeSharedComputerScenario`<br/>`ResetOfficeActivation`|
|`-CloseOutlook`|Use the `-CloseOutlook` switch to close Outlook if it's open.|Required|`TeamsAddinScenario`|
|`-P <profile name>`|Use the `-P` switch with the \<Profile name\> parameter to specify the Outlook profile that you want the `OutlookCalendarCheckTask` scenario to scan.|Optional|`OutlookCalendarCheckTask`|

## Version history of the Enterprise version of the Assistant

Throughout the year, a new build of the Enterprise version of the Assistant is available through the download link that's provided in [Download and run the command-line version of the Assistant](#download-and-run-the-enterprise-version-of-the-assistant). Because each build stops working after 90 days, we recommend that you keep the Assistant updated by replacing the files you have with the latest version.

The following table provides the versions of the Enterprise version of the Assistant that were made available on the specified date.

|Release date|Version|
|----------|-----------|
|September 13, 2022|17.00.9001.001 |
|July 8, 2022|17.00.8713.001 |
|May 18, 2022|17.00.8433.005 |
|April 7, 2022|17.00.8256.000|
|February 8, 2022|17.00.7971.000|
|November 9, 2021|17.00.7513.000|
|May 26, 2021|17.00.6665.000|
