---
title: Microsoft Store app package updates available
description: Outlines the default Windows Store apps release cycle for administrators.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, kledman
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
ms.subservice: application-compatibility
---
# Windows 8.1 Microsoft Store app package updates available for download

This article outlines the release cycle for administrators to update the Microsoft Store apps installed by default on Windows 8.1-based computers.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2971128

## More information

When you're connected to the Internet, Windows 8.1 clients obtain updates to Microsoft Store apps directly from the Microsoft Store app. The Microsoft Store app is visible on the Windows Start screen.

To update these Microsoft Store apps on computers that can't connect to the Microsoft Store site by using the Internet, Microsoft has a collection of downloadable updates available on the Windows Update Catalog. These updates can be distributed by using System Center, WSUS, and third-party equivalents. Or, they can be slipstreamed into the operating system image that's used by your organization.

The intent of this process isn't to bypass the Microsoft Store, but to enable computers that can't connect to the Microsoft Store to update Microsoft Store apps on a recurring basis.

## Frequently asked questions

### Which Microsoft Store apps will be serviced through this channel

Microsoft is releasing packages for Windows 8.1 Microsoft Store apps that are listed in the release chart at the end of this article.

### Will non-inbox Microsoft Store app updates be released, such as OneNote

No. We are currently targeting the Microsoft Store apps that are distributed by default with Windows 8.1 editions.

### Can third-party Microsoft Store apps be updated by using this process

No. The developer of the third-party app can make available the package, and it can then be [Sideload Apps with DISM](/previous-versions/windows/it-pro/windows-8.1-and-8/hh852635(v=win.10)) similar to line-of-business apps.

### Will Microsoft continue to release updates

Yes. Microsoft will update the inbox packages for Windows 8.1 for customers based on need. Contact Microsoft support to request one or more packages be updated.

### How do I get the updates

These packages will be available through WSUS and the [Windows Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx).

### Which languages are available

The packages include all the languages currently supported through the Microsoft Store.

### Which editions of Windows are supported

Windows 8.1 x86 and x64 editions are supported. Windows RT 8.1 is not supported.

### Can I install these updates on Industry (Embedded) editions

No, Industry editions are not licensed for these applications and therefore updates to these applications are not supported. If you have a need for Microsoft Store apps for Industry editions, contact your account manager or open a support ticket for your request to be evaluated.

### How do I create an image that includes these apps

We recommend installing the app updates as part of your post operating system deployment updates through WSUS. If you need an automated process, you can extract each .cab file to its respective MSI. Then you can script the installation or deploy by using traditional application deployment technologies.

### Can I use this process to reinstall the inbox apps that are removed after deploying Windows 8.1 images

No. This process is only designed to update apps already installed on the system. If you can enable temporary access to the Microsoft Store, you can install the apps again, and then maintain them by using this process. Or, you will need to deploy a new image that contains the apps.

### Can the packages be installed offline

No. You can't use dism.exe to install the updates offline. They must be installed through the .MSI installer to a running operating system.

### When are the packages going to be shipped

Here's the release schedule for each Microsoft Store app:

|Microsoft Store App|Operating System|Release Date|Version|KB Number|
|---|---|---|---|---|
|Alarms|Windows 8.1|8-Jul-14|2013.1204.852.3011| [2962197](https://support.microsoft.com/help/2962197) |
|BING Finance|Windows 8.1|8-Jul-14|2014.326.2159.4382| [2962186](https://support.microsoft.com/help/2962186) |
|BING Food and Drink|Windows 8.1|8-Jul-14|2014.326.2200.4175| [2962199](https://support.microsoft.com/help/2962199) |
|BING Health and Fitness|Windows 8.1|8-Jul-14|2014.326.2201.3773| [2962187](https://support.microsoft.com/help/2962187) |
|BING Maps|Windows 8.1|8-Jul-14|2014.130.2132.1189| [2962192](https://support.microsoft.com/help/2962192) |
|BING News|Windows 8.1|8-Jul-14|2014.326.2203.2627| [2962188](https://support.microsoft.com/help/2962188) |
|BING Sports|Windows 8.1|8-Jul-14|2014.326.2204.2598| [2962189](https://support.microsoft.com/help/2962189) |
|BING Travel|Windows 8.1|8-Jul-14|2014.326.2205.5913| [2962190](https://support.microsoft.com/help/2962190) |
|BING Weather|Windows 8.1|8-Jul-14|2014.326.2207.211| [2962191](https://support.microsoft.com/help/2962191) |
|Calculator|Windows 8.1|8-Jul-14|2013.1007.1950.2960| [2962196](https://support.microsoft.com/help/2962196) |
|Communications Apps<br/>(People, Mail, Calendar)|Windows 8.1|24-Jun-14|2014.219.1943.3721| [2962182](https://support.microsoft.com/help/2962182) |
|Help and Tips|Windows 8.1|24-Jun-14|2014.331.1818.1664| [2962194](https://support.microsoft.com/help/2962194) |
|Reader|Windows 8.1|24-Jun-14|2014.312.322.1510| [2962193](https://support.microsoft.com/help/2962193) |
|Reading List|Windows 8.1|8-Jul-14|2013.1218.27.757| [2962195](https://support.microsoft.com/help/2962195) |
|Scan|Windows 8.1|8-Jul-14|2013.1007.2015.3834| [2962200](https://support.microsoft.com/help/2962200) |
|Skype|Windows 8.1|8-Jul-14|2014.402.1024.4106| [2962201](https://support.microsoft.com/help/2962201) |
|Sound Recorder|Windows 8.1|8-Jul-14|2013.1010.500.2928| [2962198](https://support.microsoft.com/help/2962198) |
|XBOX Games|Windows 8.1|8-Jul-14|2013.1011.10.5965| [2962183](https://support.microsoft.com/help/2962183) |
|XBOX Music|Windows 8.1|8-Jul-14|2014.321.1036.1167| [2962184](https://support.microsoft.com/help/2962184) |
|XBOX Video|Windows 8.1|8-Jul-14|2014.326.530.5303| [2962185](https://support.microsoft.com/help/2962185) |
