---
title: Error 429 in Hybrid Configuration Wizard
description: Describes the possible cause of error 429 and a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 7486
ms.reviewer: batre
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchanger Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 02/23/2026
---

# Error 429 in Hybrid Configuration wizard

## Symptoms

When you run the Hybrid Configuration Wizard in a hybrid Microsoft Exchange environment, the wizard stalls while it checks the configuration of the [dedicated Exchange hybrid app.](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app) When this issue occurs, you receive the following error message:

> Checking for existing Exchange Server configuration
>
> Failed to fetch App Role Assignment. Maximum retry attempts reached. Error 429. Too many requests from identifier:<identifier_GUID> under category:aadgraph.app_small.tier2. Please try again later.

## Cause

The Hybrid Configuration Wizard tries to fetch details about the dedicated Exchange hybrid app by using Microsoft Graph. However, Graph might throttle the request and trigger the error.

## Resolution

Wait for a few minutes, and then run the Hybrid Configuration Wizard again.
