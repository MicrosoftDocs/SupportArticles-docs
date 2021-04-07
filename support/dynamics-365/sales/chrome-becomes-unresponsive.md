---
title: Google Chrome becomes unresponsive when logging into Microsoft Dynamics CRM Online
description: Fixes an issue in which the Google Chrome browser becomes unresponsive when logging into Microsoft Dynamics CRM Online.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# Google Chrome becomes unresponsive when logging into Microsoft Dynamics CRM Online

This article helps you fix an issue in which the Google Chrome browser becomes unresponsive when logging into Microsoft Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2796615

## Symptoms

The Google Chrome browser becomes unresponsive when logging into Microsoft Dynamics CRM Online. The left navigation area may render, but the remaining page elements appear blank.

## Cause

This issue is caused by Google Chrome's pop-up blocker functionality, which prevents page elements from being loaded if a pop-up message is suppressed. A common scenario where this may occur is when a user may have pending e-mail messages in the system, which normally produces a pop-up message when users log into Microsoft Dynamics CRM.

## Resolution

Add the Microsoft Dynamics CRM Online website to the pop-up exceptions.

> [!NOTE]
> These instructions are provided for Google Chrome version 23.0.1272.97.

1. Click **Settings**.
2. Scroll to the bottom of the page and click **Show advanced settings...**.
3. Under **Privacy**, click **Content settings...**.
4. Under Pop-ups, click **Manage exceptions...**.
5. Add the Microsoft Dynamics CRM website and set the **Behavior** to **Allow**.
6. Click **Ok**.
7. Close **Settings**.
