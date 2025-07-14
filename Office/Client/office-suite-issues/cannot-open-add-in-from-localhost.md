---
title: We can't open this add-in from localhost
description: When loading an Office Add-in from localhost or using Fiddler, you may see an error stating that a problem occurred while trying to reach your add-in.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Web Server Integration (SharePoint & Non-SharePoint)
  - DownloadInstall\AdvancedConfiguration\AddInsOrIntegratedApps
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Office Web Apps
ms.date: 06/06/2024
---

# "We can't open this add-in from localhost" when loading an Office Add-in or using Fiddler

## Symptoms

When you load an Office Add-in from https://localhost or when you use [Fiddler](https://www.telerik.com/fiddler), you receive the following error:     

**We can't open this add-in from localhost.**

## Resolution

One cause of this error is that the Microsoft Edge Web Viewer does not have a loopback exemption. To resolve this issue, use either of these options to add a local loopback exemption to **Desktop App Web Viewer**:

### Option 1: Use command to add a local loopback exemption
 
1. Open a command prompt as administrator.     
2. Run the following command:
    ```powershell
    CheckNetIsolation LoopbackExempt -a -n="microsoft.win32webviewhost_cw5n1h2txyewy" 
    ```

### Option 2: Use Fiddler to add a local loopback exemption

1. Select **Tools** > **Win8 Loopback Exemptions**.    
2. Add an exemption to **Desktop App Web Viewer**.    

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
