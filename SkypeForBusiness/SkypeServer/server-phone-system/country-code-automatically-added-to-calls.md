---
title: +<Country/Region code> is automatically added to all calls
description: Describes an issue in which Skype for Business for iOS users see +<country/region code> added to the beginning of phone numbers that they want to dial on an iPhone or iPad. Provides a resolution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: rischwen， landerl， mirung， corbinm
appliesto: 
  - Skype for Business for iOS
ms.date: 06/28/2023
---

# + is automatically added to all Skype for Business for iOS calls

## Symptoms

After you upgrade to the Skype for Business for iOS application on your iPhone or iPad, you notice that "+<**country/region code**>" is automatically added at the front of the number text box. This may cause a problem for customers who dial by using an extension or who have other custom dialing behavior.

For example, customers in the **United States** that have a country/region code of **1**. They are used to dialing "5000" to call an internal DID. However, the dialing rules encounter "+15000" instead. In this situation, the call may fail for this user.

## Cause

The same dialing behavior in the Skype Consumer iOS application is adopted by the Skype for Business for iOS application. This includes automatically adding +<**country/region code**> to all calls.

## Resolution

This issue can be addressed by both the user and the Enterprise Voice administrator in the on-premises deployment.

**HOW TO FIX:**

In the Skype for Business for iOS application, the user can press and hold the **Delete** button to backspace over the +<**country/region code**> entry. 

Enterprise Voice administrators can manipulate dialed numbers by using normalization rules within the dial plan. They may also be able to use a trunk translation rule to do this, depending on the dial plan configuration.

## More Information

For more information, see the following TechNet resources:

[Plan for outbound voice routing in Skype for Business Server 2015](/skypeforbusiness/plan-your-deployment/enterprise-voice-solution/outbound-voice-routing)

[Set-CsTrunkConfiguration](/powershell/module/skype/Set-CsTrunkConfiguration)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
