---
title: We can't open this add-in from localhost
description: When loading an Office Add-in from localhost or using Fiddler, you may see an error stating that a problem occurred while trying to reach your add-in.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office Web Apps
---

# "We can't open this add-in from localhost" when loading an Office Add-in or using Fiddler

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

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

### Option 2: Use Fiddler to add a local loopback exemption

1. Select **Tools** > **Win8 Loopback Exemptions**.    
2. Add an exemption to **Desktop App Web Viewer**.    

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
