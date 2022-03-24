---
title: I receive the error “Another setup is already running. Please wait for it to finish before trying again.”
description: After attempting to install Visual Studio more than once, subsequent installation attempts result in the error “Another setup is already running. Please wait for it to finish before trying again”.
ms.date: 3/25/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
Applies to: Visual Studio 2015
---

# I receive the error “Another setup is already running. Please wait for it to finish before trying again.”

## Symptom
After attempting to install Visual Studio more than once, subsequent installation attempts result in the error “Another setup is already running. Please wait for it to finish before trying again”.

## Resolution
Only one instance of a Visual Studio installation can run at a time. Make sure that there is only one instance open. If you receive this error even when there is only one instance of Visual Studio open, try restarting your machine to end the processes that can cause this issue. If restarting your machine does not resolve the problem, try the following:

1. Open **Task Manager**.
1. Click the **Details** tab.
1. Look for the process **msiexec.exe**.
1. If there are more than one, select them and choose **End Task**.
