---
title: Office doesn't render a custom DUO API multifactor authentication login page
description: Describes an issue in which Office application doesn't render a custom DUO API multifactor authentication login page.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office
ms.date: 03/31/2022
---

# Office doesn't render a custom DUO API multifactor authentication login page

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you use a custom multifactor authentication login page that uses DUO API with the Office application, the login page will flicker for a moment before it disappears. And you receive the following error message:

> Your organization's policies are preventing us from completing this action for you.  For more info, please contact your help desk.

Even though the custom login page may render correctly from web browsers, the Office application doesn't render the HTML property of the custom login page.

## Cause

When the DUO iframe is loaded from the "duo.form.login.template.html" file, the code is like:

```html
<iframe id="duo_iframe" width="100%" height="350px" frameborder="0">
```

Notice that the src attribute of the Iframe element is missing. It causes that the iFrame loads the URL "about:blank" (The Iframe src attribute is set later in the Duo-Web-v2.js file).

For security reasons, Office doesn't allow navigation to any non-https end point within the web view that is shown to capture user credentials. The lack of the src attribute causes the embedded browser to load "about:blank" in the IFRAME.

Because data isn't based on HTTPS, Office can't allow such navigation to occur.

## Workaround

To work around this issue, specify the src attribute for the Iframe element as follows. Then the "about:blank" page will no longer load and this issue will no longer occur.

```html
<iframe id="duo_iframe" src="images/TempImage.gif" width="100%" height="350px" frameborder="0">
```
