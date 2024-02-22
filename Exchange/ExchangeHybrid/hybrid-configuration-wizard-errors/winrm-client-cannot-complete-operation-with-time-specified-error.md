---
title: WinRM client cannot complete operation within time specified
description: Describes an issue in which you receive a Processing data from remote server failed with The WinRM client cannot complete the operation within the time specified error message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# (The WinRM client cannot complete the operation within the time specified) error when you run Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067913

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive a **The WinRM client cannot complete the operation within the time specified** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Configure Recipient Settings  
Execution of the Update-EmailAddressPolicy cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.  
Processing data from remote server failed with the following error message: The WinRM client cannot complete the operation within the time specified. Check if the machine name is valid and is reachable over the network and firewall exception for Windows Remote Management service is enabled. For more information, see the about_Remote_Troubleshooting Help topic.  
 at System.Management.Automation.PowerShell.CoreInvoke[TOutput](IEnumerable input, PSDataCollection\`1 output, PSInvocationSettings settings  
 at System.Management.Automation.PowerShell.Invoke(IEnumerable input, PSInvocationSettings settings)  
 at System.Management.Automation.PowerShell.Invoke()  
 at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary\`2 parameters, Boolean ignoreNotFoundErrors)

## Cause

This issue may occur if a time-out occurs while the following command is running to apply email address policies:

```powershell
Update-EmailAddressPolicy -Identity 'CN=Default Policy,CN=Recipient Policies,CN=<Exchange Org>,
CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=<DN of Org>
```

In large organizations, this command may experience a time-out if there are significant changes to email address policies.

## Resolution

To resolve this issue, follow these steps:

1. Open the Exchange Management Shell, and then run the following command:

    ```powershell
    Update-EmailAddressPolicy -Identity 'CN=Default Policy,CN=Recipient Policies,CN=<Exchange Org>,
    CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=<DN of Org>
    ```

2. Rerun the Hybrid Configuration wizard.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
