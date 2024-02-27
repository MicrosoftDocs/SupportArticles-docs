---
title: MAPI Advise() call returns 0x8007000E (E_OUTOFMEMORY)
description: Calling the MAPO Advise() function may return 0x8007000E (E_OUTOFMEMORY) if called between 7,800 and 7900 times. You can work around this problem by setting and configuring the SharedMemMaxSize registry key.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.reviewer: baijun, sgriffin
ms.date: 01/30/2024
---
# MAPI Advise() call returns 0x8007000E (E_OUTOFMEMORY)

_Original KB number:_ &nbsp; 269794

## Symptoms

When you call the Advise function about 7,800 to 7,900 times, the next Advise call may fail with the error 0x8007000E (E_OUTOFMEMORY).

## Cause

Notifications, which are registered by calling Advise, use a shared memory space. By default the heap size is set as 0x100000. If the heap size is exceeded when registering a new notification, the E_OUTOFMEMORY error is returned.

This limit is system-wide; in other words, if you are running two programs that call Advise, the combined maximum for both programs should be less than 7,900.

## Workaround

You can configure the heap size to be as high as 0x800000 by setting the following registry keys:

HKLM\SOFTWARE\Microsoft\Windows Messaging Subsystem  
Value Name: SharedMemMaxSize  
Value Type: REG_DWORD  
Value Data: 0x800000

HKLM\SOFTWARE\Microsoft\Windows Messaging Subsystem\Applications\\\<MyApp>  
Value Name: SharedMemMaxSize  
Value Type: REG_DWORD  
Value Data: 0x800000

In this scenario, **\<MyApp>** is the name of your application (without the .exe extension). For example, if your application is Mad.exe, enter MAD for the **\<MyApp>** value.
