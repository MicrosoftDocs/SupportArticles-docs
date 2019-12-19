---
title: Office Click-to-Run Perpetual (C2R-P) release for Project 2016 and Visio 2016
description: This article was created to understand the new ODT to allow IT admin a way to role out Project and Visio with their versions of Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office 365 ProPlus
---

# Office Click-to-Run Perpetual (C2R-P) release for Project 2016 and Visio 2016

## Symptoms

Consider the following scenario:

A customer has purchased Volume-Licensed perpetual copies of Project 2016 and Visio 2016.  While migrating the enterprise to Office 365 ProPlus (2016) they find out that the 2016 version of Office 365 ProPlus which uses click-to-run, cannot be installed side-by-side with the 2016 version of Project and Visio that are MSI based.  This blocks customers from upgrading their versions of Project and Visio to 2016.

## Resolution

Customers that are based on the scenario described above are now able to use the latest version of Office Deployment Tool (2016) to download and install click-to-run based Project 2016 and Visio 2016 that can be activated using their volume license (KMS or MAK).

The new Office Deployment Tool supports four new ProductIDs that allow the customers to download and install the standard or Professional versions of Project 2016 and/or Visio 2016. For more details see [Use the Office Deployment Tool to install volume licensed editions of Visio 2016 and Project 2016](https://technet.microsoft.com/library/mt703272.aspx)

Download the latest version of the Office 2016 Deployment Tool [here](https://www.microsoft.com/download/details.aspx?id=49117). 

## More Information

In addition, the following articles provide more information on this topic:

- [Supported scenarios for installing different versions of Office, Visio, and Project on the same computer](https://technet.microsoft.com/library/mt712177%28v=office.16%29.aspx)
- [Product IDs that are supported by the Office Deployment Tool for Click-to-Run](https://support.microsoft.com/help/2842297)
