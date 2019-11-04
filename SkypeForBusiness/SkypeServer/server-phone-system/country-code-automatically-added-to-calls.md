---
title: +<Country code> is automatically added to all calls
description: Describes an issue in which Skype for Business for iOS users see +<country code> added to the beginning of phone numbers that they want to dial on an iPhone or iPad. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: rischwen， landerl， mirung， corbinm
appliesto:
- Skype for Business for iOS
---

# + is automatically added to all Skype for Business for iOS calls

## Symptoms

After you upgrade to the Skype for Business for iOS application on your iPhone or iPad, you notice that "+<**country code**>" is automatically added at the front of the number text box. This may cause a problem for customers who dial by using an extension or who have other custom dialing behavior. 

For example, customers are in the **United States**, which has a country code of **1**. They are used to dialing "5000" to call an internal DID. However, the dialing rules encounter "+15000" instead. In this situation, the call may fail for this user.

## Cause

The same dialing behavior in the Skype Consumer iOS application are adopted by the Skype for Business for iOS application. This includes automatically adding +<**country code**> to all calls.

## Resolution

This issue can be addressed by both the user and the Enterprise Voice administrator in the on-premises deployment.

**HOW TO FIX:**

In the Skype for Business for iOS application, the user can press and hold the **Delete** button to backspace over the +<**country code**> entry. 

Enterprise Voice administrators can manipulate dialed numbers by using normalization rules within the dial plan. They may also be able to use a trunk translation rule to do this, depending on the dial plan configuration.

## More Information

For more information, see the following TechNet resources:

[Plan for outbound voice routing in Skype for Business Server 2015](https://technet.microsoft.com/library/gg413082.aspx)

[Set-CsTrunkConfiguration](https://technet.microsoft.com/library/gg398238.aspx)
