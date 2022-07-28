---
title: Microsoft Support and Recovery Assistant command-line version
description: Describes the command-line version of Microsoft Support and Recovery Assistant.
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
ms.date: 06/09/2022
---
# Command-line version of Microsoft Support and Recovery Assistant

> [!NOTE]
> This article is for Microsoft 365 administrators only. For help to diagnose and fix issues with Office, Microsoft 365 or Outlook on your computer, see [About the Microsoft Support and Recovery Assistant](https://aka.ms/SaRA_Home).

The command-line version of Microsoft Support and Recovery Assistant is self-contained and scriptable. It runs at a command line or in a PowerShell script. This version is an enterprise-ready diagnostic tool for specific client issues. It's useful when administrators have to run a diagnostic tool remotely on computers in their organization.

If you need to fix issues on a single computer, we recommend that you use the [full UI version of the Assistant](https://aka.ms/SaRA_Home). If multiple devices are impacted by an issue, then the command-line version of the Assistant is helpful.

## Supported scenarios

You can use the command-line version of the Assistant to resolve issues for the following scenarios. The Assistant requires specific switches to run these scenarios. Select a scenario to learn about the switches available for it. Then run the command-line version of the Assistant by using the appropriate switches for the scenario to resolve your issue.

|Command-line scenario name|Description|Scenario path in UI version of the Assistant*|
|---|---|---|
|[ExpertExperienceAdminTask]|Scans Outlook for known issues and generates a comprehensive configuration report for Outlook, Office, and Windows. A full or offline scan can be run.|Advanced diagnostics \| Outlook \| Create detailed report of my Outlook configuration|
|OfficeScrubScenario|Scrubs any version of Office from a device. Use when you can't fully remove Office through Control Panel.|Office  \| I have Office installed, but I’m having trouble uninstalling it|
|OfficeActivationScenario|Automated checks and recoveries to reset activation-related settings so you can successfully activate a subscription version of Office.|Office \| I have a subscription version of Office, but I can't activate it|
|OfficeSharedComputerScenario|Automated checks and recoveries to either enable or disable Office Shared Computer Activation.|Office \| I want to setup Office with shared computer activation|
|OutlookCalendarCheckTask|Scans your Outlook calendar with the Calendar Checking tool (CalCheck) for dozens of known problems.|Advanced diagnostics \| Outlook \| Create detailed scan of my Outlook calendar|
|TeamsAddinScenario|Automated checks and recoveries to help you get the Teams Meeting Add-in for Outlook up and running.|Teams \| The Teams meeting option isn’t shown in Outlook|
|ResetOfficeActivation|Clear prior activations of Microsoft 365 Apps for Enterprise to remove related licenses and cached Office account information. This resets Office applications to a clean state, and you can then activate them with a different Office account or change to a different license mode.|Not available in the UI version of the Assistant.|

**The command-line scenarios are the same scenarios as those available in the UI version of the Assistant. The path to run these scenarios in the UI version of the Assistant is provided here as a reference point.*

## Download and run the command-line version of the Assistant

1. Download the Assistant by selecting the button below: 
   > [!div class="nextstepaction"]
   > [Download Command-line Assistant](https://aka.ms/SaRA_CommandLineVersionFiles)
1. In the downloaded file, extract the files in the *DONE* folder to a folder that you can access from the user's computer on which you'll run the Assistant.
1. On the user's computer, select **Start**, enter *`cmd`*, and then press Enter to open a Command Prompt window.

    **Note:** If the scenario you want to run requires it, open an elevated Command prompt window. Select **Start**, enter *`cmd`*, right-click **Command Prompt** in the results, and then select **Run as Administrator**.
1. In the Command Prompt window, navigate to the folder in which you extracted the files from step 2.
1. Run the command-line version of the Assistant by using the appropriate switches for the scenario.

> [!IMPORTANT]
> Updates to the command-line version of the Assistant are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application will stop working 90 days after the **Created** date listed for SaRAcmd.exe. Use the link provided in step 1 to download the latest version.

### Available switches for all scenarios

The following switches are available for the command-line version of the Assistant. They aren't case-sensitive. The switches, unless noted as **Optional**, are required to run the scenario and more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|Applicable scenarios|
|---|---|---|---|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use the `-?` switch along with other switches, it will override the others.|Optional|All|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|All|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|All|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run.|Required|All|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|All|
|`-LogFolder <Output Path>`| Use the `-LogFolder` switch to force SaraCmd.exe to output scenario-specific logs to the folder that's specified by \<Output Path\>.|Optional|ExpertExperienceAdminTask<br/>OutlookCalendarCheckTask|
|`-HideProgress`|The default feature is to always display the progress of the scenario. Use this switch to hide the progress display for the Outlook Scan scenario.|Optional|ExpertExperienceAdminTask<br/>OutlookCalendarCheckTask|
|`-OfflineScan`|This switch forces Outlook to be scanned as an Offline scan while the Outlook application is running.|Optional|ExpertExperienceAdminTask|
|`-OfficeVersion`|Using this switch only removes the Office version that's defined in the parameter. If you use **All** as a parameter, it removes all Office versions from your machine.|Optional|OfficeScrubScenario|
|`-RemoveSCA`|This switch removes Shared Computer Activation (SCA) and configures non-SCA activation for Office.|Optional|OfficeActivationScenario<br/>OfficeSharedComputerScenario|
|`-CloseOffice`|Closes any opened Office apps.|Required|OfficeActivationScenario<br/>OfficeSharedComputerScenario<br/>ResetOfficeActivation|
|`-CloseOutlook`|Closes Outlook if it's opened.|Required|TeamsAddinScenario|
|`-P <profile name>`|\<Profile name\> is the Outlook profile that's scanned by the OutlookCalendarCheckTask scenario.|Optional|OutlookCalendarCheckTask|

## Version history of the Assistant

Throughout the year, a new build of the command-line version of the Assistant is available through the download link that's provided in [Download and run the command-line version of the Assistant](#download-and-run-the-command-line-version-of-the-assistant). Because each build stops working after 90 days, we recommend that you keep the Assistant updated by replacing the files you have with the latest version.

The following table provides the versions of the Assistant that were made available on the specified date.

|Release date|SaRACmd.exe version|
|----------|-----------|
|July 8, 2022|17.00.8713.001 |
|May 18, 2022|17.00.8433.005 |
|April 7, 2022|17.00.8256.000|
|February 8, 2022|17.00.7971.000|
|November 9, 2021|17.00.7513.000|
|May 26, 2021|17.00.6665.000|
