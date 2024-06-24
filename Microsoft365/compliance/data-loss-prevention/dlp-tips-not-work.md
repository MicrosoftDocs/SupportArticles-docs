---
title: Microsoft 365 DLP policy tips are not showing in Outlook or OWA
description: Policy tips for unified DLP policies created in Office 365 Security and Compliance Center don't work in Microsoft Outlook or Outlook Web App.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: divyarp
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 06/24/2024
---

# DLP policy tips in Security and Compliance Center don't work in OWA/Outlook

_Original KB number:_ &nbsp; 4229971

## Symptoms

Policy tips for unified data loss prevention (DLP) policies that are created in Office 365 Security and Compliance Center don't work in Microsoft Outlook or Outlook Web App (OWA).

## Cause

This issue occurs because a policy tip can be enabled only in one of the following locations:

- Security and Compliance Center
- Exchange Online

## Resolution

To view unified DLP policy tips, use one of the following options in Exchange Online:

- Disable all Transport rules that include the **Notify the sender with a Policy Tip** action.
- Remove the action **Notify the sender with a Policy Tip**  from all Transport rules.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/site/createprofile).
