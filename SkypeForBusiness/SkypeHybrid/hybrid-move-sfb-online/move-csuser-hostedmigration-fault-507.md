---
title: Move-CsUser HostedMigration fault Error=(507) when move to Online
description: To resolve this issue, you must assign the user a license for Skype for Business Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Skype for Business Online
---

# "Move-CsUser : HostedMigration fault: Error=(507)" error message when you try to move a user to Skype for Business Online in a Lync hybrid deployment

## Problem 

In a Lync hybrid deployment, when you try to move a user to Skype for Business Online (formerly Lync Online) by using Skype for Business Online PowerShell, you receive the following error message:

**Move-CsUser : HostedMigration fault: Error=(507), Description=(User must has an assigned license to use Skype for Business Online.)**

![Screen shot of the error message after you run Move-CsUser cmdlet in Skype for Business Online PowerShell ](https://support.microsoft.com/Library/Images/2832980.jpg)

## Solution 

Before you try to move the user to Skype for Business Online, the user must be enabled for both Lync Server on-premises and Skype for Business Online. The solution is to sign in to the Microsoft 365 admin center and then assign the user a license for Skype for Business Online. For more information about how to assign a license to a user, go to the following Microsoft website: [Assign or remove a license](https://office.microsoft.com/redir/ha102816053)  

## More information

After you assign a license, you may receive the error that is mentioned in the "Problem" section until the user is fully provisioned for Skype for Business Online. This can require up to 30 minutes in some cases.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).