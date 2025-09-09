---
title: 'Edit Document requires a Microsoft SharePoint Foundation compatible application and web browser error when you open documents from SharePoint'
description: Describes an issue that occurs when you try to open documents from SharePoint by using Office applications.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: warrenr
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - Office Web Apps
ms.date: 12/17/2023
---

# "Edit Document requires a Microsoft SharePoint Foundation compatible application and web browser" when you open documents from SharePoint

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

Assume that you have the Click-to-Run version of Microsoft 365 and Microsoft Application Virtualization (App-V) 5 Service Pack 2 (SP2) installed on the same computer. When you try to open documents from SharePoint by using Office applications, you receive the following error message:

> Edit Document requires a Microsoft SharePoint Foundation compatible application and web browser.

## Cause

To work around this issue, remove the iexplore.exe process from the **ProcessesUsingVirtualComponents** registry key in the following location:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\Virtualization**

There are side effects for this workaround, as follows:

The registry key that toggles this on or off is **EnableDynamicVirtualization**. In addition, those processes that are specified for this feature are listed in the **ProcessesUsingVirtualComponents** registry key that's located in the same key. By default, **Explorer.exe** and **Internet Explorer** are listed there.

Dynamic Virtualization has a limited scope of interaction designed for features that are introduced in App-V SP 2.

This leads to an important statement: Just because the application is hooked, it doesn't always mean that it's running virtualized if it's displayed as a process under the **ProcessesUsingVirtualComponents** registry key. This will be done at the thread level. When an ActiveX OCX or a DLL that implements a shell extension is loaded from a native process or a process from another virtual application, App-V generates an additional virtual environment on demand linking the package that contains the OCX or DLL with the process. Then dynamic virtualization is turned on for that particular thread. As soon as the thread exits, dynamic virtualization is turned off. If the said thread with dynamic virtualization spawns another thread, that thread will also be virtualized.

> [!NOTE]
> When you turn off the Dynamic Virtualization and remove the executable paths from the previous configuration, you will lose the functionality described above.

## More information

If you need App-V to function inside Internet Explorer, say for your own custom Internet Explorer add-ins that require App-V, contact Microsoft Technical Support and get help from the Office support team.
