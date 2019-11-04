---
title: We can't open this add-in from localhost
description: When loading an Office add-in from localhost or using Fiddler, you may see an error stating that a problem occurred while trying to reach your add-in.
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

# "We can't open this add-in from localhost" when loading an Office add-in or using Fiddler

## Symptoms

When you load an Office add-in from https://localhost or when you use [Fiddler](https://www.telerik.com/fiddler), you receive the following error:     

**We can't open this add-in from localhost.**

## Resolution

To resolve this issue, use either of these options to add a local loopback exemption to **Desktop App Web Viewer**:

### Option 1: Use command to add a local loopback exemption
 
1. Open a command prompt as administrator.     
2. Run the following command:
    ```powershell
    CheckNetIsolation LoopbackExempt -a -n="microsoft.win32webviewhost_cw5n1h2txyewy" 
    ```

### Option 2: Use Fiddler to add a local loopback exemption

1. Select **Tools** > **Win8 Loopback Exemptions**.    
2. Add an exemption to **Desktop App Web Viewer**.    

**Third-party disclaimer information** 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
