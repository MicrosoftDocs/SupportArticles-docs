---
title: C0000006 error and troubleshooting suggestions
description: This article discusses the meaning of a C0000006 error and how to troubleshoot it.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.reviewer: TrevorH
ms.prod: visual-studio-family
---
# The C0000006 error and troubleshooting suggestions

This article introduces the meaning of a C0000006 error and how to troubleshoot it.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 2704157

## Symptoms

You have an application written in Visual FoxPro. The application may terminate and close after reporting the following error:

> ExceptionCode: C0000006 (In-page I/O error).

## Cause

A C0000006 error is a networking or network connectivity error. Specifically, a C0000006 error is an in page I/O error. This error occurs when an application loses its underlying network connectivity.

## Resolution

Since a C0000006 error indicates a networking problem, the best option is to obtain a network trace and analyze the results. This normally involves opening a case with our Windows Platforms Support group to help you obtain the trace and interpret the results.

While a C0000006 error indicates an underlying network problem, there are some suggestions you can try that might help prevent this error.

- Disable opportunistic locking in Windows: [Configuring opportunistic locking in Windows](https://support.microsoft.com/help/296264)
- Move the executable, the Visual FoxPro runtime files, and data files to the same machine.
- Make sure the VFP9RENU.dll file is the same major build (9 for 9, 8 for 8, etc.) as VFP9R.dll and VFP9T.dll.
- Mark the .EXE \ runtimes read only.
- Disable the creation of the Foxuser files (FOXUSER.DBF\\.FPT) via the CONFIG.FPW file with a RESOURCE=OFF line unless you specifically need the file. The Foxuser files are created automatically and are one more set of files to cause a possible network failure.
- Make sure you are running Service Pack 2 version of VFP 9.0. You can download Service Pack 2 from here: [Microsoft Visual FoxPro 9.0 Service Pack 2.0](https://www.microsoft.com/download/details.aspx?id=13959)
- To generate more ideas, leverage the VFP forum community: [VFP forum community](https://social.msdn.microsoft.com/Forums/en-US/home?forum=visualfoxprogeneral&preserve-view=true)
