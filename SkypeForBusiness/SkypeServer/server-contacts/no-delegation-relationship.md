---
title: No delegation relationship in Lync 2013 (Skype for Business)
description: Fixes an issue that prevents you from being displayed as a delegate in Lync 2013 (Skype for Business) after you are added by the delegator in Outlook 2013. Therefore, you can't create a meeting. A resolution is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: nichburk
appliesto: 
  - Lync 2013
  - Skype for Business 2015
ms.date: 03/31/2022
---

# No delegation relationship in Lync 2013 (Skype for Business) even though you're a delegate in Outlook 2013

## Symptoms

Consider the following scenario:
- You've been added as a delegate in Microsoft Outlook 2013.   
- The EnableExchangeDelegateSync parameter of the delegator's client policy is set to $True.   
- The EnableDelegation parameter of the delegator's voice policy is set to $False.   
- Neither the delegator nor your accounts are enabled for Enterprise Voice (EV).   
- MAPI information on the Microsoft Lync 2013 (Skype for Business) client Configuration Information page shows MAPI Status OK.   
- You aren't displayed in the Delegates group in the Lync 2013 (Skype for Business) contact list.   
- The delegator isn't displayed in the People I Manage Calls For group in Lync 2013 (Skype for Business) contact list.   

In this scenario, you can't create a Lync (Skype for Business) meeting for the delegator in the Outlook client.

## Cause

This issue occurs because of a conflict in delegation parameter settings between the client policy and the voice policy that are assigned to the delegator.

The Lync 2013 (Skype for Business) client can add you as a delegate only if both the EnableExchangeDelegateSync parameter of the delegator's client policy and the EnableDelegation parameter of the delegator's voice policy are set to $True.

## Resolution

To fix the issue, use one of the following methods:

- Method 1:
  - Make sure that the EnableExchangeDelegateSync parameter in delegator's the client policy is set to $True.   
  - Make sure that the EnableDelegation parameter in the delegator's voice policy is set to $True.   
  - Remove and re-add the delegate relationship if necessary.   

  **Note** This is the recommended solution because it requires the least amount of administrative effort.
- Method 2:

   The appropriate administrator can manage delegator and delegate relationships by using the SEFAUtil.exe tool. For more information, see [Lync Server 2013 Resource Kit Tools Documentation](/previous-versions/office/lync-server-2013/lync-server-2013-resource-kit-tools-documentation).   

## More Information

By default, the EnableDelegation parameter is set to $True in the voice policy. For more information about voice policy parameters. see [New-CsVoicePolicy](/powershell/module/skype/New-CsVoicePolicy).

To check the value for the EnableExchangeDelegateSync parameter, run the following cmdlet:

```powershell
Get-CsClientPolicy -Identity <ClientPolicyAssignedToDelegator> | Select EnableExchangeDelegateSync 
```

To check the value of the EnableDelegation parameter, run the following cmdlet: 

```powershell
Get-CsVoicePolicy -Identity <VoicePolicyAssignedToDelegator> | Select EnableDelegation 
```

These settings can also be confirmed by using the Snooper tool to analyze the client UCCAPILOG file and by checking the values of the following settings that are returned from Lync Server 2013 Front End server:

- EnableExchangeDelegateSyncUp   
- EnableDelegation   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).