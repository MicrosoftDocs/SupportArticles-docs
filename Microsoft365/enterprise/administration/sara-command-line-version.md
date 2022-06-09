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
ms.reviewer: zebamehdi; brandisi
appliesto: 
  - Office 365
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

|Scenario|Description|Scenario path in UI version of the Assistant|
|---|---|---|
|<ul><li>Common name: <b>[Outlook scan](./sara-outlook-scan.md)</b></li><li>Name in the Assistant UI: <b>[ExpertExperienceAdminTask]((./sara-outlook-scan.md)</b></li><li>Elevated command prompt: <b>No</b></li></ul>|Scans Outlook for known issues and generates a comprehensive configuration report for Outlook, Office, and Windows. A full or offline scan can be run.|Advanced diagnostics \| Outlook \| Create detailed report of my Outlook configuration|
|<ul><li>Common name: <b>Office Uninstall</b></li><li>Name in the Assistant UI: <b>OfficeScrubScenario</b></li><li>Elevated command prompt: <b>Yes</b></li></ul>|Scrubs any version of Office from a device. Use when you can't fully remove Office through control panel.|Office  \| I have Office installed, but I’m having trouble uninstalling it|
|<ul><li>Common name: <b>Office Activation</b></li><li>Name in the Assistant UI: <b>OfficeActivationScenario</b></li><li>Elevated command prompt: <b>Yes</b></li></ul>|Automated checks and recoveries to reset activation-related settings so you can successfully activate a subscription version of Office.|Office \| I have a subscription version of Office, but I can’t activate it|
|<ul><li>Common name: <b>Office Shared Computer Activation</b></li><li>Name in the Assistant UI: <b>OfficeSharedComputerScenario</b></li><li>Elevated command prompt: <b>Yes</b></li></ul>|Automated checks and recoveries to either enable or disable Office Shared Computer Activation.|Office \| I want to setup Office with shared computer activation|
|<ul><li>Common name: <b>Calendar scan</b></li><li>Name in the Assistant UI: <b>OutlookCalendarCheckTask</b></li><li>Elevated command prompt: <b>No</b></li></ul>|Scans your Outlook calendar with the Calendar Checking tool (CalCheck) for dozens of known problems.|Advanced diagnostics \| Outlook \| Create detailed scan of my Outlook calendar|
|<ul><li>Common name: <b>Teams Meeting Add-in for Outlook</b></li><li>Name in the Assistant UI: <b>TeamsAddinScenario</b></li><li>Elevated command prompt: <b>No</b></li></ul>|Automated checks and recoveries to help you get the Teams Meeting Add-in for Outlook up and running.|Teams \| The Teams meeting option isn’t shown in Outlook|

## Download and run the command-line version of the Assistant

1. Download the Assistant by selecting the button below: 
   > [!div class="nextstepaction"]
   > [Download Command-line Assistant](https://aka.ms/SaRA_CommandLineVersionFiles)
1. In the downloaded file, extract the files in the *DONE* folder to a folder that you can access from the user's computer on which you'll run the Assistant.
1. On the user's computer, select **Start**, enter *`cmd`*, and then press Enter to open a Command Prompt window.

    **Note:** If the scenario you want to run requires it, open an elevated Command prompt window. Select **Start**, enter *`cmd`*, right-click **Command Prompt** in the results, and then select **Run as Administrator**.
1. In the Command Prompt window, navigate to the folder in which you extracted the files from step 2.
1. Run the command-line version of the Assistant by using the appropriate switches for the scenario.

Updates to the command-line version of the Assistant are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application will stop working 90 days after the **Created** date listed for the SaRAcmd.exe file. Use the link provided in step 1 to always download the latest version available.

## Version history of the Assistant

A new build of the Assistant is available multiple times a year for download. Because each build stops working after 90 days, we recommend that you keep the Assistant updated by replacing the files you have with the latest version always.

The following table provides the versions of the Assistant that were made available on the specified date.

|Release date|SaRACmd.exe version|
|----------|-----------|
|May 18, 2022|17.00.8433.005 |
|April 7, 2022|17.00.8256.000|
|February 8, 2022|17.00.7971.000|
|November 9, 2021|17.00.7513.000|
|May 26, 2021|17.00.6665.000|
