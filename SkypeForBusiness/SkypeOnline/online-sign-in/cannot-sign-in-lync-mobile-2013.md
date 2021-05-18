---
title: You can't sign in with this version of Lync in Lync Mobile 2013
description: Describes an issue in which users can't sign in and are asked to install Lync Mobile 2010 after Lync Mobile 2013 is installed. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# "You can't sign in with this version of Lync. Install Lync 2010" error after Lync Mobile 2013 is installed

## Problem 

After Lync Mobile 2013 is installed, users who try to sign in to their organization's Lync server or to Skype for Business Online (formerly Lync Online) in Office 365 receive the following error message:

**You can't sign in with this version of Lync. Install Lync 2010.**

## Solution 

If the users are signing in to an on-premises Lync Server 2013 deployment, you must apply Cumulative Update 1 for Lync Server 2013, and mobility must be enabled. For more information, go to the following Microsoft Knowledge Base article: 

[2809243](https://support.microsoft.com/help/2809243) Updates for Lync Server 2013 

If the users are signing in to Skype for Business Online in Office 365, they may have to wait until your organization receives the latest Skype for Business Online service upgrades.

For more information, see the following Microsoft websites: 
 
- [https://go.microsoft.com/fwlink/?linkid=2003907](https://go.microsoft.com/fwlink/?linkid=2003907)    

## More information

For more information about how to troubleshoot additional sign-in-related issues with Lync Mobile 2013, go to the following Microsoft Knowledge Base article: 

[2806012](https://support.microsoft.com/help/2806012) Users can't sign in to Skype for Business Online by using Lync Mobile 2013

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).