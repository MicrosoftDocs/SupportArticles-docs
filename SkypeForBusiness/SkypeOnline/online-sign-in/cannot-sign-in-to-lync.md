---
title: Cannot sign in to Lync because this sign-in address was not found
description: Describes an issue that occurs when you try to sign in to Skype for Business Online. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Error message when you try to sign in to Skype for Business Online: "Cannot sign in to Lync because this sign-in address was not found"

## Problem

When you try to sign in to Skype for Business Online (formerly Lync Online), you receive the following error message:

> Cannot sign in to Lync because this sign-in address was not found. Verify the sign-in address and try again. If the problem continues, please contact your support team.

## Solution

To resolve this issue, first make sure that the user is licensed for Skype for Business Online in the Microsoft 365 portal. After the user is licensed, the user will be displayed in the Lync Admin Center.

If you're synchronizing your on-premises Active Directory with Microsoft 365 and the user is already licensed for Skype for Business Online but still can't sign in, make sure that the value of **msRTCSIP-UserEnabled** is **TRUE** in the on-premises Active Directory schema. Force a directory synchronization, and then wait 30 minutes. To do this, follow these steps:

1. If you're in a Lync hybrid environment and still running Lync Server on-premises, enable the user for Lync through the Lync Control Panel or Lync Management Shell, and then move them to Skype for Business Online.   
2. If you aren't in a Lync hybrid environment, but still have an on-premises Lync Server, delete the user from the Lync Control Panel or Lync Management Shell. Deleting the user and not just disabling them, from Lync will remove the values in** msRTCSIP** attributes for the user. You can also follow the next steps to manually fix the issue.   
3. If you previously had an Office Communications Server (OCS) or Lync deployment that's no longer being used, you may have to manually edit the user's **msRTCSIP** attributes to fix the issue. Open Active Directory Service Interfaces Edit (ADSIEdit) from the on-premises domain controller. For information about ADSIEdit, go to the following Microsoft website. (This includes information about how to add ADSIEdit to the Microsoft Management Console [MMC].)

    [TechNet: Adding ADSI Edit to MMC](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)#bkmk_addingadsiedit)
1. Locate the user who can't sign in to Skype for Business Online. To do this, build an LDAP query in ADSIEdit. For help with building the appropriate query and in locating the correct user, see [TechNet: Using ADSI Edit](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)#bkmk_usingadsiedit).   
1. When the correct user is found, change the msRTCSIP-UserEnabledattribute to TRUE.   
1. Use the Force the Directory Sync Tool to sync with Microsoft 365, and then wait approximately 30 minutes for the change to take effect in Microsoft 365. 

For more information about how to synchronize your directories, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).


## More Information

This issue may occur if one or more of the following conditions are true:

- You are running the Active Directory Sync Tool together with an on-premises Active Directory schema.   
- You have or previously had a deployment of Lync Server 2010 or of Office Communications Server 2007, together with Active Directory schema extensions. 
- In a previous deployment, the **msRTCSIP-UserEnabled** attribute was set to **FALSE**. This attribute value is synced to Microsoft 365 and disables the Skype for Business Online license of the Skype for Business Online user who can't sign in. (However, the Skype for Business Online license is still displayed as enabled in the Microsoft 365 portal.)   


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).