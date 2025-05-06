---
title: A custom HTML login page doesn't render correctly in an Office application
description: Describes an issue in which a custom HTML login page doesn't render correctly in an Office application, and provides a workaround.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Activation\SignIn\Password Prompts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# A custom HTML login page doesn't render correctly in an Office application

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

If a custom HTML login page(like Active Directory Federated Services) doesn't render correctly in an Office application when users are prompted for credentials for using online Office resources, the custom HTML login page is likely incompatible with the Office application.

## Cause

Microsoft 365 Apps for enterprise and Office 2016 use Internet Explorer document mode 7 (also known as IE7 mode) when rendering HTML login pages in an Office application for Forms-Based Authentication.

## Workaround

**Method 1: Use a different document mode for the custom HTML login page**

To make Office use a different document mode for the custom HTML login page, use the following directive in the custom HTML login page:

```html
<meta http-equiv="x-ua-compatible" content="IE=9" >
```

**Method 2: Stay the correct size and add scroll bars if the page is bigger than the Office Sign In window**

To make the custom HTML login page stay the correct size and display scroll bars, use the code like the following:

```html
<DIV STYLE="width: 460px; height: 530px; overflow: scroll">
```

> [!NOTE]
> If you need to dynamically change the style, you can change the token **MSIE 7.0** in the user-agent string.

## More information

This inline browser for Office is used for login pages. Although the login page is based on the older Internet Explorer technology, the inline browser for the Office application is fully supported as long as the Office application is currently supported.
