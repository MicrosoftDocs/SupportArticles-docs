---
title: Click to Join fails to invoke Skype for Business
description: Describes an issue in which Click to Join fails to invoke Skype for Business on machines that use Application Virtualization. A workaround is provided.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: kkodali
appliesto: 
  - Office Professional 2013
  - Office Professional Plus 2013
  - Office Home and Business 2013
ms.date: 03/31/2022
---

# "Click to Join" fails to invoke Skype for Business on computers that use Application Virtualization

This issue occurs on computers and devices on which Office Click-to-Run (C2R) is installed and Application Virtualization (App-V) is enabled.

## Cause

The Office C2R Internet Explorer virtualized component, Interceptor.dll (which, in turn, calls MeetingJoinAxOC.dll), is not invoked because of a conflict with the already installed App-V subsystem on the computer.

## Workaround

To work around this issue, use one of the follow methods.

### Method 1

1. Exit all Internet Explorer(iexplore.exe) instances by using Task Manager.   
2. Remove the iexplore.exe path from the following registry value: 

    HKEY_LOCAL_MACHINE\Software\Microsoft\AppV\Client\Virtualization\ProcessesUsingVirtualComponents

### Method 2

Install the [latest Hotfix for App-V](/archive/blogs/appv/hotfix-package-2-for-microsoft-app-v-5-1-and-hotfix-package-3-for-microsoft-app-v-5-0-sp3-now-available).

> [!NOTE]
> If there are no Internet Explorer app-V add-ins, Method 1 or Method 2 is a safer route.

## More Information

What is the Dynamic Virtualization feature?

App-V 5.0 Service Pack 2 and later versions have enhanced "Dynamic Virtualization" by extending support to Shell Extensions, Browser Helper Objects, and Active X controls to be virtualized and run with virtual applications. The registry values under the HKLM\Software\Microsoft\AppV\Client\Virtualization subkey are used to control this feature.

Why is Office C2R and SharePoint Integration broken when App-V 5.0 SP2 or later is installed on the system?

The ProcessesUsingVirtualComponents registry value specifies a list of process paths that are candidates for using dynamic virtualization (supported shell extensions, browser helper objects, and ActiveX controls). Only processes whose full path matches one of these items can use dynamic virtualization. 

By default, Explorer.exe and Internet Explorer are listed there. Therefore, when the iexplore.exe process runs, it has the APPVEntsubsystem32.dllloaded in Internet Explorer. When Office C2R detects that APPVEntsubsystem32.dll is loaded into Internet Explorer, it does not load jitv.dll or APPVISVSubsystem32.dll into Internet Explorer. As a result, there is no registry redirection support. 

When the JavaScript that's running in Internet Explorer tries to create any ActiveX objects that are part of the Office C2R package, that operation fails and the Office C2R and SharePoint integration are broken. Office C2R and App-V dynamic virtualization aren't designed to co-exist; therefore, Office C2R disables Dynamic Virtualization when it detects that AppV client binaries are loaded in Internet Explorer to prevent double hooking.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
