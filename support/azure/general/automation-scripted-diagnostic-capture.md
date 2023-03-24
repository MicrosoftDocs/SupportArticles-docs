---
title: How to capture Azure Automation-scripted diagnostics
description: Provides guidance for capturing diagnostic information for Microsoft Support engineers. 
ms.date: 08/14/2020
ms.service: automation
ms.author: genli
author: genlin
ms.reviewer: jfanjoy
---
# How to capture Azure Automation-scripted diagnostics

Azure Automation handles lots of user-defined data that represents a potential privacy risk. During Azure Automation troubleshooting, users must provide a significant amount of data to Microsoft Support. This article provides guidance for capturing diagnostic information for Microsoft Support engineers.

_Original product version:_ &nbsp; Azure Automation  
_Original KB number:_ &nbsp; 4034605

## Diagnostic script

The Azure Automation support team has created a script to capture troubleshooting information. The script is stored on the [PowerShell Gallery](https://www.powershellgallery.com/) website. The script uses the Package Management capabilities that were introduced in Windows PowerShell 5.0.

## Requirement: Package Management

If you're using a computer that's running Windows 10 or Windows Server 2016, you already have PowerShell 5.0 or a later version installed. In that case, go to [Installing the diagnostic script](#install-the-diagnostic-script).

If you're running an earlier version of Windows PowerShell, you must either upgrade to the latest version of Windows Management Framework (WMF), which includes PowerShell, or install the package management components for PowerShell 3.0 or 4.0.

- To get the latest version of WMF, go to [Windows Management Framework 5.1](https://www.microsoft.com/download/details.aspx?id=54616).
- For more information about how to use and manage PowerShell, go to the [PowerShell Gallery website](https://www.powershellgallery.com/).

To determine the version of Windows PowerShell that you're currently running, open a PowerShell session, type `$PSVersionTable`, and then press Enter.
  
The following screenshot shows an example of the command output.

:::image type="content" source="media/automation-scripted-diagnostic-capture/powershell-version.png" alt-text="Screenshot of the version of Windows PowerShell." border="false":::

The **PSVersion** property indicates which version of PowerShell is being used. In this example, PowerShell 5.1 is installed.

## Requirement: Azure Resource Management

You must install the Azure Resource Management (AzureRM) module to be able to query information from Azure through PowerShell. Make sure that your computer meets the Package Management requirements before you continue.

To install the AzureRM module, follow these steps:

1. Open a **PowerShell** session by using the **Run as administrator** option.
2. Type `Install-Module -Name AzureRM -Force -Verbose`, and press Enter.
3. Wait for the installation to complete. You should be returned to the PowerShell prompt.
4. To verify that the module was installed, type `Get-Module -Name AzureRM -ListAvailable`, and then press Enter.

If the module is installed, the name and version number of the module are returned. If nothing is returned, the module was not installed successfully.

## Install the diagnostic script

The diagnostic script is maintained on the PowerShell Gallery website. You can install the script by using PowerShell Package Management. The script requires the AzureRM module to run. Make sure that your computer meets the Package Management requirements and has the AzureRM module installed before you continue.

To install the diagnostic script, follow these steps:

1. Open a PowerShell session by using the **Run as administrator** option.
2. Type `Install-Script -Name Get-AzureAutomationDiagnosticResults -Force` and press **Enter**.
3. Wait for the installation to finish. You should be returned to the PowerShell prompt.
4. To confirm the script was installed, type `Get-InstalledScript -Name Get-AzureAutomationDiagnosticResults` and press **Enter**.

If the script is installed, you should see a result including the name and version of the script. If nothing is returned, then the script was not successfully installed.

## Run the diagnostic script

After the script is successfully installed, follow these steps to run it:

1. Open a **PowerShell** session by using the **Run as administrator** option.
2. Type `Get-AzureAutomationDiagnosticResults`, and then press **Enter**.

The script first verifies that all Package Management requirements are met.  Then, it prompts you to sign in to Azure.

> [!NOTE]
> You must sign in by using an account that has permissions to the subscription content. This includes Automation accounts. If more than one subscription is available to the logon account, you are prompted to select the appropriate subscription.

The script then runs on its own to collect relevant data.

## After script runs

After the script runs, it opens a Windows File Explorer window that points to the folder in which it stored the captured information.  To have the information analyzed, compress the storage folder, and then send the compressed file to Microsoft Support.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
