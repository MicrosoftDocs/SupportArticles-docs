---
title: Credential prompts when opening documents by persistent cookies
description: This article describes an issue where additional credential prompts when opening Office documents from a web server by using persistent cookies, and provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:User experience\Accessibility
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# Additional credential prompts when opening Office documents from a web server by persistent cookies

This article was written by [Alan Umanos](https://social.technet.microsoft.com/profile/alan%20umanos), Support Engineer.

## Symptoms

Consider the following scenarios:

### Scenario 1

A user browses to a SharePoint or other website by using a non-Internet Explorer browser, enters their forms-based authentication (FBA) credentials and checks the box to remember their account information. This creates a persistent cookie. They continue to click a link to open an Office document, which produces a prompt again for their credentials.

If the user switches to an Internet Explorer browser, they don't receive the additional prompt.

### Scenario 2

A user browses to a SharePoint or other website by using Internet Explorer to browse. This user enters their credentials in the form and continues to click a link to open an Office document. They receive another FBA challenge for credentials.

If they then put the URL of the site into either the Local Intranet zone or the Trusted Site zone, they don't receive the additional challenge for credentials.

## Cause

For Scenario 1, the reason for the challenge in the non-Internet Explorer browser is that when Office requests the persistent, it's retrieved from IE's cookie jar. Other browsers don't write their cookies the same way or to the same location. Therefore, Office cannot retrieve those cookies.

For Scenario 2, the reason for the challenge is due to Internet Explorer's protected mode. If the URL is fixed to an Internet Explorer zone that has protected mode set, Internet Explorer won't share the cookie with other applications, such as Office.  

## Solution

For Scenario 1, the workaround is either to use Internet Explorer to take advantage that Office can retrieve the persistent cookie, or (for non-Internet Explorer browsers) the user will have to log on again when opening Office documents.

For Scenario 2, the workaround is to ether remove the check box for protected mode or move the URL of the site to a zone that does not have it set.
