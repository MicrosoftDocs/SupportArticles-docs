---
title: SaRA command-line version
description: Describes the command-line version of Microsoft Support and Recovery Assistant (SaRA).
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom:
- CI 148047
- CSSTroubleshoot
ms.reviewer: zebamehdi
appliesto:
- Office 365
search.appverid: MET150
---
# Command-line version of Microsoft Support and Recovery Assistant (SaRA)

The command-line version of Microsoft Support and Recovery Assistant (SaRA) is self-contained and scriptable (run at a command line or in a PowerShell script). This version was created as an enterprise-ready diagnostic tool to target specific client issues. It's useful in situations in which administrators have to remotely run a diagnostic tool on computers in their organization.

## Download SaRA

1. To download the command-line version of SaRA, use the following link: [https://aka.ms/SaRA_CommandLineVersionFiles](https://aka.ms/SaRA_CommandLineVersionFiles).
1. In the downloaded file, extract the files in the *DONE* folder to a location that you can access from the computer on which you'll run the application.

## Running the command-line version of SaRA

1. Select **Start**, enter `cmd`, and then press Enter to open a Command Prompt window.

    **Note:** See the table in the "[Supported switches](#supported-switches)" section to determine whether an elevated Command Prompt window is required for that scenario.

2. In the Command Prompt window, navigate to the folder to which you copied the files for the command-line version of SaRA.
3. Run the command-line version of SaRA by using one or more of the switches that are discussed in the "[Supported switches](#supported-switches)" section.

   > [!IMPORTANT]
   > The command-line version of SaRA will be updated for new improvements and fixes on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, we will program each build of the application to stop running 90 days after the listed **Created** date for SaRAcmd.exe.

## Supported switches

The following switches are available to control SaRAcmd.exe.

**Note:** The switches aren't case-sensitive.

1. `-S <scenarioname>`

   Use the `-S` switch to specify the scenario that you want to run. The switch cannot be run on its own. It must be followed by `-AcceptEula`. For example, to run the scenario that removes the currently installed version of Office, enter `–S OfficeScrubScenario -AcceptEula`, and then press Enter.

   Currently, the following scenarios are supported through the command line.

   |*Scenarioname* value|Scenario entry point in the UI version of SaRA|Elevated Command Prompt window required|
   |---|---|---|
   |`ExpertExperienceAdminTask`|Advanced Diagnostics \ Outlook|No|
   |`OfficeScrubScenario`|Office \ I have Office installed, but I'm having trouble uninstalling it|Yes|
   |||

   **Note:** To open an elevated Command Prompt window, select **Start**, enter `cmd`, right-click **Command Prompt** in the results, and then select **Run as administrator**.

2. `-AcceptEula`

   The End User License Agreement (EULA) must be accepted before a scenario can be run. If you're using `-AcceptEULA`, you must also use `-S <scenarioname>` to specify the scenario that you want to run. For example, to uninstall Office, run the following command:

   ```console
   SaRAcmd.exe -S OfficeScrubScenario -AcceptEula
   ```

   If you want to run the Advanced Diagnostic scenario for Outlook, run the following command:

   ```console
   SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula
   ```

3. `-DisplayEULA`

   Use the `-DisplayEULA` switch to display the EULA. To output the EULA text to a file, run a command that resembles the following example:

   ```console
   SaRAcmd.exe -DisplayEULA > c:\temp\SaRAEula.txt
   ```

4. `-Help`

   The `-Help` switch displays a link to online content for additional information. If you use `-Help` together with other switches, `-Help` will override all the other switches except the `-?` switch.

5. `-?`

   Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use `-?` together with other switches, `-?` will override the other switches. The following screenshot shows example output if the `-?` switch is used.

   :::image type="content" source="media/sara-command-line-version/sara-command-line-version.png" alt-text="Screenshot of the output of the switch.":::

## Conditions of the command-line scenarios

When you run a scenario by using the command-line version of SaRA, you receive no prompts. This is a different experience from the UI version of SaRA. The following table describes the actions that SaRA takes, and the output that the tool displays for each condition within a scenario.

- `ExpertExperienceAdminTask`

  |Condition|Action taken by the command-line version|Output in the Command Prompt window|
  |---|---|---|
  |Outlook isn't running|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook is running|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |More than one Outlook version is detected|Run a scan of the latest version of Outlook|(Depending on the situation, this output could be *01*, *02*, *04*, or *05*)|
  |Outlook and the Command Prompt window are both elevated|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook is running as elevated; the SaRA Command Prompt window isn't elevated|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook isn't running as elevated; the SaRA Command Prompt window is elevated|No scan is run|*04:* Outlook isn't running elevated. Don't use an elevated command-prompt.|
  |Failure to run a scan (for any reason); for example:<ol><li>Outlook isn't installed</li><li>Only one Outlook version is detected, and that version is earlier than 2007</li><li>An exception occurs during the scan</li></ol>|No scan is run|*05:* An error occurred while performing a scan of Outlook. You might be able to perform an Offline scan if you exit Outlook and rerun this scenario. You can also try using the full SaRA version.|
  |||
- `OfficeScrubScenario`

  |Condition|Action taken by the command-line version|Output shown in the command-prompt window|
  |---|---|---|
  |Successfully completed|Not applicable|*00:* Successfully completed this scenario.<br/><br/>**Note:** We recommend you restart the computer to finish any remaining cleanup tasks.|
  |Office program found .exe files running:<br/><br/>lync, winword, excel, msaccess, mstore, infopath, setlang, msouc, ois, onenote, outlook, powerpnt, mspub, groove, visio, winproj, graph, teams|Exit the scenario|*06:* Office programs are running. Please close all open Office programs and then rerun this scenario.|
  |No Office products found|Exit the scenario|*07:* No installed Office versions were found. Please use the full SaRA version.|
  |Multiple Office products found|Exit the scenario|*08:* Multiple Office versions were found. Please use the full SaRA version.|
  |Failure to remove Office|Exit the scenario|*09:* Failure to remove Office. Please use the full SaRA version.|
  |SaRA isn't elevated|Exit the scenario|*10:* SaRA needs to run elevated for this scenario. Please use an elevated command-prompt.|
  |||

For more information about the UI version of SaRA, see [About the Microsoft Support and Recovery Assistant](https://aka.ms/sara_home).
