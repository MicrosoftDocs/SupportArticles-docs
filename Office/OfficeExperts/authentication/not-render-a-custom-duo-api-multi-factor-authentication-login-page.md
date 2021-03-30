---
title: Office doesn't render a custom DUO API multi-factor authentication login page
author: simonxjx
ms.author: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Office
---

# Office doesn't render a custom DUO API multi-factor authentication login page

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you use a custom multi-factor authentication login page that uses DUO API with the Office application, the login page will flicker for a moment before disappearing, and you receive the following error message:

**Your organization's policies are preventing us from completing this action for you.  For more info, please contact your help desk.**

Even though the custom login page may render correctly from web browsers, the Office application doesn't render the HTML property of the custom login page.

## Cause

When the DUO iframe is loaded from the "duo.form.login.template.html" file, the code is like:
```html
<iframe id="duo_iframe" width="100%" height="350px" frameborder="0">
```
Notice that the src attribute of the Iframe element is missing. This causes that the iFrame loads the URL about:blank (The Iframe src attribute is set later in the Duo-Web-v2.js file).

For security reasons, Office does not allow navigation to any non-https end point within the web view that is shown to capture user credentials. The lack of the src attribute causes the embedded browser to load "about:blank" in the IFRAME.

Because data is not based on HTTPS, Office can't allow such navigation to occur.

## Workaround

To resolve this issue, specify the src attribute for the Iframe element as follows. Then the "about:blank" page will no longer load and this issue will no longer occur.
```html
<iframe id="duo_iframe" src="images/TempImage.gif" width="100%" height="350px" frameborder="0">
```