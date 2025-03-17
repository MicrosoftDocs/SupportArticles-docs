---
title: Error while interacting with Web element on runtime
description: Solves issues related to interaction with web elements during runtime.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---

# Error while interacting with web element on runtime

This article refers to issues that might appear when interacting with web element during runtime.

## Symptom

A Web automation action (like "Click Link", "Populate text field" or "Get details of element" etc.) fails during runtime.  

## Verifying issue

During the initial development of the desktop flow, the user was able to capture and interact with the web element.

## Cause

Some web pages change their underlying HTML structure dynamically. Therefore, the CSS selector initially used to locate the element is no longer applicable.

## Resolution

Please refer to the following articles:

- [Repair a Selector](https://learn.microsoft.com/en-us/power-automate/desktop-flows/repair-selector).

- [Can't interact with a web element on runtime](https://learn.microsoft.com/en-us/troubleshoot/power-platform/power-automate/desktop-flows/web-automation-action-fails-runtime)