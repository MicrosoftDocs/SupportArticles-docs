---
title: SharePoint Online performance troubleshooter
description: SharePoint Online client performance diagnostic package collects information that can be used to troubleshoot SharePoint Online client performance issues.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sites\Performance
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Microsoft 365 SharePoint Online performance troubleshooter

## Introduction

The Microsoft 365 SharePoint Online client performance diagnostic package collects information that can be used to troubleshoot SharePoint Online client performance issues. This diagnostic package also lets you capture a Fiddler trace of HTTP(S) traffic while you reproduce these performance issues.

This diagnostic package uploads trace files of up to 2 gigabytes (GB) after the files are compressed.

## More Information

### Required permissions

The rules in the diagnostic package require that you are the SharePoint Online site collection administrator for the SharePoint Online URL that you enter.

:::image type="content" source="media/sharepoint-online-performance-troubleshooter/credentials.png" alt-text="Screenshot of the SharePoint Online site collection administrator credentials input dialog." border="false":::

This article describes the information that may be collected from a computer that's trying to connect to SharePoint Online in Microsoft 365.

#### Fiddler or network trace output

The following data may be collected by the Network Capture diagnostic that's run by the Microsoft Support Diagnostic Tool.

The files are typically large, and therefore the diagnostic may take several minutes to finish. After this diagnostic runs, the collected traces will be automatically compressed and then uploaded to Microsoft Support. A total size of up to 2 GB can be uploaded.

If the results files are larger than 2 GB after compression, some files won't be uploaded and will be left on your system. In this case, you must contact a support professional to ask for an alternative way to upload the remaining collected information.

|Description|Filename|
|----------|----------|
|Fiddler Trace|{Computer_name}_fiddler.cap|
|Network capture information from nmcap.exe output|{ComputerName}_netcap.cap; {ComputerName}__NMcap_Trace_DisplayNet.txt}__NMcap_Trace_DisplayNet.txt|

### Site performance rules

#### Prerequisites

To install this package, you must have Windows PowerShell 2.0 installed on the computer. For more information, see [Windows Management Framework](/powershell/scripting/windows-powershell/wmf/overview).

The following checks are performed by the Microsoft 365 SharePoint Online diagnostic package:

|Rule ID|Title|Reference|
|----------|----------|----------|
|4C7B890F-F367-4719-B5D2-85AB4200B144|Checks whether Receive Window Auto-Tuning Level is disabled|[Ensuring your Microsoft 365 network connection isn't throttled by your Proxy](/archive/blogs/onthewire/ensuring-your-office-365-network-connection-isnt-throttled-by-your-proxy)|
|8D1F2D6E-07FF-462C-9EBE-02E44CCAE5A5|Checks whether round-trip time between client and server isn't greater than 300 ms.|[How to measure the Network Round Trip Time to Microsoft 365](/archive/blogs/onthewire/how-to-measure-the-network-round-trip-time-to-office-365)|
|1750D57E-FD44-4A83-8FCF-56B7DB0124BB|Checks whether Minimal Download Strategy is disabled.|[Minimal Download Strategy overview](/sharepoint/dev/general-development/minimal-download-strategy-overview)|
|AB374115-9DCE-4977-BE87-22DD321E6737|Checks whether Structural Navigation is turned on for a SharePoint Online publishing site.|[Managed navigation in SharePoint](/sharepoint/dev/general-development/managed-navigation-in-sharepoint)|

## References

For more information about which operating systems can run Microsoft Support's diagnostic packages, go to [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970/information-about-microsoft-automated-troubleshooting-services-and-sup#q4).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
