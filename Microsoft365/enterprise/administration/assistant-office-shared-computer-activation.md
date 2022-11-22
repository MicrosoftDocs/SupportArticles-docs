---
title: Office shared computer activation with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant for Office shared computer activation.
author: helenclu    
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: gregmans; zebamehdi
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 10/25/2022
---
# Scenario: Office Shared Computer Activation

The Office Shared Computer Activation scenario automates checks and recoveries to enable or disable shared computer activation on a device. For more information, see [Overview of shared computer activation for Microsoft 365 Apps](/deployoffice/overview-shared-computer-activation).

In the full version of the Assistant, the equivalent entry point for this scenario is *Office & Office Apps \ I want to setup Office with shared computer activation on a computer or server in my organization*.

**Note** This scenario requires an elevated command prompt. To open an elevated Command Prompt window, select **Start**, enter *cmd*, right-click **Command Prompt** in the results, and then select **Run as administrator**.

## Download the Assistant

Download the Enterprise version of the Assistant by selecting the button below:

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA_EnterpriseVersionFiles)

For complete details about how to run the Enterprise version of the Assistant, see [Enterprise version of Microsoft Support and Recovery Assistant](sara-command-line-version.md).

## Available switches for this scenario

The following switches are available for this scenario. They aren't case-sensitive. The switches, unless noted as optional, are required to run the scenario. And more than one optional switch can be used.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Office Shared Computer Activation scenario, use `OfficeSharedComputerScenario` as the value of `scenarioname`.|Required|
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

  To enable Shared Computer Activation (SCA) on the machine, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeSharedComputerScenario -AcceptEula -CloseOffice
  ```

- Sample 2

  To remove Shared Computer Activation (if it's enabled) and configure non-SCA activation for Office, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeSharedComputerScenario -AcceptEula -CloseOffice -RemoveSCA
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

|Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
|---|---|---|
|Scan completed successfully|Exit the scenario|63: Scenario completed successfully. Please exit and restart Windows and sign back in as an end-user that needs to use Office.|
|User doesn't include the `-CloseOffice` switch|Exit the scenario|01: This scenario requires the `-CloseOffice` switch. Note, if Office is running, the `-CloseOffice` switch closes Office applications. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
|Error closing Office application|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Failure to remove SCA|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI). |
|Office isn't installed|Exit the scenario|60: This scenario requires an existing Office installation. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Error checking if Office is installed|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI). |
|Error determining if Office SKU is ProPlus or BusinessRetail|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
|Office SKU installed isn't ProPlus or BusinessRetail|Exit the scenario|61: This scenario requires an existing Office installation that supports Shared Computer Activation. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from https://aka.ms/SaRA-OfficeSCA-CmdLine.|
|Error running recovery action|Exit the scenario|62: We ran into a problem. Please run the Office Shared Computer Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeSCA-UI](https://aka.ms/SaRA-OfficeSCA-UI).|
