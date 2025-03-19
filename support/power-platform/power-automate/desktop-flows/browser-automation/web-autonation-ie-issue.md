---
title: Web automation with Internet Explorer issue (Failed to assume control of IE)
description: Solves a issues caused whem try to Launch Internet Explorer due to security settings.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---
# Web automation with Internet Explorer issue (Failed to assume control of IE)

This article refers to failures, that appear due to security settings when Internet Explore is launched.

## Symptoms

Launch Internet Explorer action throws a runtime error. (Failed to assume control of IE)

## Cause

Security settings of Internet Explorer not properly set

## Resolution

- Open Internet Explorer
- Go to settings
- Select Internet Options
- Go to security
- Uncheck the Enable Protected Mode checkbox on the Internet section.
- Restart Internet Explorer

Refer to the [article](/power-automate/desktop-flows/install-browser-extensions#set-up-browsers)