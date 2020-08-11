---
title: Office viewers or Microsoft Offices Online shows the "This page can't be displayed" error
author: AmandaAZ
ms.author: arhinesm
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Office Online Server
---

# Office viewers or Microsoft Offices Online shows the "This page can't be displayed" error

This article was written by [Adam Rhinesmith](https://social.technet.microsoft.com/profile/Adam+R+-+MSFT), Support Escalation Engineer.

## Symptoms

When you use Microsoft .NET Framework 4.6 or later versions with Office Online Server 2013 or Office Online Server, Office viewers don't work or *https://internalurl/op/generate.aspx* page doesn't open in a browser, and you receive the following error:

![the error message dialog box](./media/office-viewers-or-office-web-apps-shows-this-page-cannot-be-displayed/this-page-cant-be-displayed.png)

## Cause

The .NET Framework 4.6 and later versions includes a new Just-In-Time (JIT) compiler.

## Resolution

To fix this issue, the easiest workaround is to disable the new Just-In-Time (JIT) compiler on the Office Online Server or your Office Online Server that uses *https://internalurl/op/generate.aspx* or the Office viewers. To do this, add the **useLegacyJit** registry key, as follows:

**Location**: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework or HKEY_CURRENT_USER\SOFTWARE\Microsoft\.NETFramework

**Value name**: useLegacyJit

**Type**: DWORD (32-bit) (also known as REG_DWORD)

**Value**: 1

> [!NOTE]
> The registry value name isn't case-sensitive.

For more workarounds, see [.NET Framework-Troubleshooting RyuJIT](https://github.com/Microsoft/dotnet/blob/master/Documentation/testing-with-ryujit.md).