---
title: Access Denied when you connect to Office 365, Azure, or Intune
description: Describes an issue in which you can't connect to a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune by using the connect-MSOLService cmdlet in the Azure Active Directory Module for Windows PowerShell.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office 365
ms.topic: article
ms.author: v-six
---

# "Access Denied" error when you use the connect-MSOLService cmdlet to connect to Office 365

## Problem 

When you try to use the connect-MSOLService cmdlet in the Microsoft Azure Active Directory Module for Windows PowerShell to connect to a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune, your attempt is unsuccessful. Additionally, you may receive the following error message:

```asciidoc
Connect-MsolService : Access Denied. You do not have permissions to call this cmdlet.
```

## Solution 

To resolve this issue, check whether the user has the appropriate admin role.

## More information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.