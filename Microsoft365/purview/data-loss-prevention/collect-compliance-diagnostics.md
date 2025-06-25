---
title: Collect Microsoft Purview Compliance Diagnostics
description: Discusses how to collect diagnostic data for issues in MIP and DLP by using the ComplianceDiagnostics tool.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Microsoft Information Protection (MIP)
  - Exchange Online
  - CSSTroubleshoot
  - CI 186303
ms.reviewer: sathyana, shrshet, jovind, meerak
appliesto: 
  - Exchange Online
  - Exchange Online Protection
  - Microsoft Purview
search.appverid: MET150
ms.date: 05/05/2025
---

# Collect Microsoft Purview compliance diagnostics

If you open a Microsoft Support case for an issue in Microsoft Purview Information Protection (MIP) or Microsoft Purview Data Loss Prevention (DLP), you might be asked to provide diagnostic data. We recommend that you use the Microsoft [ComplianceDiagnostics](https://www.powershellgallery.com/packages/ComplianceDiagnostics) tool to simplify, standardize, and streamline data collection.

The ComplianceDiagnostics tool is a PowerShell module that's hosted in the PowerShell Gallery. You can select any of the several data collection templates that are available in the tool. Your selection determines what diagnostic data is gathered. Typically, a Microsoft Support engineer requests diagnostic data and tells you which data collection template to use.

> [!NOTE]
> The ComplianceDiagnostics tool doesn't modify, delete, or transmit diagnostic data. The tool processes diagnostic files and saves the collected data to a local .zip file. You can review the contents of the .zip file before you share it with a Microsoft Support engineer.

## Prerequisites

To use the ComplianceDiagnostics tool, make sure that your environment meets the following requirements:

- You have PowerShell 5.0 or a later version installed. As a best practice, install the latest version of [PowerShell](https://aka.ms/PSWindows).

- You have [ExchangeOnlineManagement module](https://www.powershellgallery.com/packages/ExchangeOnlineManagement/) 3.0 or a later version installed.

- The PowerShell Gallery is in the list of PowerShell repositories on your local computer. To check the list, run the following PowerShell cmdlet:

  ```PowerShell
  Get-PSRepository -Name PSGallery
  ```

  If the PowerShell Gallery isn't in the list, add it by running the following PowerShell cmdlet in an elevated PowerShell session:

  ```PowerShell
  Register-PSRepository -Default
  ```

- You are a Compliance administrator in [Microsoft Purview](https://compliance.microsoft.com/compliancecenterpermissions).

- Your PowerShell execution policy is set to `RemoteSigned`. To check the setting, run the following PowerShell cmdlet:

  ```PowerShell
  Get-ExecutionPolicy -List
  ```

  If the PowerShell execution policy isn't set to `RemoteSigned`, set it by running the following PowerShell cmdlet:

  ```PowerShell
  Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
  ```

  After you close the tool, you can revert to your usual PowerShell execution policy.

## Install the tool

Install the latest version of the ComplianceDiagnostics tool by running the following PowerShell cmdlet:

```PowerShell
Install-Module ComplianceDiagnostics -Force
```

Note: As a best practice, run the command periodically to install the latest tool version.

## Run the tool

To open the ComplianceDiagnostics tool, run the following PowerShell cmdlet and then sign in to the Exchange Management Shell and Security & Compliance PowerShell when you're prompted.

```PowerShell
Start-ComplianceDiagnostics
```

> [!NOTE]
> By default, the tool connects to the production environment (O365Default). To change the environment, use the Start-ComplianceDiagnostics cmdlet together with the `Environment` switch. For example, `Start-ComplianceDiagnostics -Environment O365China`. The following `Environment` values are supported:
>
> - O365Default
> - O365GermanyCloud
> - O365China
> - O365USGovGCCHigh
> - O365USGovDoD

After the following command output appears in the terminal, the ComplianceDiagnostics tool opens in a new PowerShell window:

```output
Checking presence of ExchangeOnlineManagement PowerShell Module  
Connecting to ExchangeManagement Shell. Please check your login prompt.
Connecting to Security & Compliance PowerShell. Please check your login prompt.
Getting Sensitive information types in your organization.
Getting Sensitive information rule packages in your organization.
Getting Keyword dictionaries in your organization.
Getting sensitivity labels in your organization.
Getting sensitivity label policies in your organization.
Getting data loss prevention (DLP) policies in your organization.
Getting data loss prevention (DLP) rules in your organization.
Getting Autolabeling policies in your organization.
Getting Autolabeling rules in your organization.
Getting IB labels in your organization.
Getting IB policies in your organization.
Getting IB Application Status for your organization.
Starting UX......
```

## Collect diagnostic data

Follow these steps:

1. Select the data collection template that matches your issue from the following options:

   - **Data Classification** \> **Classification**
   - **Data Classification** \> **EDM**
   - **Data Classification** \> **Activity/Content Explorer**
   - **Information Protection** \> **MIP Labels**
   - **Data Loss Prevention** \> **Exchange DLP**
   - **Data Loss Prevention** \> **SPO/ODB DLP**
   - **Data Loss Prevention** \> **Teams DLP**
   - **Data Loss Prevention** \> **Endpoint DLP**
   - **Data Loss Prevention** \> **Collect DLP Alerts Data**
   - **Auto Labeling** \> **Exchange Auto Labeling**
   - **Auto Labeling** \> **SPO/ODB Auto Labeling**
   - **Encryption** \> **Encryption**
   - **Information Barriers** \> **Information Barriers**
   - **eDiscovery** \> **Hold**
   - **eDiscovery** \> **Search**
   - **eDiscovery** \> **Export**

   For example, to collect support data for an issue in which a sensitive information type (SIT) is incorrectly detected in a document, select the **Data Classification** \> **Classification** template.

2. Use the template fields to provide information about your issue. For example, you could add a sample file, a trace file, and an email alert message, as shown in the following screenshot.

   :::image type="content" source="media/collect-compliance-diagnostics/tool-template.png" border="true" alt-text="Screenshot of the classification support data template in the tool UI." lightbox="./media/collect-compliance-diagnostics/tool-template.png":::

3. Select **Export Support Data**.

4. In the folder dialog box that opens, select a parent folder for the diagnostic data.

   Wait for the tool to finish processing the diagnostic data and write the processed data to an .json file. The tool generates a .zip file that packages the .json file together with any diagnostic files from the template. The tool then saves the .zip file to the parent folder that you selected, and then opens a completion dialog box.

   As an example of data processing, if you select the **Data Classification** \> **Classification** template, the tool fetches the applicable rule packs and keyword dictionaries, and then tests data classification on the sample file that you specify in the template.

5. Select **Yes** in the completion dialog box to view the .zip file in File Explorer.

## Review diagnostic data

Follow these steps:

1. Extract the contents of the .zip file.

2. Parse the .json file, and view the parsed data objects by running the following PowerShell commands:

   ```PowerShell
   # Get the content of the JSON file
    $jsonContent = Get-Content -Path "<JSON file path>" -Raw
   # Load the System.Web.Extensions assembly which is needed for the JavaScriptSerializer class
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
   # Create a new instance of JavaScriptSerializer with a specified maximum JSON length for deserialization
    $serializer = New-Object -TypeName System.Web.Script.Serialization.JavaScriptSerializer -Property @{MaxJsonLength=67108864}
   # Convert JSON content to PowerShell object
    $debugInfo = $serializer.DeserializeObject($jsonContent)
   # Show output
    $debugInfo
   ```
   For example, you might see the following data objects in the command output.

   :::image type="content" source="media/collect-compliance-diagnostics/data-objects-example.png" border="false" alt-text="Screenshot of an example data objects list." lightbox="./media/collect-compliance-diagnostics/data-objects-example.png":::

3. Get detailed diagnostic information by querying the data objects. For example, to list the publishers of the [DLP SIT rule packages](/powershell/module/exchange/get-dlpsensitiveinformationtyperulepackage), run the following command:

   ```PowerShell
   $debugInfo.EopRulePackage | FT Publisher, RuleCollectionName
   ```

   You might see the following rule package publishers in the command output.

   :::image type="content" source="media/collect-compliance-diagnostics/data-object-detail-example.png" border="false" alt-text="Screenshot of example data object details." lightbox="./media/collect-compliance-diagnostics/data-object-detail-example.png":::

After you finish the diagnostic data review, send the .zip file to Microsoft Support to investigate your issue.
