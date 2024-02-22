---
title: Outlook can't connect via a proxy set by PAC
description: "Describes a problem that prevents you from using Outlook Anywhere to connect to Exchange Server or Exchange Online through a proxy that's configured by using a PAC file that has a file:// prefix."
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: naokon, v-six
appliesto: 
  - Exchange Online
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook can't connect through a proxy that's set up by using a file://-based PAC file

_Original KB number:_ &nbsp; 2332495

## Symptoms

Assume that you have a proxy that's set up by using a file://-based PAC file. In this situation, you can't use Outlook Anywhere to connect through this proxy to an on-premises Exchange 2013 server, an on-premises Exchange 2010 server, or Exchange Online.

## Cause

WinHTTP does not support PAC URLs that use a file:// prefix. Therefore, when Outlook connects by using WinHTTP, it can't use the PAC file if the URL starts with file://. This behavior is by design.

## Workaround - Method 1

Set up an `http://-based` PAC file, select the Use automatic configuration script option in Internet Explorer, and then specify the URL of the PAC file in the **Address** box.

## Workaround - Method 2

Deploy Web Proxy Automatic Discovery (WPAD), and then select the **Automatically detect settings** option in Internet Explorer.

For more information, see [Automatic discovery for firewall and Web Proxy clients](/previous-versions/tn-archive/cc713344(v=technet.10)).

## More information

For more information about WinHTTP autoproxy support, see [WinHTTP AutoProxy support](/windows/win32/winhttp/winhttp-autoproxy-support).

For more information about a similar scenario in Skype for Business Online (formerly Lync Online), see [Lync 2013 or Lync 2010 can't connect to the Skype for Business Online service because a proxy is blocking connections from MSOIDSVC.exe](/SkypeForBusiness/troubleshoot/online-sign-in/lync-cant-connect-to-sfb-online).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
