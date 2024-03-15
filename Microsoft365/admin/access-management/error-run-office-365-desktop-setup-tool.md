---
title: Error when you run the Microsoft 365 Desktop Setup Tool
description: Describes a problem that occurs when invalid or incorrect credentials are entered to run the Microsoft 365 Desktop Setup Tool. Resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---

# Error message when you run the Microsoft 365 Desktop Setup Tool: "Application configuration incomplete"

## Problem

You receive the following error message after you enter your credentials in the Microsoft 365 Desktop Setup Tool:

```output
Application configuration incomplete. 
The information required to configure your computer for Microsoft 365 could not be downloaded. If the issue persists, contact Microsoft 365 Support.
Learn More.
```

When you click the Learn More link, no additional info is available.

## Solution

To fix this issue, exit the Microsoft 365 Desktop Setup Tool, restart it, and then enter the correct credentials.

## Cause

This issue occurs if invalid or incorrect credentials are entered after you start the Microsoft 365 Desktop Setup Tool. In this case, the Microsoft 365 Desktop Setup Tool can't determine the licensed services that apply to the user account.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
