---
title: Office viewers or Microsoft Offices Online shows the This page can't be displayed error
description: Office viewers don't work with the This page can't be displayed error when you use Microsoft .NET Framework 4.6.
author: helenclu
ms.author: luche
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# Office viewers or Microsoft Offices Online shows the "This page can't be displayed" error

This article was written by [Adam Rhinesmith](https://social.technet.microsoft.com/profile/Adam+R+-+MSFT), Support Escalation Engineer.

## Symptoms

When you use Microsoft .NET Framework 4.6 or later versions with Office Online Server 2013 or Office Online Server, Office viewers don't work or *https://internalurl/op/generate.aspx* page doesn't open in a browser, and you receive the following error:

> This page can't be displayed.

:::image type="content" source="media/office-viewers-or-office-web-apps-shows-this-page-cannot-be-displayed/error-page.png" alt-text="Screenshot of the error message, showing this page can't be displayed." border="false":::

## Cause

The .NET Framework 4.6 and later versions includes a new Just-In-Time (JIT) compiler.

## Resolution

To fix this issue, the easiest workaround is to disable the new Just-In-Time (JIT) compiler on the Office Online Server or your Office Online Server that uses *https://internalurl/op/generate.aspx* or the Office viewers. To do this, add the **useLegacyJit** registry key, as follows:

**Location**: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\\.NETFramework or HKEY_CURRENT_USER\SOFTWARE\Microsoft\\.NETFramework

**Value name**: useLegacyJit

**Type**: DWORD (32-bit) (also known as REG_DWORD)

**Value**: 1

> [!NOTE]
> The registry value name isn't case-sensitive.

For more workarounds, see [.NET Framework-Troubleshooting RyuJIT](https://github.com/Microsoft/dotnet/blob/master/Documentation/testing-with-ryujit.md).
