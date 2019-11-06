---
title: Support for 2013 versions of Office 365 ProPlus ends February 28, 2017
description: Describes the end of support for the 2013 versions of Office 365 ProPlus client applications and how to obtain the latest versions of Office 365 ProPlus.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office 365 ProPlus
- Office 365 Home
- Office 365 Personal
---

# Support for 2013 versions of Office 365 ProPlus ends February 28, 2017

## Introduction

This article explains that support for the 2013 versions of Office 365 client applications ended on February 28, 2017.
 > [!NOTE]
> This article doesn't apply to the Office 2013 Professional Plus, Professional, and Standard editions. To learn about the support dates for the Office 2013 Professional Plus, Professional, and Standard editions see the following Microsoft website: [Microsoft support lifecycle](https://support.microsoft.com/en-us/lifecycle/search/?p1=16674).

 Users who are running the 2013 versions of Office 365 client applications after February 28, 2017, will have to upgrade to the latest version of Office 365 client applications to continue to receive support from Microsoft. The following is a list of products for which support will end:  
- Office 365 ProPlus (2013)
- Office 365 Business Premium (2013)
- Office 365 Business (2013)
- Office 365 Home (2013)
- Office 365 Personal (2013)
- Project Pro for Office 365 (2013)
- Visio Pro for Office 365 (2013)
  
## More information

After February 28, 2017:
- All 2013 versions of Office 365 client applications (32-bit and 64-bit) and all language packs will no longer be available for installation from the Microsoft 365 admin center.
- Customers can obtain the latest 2013 version of Office through the Office Deployment Tool, for the installation of Office 365 client applications.
- Microsoft will not release any feature updates for these versions of the products.
- Microsoft will no longer provide support for these versions of the products through Customer Service and Support (CSS) or Microsoft Premier Support.
- Microsoft will continue to release critical and important security updates for these versions of the products until April 10, 2023. For more information, see [Security Bulletin Severity Rating System](https://technet.microsoft.com/security/gg309177.aspx).
- Microsoft will not provide notification before implementing potentially disruptive changes that may result in a service interruption for users of the 2013 versions of Office 365 client applications. For more information, see [Microsoft Online Services support lifecycle policy](https://support.microsoft.com/help/microsoft-online-services-support-lifecycle-policy).

#### How to get the latest version of Office 365 ProPlus

1. Contact the [FastTrack Center](https://aka.ms/requestonboarding) to get assistance for your Office 365 ProPlus deployment.

    The FastTrack engineers will help you upgrade 2013 clients to 2016 and make sure that you're on the latest service managed client. You can review the [FastTrack Benefit Overview](https://technet.microsoft.com/library/office-365-onboarding-benefit-process.aspx) to learn more about how to work remotely with Microsoft specialists to get your Office 365 environment ready for use, and to plan rollout and usage within your organization. The FastTrack Center can help you with testing, repackaging, and distributing the 2016 version of Office 365 ProPlus, or help you validate your deployment approach with a Microsoft engineer. To request assistance, go to the [FastTrack site](https://fasttrack.microsoft.com/), select the **Services** tab, and then submit the Request Office 2016 ProPlus Upgrade Assistance form. You can also contact your Microsoft sales representative or Technical Account Manager for assistance.

2. Get to know the Office channel release model.

    Office 2016 is shipping in multiple channels. These different release channels let you control who in your organization gets the latest release, based on your needs.

    The First Release for Deferred Channel (FRDC) lets you configure (per user) a group of early adopters. This group will receive the latest and greatest features four months in advance of a Deferred Channel (DC) release.Premier Support escalates any cases related to the FRDC build directly to the Office engineering team so that issues can be addressed before the DC release.

     The DC is made available only a few times a year (instead of every month) and is best for organizations that don't want to deploy the latest features of Office right away or that have a significant number of line-of-business (LOB) applications, add-ins, or macros that must be tested. This approach helps avoid compatibility issues that can potentially stall deployments.

     If you plan to roll out the DC June release, start testing FRDC now. For more information about channel release models, see [Overview of update channels for Office 365 ProPlus](https://technet.microsoft.com/library/mt455210.aspx).

3. Start a group of users on the First Release builds.

    This group could include the IT team or early adopters, and it will give them an opportunity to get comfortable with the new capabilities and test any LOB integrations that are critical to your business.

4. Determine which Exchange Server configuration is needed for your organization.

    If you plan to deploy the 2016 version of Office 365 ProPlus, and you're still using Exchange Server 2007, be aware that the 2016 version of Office 365 ProPlus won't support connections to Exchange Server 2007.

    Option 1: Move to Exchange Online in Office 365

     Office 365 ProPlus is built to support Exchange Online and the other Office 365 workloads. Customers deployed on Office 365 will always be up to date without a worry of end of support deadlines. The Microsoft FastTrack Center is ready to help and will provide onboarding guidance and data migration services to all eligible Office 365 customers.

     Option 2: Upgrade to the latest version of Exchange Server

     The 2016 version of Office 365 ProPlus does not support connections to Exchange Server 2007 or older. The supported versions of Exchange Server include the following: Microsoft Exchange Server 2016, Exchange Server 2013, Exchange Server 2010. For more information, see [System requirements for Office](https://products.office.com/office-system-requirements).

     If you plan to upgrade Exchange Server, make sure that the Microsoft Exchange Server Autodiscover service is functional, because Outlook 2016 no longer supports the option to manually configure an Exchange account. For more information about Autodiscover, see [Autodiscover service](https://technet.microsoft.com/library/bb124251%28v=exchg.150%29.aspx). For more information about Autodiscover and Outlook 2016, see [3098831](https://support.microsoft.com/help/3098831) “Stop, you should wait to install Office 2016” or “Outlook cannot log on” error in Microsoft Outlook 2016.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
