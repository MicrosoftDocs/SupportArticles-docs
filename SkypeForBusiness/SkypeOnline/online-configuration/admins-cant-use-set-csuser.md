---
title: Skype for Business Online admins can't use Set-CsUser cmdlet
description: Describes the issue in which Microsoft Skype for Business Online admins can't use the Set-CsUser cmdlet in Skype for Business Online Remote PowerShell. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-swei
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# Skype for Business Online admins can't use the "Set-CsUser" cmdlet in Skype for Business Online Remote PowerShell

## Problem

When you try to use the **[Set-CsUser](/powershell/module/skype/set-csuser)** cmdlet to change a user or group of users in Skype for Business Online (formerly Lync Online), you receive the following error message:

**Unable to set "SipAddress". This parameter is restricted within Remote Tenant PowerShell.**

> [!NOTE]
> Depending on the task that you're trying to perform, the parameter may be different. However, the error message will always resemble the message that's shown in this section.

## Solution

**AudioVideoDisabled** is the only parameter that you can use together with the **Set-CsUser** cmdlet in Skype for Business Online. Depending on what you were trying to do, you may be able to complete the same task by using other available cmdlets.

## More information

The **Set-CsUser** cmdlet is included in the set of cmdlets that are available to Skype for Business Online administrators. However, you can't currently use the **Set-CsUser** cmdlet to manage Skype for Business Online. The only exception is that you can use this cmdlet to set the AudioVideoDisabled parameter. This is by design.

For more information about how to perform various administrative tasks by using Skype for Business Online Remote PowerShell, see [Set up your computer for Windows PowerShell](/SkypeForBusiness/set-up-your-computer-for-windows-powershell/set-up-your-computer-for-windows-powershell).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).