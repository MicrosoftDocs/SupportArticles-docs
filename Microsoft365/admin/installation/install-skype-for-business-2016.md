---
title: Install of Skype for Business 2016 installs Microsoft 365 Apps for enterprise
description: Explains that when you install Skype for Business 2016 from the Office 365 portal, all the Microsoft 365 Apps for enterprise applications are installed, not just Skype. A workaround is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office 365
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft 365 Apps for enterprise
- Skype for Business 2016
---

# Install of Skype for Business 2016 from the Office 365 portal installs all the Microsoft 365 Apps for enterprise applications

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

You have a Microsoft Microsoft 365 Apps for enterprise or Office 365 E3 subscription. In the Office 365 portal, you click **Install** for Skype for Business 2016 on the **Skype for Business** tab of the **MySoftware** page. After you activate the installation, you notice that all the Microsoft 365 Apps for enterprise applications are installed, instead of just Skype for Business 2016.

> [!NOTE]
> This doesn't occur for Office 365 Business Premium subscription users.

## Workaround

To install only Skype for Business 2016, you have to use the 2016 version of the Office Deployment Tool (ODT) for Click-to-Run.

For more information about the Office Deployment Tool, see [Overview of the Office Deployment Tool](/deployoffice/overview-office-deployment-tool). 

For information about excluding programs from the installation, see [Configuration options for the Office Deployment Tool](/deployoffice/office-deployment-tool-configuration-options).

A sample Configuration.XML file:

```xml
<Configuration>
  <Add OfficeClientEdition="32" Channel="Deferred">
  <Product ID="O365ProPlusRetail">
  <Language ID="en-us" />
  <ExcludeApp ID="Access" />
  <ExcludeApp ID="Excel" />
  <ExcludeApp ID="OneNote" />
  <ExcludeApp ID="OneDrive" />
  <ExcludeApp ID="Outlook" />
  <ExcludeApp ID="PowerPoint" />
  <ExcludeApp ID="Publisher" />
  <ExcludeApp ID="Word" />
  <ExcludeApp ID="Groove" />
  </Product>
  </Add>
</Configuration>
```

## More Information

Microsoft is aware of this behavior, and we are working to improve this experience. This issue occurs because the Microsoft 365 Apps for enterprise and Office 365 E3 subscriptions don't include entitlement for the Skype for Business product that's currently offered from the **Skype for Business** tab.

This issue doesn't occur when Microsoft Lync 2013 or Skype for Business 2015 is installed from the **Skype for Business** tab. During activation for these productions you're prompted to "Choose your product" and are presented with the option to install Microsoft 365 Apps for enterprise. If you exit without completing "Choose your product", Lync or Skype for Business will not be activated.