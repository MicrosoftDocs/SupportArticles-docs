---
title: Application cannot be started, contact the application vendor in Office 365
description: Describes an issue in which you receive an "Application cannot be started" error when you try to run an Office 365 ClickOnce application such as Office 365 Desktop Setup or the Office 365 Desktop Readiness Tool. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft 365 Apps for enterprise
- Microsoft Windows XP Professional
- Microsoft Windows XP Home Edition
- Office 365 User and Domain Management
---

# "Application cannot be started. Contact the application vendor" when run Office 365 Desktop Setup

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When you try to run a Microsoft Office 365 ClickOnce application such as Office 365 Desktop Setup or the Office 365 Desktop Readiness Tool, you receive the following error message:

**Application cannot be started. Contact the application vendor.**

![A screen shot of the Cannot Start Application dialog box, showing the error message ](./media/office-365-application-cannot-be-started/error.jpg)

When you click **Details**, you receive a detailed error message that resembles the following:

```asciidoc
ERROR SUMMARY
Below is a summary of the errors, details of these errors are listed later in the log.
* Activation of https://<NameOfDomain>/ClickOnceConnector/Office365DesktopSetup.application resulted in exception. Following failure messages were detected:
+ Unable to install this application because an application with the same identity is already installed. To install this application, either modify the manifest version for this application or uninstall the preexisting application.
```

## Cause 

This issue occurs if the application was cached in the ClickOnce application cache. The application must be removed from the cache before you can successfully run it.

## Solution

To clear the ClickOnce application cache, follow these steps: 

1. Click **Start**, click **Run**, type cmd, and then click **OK**.    
2. Type the following command, and then press Enter: rundll32 dfshim CleanOnlineAppCache

To check whether the problem is fixed, follow these steps:
  - If the problem is fixed, you are finished with these steps.    
  - If the problem is not fixed, visit [https://go.microsoft.com/fwlink/?linkid=2003907](https://go.microsoft.com/fwlink/?linkid=2003907) or [contact support](https://support.microsoft.com/contactus/).    
     
## More information

For more information, see [ClickOnce Unmanaged API Reference](/previous-versions/visualstudio/visual-studio-2015/deployment/clickonce-unmanaged-api-reference).

Still need help? Go to the [https://go.microsoft.com/fwlink/?linkid=2003907](https://go.microsoft.com/fwlink/?linkid=2003907) website.