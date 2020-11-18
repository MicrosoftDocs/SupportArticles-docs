---
title: Unable to determine routing domain for cloud organization
description: Describes an issue in which you receive an Unable to determine the routing domain for the cloud organization error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition 
search.appverid: MET150
---
# (Unable to determine the routing domain for the cloud organization) error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3068010

## Symptoms

When you run the Hybrid Configuration wizard, you receive an **Unable to determine the routing domain for the cloud organization** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites  
Microsoft.Exchange.Data.Common.LocalizedException: Unable to determine the routing domain for the cloud organization.  
Unable to determine the routing domain for the cloud organization.  
at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(ITask taskBase, ITaskContext taskContext)

## Resolution

Enable directory synchronization. When directory synchronization is enabled, the routing domain is created. To enable directory synchronization, follow these steps:

1. Connect to Azure Active Directory (Azure AD) by using Windows PowerShell. For more info about how to do this, see [Manage Azure AD using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)).
2. Run the following command:

    ```powershell
    Set-MsolDirSyncEnabled -EnableDirsync $true
    ```

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
