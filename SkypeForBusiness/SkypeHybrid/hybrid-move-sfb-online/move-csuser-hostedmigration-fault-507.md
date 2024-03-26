---
title: Move-CsUser HostedMigration fault Error=(507) when move to Online
description: To resolve this issue, you must assign the user a license for Skype for Business Online.
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
  - Skype for Business Online
ms.date: 03/31/2022
---

# "Move-CsUser: HostedMigration fault: Error=(507)" error message when you try to move a user to Skype for Business Online in a Lync hybrid deployment

## Problem 

In a Lync hybrid deployment, when you try to move a user to Skype for Business Online (formerly Lync Online) by using Skype for Business Online PowerShell, you receive the following error message:

**Move-CsUser: HostedMigration fault: Error=(507), Description=(User must has an assigned license to use Skype for Business Online.)**

:::image type="content" source="./media/move-csuser-hostedmigration-fault-507/powershell.png" alt-text="Screenshot that shows the error message after running the Move-CsUser cmdlet in Skype for Business Online PowerShell.":::

## Solution 

Before you try to move the user to Skype for Business Online, the user must be enabled for both Lync Server on-premises and Skype for Business Online. The solution is to sign in to the Microsoft 365 admin center and then assign the user a license for Skype for Business Online. For more information about how to assign a license to a user, go to the following Microsoft website: [Assign or remove a license](/skypeforbusiness/skype-for-business-and-microsoft-teams-add-on-licensing/assign-skype-for-business-and-microsoft-teams-licenses)  

## More information

After you assign a license, you may receive the error that is mentioned in the "Problem" section until the user is fully provisioned for Skype for Business Online. This can require up to 30 minutes in some cases.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).