---
title: Office shared computer activation by using command line version of Get Help
description: Describes available switches and conditions when using the command line version of Get Help for Office shared computer activation.
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
# Scenario: Office Shared Computer Activation

The Office Shared Computer Activation scenario automates checks and recovery activities to enable or disable shared computer activation on a device. Shared computer activation for Office is supported for specific subscription plans. For more information, see [Overview of shared computer activation for Microsoft 365 Apps](/deployoffice/overview-shared-computer-activation).

**Note:** This scenario requires that you use an elevated Command Prompt window. To do this, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

## Download the command line version of Get Help

Select the following button:

> [!div class="nextstepaction"]
> [Download Command line Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the command line version of Get Help, see [Command line version of Get Help](get-help-command-line-overview.md).

## Available switches for the Office Shared Computer Activation scenario

The following switches are available for this scenario. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Specify this switch and `OfficeSharedComputerScenario` as the value of the `scenarioname` parameter to run this scenario.|Required|
|`-AcceptEula`|Specify this switch to accept the End User License Agreement (EULA) and run this scenario.|Required|
|`-CloseOffice`|Specify this switch to close all Office apps that are running.|Required|
|`-RemoveSCA`|Specify this switch to remove Shared Computer Activation (SCA) and to configure non-SCA activation for Office.|Optional|

## Sample commands

Here are some sample combinations of switches to run the Office Shared Computer Activation scenario.

- Sample 1

  To enable SCA on a computer, run the following command in an elevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S OfficeSharedComputerScenario -AcceptEula -CloseOffice
  ```

- Sample 2

  To remove SCA if it's enabled, and configure non-SCA activation for Office, run the following command in an elevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S OfficeSharedComputerScenario -AcceptEula -CloseOffice -RemoveSCA
  ```

## Detected conditions and results

When you run the Office Shared Computer Activation scenario by using the command line version of the Assistant, you don't receive any prompts. This is a different experience from the full version of Get Help. The following table describes the actions that the command line version of Get Help takes for each condition that's encountered in this scenario, and the corresponding output that is displayed.

|Condition|Action taken by the command line version|Output shown in the Command Prompt window|
|---|---|---|
|Scan completed successfully|Exit the scenario|63: Scenario completed successfully. Please exit and restart Windows and sign back in as an end-user that needs to use Office.|
|The user didn't include the `-CloseOffice` switch|Exit the scenario|01: This scenario requires the `-CloseOffice` switch. Note, if Office is running, the `-CloseOffice` switch closes Office applications. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/get-help-command-line-overview).|
|Error closing Office application|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Failure to remove SCA|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Office isn't installed|Exit the scenario|60: This scenario requires an existing Office installation. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Error checking whether Office is installed|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI). |
|Error determining whether Office SKU is ProPlus or BusinessRetail|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|The installed Office SKU isn't ProPlus or BusinessRetail|Exit the scenario|61: This scenario requires an existing Office installation that supports Shared Computer Activation. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from https://aka.ms/SaRA-OfficeSCA-CmdLine.|
|Error running recovery action|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
