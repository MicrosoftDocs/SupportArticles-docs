---
title: Presence information isn't displayed on a SharePoint page
description: When you open a SharePoint page, your presence information is not shown.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Pages\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Online
ms.date: 12/17/2023
---

# Presence information does not show on a SharePoint page

Assume that you have Skype for Business running on the computer. When you open a SharePoint page, your presence information is not shown.

## Workarounds

Use one of the following two workarounds, and then open the page again:

- Disable Protected Mode for Internet Explorer by clearing the **Enable Protected Mode** check box on the **Security** tab in the **Internet Options** dialog box.
- Run Internet Explorer as an administrator.

## Why this issue occurs

The Office add-on for Internet Explorer loops though all the processes on the computer to look for the Skype for Business process so that it can use a handle to the process to communicate with it.  When Internet Explorer runs in Protected Mode, Windows security restricts the process list that is sent back to the Office add-on, and the Skype for Business handle is inaccessible.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
