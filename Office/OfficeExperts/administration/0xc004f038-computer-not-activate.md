---
title: 0xC004F038 computer couldn't be activated
description: Describes the Office 2010 and Office 2013 Activation troubleshooter for the 0xC004F038 error message. Provides a workaround.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Perpetual
  - sap:office-experts
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Office Professional Plus 2016
  - Office Professional Plus 2013
  - Office Standard 2013
ms.date: 06/06/2024
---

# "0xC004F038: The computer couldn't be activated" error in KMS activation

This article was written by [Eric Ashton](https://social.technet.microsoft.com/profile/EricAshton), Senior Support Escalation Engineer.

## Symptoms

You try to activate Microsoft Office 2013 or Office 2016 through the Key Management Service (KMS) host by using any of the following methods:

- Volume Activation Management Tool (VAMT)
- Office activation wizard from a client computer
- OSPP.vbs /act script

However, you receive the following error message:

> 0xC004F038: The Software Licensing Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.  

## Cause

This issue occurs because the Office KMS pool contains fewer than five unique client computers.

## Resolution

To resolve this problem, increase the number of client computers in the Office KMS pool to five or more.

> [!NOTE]
> To determine how many client computers are currently in the Office KMS pool on the KMS host, run the following command in an elevated Command Prompt window from c:\windows\system32, and then press Enter:
>
> `Cscript slmgr.vbs -dlv all >c:\temp\KMSInfo.txt`

Go to c:\temp (or any custom location where you put the output), and then open KMSInfo.txt. Search for Office to find your Office KMS host installation details. Check the **Current Count** value. If the Office KMS count value is less than **5**, Office clients won't activate.

When the Office KMS pool contains five or more client computers, try to activate Office by using the Office activation wizard, [OSPP.vbs](/deployoffice/vlactivation/tools-to-manage-volume-activation-of-office), or VAMT.

If you use System Preparation (Sysprep) in your environment, it's possible that Office wasn't rearmed before the image creation. Therefore, computers may have the same client computer ID (CMID) for Office.

If you've more than five computers that are trying to activate, and you still see this error message, check the KMS host logon Event Viewer on the KMS server. For example, you see entries that resemble the following:

- 0x0,5,Ignite1.ignite.local,930bd202-a335-4c7e-bd9d-7305361f0d37,Date/Time,0,5,0,6f327760-8c5c-417c-9b61-836a98287e0c
- 0x0,5,Ignite2.ignite.local,2f362dd3-fb39-4d18-94e6-de1d30dd27d5,Date/Time,0,5,0,6f327760-8c5c-417c-9b61-836a98287e0c
- 0x0,5,Ignite5.ignite.local,930bd202-a335-4c7e-bd9d-7305361f0d37,Date/Time,0,5,0,6f327760-8c5c-417c-9b61-836a98287e0c

In this example, notice that Ignite5 and ignite1 have the same CMID (930bd202-a335-4c7e-bd9d-7305361f0d37). This indicates that the Office rearm was skipped even though the base operating system image may have been generated.

> [!NOTE]
> Before Sysprep prepares the image, make sure that you run one of the following commands, based on your Office bit version, to guarantee a unique Office CMID.
>
> - For 32-bit Office
>  
>   C:\Program Files (x86)\Microsoft Office\Office16\ospprearm.exe
> - For 64-bit Office
>  
>   C:\Program Files\Microsoft Office\Office16\ospprearm.exe

For detailed information about how to rearm the Office installation, see the following articles:  

- [Rearm the Office 2013 installation](/previous-versions/office/office-2013-resource-kit/dn385362%28v%3doffice.15%29)
- [Rearm a volume licensed version of Office that's included in an operating system image](/deployoffice/vlactivation/rearm-an-office-installation-on-an-image-when-using-kms-to-activate)

You can run the following startup script on these computers to rearm Office and generate new, unique Office IDs. In this script, replace XX with the appropriate value, based on your Office version:

*XX* = 15 for Office 2013

*XX* = 16 for Office 2016

```console
@echo off

:OSPP 

reg query HKLM\Software\Microsoft\Office\XX.0\Common\OSPPREARM if %errorlevel%==1 (goto RUN) else (goto END)

:RUN set ProgramFilesPath=%ProgramFiles% 

"%ProgramFilesPath%\Microsoft Office\OfficeXX\OSPPREARM.EXE"

C:\Windows\system32\cscript.exe "%ProgramFilesPath%\Microsoft Office\OfficeXX\ospp.vbs" /act set ProgramFilesPath=%ProgramFiles(x86)%

"%ProgramFilesPath%\Microsoft Office\OfficeXX\OSPPREARM.EXE"

C:\Windows\system32\cscript.exe "%ProgramFilesPath%\Microsoft Office\OfficeXX\ospp.vbs" /act REG ADD "HKLM\Software\Microsoft\Office\XX.0\Common\OSPPREARM"

:END

Exit
```
