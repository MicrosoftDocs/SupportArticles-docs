---
title: Install of Skype for Business 2016 installs Office 365 ProPlus
description: Explains that when you install Skype for Business 2016 from the Office 365 portal, all the Office 365 ProPlus applications are installed, not just Skype. A workaround is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: Office 365
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 ProPlus
- Skype for Business 2016
---

# Install of Skype for Business 2016 from the Office 365 portal installs all the Office 365 ProPlus applications

## Problem

You have a Microsoft Office 365 ProPlus or Office 365 E3 subscription. In the Office 365 portal, you click **Install** for Skype for Business 2016 on the **Skype for Business** tab of the **MySoftware** page. After you activate the installation, you notice that all the Office 365 ProPlus applications are installed, instead of just Skype for Business 2016.

> [!NOTE]
> This doesn't occur for Office 365 Business Premium subscription users.

## Workaround

To install only Skype for Business 2016, you have to use the 2016 version of the Office Deployment Tool (ODT) for Click-to-Run.

For more information about the Office Deployment Tool, see [Overview of the Office Deployment Tool](https://technet.microsoft.com/library/jj219422%28v=office.15%29.aspx). 

For information about excluding programs from the installation, see [Configuration options for the Office Deployment Tool](https://technet.microsoft.com/library/dn745895.aspx).

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

Microsoft is aware of this behavior, and we are working to improve this experience. This issue occurs because the Office 365 ProPlus and Office 365 E3 subscriptions don't include entitlement for the Skype for Business product that's currently offered from the **Skype for Business** tab.

This issue doesn't occur when Microsoft Lync 2013 or Skype for Business 2015 is installed from the **Skype for Business** tab. During activation for these productions you're prompted to "Choose your product" and are presented with the option to install Office 365 ProPlus. If you exit without completing "Choose your product", Lync or Skype for Business will not be activated.
