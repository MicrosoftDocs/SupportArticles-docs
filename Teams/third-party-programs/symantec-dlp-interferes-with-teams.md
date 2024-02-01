---
title: Symantec DLP interferes with Teams processes
ms.author: luche
author: helenclu
ms.date: 01/02/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Provides a resolution to an issue in which Symantec DLP interferes with Teams processes.
---

# Symantec DLP interferes with Teams processes

## Symptoms

Installing Symantec DLP creates operability issues with Microsoft Teams.

## Cause

Symantec DLP Endpoint agents can interfere with Teams processes, which can then lead to launch or exit failures.

## Resolution

Exclude Teams.exe from the Symantec DLP's Endpoint agents using the information in this [Symantec support article](https://knowledge.broadcom.com/external/article/160078/how-to-whitelist-or-exclude-an-applicati.html).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
