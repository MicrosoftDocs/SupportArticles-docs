---
title: Information about Office Click-to-Run installation
description: Discusses Click-to-Run and how it interacts with some anti-malware applications.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Information about Office Click-to-Run installations and about related anti-malware applications

## Summary

For Microsoft Office 2010, Microsoft is offering a new way to download and install its Office 2010 products. This technology is called Click-to-Run, and this article discusses Click-to-Run and how it interacts with some anti-malware applications. 

## More Information

What is Click-to-Run?

Click-to-Run is a new way to deliver and update Microsoft Office to broadband customers. Click-to-Run uses Microsoft virtualization and streaming technologies. 

How does Click-to-Run work?

Click-to-Run products use streaming. Think of this in the same way that you think about streaming video. You can watch the first part of the video before the whole file is downloaded. Similarly, with Click-to-Run, you can start using Office before the whole suite or product has been downloaded. While you are using your application, the rest of Office is being downloaded quietly in the background. 

Another aspect of Office Click-to-Run is the unique way that Office is stored after it is downloaded onto your computer. Click-to-Run uses Microsoft virtualization technology to contain Office 2010 inside a virtualized application space. This virtual "bubble" separates Office from the regular file system and applications on your hard disk. This lets Office 2010 Click-to-Run coexist side-by-side with any existing version of Office that is already installed on your computer. There are also other benefits to Office Click-to-Run.

Why does a drive Q or a drive R appear in My Computer after I use Click-to-Run to install Office?

Drive Q (or sometimes drive R) appears when users install an Office 2010 product or suite that is deployed through Click-to-Run. These products require the installation of a virtual file system on a logical drive, and that is why users see drive Q or drive R.

What products use Click-to-Run?

Click-to-Run delivery is available for Office Home & Student 2010 and for Office Home & Business 2010 when you download directly from Microsoft. Click-to-Run is also used for Office Starter 2010.

### Office Click-to-Run and anti-malware applications

Click-to-Run anti-malware software compatibility

The drive Q implementation (or drive R on some systems) is not yet completely compatible with some existing anti-malware solutions. Until all anti-malware vendors distribute versions of their software that are compatible with Microsoft virtualization technology, some anti-malware applications may not detect or clean malware that has penetrated the virtual environment of Office 2010 suites that were installed by using Click-to-Run.

Does Click-to-Run present a security risk to users who have used Click-to-Run to obtain Office 2010?

The Microsoft Office Click-to-Run implementation, based on Microsoft virtualization technology, is compliant with Microsoft's strict security standards. Users are no more vulnerable than if they did not have a Click-to-Run Office product. Click-to-Run has passed third-party penetration tests and has completed extensive security reviews.

That said, users will have a drive Q or drive R configuration that is incompatible with some anti-malware solutions. Therefore, malware may hide undetected on drive Q or drive R, but only if the user's computer is already exploited. Microsoft is not aware of any instance of this scenario, but it is considered possible.

What can users do to protect against malware until their anti-malware vendors release an update that is compatible with Microsoft virtualization technology?

Users should run their existing anti-malware software. They are no more vulnerable than if they did not have a Click-to-Run Office product installed. If the installation of Office is experiencing problems, users can perform a repair of Office. This procedure removes any non-Microsoft content and restores Office to its original installation state. Microsoft also recommends that users contact their anti-malware vendors for specific help with malware concerns.

What if my anti-malware vendor doesn't have a solution for detecting and cleaning malware on drive Q or drive R?

Anti-malware vendors should contact Microsoft.
