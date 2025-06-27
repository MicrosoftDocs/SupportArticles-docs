---
title: A Teams meeting wants to open Skype for Business
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Hybrid and Deployment (Migration)\Hybrid SfB and O365
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Explains why a Teams meeting opens Skype for Business rather than Teams.
---

# Skype for Business required for some meetings instead of Teams

## Symptoms

When you join a meeting in your calendar, Skype for Business is launched instead of Microsoft Teams.

## Cause

If the meeting was scheduled with Skype for Business, Microsoft Teams launches Skype for Business client to complete your entrance into the meeting. Meetings scheduled within Microsoft Teams initiate directly within the product.

## More information

Microsoft Teams decides whether Skype for Business is required for a user to join the meeting based on the URL included in the meeting description.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
