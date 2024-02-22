---
title: Documents aren't displayed in web browser when you're using TLS 1.2
description: Describes an issue that blocks Microsoft Office Online documents from being displayed in a web browser. Occurs because Office Online Server does not support TLS 1.2 when rendering documents on HTTPS SharePoint sites. A resolution is offered.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 12/17/2023
---

# Documents aren't displayed in web browser when you're using TLS 1.2  

## Symptoms  

When you use web apps in Microsoft Office Online Server, documents are not displayed in the web browser as expected. Instead, you receive an error message that resembles the following:   

**We're sorry, we ran into a problem completing your request...**

Additionally, you learn that TLS 1.0 has been disabled on the SharePoint web front-end servers through the registry entry that's provided in the following Microsoft Knowledge Base article:   

[How to disable PCT 1.0, SSL 2.0, SSL 3.0, or TLS 1.0 in Internet Information Services](https://support.microsoft.com/help/187498)  

## Cause  

TLS 1.2 is not currently supported because Office Online Server (and Office Web Apps Server) uses .NET Framework 4.*x* to establish network connections. By default, .NET Framework 4.*x* doesn't support TLS 1.2.    

## Resolution  

Microsoft released the following optional security update to .NET Framework 4.*x*, which changes the default encryption protocols:  

[Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358)  

This update changes the default encryption protocols from **SSL 3.0 or TLS 1.0** to the following: **TLS 1.0 or TLS 1.1 or TLS 1.2**  

**Note** This security update won't be released for Windows Server 2016 or later. Starting with Windows 2016, the registry keys that the optional security update automatically sets will have to be manually configured on each Office Online Server computer. Those registry keys and settings are as follows:  

```
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319]  
"SchUseStrongCrypto"=dword:00000001  

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319]  
"SchUseStrongCrypto"=dword:00000001
```

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).