---
title: Reset Office activation with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant to reset Office activation.
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
# Scenario: Reset Office Activation

The Reset Office Activation scenario automates all of the checks and scripts that are described and provided in [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

This scenario isn't available in the full version of the Assistant.

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
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Reset Office Activation scenario, use `ResetOfficeActivation` as the value of `scenarioname`.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-CloseOffice`|The `-CloseOffice` switch closes all running Office apps.|Required|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for *SaRAcmd.exe*. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here is a sample combination of switches to run this scenario:

- To reset Office activation, run the following command from an elevated command prompt.

  ```console
  SaRAcmd.exe -S ResetOfficeActivation -AcceptEula -CloseOffice
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

> [!div class="mx-tdCol3BreakAll"]
> |Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
> |---|---|---|
> |Scan completed successfully|Exit the scenario|80: Successful run. Start any Office app and sign-in to activate.|
> |User doesn't include the `-CloseOffice` switch|Exit the scenario 01: This scenario requires the `-CloseOffice` switch. Note, if Office is running, the `-CloseOffice` switch closes Office applications. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
> |Error performing any action(s)|Exit the scenario|71: We ran into a problem. Please run the Office Activation scenario in the full UI version of SaRA. You can download SaRA from [https://aka.ms/SaRA-OfficeActivation-Cmdline](https://aka.ms/SaRA-OfficeActivation-Cmdline). |
> |Command-prompt not elevated|Exit the scenario|72: The scenario requires an elevated command-prompt.|
> |Failure to run the OLicenseCleanup script|Exit the scenario|73: We ran into a problem running OLicenseCleanup.vbs. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps.|
> |Failure running `Dsregcmd`|Exit the scenario|74: We ran into a problem running Dsregcmd. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps.|
> |Windows build requirement not met|Exit the scenario|75: Windows is not at least Windows 10 version 1803. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps|
> |Failure to run the `SignOutOfWamAccounts` script|Exit the scenario|76: We ran into a problem running SignOutOfWamAccounts.ps1. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps.|
> |`WPJCleanup` script requirements not met|Exit the scenario|78: WorkplaceJoined=True, but Windows 10 is not at least version 1809. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps.|
> |Failure to run the `WPJCleanup` script|Exit the scenario|79: We ran into a problem running WPJCleanup. See [https://learn.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state) for manual reset steps.|
