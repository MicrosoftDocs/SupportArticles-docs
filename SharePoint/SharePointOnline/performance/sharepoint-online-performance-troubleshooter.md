---
title: SharePoint Online performance troubleshooter
description: SharePoint Online client performance diagnostic package collects information that can be used to troubleshoot SharePoint Online client performance issues.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Office 365 SharePoint Online performance troubleshooter

## Introduction

The Office 365 SharePoint Online client performance diagnostic package collects information that can be used to troubleshoot SharePoint Online client performance issues. This diagnostic package also lets you capture a Fiddler trace of HTTP(S) traffic while you reproduce these performance issues.

This diagnostic package uploads trace files of up to 2 gigabytes (GB) after the files are compressed.

## More Information

### Required permissions

The rules in the diagnostic package require that you are the SharePoint Online site collection administrator for the SharePoint Online URL that you enter.

![Type your credentials](./media/sharepoint-online-performance-troubleshooter/credentials.png)

This article describes the information that may be collected from a computer that's trying to connect to SharePoint Online in Office 365.

#### Fiddler or network trace output

The following data may be collected by the Network Capture diagnostic that's run by the Microsoft Support Diagnostic Tool.

The files are typically large, and therefore the diagnostic may take several minutes to finish. After this diagnostic runs, the collected traces will be automatically compressed and then uploaded to Microsoft Support. A total size of up to 2 GB can be uploaded.

If the results files are larger than 2 GB after compression, some files won't be uploaded and will be left on your system. In this case, you must contact a support professional to ask for an alternative way to upload the remaining collected information.

|Description|Filename|
|----------|----------|
|Fiddler Trace|{Computer_name}_fiddler.cap|
|Network capture information from nmcap.exe output|{ComputerName}_netcap.cap; {ComputerName}__NMcap_Trace_DisplayNet.txt}__NMcap_Trace_DisplayNet.txt|

#### Fiddler output

The fiddler tracing output is described in the following Microsoft Knowledge Base article, [Fiddler tracing of HTTP(S)](https://support.microsoft.com/help/2580337/sdp-3-50c838e4-5a78-4c7c-a398-efabf1f5aeb7-fiddler-tracing-of-http-s).

### Site performance rules

#### Prerequisites

To install this package, you must have Windows PowerShell 2.0 installed on the computer. For more information, go to the following Microsoft Knowledge Base article, [Windows Management Framework (Windows PowerShell 2.0, WinRM 2.0, and BITS 4.0)](https://support.microsoft.com/help/968929/windows-management-framework-windows-powershell-2-0-winrm-2-0-and-bits
).

The following checks are performed by the Office 365 SharePoint Online diagnostic package:

|Rule ID|Title|Reference|
|----------|----------|----------|
|4C7B890F-F367-4719-B5D2-85AB4200B144|Checks whether Receive Window Auto-Tuning Level is disabled|[Ensuring your Office 365 network connection isn't throttled by your Proxy](https://blogs.technet.microsoft.com/onthewire/2014/03/28/ensuring-your-office-365-network-connection-isnt-throttled-by-your-proxy/)|
|8D1F2D6E-07FF-462C-9EBE-02E44CCAE5A5|Checks whether round-trip time between client and server isn't greater than 300 ms.|[How to measure the Network Round Trip Time to Office 365](https://blogs.technet.microsoft.com/onthewire/2014/05/08/how-to-measure-the-network-round-trip-time-to-office-365/)|
|1750D57E-FD44-4A83-8FCF-56B7DB0124BB|Checks whether Minimal Download Strategy is disabled.|[Minimal Download Strategy overview](https://docs.microsoft.com/sharepoint/dev/general-development/minimal-download-strategy-overview)|
|AB374115-9DCE-4977-BE87-22DD321E6737|Checks whether Structural Navigation is turned on for a SharePoint Online publishing site.|[Managed navigation in SharePoint](https://docs.microsoft.com/sharepoint/dev/general-development/managed-navigation-in-sharepoint)|

## References

For more information about which operating systems can run Microsoft Support's diagnostic packages, go to [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970/information-about-microsoft-automated-troubleshooting-services-and-sup#q4).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
