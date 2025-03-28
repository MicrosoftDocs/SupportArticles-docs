---
title: Recorder not recording keystrokes on RDP Window
description: Solves an issue that causes recorder not to record keystrokes on RDP windows
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---
# Recorder not recording keystrokes on RDP Window

## Symptoms

When using the recorder on an RDP window, the keystores are not recorded but other interactions (like clicks) are recorded fine.

## Causes

The RDP window is in Maximized state. This is a limitation of the RDP clients that intercept keystrokes and interferes with the recorder when the window is maximized.

## Resolution

Change the RDP window to non maximized.