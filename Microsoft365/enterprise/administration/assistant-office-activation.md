---
title: Office activation with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant to activate Office.
author: helenclu    
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: zebamehdi; brandisi
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 10/25/2022
---
# Scenario: Office Activation

The Office Activation scenario automates checks and recoveries to reset activation-related settings to successfully activate a subscription version of Office.

In the full version of the Assistant, the equivalent scenario entry point is *Office & Office Apps \ I've installed a subscription version of Office, but I can't activate it*.

**Note** This scenario requires an elevated command prompt. To open an elevated Command Prompt window, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

## Download the Assistant

Download the Assistant by selecting the button below:

> [!div class="nextstepaction"]
> [Download the Assistant (Enterprise version)](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the Enterprise version of the Assistant, see [Enterprise version of Microsoft Support and Recovery Assistant](sara-command-line-version.md).

## Available switches for this scenario

The following switches are available for this scenario. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Office Activation scenario, use `OfficeActivationScenario` as the value of `scenarioname`.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-CloseOffice`|The `-CloseOffice` switch closes all running Office apps.|Required|
|`-RemoveSCA`|The `-RemoveSCA` switch removes Shared Computer Activation (SCA) and configures non-SCA activation for Office.|Optional|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for *SaRAcmd.exe*. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here are sample combinations of switches to run this scenario:

- Sample 1

  To ensure requirements are met for Office activation and to prepare for successful activation on the next launch of an Office app, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeActivationScenario -AcceptEula -CloseOffice
  ```

- Sample 2

  To perform the same steps in sample 1 and remove Office SCA (if enabled), run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeActivationScenario -AcceptEula -CloseOffice -RemoveSCA
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

|Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
|---|---|---|
|User doesn't include the `-CloseOffice` switch|Exit the scenario|01: This scenario requires the `-CloseOffice` switch. Note, if Office is running, the `-CloseOffice` switch closes Office applications. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
|Office isn't installed|Exit the scenario|30: Could not find an installed version of Office |
|Office subscription not found|Exit the scenario|31: Could not find a subscription version of Office. Please see [https://aka.ms/SaRA-Cmdline-NoSubscriptionFoun](https://aka.ms/SaRA-Cmdline-NoSubscriptionFound) for troubleshooting information.|
|Device subscription detected.|Exit the scenario|32: Device subscription detected. See [https://aka.ms/SaRA_DeviceActivationDetectedCmd](https://aka.ms/SaRA_DeviceActivationDetectedCmd) for troubleshooting and configuration information.|
|The Assistant isn't elevated|Exit the scenario|33: This scenario requires an elevated command-prompt.|
|Shared Computer Activation (SCA) is enabled for Office|Exit the scenario|34: Shared Computer Activation (SCA) is enabled for Office. Please use the `-RemoveSCA` switch if you want this scenario to remove SCA and configure non-SCA activation for Office. Otherwise, use the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Failure to complete the scenario (for any reason)|Exit the scenario|35: We ran into a problem. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Scan completed successfully|Exit the scenario|36: Successful run. Start any Office app and sign-in to activate.|
|Office is already activated|Exit the scenario|37: It looks like Microsoft Office is already activated. If you don't think this is correct, please run the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine). |
|Failure to complete the scenario (for any reason)|Exit the scenario|38: \<message depends on the ReasonCode\> |
|Unable to activate Office|Exit the scenario|39: Office may not be activated. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeActivation-CmdLine](https://aka.ms/SaRA-OfficeActivation-CmdLine).|
|Failure to complete the scenario|Exit the scenario|40: Cannot reach all endpoints required for activation. Please run the full UI version of SaRA.|
