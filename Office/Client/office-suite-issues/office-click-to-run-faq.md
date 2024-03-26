---
title: Click-to-Run for Office 2010
description: Discusses Office Click-to-Run, how Office Click-to-Run works, and answers some FAQs.
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
ms.reviewer: bobcool
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# An overview of Microsoft Office Click-to-Run for Office 2010

## Summary

Microsoft is offering a new way to download and install products of Microsoft Office 2010. This technology is called Microsoft Office Click-to-Run, and this article discusses how Office Click-to-Run works and lists some frequently asked questions (FAQ).

## More Information

Introduction to Office Click-to-Run

Office Click-to-Run is a new way for broadband customers to obtain Microsoft Office and to update Office 2010. Office Click-to-Run uses the virtualization and streaming technologies of Microsoft.

Office Click-to-Run Technology

Office Click-to-Run products use streaming technology that is similar to watching a video on the web. When you watch a video on the web, you can watch the first part of the video before the whole file is downloaded. Similarly, you can start using Office 2010 before the whole suite or product is downloaded when you use Office Click-to-Run. Therefore, the rest of Office 2010 is being downloaded in the background quietly while you use one part of Office 2010. 

Office Click-to-Run products also use Microsoft virtualization technology that stores Office 2010 in virtualized application space. This virtual space separates Office 2010 from the regular file system and from the other applications on your computer. This separation lets Office 2010 coexist together with any existing version of Office that is already installed on your computer.

Office Click-to-Run products

To download Office Click-to-Run for Microsoft Office Home and Student 2010 and for Microsoft Office Home and Business 2010, download the installation files from Microsoft directly. 

**Note** The Office Click-to-Run technology is also used in Microsoft Office Starter 2010.

### Frequently asked questions (FAQ)

When you try to install a product of Office 2010 by using Office Click-to-Run, the user encounters the following error: 

"This product must be installed to Q:. Ensure that Q: is unused and try again" 

This error means that the Q: drive letter is already being used by something else on your computer. However, the installation of Office Click-to-Run requires this drive letter for Office 2010. 

How to resolve this error in Office Starter 2010

If the Q: drive letter is not available, the installation does not install Office Starter2010. 

To resolve this error, determine which application or which hardware uses the Q: drive letter, and then move it off the Q:drive by referring to the documentation from the manufacturer or to a support channel of the manufacturer for help. After the Q: drive is made available, the installation does not display the error. 

How to resolve this error in Office Home and Student 2010 or in Office Home and Business 2010

In order to successfully use the Office Click-to-Run version of Office Home and Business 2010 or of Office Home and Student 2010, use one of the following methods:

- Determine which application or which hardware uses the Q: drive letter, and then move it off the Q: drive by referring to the documentation from the manufacturer or to a support channel of the manufacturer for help. After the Q: drive is made available, the installation does not display the error.   
- Download a version of Office 2010 that is not an Office Click-to-Run product. To do this, visit the site where you purchased Office 2010, and sign in by using your Live ID. Then, click **My Account** at the top of the home page to access your Office 2010 downloads. Click **Download** for the suite that you purchased, and then click **Advanced Options** under **Download Now**. A version of Office 2010 is listed that is not an Office Click-to-Run product and that does not require the Q: drive to be available.   

Why do I receive the "This product must be installed to Q:. Ensure that Q: is unused and try again" error when I try to use Office Starter To-Go on my computer?

This error means that the Q: drive letter is already being used by something else on your computer. However, the installation of Office Click-to-Run requires this drive letter for Office 2010. If the Q: drive letter cannot be made available, you cannot use Office Starter To-Go on your computer.

Why do I have a "Q:" drive when I use Office Starter To-Go?

Office Starter To-Go uses the Office Click-to-Run technology that must use a virtual application drive. This virtual application drive is why you have the Q: drive.

What is the "Q:" drive?

Office 2010 Click-to-Run suite such as Office Starter 2010, Office Starter To-Go, Office Home and Student 2010, and Office Home and Business 2010 are based on some application virtualization technology. The Q: drive is the virtual file system drive where virtualized applications are located in the file system namespace. This Q:drive is not a typical drive. The Q: drive has no space that the user can access directly and is inaccessible from Windows Explorer or My Computer. 

Are my Office documents also stored in this "Q:" drive?

By default, Office saves your documents in the **My Documents** folder. 

Caution We strongly recommend that you do not save any Office documents on the Q:drive for the following reasons:

- The Q:drive cannot be accessed from Windows Explorer directly.    
- If the Office installation files have to be repaired, the Q: drive may be removed and recreated. Therefore, any Office documents that are stored on the Q: drive are lost.    
Can I hide or delete the "Q:" drive?

No. Any access to hide or to delete the Q: drive is removed.

Can I rename the "Q:" drive?

Yes. Right-click the drive, click Rename, and then type the new name for the drive.

Why is my backup program giving me errors when it tries to access the "Q:" drive?

The Q:drive is inaccessible. This limited access protects the integrity of the installation files for Office 2010. For Help in resolving the errors from your backup program, see the documentation from the manufacturer or to the support channel of the manufacturer.

I cannot access the "Q:" drive in My Computer, but I can access it from the "Save" dialog box inside my Office applications. Why?

When you run an Office Click-to-Run application, the application requires access to the virtual file system. This required access by the application is why you can access the Q: drive from the Save dialog box.

Caution We strongly recommend that you do not save any Office documents on the Q:drive for the following reasons:

- The Q:drive cannot be accessed from Windows Explorer directly.    
- If the Office installation files have to be repaired, the Q: drive may be removed and recreated. Therefore, any Office documents that are stored on the Q: drive are lost.    

If I do save any documents or e-mails to the "Q:" drive, then why are they inaccessible from My Computer?

The Q: drive is inaccessible from My Computer. This limited access protects the integrity of the installation files for Office 2010.

Caution We strongly recommend that you do not save any Office documents on the Q:drive for the following reasons:

- The Q:drive cannot be accessed from Windows Explorer directly.    
- If the Office installation files have to be repaired, the Q: drive may be removed and recreated. Therefore, any Office documents that are stored on the Q: drive are lost.    

Can I install other applications to the "Q:" drive?

The Q:drive is inaccessible to external applications. This limited access protects the integrity of the installation files for Office 2010. 

What if Office Click-to-Run does not meet my needs? How can I obtain the traditional MSI-based installation for Office Home and Student 2010 or Office Home and Business 2010?

If Office Click-to-Run does not meet your needs, you can uninstall it, and obtain the MSI-based Office product. To do this, follow these steps:


1. Uninstall the Office Click-to-Run version of Office 2010 by using Control Panel.   
2. Visit the site where you purchased Office 2010, and sign in by using your Live ID.   
3. Then, click My Account at the top of the home page to access your Office 2010 downloads.    
4. Click Download for the suite you purchased, and then click Advanced Options under Download Now. 
A version of Office 2010 is listed that is not an Office Click-to-Run product and that does not require the Q: drive to be available.   
