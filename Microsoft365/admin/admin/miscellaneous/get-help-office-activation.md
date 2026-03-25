---
title: Office activation with the command line version of Get Help
description: Describes available switches and conditions when using the commnad line version of Get Help to activate Office.
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
# Scenario: Office Activation

The Office Activation scenario automates checks and recovery activities to reset activation-related settings and successfully activate a subscription version of Office.

**Note:** This scenario requires that you use an elevated Command Prompt window. To do this, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

## Download the command line version of Get Help

Select the following button:

> [!div class="nextstepaction"]
> [Download Command line Get Help](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the command line version of Get Help, see [Command line version of Get Help](get-help-command-line-overview.md).

## Available switches for the Office Activation scenario

The following switches are available for this scenario. They aren't case-sensitive. Unless noted as optional, the switches are required to run the scenario. You can use more than one optional switch.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Specify this switch and `OfficeActivationScenario` as the value for the `scenarioname` parameter to run this scenario.|Required|
|`-AcceptEula`|Specify this switch to accept the End User License Agreement (EULA) and run this scenario.|Required|
|`-CloseOffice`|Specify this switch to close all Office apps that are running.|Required|
|`-RemoveSCA`|Specify this switch to remove Shared Computer Activation (SCA) and to configure non-SCA activation for Office.|Optional|

## Sample commands

Here are some sample combinations of switches to run the Office Activation scenario.

- Sample 1

  To make sure that the requirements for Office activation are met, and to prepare for successful activation at the next startup of an Office app, run the following command in an elevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S OfficeActivationScenario -AcceptEula -CloseOffice
  ```

- Sample 2

  To do the same steps as in sample 1, and also remove SCA if it's enabled, run the following command in an elevated Command Prompt window:

  ```console
  GetHelpCmd.exe -S OfficeActivationScenario -AcceptEula -CloseOffice -RemoveSCA
  ```

## Detected conditions and results

When you run the Office Activation scenario by using the command line version of Get Help, you don't receive any prompts. This is a different experience from the full version of Get Help. The following table describes the actions that the commnad line version of Get Help takes for each condition that's encountered in this scenario, and the corresponding output that is displayed.

|Condition|Action taken by the command line version|Output shown in the Command Prompt window|
|---|---|---|
|The user didn't include the `-CloseOffice` switch|Exit the scenario|01: This scenario requires the `-CloseOffice` switch. If Office is running, the `-CloseOffice` switch closes Office applications. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/get-help-command-line-overview).|
|Office isn't installed|Exit the scenario|30: Could not find an installed version of Office|
|Office subscription not found|Exit the scenario|31: Could not find a subscription version of Office. Please see [https://aka.ms/SaRA-Cmdline-NoSubscriptionFoun](https://aka.ms/SaRA-Cmdline-NoSubscriptionFound) for troubleshooting information.|
|Device subscription detected.|Exit the scenario|32: Device subscription detected. See [https://aka.ms/SaRA_DeviceActivationDetectedCmd](https://aka.ms/SaRA_DeviceActivationDetectedCmd) for troubleshooting and configuration information.|
|Command line Get Help isn't running in an elevated mode|Exit the scenario|33: This scenario requires an elevated command-prompt.|
|Shared Computer Activation (SCA) is enabled for Office but the `-RemoveSCA` switch is not specified|Exit the scenario|34: Shared Computer Activation (SCA) is enabled for Office. Please use the `-RemoveSCA` switch if you want this scenario to remove SCA and configure non-SCA activation for Office. Otherwise, use the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Failure to complete the scenario (for any reason)|Exit the scenario|35: We ran into a problem. Please run the Office Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Scan completed successfully|Exit the scenario|36: Successful run. Start any Office app and sign-in to activate.|
|Office is already activated|Exit the scenario|37: It looks like Microsoft Office is already activated. If you don't think this is correct, please run the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Can't successfully activate Office|Exit the scenario|38: The message varies depending on the reason for the failure to activate Office.|
|Can't activate Office|Exit the scenario|39: Office may not be activated. Please run the Office Activation scenario in the full UI version of Get Help. You can download Get Help from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
