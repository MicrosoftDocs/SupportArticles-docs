---
title: 0x80041015 error when you start an Office program
description: Discusses that you receive a 0x80041015 error when you try to start a Microsoft Office 2013 or Microsoft Office 365 program. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: Office 365
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 ProPlus
- Office 365 Home
- Office 365 Personal
- Office Home and Student 2013
- Office Home and Business 2013
- Office Professional 2013
---

# You receive a "0x80041015" error message when you try to start an Office program

## Symptoms

When you try to start a Microsoft Office 2013 or Microsoft Office 365 program, you receive the following error message: 

```adoc
Sorry, we ran into a problem While trying to install the product key. 

If this keeps happening, you should try repairing your office product. 

System error: 0x80041015
```

## Cause

This problem can occur when all the following conditions are true:

- Office was installed before the May Public Update (KB 2964042, May 13, 2014) was installed.   
- An Office product was activated before the May Public Update was installed.   
- There was an attempt to add another Office product (such as Microsoft Visio, OneDrive for Business, or Office 365) or to reinstall an Office product on the same computer after the May Public Update was installed.   

## Resolution

### Hotfix information

A supported hotfix is available from Microsoft Support. However, this hotfix is intended to correct only the problem that is described in this article. Apply this hotfix only to systems that are experiencing the problem described in this article. This hotfix might receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next software update that contains this hotfix.

If the hotfix is available for download, there is a "Hotfix download available" section at the top of this Knowledge Base article. If this section does not appear, contact Microsoft Customer Service and Support to obtain the hotfix.

> [!NOTE]
> - The "Hotfix download available" form displays the languages for which the hotfix is available. If you do not see your language, it is because a hotfix is not available for that language. 
> - Only an x86 version of this hotfix is listed as available. However, you can apply this version successfully to both x86 and x64 operating system platforms and also to x86 and x64 versions of Office 2013.
> - If additional issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and issues that do not qualify for this specific hotfix. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the website: [https://support.microsoft.com/contactus/?ws=support](https://support.microsoft.com/en-us/contactus/?ws=support).

#### Installation information

To install this hotfix, follow these steps: 

1. Close all open Office programs.   
2. Save the compressed file to your computer, and then extract the OSPPFixIt.exe file to the folder of your choice.   
3. Open the folder to which the OSPPFixIt.exe file is saved, right-click the file, and then click **Run as Administrator**.

    > [!NOTE]
    > A Command Prompt window will open and then close.   
4. Perform the action that you tried before you received the error message. For example, start Microsoft Word.   
Note If you see an "Unlicensed product" message when the Office application starts, exit and then restart the application. The application should now be activated.

#### Prerequisites

You must have Microsoft Office 2013 or Microsoft Office 365 installed to install this hotfix.

#### Restart requirement

You do not have to restart the computer after you install this hotfix.

#### Hotfix replacement information

This hotfix does not replace any previously released hotfix.

### Click-to-Run information

An updated Office 2013 Click-to-Run image has been published that also resolves this problem. To obtain the image and for more information, see the following Microsoft Office Sustained Engineering Team blog article: 

[C2R Update - May 2014](https://blogs.technet.com/b/office_sustained_engineering/archive/2014/05/22/c2r-update-may-2014.aspx)
