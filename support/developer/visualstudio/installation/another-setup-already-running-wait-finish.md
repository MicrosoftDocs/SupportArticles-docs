---
title: Wait for setup to finish before trying again
description: Provides a resolution to the error "Another setup is already running. Please wait for it to finish before trying again".
ms.date: 04/15/2024
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee, jagbal
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Error "Another setup is already running. Please wait for it to finish before trying again"

_Applies to:_&nbsp;Visual Studio 2015

## Symptom

After attempting to install Visual Studio more than once, subsequent installation attempts result in the following error:

> Another setup is already running. Please wait for it to finish before trying again.

## Resolution

Only one instance of a Visual Studio installation can run at a time. Make sure that there's only one instance open. If you receive this error, even when there's only one instance of Visual Studio open, restart your machine to end the processes that can cause this issue. If restarting your machine doesn't resolve the problem, follow these steps:

1. Open **Task Manager**.
1. Select **Details**.
1. Look for the process **msiexec.exe**.
1. Select them and choose **End Task** if there's more than one.
