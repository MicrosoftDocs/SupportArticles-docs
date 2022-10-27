---
title: Office uninstall with Microsoft Support and Recovery Assistant
description: Describes available switches and conditions when using the enterprise version of Microsoft Support and Recovery Assistant to uninstall Office.
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
# Scenario: Office Uninstall

The Office Uninstall scenario removes any version of Office from a device. This scenario automates all of the steps that are described and provided in [Uninstall Office from a PC](https://support.microsoft.com/office/9dd49b83-264a-477a-8fcc-2fdf5dbf61d8).

In the full version of the Assistant, the equivalent scene entry point is *Office & Office Apps \ I have Office installed, but I'm having trouble uninstalling it*.

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
|`-S <scenarioname>`|Use the `-S` switch to specify the scenario that you want to run. For the Office Uninstall scenario, use `OfficeScrubScenario` as the value of `scenarioname`.|Required|
|`-AcceptEula`|The End User License Agreement (EULA) must be accepted before a scenario can be run.|Required|
|`-OfficeVersion`|The `-OfficeVersion` switch removes the Office version that's defined in the `<version>` parameter. The allowed values for `<version>` are: All, M365, 2021, 2019, 2016, 2013, 2010, and 2007.|Optional|

The following switches are available for all scenarios.

|Switch \<parameter\>|Details|Required/Optional|
|---|---|---|
|`-DisplayEULA <file path>`|Use the `-DisplayEULA` switch to display the EULA. You can save the EULA text to a file by specifying a path to the file with the switch.|Optional|
|`-Help`|The `-Help` switch displays a link to online content for additional information. If you use the `-Help` switch along with other switches, it will override all the others except the `-?` switch.|Optional|
|`-?`|Use the `-?` switch to display the functions of all the switches that are available for *SaRAcmd.exe*. If you use the `-?` switch along with other switches, it will override the others.|Optional|

## Sample commands

Here is a sample combination of switches to run this scenario:

- Sample 1

  To uninstall the detected installed version of Office, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeScrubScenario -AcceptEula
  ```

- Sample 2

  To uninstall a subscription version of Office such as Microsoft 365 Apps for enterprise, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeScrubScenario -AcceptEula -OfficeVersion M365
  ```

- Sample 3

  To uninstall Office 2016 only, run the following command from an elevated Command Prompt window:

  ```console
  SaRAcmd.exe -S OfficeScrubScenario -AcceptEula -OfficeVersion 2016
  ```

- Sample 4

  To uninstall all versions of Office, run the following command from an elevated Command Prompt window:

  ```console  
  SaRAcmd.exe -S OfficeScrubScenario -AcceptEula -OfficeVersion All
  ```

## Detected conditions and results

When you run a scenario by using the Enterprise version of the Assistant, you don't receive any prompts. It's a different experience from the full version of the Assistant. The following table describes the actions that the Enterprise version of the Assistant takes for each condition encountered by this scenario, and the corresponding output that it displays.

|Condition|Action taken by the Enterprise version|Output shown in the command prompt window|
|---|---|---|
|Office is removed successfully|None|00: Successfully completed this scenario.<br/><br/>**Note**: We recommend you restart the computer to finish any remaining cleanup tasks.|
|Office program found .exe files running: `lync`, `winword`, `excel`, `msaccess`, `mstore`, `infopath`, `setlang`, `msouc`, `ois`, `onenote`, `outlook`, `powerpnt`, `mspub`, `groove`, `visio`, `winproj`, `graph`, `teams`|Exit the scenario|06: Office programs are running. Please close all open Office programs and then rerun this scenario.|
|No Office products found and the `-OfficeVersion` switch isn't used|Exit the scenario|68: We could not find any Office version. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).<br/><br/>**Note**: For SaRA command line users with version 17.00.8256.000 or earlier, the error displayed is:<br/><br/>-07: No installed Office versions were found. Please use the full SaRA version.|
|Multiple Office versions are detected as installed and the `-OfficeVersion` switch isn't used|Exit the scenario|08: Multiple Office versions were found. Please use the full SaRA version.|
|Failure to remove Office|Exit the scenario|09: Failure to remove Office. Please use the full SaRA version.|
|The Assistant isn't elevated|Exit the scenario|10: SaRA needs to run elevated for this scenario. Please use an elevated command-prompt.|
|Office version specified on the command line doesn't match the detected installed version|Exit the scenario|66: We could not find the specified Office version. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
|Invalid Office version specified on the command line|Exit the scenario|67: The Office version that you have specified is invalid. Please rerun this scenario specifying the correct Office version that is installed on your machine. You can also run this scenario using the full UI version of SaRA. For additional information, please visit [https://aka.ms/SaRA_CommandLineVersion](https://aka.ms/SaRA_CommandLineVersion).|
