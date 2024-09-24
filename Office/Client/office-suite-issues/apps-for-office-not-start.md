---
title: Office Add-in doesn't start if you disable protected mode for Restricted Sites zone
description: Resolves issues that blocks Office Add-in from starting if protected mode for the Restricted Sites zone is not enabled in Internet Explorer.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Add-Ins\Centralized Deployment of Add-Ins
  - DownloadInstall\AdvancedConfiguration\AddInsOrIntegratedApps
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: pconlan, misaun
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
ms.date: 06/06/2024
---

# Office Add-in doesn't start if you disable protected mode for the Restricted Sites zone in Internet Explorer

## Symptoms

When you use Microsoft Office 2013 or later, you experience the following issues.

### Issue 1

Assume that you open an Office document that contains an app for Office or try to use a mail app in Microsoft Outlook. However, the app does not start, and you receive the following error message:

```adoc
APP ERROR
This app could not be started. Close this dialog to ignore the problem or click "Restart" to try again.
```

### Issue 2

When you try to play a video in a Microsoft Word document, the video does not play, and you receive the following error message: 

```adoc
VIDEO ERROR
This video could not be started. Close this dialog to ignore the problem or click "Restart" to try again.
```

## Cause

These issues occur because protected mode is not enabled for the Restricted Sites zone in Internet Explorer. 

## Workaround

For Office 2013, first make sure that the following update is installed:

[May 12, 2015, update for Office 2013 (KB2986156)](https://support.microsoft.com/help/2986156) 

Re-enable protected mode for Restricted Sites: 

1. In Internet Explorer, click the **Tools** button, and then click **Internet Options**.   
2. Click the **Security** tab, and then select the Restricted SitesZone.   
3. Select the **Enable Protected Mode** check box, and then click **OK**.   
4. Restart Internet Explorer.

> [!IMPORTANT]
> Admin policies take priority over local settings. If enabling Protected Mode through Internet Explorer has no effect, or the ability to enable Protected Mode is turned off,  check your admin settings to see if there's a Group Policy that disables Protected Mode.

## More Information

Microsoft Office Add-ins using the Office Add-in platform are designed to run in isolation, using a low right sandbox. Several features, such as the task pane view, use web views provided using Internet Explorer APIs.  To ensure these components execute HTML script in low rights mode, Office explicitly requires the browser object to run in Protected Mode.  Currently, IE does not support this from the API unless Protected Mode is enabled for Restricted Sites zone in IE itself.  This is typically not a problem since this is the default setting, and rarely will users disable it. However, if disabled (by user action or by GPO), these Office add-in types may report an error when starting and refuse to load. It is an expected failure under that condition, and is blocked for security reasons.
