---
title: An error occurred in the Communication panel
description: Provides a resolution for the error that occurs when you sign in to the communication panel in Unified Service Desk client application.
ms.reviewer: nenellim
ms.author: askuma
ms.date: 05/23/2023
---
# "An error occurred in the communication panel" error in Unified Service Desk

This article provides a resolution for an error that occurs in the communication panel after you sign in to the Unified Service Desk client application.

## Symptoms

After you sign in to the Unified Service Desk client application, you see the following error message:

> An error occurred in the Communication panel. Restart Unified Service Desk and try again. (Error Code - AAD_ID_MISMATCH - Azure ADID mismatched with logged-in user id)

## Cause

When signing in to Unified Service Desk, you must enter the Customer Service app credentials to sign in, and then again, you're shown a dialog to enter credentials to connect to Dataverse server. If you enter different credentials, this issue occurs.

## Resolution

If you use **Chrome process** to host applications, go to `C:\Users\<USER_NAME>\AppData\Roaming\Microsoft\USD` and delete the CEF folder. Now, sign in to Unified Service Desk client application and try again.
