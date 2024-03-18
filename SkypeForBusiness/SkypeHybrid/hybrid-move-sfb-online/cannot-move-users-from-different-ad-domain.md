---
title: Cannot move users from a different AD domain from Control Panel
description: Describes an issue in which users from a different AD domain in a Skype for Business Server hybrid environment cannot be moved to Skype for Business Online from Control Panel. Provides a workaround.
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
appliesto: 
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# You cannot move users from a different AD domain in hybrid Skype for Business Server to Skype for Business Online from Control Panel

## Symptoms

In a Microsoft Skype for Business Server 2015 hybrid environment that has a multidomain Active Directory Domain Services (AD DS) topology, a user from a child AD domain cannot be moved to Skype for Business Online from Control Panel. The move operation fails and returns the following error message:    
 
**Cannot find user in Active Directory with the following SIP URI: \<SipAddress>.**     

## Cause

By design, the scope of the user query for hosted migration from Skype for Business Server Control Panel is limited to the AD DS domain of the Skype for Business servers. During the move operation, Control Panel runs the **Move-CsUser** PowerShell cmdlet without the **DomainController** parameter. 

## Workaround

To work around this issue, use the **Move-CsUser** cmdlet together with the **DomainController** parameter.