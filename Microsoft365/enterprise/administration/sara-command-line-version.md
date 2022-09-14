---
title: SaRA Enterprise version
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
ms.date: 4/26/2022
---
# Enterprise version of Microsoft Support and Recovery Assistant

The Enterprise version of Microsoft Support and Recovery Assistant is a self-contained enterprise-ready diagnostic tool that you can use to troubleshoot specific client issues with Office, Teams, Outlook and Advance Diagnostics. This verson of the Assistant runs either at a command-line or through a script such as PowerShell. It is useful when administrators need to run the Assistant on computers in their organization remotely.

## Download and run the Enterprise version of the Assistant

1. Download the Assistant from [https://aka.ms/SaRA_EnterpriseVersionFiles](https://aka.ms/SaRA_EnterpriseVersionFiles) .
1. In the downloaded .zip file, extract the files to a folder that you can access from the computer on which you'll run the Assistant.
1. On the user's computer, select **Start**, enter *cmd*, and then press Enter to open a Command Prompt window.

    **Note:** See the table in the "[Supported switches](#supported-switches)" section to determine whether an elevated Command Prompt window is required to run the Assistant for the user's scenario.

1. In the Command Prompt window, navigate to the folder in which you extracted the files from step 2.
1. Run the command-line version of the Assistant by using one or more switches that are discussed in the "[Supported switches](#supported-switches)" section.

   > [!IMPORTANT]
   > Updates to the Enterprise version of the Assistant are released on a regular basis. To make sure that you're using the latest version that has the most features and highest stability, each build of the application will stop working 90 days after the **Created** date listed for SaRAcmd.exe. Use the link provided in step 1 to download the latest version.

## Supported switches

The following switches are available to control SaRAcmd.exe.

**Note:** The switches aren't case-sensitive.

1. `-S <scenarioname>`

   Use the `-S` switch to specify the scenario that you want to run. The switch can't be run on its own. It must be followed by `-AcceptEula`. For example, to run the scenario that removes the currently installed version of Office, use the following format of the `-S` switch:
   
   `-S OfficeScrubScenario -AcceptEula`

   Currently, the following values for `Scenarioname` are supported with the `-S` switch.

   |Scenarioname value|Equivalent scenario entry point in the full (UI) version of SaRA (for reference)|Elevated Command Prompt window required|
   |---|---|:-:|
   |`ExpertExperienceAdminTask`|Advanced Diagnostics \ Outlook| No |
   |`OfficeScrubScenario`|Office \ I have Office installed, but I'm having trouble uninstalling it| Yes |
   |`TeamsAddinScenario`|Teams \ The Teams Meeting option isn't shown, or the Teams Meeting add-in doesn't load in Outlook| No |
   |`OfficeActivationScenario`|Office \ I've installed a subscription version of Office, but I can't activate it|      Yes |
   |`OutlookCalendarCheckTask`|Advanced Diagnostics \ Outlook \ Create a detailed scan of my Outlook Calendar to identify and resolve issues| No |
   |`OfficeSharedComputerScenario`|Office \ I want to setup Office with shared computer activation on a computer or server in my organization| Yes |
   |`ResetOfficeActivation`|Not applicable. THis scenario resets the Office Activation state and is available in the Command-line version of the Assistant only.| Yes |
   
   **Note:** To open an elevated Command Prompt window, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

2. `-AcceptEula`

   The End User License Agreement (EULA) must be accepted before any scenario can be run. If you're using `-AcceptEULA`, you must also use `-S <scenarioname>` to specify the scenario that you want to run. For example, to uninstall Office, run the following command from an elevated Command Prompt window:

   ```console
   SaRAcmd.exe -S OfficeScrubScenario -AcceptEula
   ```

   If you want to run the Advanced Diagnostic scenario for Outlook, run the following command:

   ```console
   SaRAcmd.exe -S ExpertExperienceAdminTask -AcceptEula
   
3. `-DisplayEULA`

   Use the `-DisplayEULA` switch to display the EULA. To save the EULA text to a file such as SaRAEula.txt that is located in the C:\temp folder, run the following command:

   ```console
   SaRAcmd.exe -DisplayEULA > c:\temp\SaRAEula.txt
   ```
   
4. `-CloseOutlook`

   The `-CloseOutlook` switch is required to run the **TeamsAddinScenario**. If Outlook is running, this switch closes Outlook.
   
   ```console
   SaRAcmd.exe -S TeamsAddinScenario -AcceptEula -CloseOutlook
   ```

5. `-CloseOffice`

   The `-CloseOffice` switch is required to run the **OfficeActivationScenario**, **OfficeSharedComputerScenario**, and **ResetOfficeActivation** scenarios. It closes Office applications.
   
   ```console
   SaRAcmd.exe -S OfficeActivationScenario -AcceptEula -CloseOffice
   ```
   
6. `-LogFolder <Output Path>`

   The `-LogFolder` switch is optional for the **ExpertExperienceAdminTask** and **OutlookCalendarCheckTask** scenarios. If the `-LogFolder` switch is used, it forces SaraCmd.exe to output scenario-specific logs to the folder that's specified by `Output Path`.
  
7. `-P <Profile Name>`
  
   The `-P` switch is optional for the **OutlookCalendarCheckTask** scenario. `Profile name` identifies the Outlook profile that's scanned by the scenario.
  
8. `-RemoveSCA`
  
   The `-RemoveSCA` switch is optional for **OfficeActivationScenario** and **OfficeSharedComputerScenario**. This switch removes Shared Computer Activation (SCA) and configures non-SCA activation for Office.
  
9. `-HideProgress`
  
   The `-HideProgress` switch is optional and works with the **ExpertExperienceAdminTask** and **OutlookCalendarCheckTask** scenarios only. When this switch is used, it hides the progress display for these scenarios. The default feature of the Assistant is to always display the progress of tasks.
  
10. `-OfflineScan`
  
    The `-OfflineScan` switch is optional and only works with the **ExpertExperienceAdminTask** scenario. This switch forces an offline scan of Outlook when the application is running. 
  
11. `-OfficeVersion <version>`
  
    The `-OfficeVersion` switch is optional and works only with the **OfficeScrubScenario** scenario. Using this switch removes the Office version that's defined in the `<version>` parameter. The allowed values for `<version>` are: All, M365, 2021, 2019, 2016, 2013, 2010, and 2007. For example, to uninstall Office 2016 only, run the following command from an elevated Command Prompt window:
   
   ```console
   SaRAcmd.exe -S OfficeScrubScenario -AcceptEula -Officeversion 2016
   ```
 To uninstall all Office versions,  run the following command from an elevated Command Prompt window:
 
  ```console
  SaRAcmd.exe -S OfficeScrubScenario -AcceptEula -Officeversion All
  ```
   
12. `-Help`

    The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, `-Help` will override all the other  switches except the `-?` switch.

13. `-?`

    Use the `-?` switch to display the functions of all the switches that are available for SaRAcmd.exe. If you use `-?` together with other switches, `-?` will override the other switches.

## Conditions addressed by the Enterprise (command-line) version of SaRA

When you run a scenario by using the Enterprise version of the Assistant, you receive no prompts. It is a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes, and the output that the tool displays for each condition within a scenario.

- `ExpertExperienceAdminTask`

  |Condition|Action taken by the Enterprise version|Output in the Command Prompt window|
  |---|---|---|
  |Outlook isn't running|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook is running|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |More than one Outlook version is detected|Run a scan of the latest version of Outlook|(Depending on the situation, this output could be *01*, *02*, *04*, or *05*)|
  |Outlook and the Command Prompt window are both elevated|Run a full scan of Outlook|*02:* A Full scan was performed. See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook is running as elevated; the Assistant's Command Prompt window isn't elevated|Run an Offline scan of Outlook|*01:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See \<filename> in *%localappdata%\saralogs\UploadLogs*.|
  |Outlook isn't running as elevated; the Assistant's Command Prompt window is elevated|None|*04:* Outlook isn't running elevated. Don't use an elevated command-prompt.|
  |Failure to run a scan (for any reason); for example:<ol><li>Outlook isn't installed</li><li>Only one Outlook version is detected, and that version is earlier than 2007</li><li>An exception occurs during the scan</li></ol>|Scan initiated but not completed|*05:* An error occurred while performing a scan of Outlook. You might be able to perform an Offline scan if you exit Outlook and rerun this scenario. You can also try using the full SaRA version.|
  |Offline Scan with Log Folder location provided |Run an Offline scan of Outlook|*66:* An Offline scan was performed because Outlook is either not running or it is running elevated (as Administrator). See the Outlook configuration details at the location specified by you.|
  |Normal Scan with Log Folder location provided  |Run a full scan of Outlook|*67:* A Full scan was performed. See the Outlook configuration details at the location specified by you.|

- `OfficeScrubScenario`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |Office removed successfully|None|*00:* Successfully completed this scenario.</br></br>**Note:** We recommend you restart the computer to finish any remaining cleanup tasks.|
  |Office program found .exe files running: `lync, winword, excel, msaccess, mstore, infopath, setlang, msouc, ois, onenote, outlook, powerpnt, mspub, groove, visio, winproj, graph, teams`|Exit the scenario|*06:* Office programs are running. Please close all open Office programs and then rerun this scenario.|
  |No Office products found and -OfficeVersion switch not used |Exit the scenario|*68:* We could not find any Office version. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion. <br /><br />**Note:** For SaRA Command line users with version 17.00.8256.000 or earlier, the error displayed is -*07:* No installed Office versions were found. Please use the full SaRA version.|
  |Multiple Office versions detected as installed and the -OfficeVersion switch not used|Exit the scenario|*08:* Multiple Office versions were found. Please use the full SaRA version.|
  |Failure to remove Office|Exit the scenario|*09:* Failure to remove Office. Please use the full SaRA version.|
  |The Assistant isn't elevated|Exit the scenario|*10:* SaRA needs to run elevated for this scenario. Please use an elevated command-prompt.|
  |Office version provided on command line doesn’t match detected installed version|Exit the scenario|*66:* We could not find the specified Office version. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion.|
  |Invalid Office version specified on command line|Exit the scenario|*67:* The Office version that you have specified is invalid. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion. |
  
- `TeamsAddinScenario`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |Scan completed successfully|None|*00:* Scenario completed successfully. Please exit and restart Outlook.|
  |User doesn't include the `-CloseOutlook` switch|Exit the scenario|*01:* This scenario requires the -CloseOutlook switch. Note, if Outlook is running, the -CloseOutlook switch closes Outlook. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion)|
  |User doesn't include the `-AcceptEula` switch|Exit the scenario|*01:* Please provide -AcceptEula to continue with this scenario. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion)|
  |Teams isn't installed|Exit the scenario|*20:* Could not find an installed version of Teams. Please see [https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b](https://support.office.com/article/how-do-i-get-access-to-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b)|
  |Outlook 2013 or later isn't installed|Exit the scenario|*21:* Could not find an installed version of Outlook 2013, or later. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032)|
  |Windows 7 users don't have the [Update for Universal C Runtime in Windows](https://support.microsoft.com/help/2999226/update-for-universal-c-runtime-in-windows) installed|Exit the scenario|*22:* Pre-requisites not met. Update from KB2999226 needs to be installed. See [https://go.microsoft.com/fwlink/?linkid=2129032](https://go.microsoft.com/fwlink/?linkid=2129032)|
  |Registry issues detected: <br/><br/>LoadBehavior<>3 or add-in listed under the `DisabledItems` key or TeamsAddin.Connect<>1 under the `DoNotDisableAddinList` key|Run the registry recovery action, and then exit the scenario.|*23:* The registry was updated to address missing or incorrect values. Please exit and restart Outlook.</br></br>*17:* An error occurred while running this scenario. You can also try using the full SaRA version.|
  |None of the listed conditions was detected|Run the re-register dll recovery action, and then exit the scenario.|*24:* The Microsoft.Teams.AddinLoader.dll was re-registered. Please exit and restart Teams. Then, exit and restart Outlook.|
  |Failure to complete the scenario (for any reason)|Exit the scenario|*17:* An error occurred while running this scenario. You can also try using the full SaRA version.|

- `OutlookCalendarCheckTask`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |Scan completed successfully |Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at %localappdata%\saralogs\uploadlogs location.|
  |Scan completed successfully with custom location (-LogFolder)|Exit the scenario|43: A complete Outlook Calendar scan was performed. See the Outlook configuration details at the location specified by you. |
  |User doesn't include -AcceptEULA switch|Exit the scenario|01: Please provide -AcceptEula to continue with this scenario. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion.|
  |Outlook isn’t installed|Exit the scenario|40: To run diagnostics for this scenario, please download and install Microsoft Outlook. For additional information, please visit https://aka.ms/SaRA-CalCheckDocs.|
  |Unable to identify user's profile |Exit the scenario|41: Unable to complete this scenario as Microsoft Outlook profile is missing. For additional information, please visit https://aka.ms/SaRA-CalCheckDocs.|
  |Failure to complete the scenario (for any reason)|Exit the scenario|42: An error occurred while running this scenario. You can also try using the full SaRA version. For additional information, please see this article https://aka.ms/SaRA-CalCheckDocs.|
  |If current active Outlook profile isn't the same as the -P switch profile|Exit the scenario|44: Unable to complete this scenario because the profile specified using the -P switch does not match the profile currently running in Outlook. Please close the Outlook application and try again. For additional information, please see this article https://aka.ms/SaRA-CalCheckDocs.|

- `OfficeActivationScenario`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |User doesn't include -CloseOffice switch|Exit the scenario| 01: This scenario requires the -CloseOffice switch. Note, if Office is running, the -CloseOffice switch closes Office applications. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion.|
  |Office isn't installed|Exit the scenario| 30: Could not find an installed version of Office|
  |Office subscription not found|Exit the scenario| 31: Could not find a subscription version of Office. Please see https://aka.ms/SaRA-Cmdline-NoSubscriptionFound for troubleshooting information.|
  |Device subscription detected.|Exit the scenario| 32: Device subscription detected. See https://aka.ms/SaRA_DeviceActivationDetectedCmd for troubleshooting and configuration information.|
  |The Assistant isn't elevated|Exit the scenario| 33: This scenario requires an elevated command-prompt.|
  |Shared Computer Activation (SCA) is enabled for Office|Exit the scenario| 34: Shared Computer Activation (SCA) is enabled for Office. Please use the -RemoveSCA switch if you want this scenario to remove SCA and configure non-SCA activation for Office. Otherwise, use the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeActivation-CmdLine.|
  |Failure to complete the scenario (for any reason)|Exit the scenario| 35: We ran into a problem. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeActivation-CmdLine.|
  |Scan completed successfully|Exit the scenario| 36: Successful run. Start any Office app and sign-in to activate.|
  |Office is already activated|Exit the scenario| 37: It looks like Microsoft Office is already activated. If you don’t think this is correct, please run the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeActivation-CmdLine.|
  |Failure to complete the scenario (for any reason)|Exit the scenario| 38: `<message depends on the ReasonCode>`|
  |Unable to activate Office|Exit the scenario| 39: Office may not be activated. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeActivation-CmdLine.|
  |Failure to complete the scenario|Exit the scenario| 40: Cannot reach all endpoints required for activation. Please run the full UI version of SaRA.|

- `OfficeSharedActivationScenario`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |Scan completed successfully|Exit the scenario| 63: Scenario completed successfully.  Please exit and restart Windows and sign back in as an end-user that needs to use Office.|
  |User doesn't include -CloseOffice switch|Exit the scenario| 01: This scenario requires the -CloseOffice switch. Note, if Office is running, the -CloseOffice switch closes Office applications. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion.|
  |Error closing Office application|Exit the scenario| 62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  |Failure to remove SCA|Exit the scenario| 62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  |Office isn't installed|Exit the scenario| 60: This scenario requires an existing Office installation. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  |Error checking if Office is installed|Exit the scenario| 62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  |Error determining if Office is ProPlus or BusinessRetail|Exit the scenario| 62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  |Office SKU installed is not ProPlus or BusinessRetail|Exit the scenario| 61: This scenario requires an existing Office installation that supports Shared Computer Activation. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-CmdLine.|
  |Error running recovery action|Exit the scenario| 62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-UI.|
  
 - `ResetOfficeActivation`

  |Condition|Action taken by the Enterprise version|Output shown in the command-prompt window|
  |---|---|---|
  |Scan completed successfully|Exit the scenario| 80: Successful run. Start any Office app and sign-in to activate.|
  |User doesn't include -CloseOffice switch|Exit the scenario|01: This scenario requires the -CloseOffice switch. Note, if Office is running, the -CloseOffice switch closes Office applications. For additional information, please visit https://aka.ms/SaRA_CommandLineVersion.|
  |Error performing any action(s)|Exit the scenario| 71: We ran into a problem. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeActivation-Cmdline.|
  |Command-prompt not elevated|Exit the scenario| 72: The scenario requires an elevated command-prompt.|
  |Failure to run the OLicenseCleanup script|Exit the scenario|73: We ran into a problem running OLicenseCleanup.vbs. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps.|
  |Failure running Dsregcmd|Exit the scenario| 74: We ran into a problem running Dsregcmd. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps.|
  |Windows build requirement not met|Exit the scenario| 75: Windows is not at least Windows 10 version 1803. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps|
  |Failure to run the SignOutOfWamAccounts script|Exit the scenario| 76: We ran into a problem running SignOutOfWamAccounts.ps1. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps.|
  |WPJCleanup script requirements not met|Exit the scenario| 78: WorkplaceJoined=True, but Windows 10 is not at least version 1809. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps.|
  |Failure to run the WPJCleanup script|Exit the scenario| 79: We ran into a problem running WPJCleanup. See `https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state` for manual reset steps.|


## SaRA Enterprise version history

Throughout the year, a new build of the Enterprise version of the Assistant is available through the download link that's provided at the beginning of this article. Because each build stops working after 90 days, we recommend that you keep the Assistant updated by replacing the files you have with the latest version.

The following table lists the versions of SaRA that were released on the specified date.

|Release date|SaRA Enterprise version|
|----------|-----------|
|September 13, 2022|17.00.9001.001 |
|July 8, 2022|17.00.8713.001 |
|May 18, 2022|17.00.8433.005 |
|April 7, 2022|17.00.8256.000|
|February 8, 2022|17.00.7971.000|
|November 9, 2021|17.00.7513.000|
|May 26, 2021|17.00.6665.000|

For information about the full version of the Assistant, see [About the Microsoft Support and Recovery Assistant](https://aka.ms/sara_home).
