---
title: Unable to determine routing domain for cloud organization
description: Describes an issue in which you receive an Unable to determine the routing domain for the cloud organization error message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# "Unable to determine the routing domain for the cloud organization" error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3068010

## Symptoms

When you run the Hybrid Configuration wizard, you receive an **Unable to determine the routing domain for the cloud organization** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites  
Microsoft.Exchange.Data.Common.LocalizedException: Unable to determine the routing domain for the cloud organization.  
Unable to determine the routing domain for the cloud organization.  
at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(ITask taskBase, ITaskContext taskContext)

## Resolution

Enable directory synchronization. When directory synchronization is enabled, the routing domain is created. To enable directory synchronization, follow these steps:

1. Connect to Microsoft Entra ID by using Windows PowerShell. For more information about how to do so, see [Connect to Microsoft Entra ID](/powershell/azure/active-directory/overview?view=azureadps-1.0#connect-to-azure-ad&preserve-view=true).
2. Run the following command:

    ```powershell
    Set-MsolDirSyncEnabled -EnableDirsync $true
    ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
