---
title: Symantec DLP interferes with Teams processes
ms.author: meerak
author: Cloud-Writer
ms.date: 01/02/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Security and Compliance (Retention, etc)\DLP
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Provides a resolution to an issue in which Symantec DLP interferes with Teams processes.
---

# Symantec DLP interferes with Teams processes

## Summary

Symantec DLP Endpoint agents can interfere with Microsoft Teams processes and cause Teams to fail to start or close unexpectedly. To prevent these failures, exclude `Teams.exe` from the agents by following Broadcom article 160078.

## Symptoms

Installing Symantec DLP creates operability issues with Microsoft Teams.

## Cause

Symantec DLP Endpoint agents can interfere with Teams processes, which can then lead to launch or exit failures.

## Resolution

Exclude Teams.exe from the Symantec DLP's Endpoint agents using the information provided in article ID 160078 on the [Broadcom website](https://knowledge.broadcom.com/).
