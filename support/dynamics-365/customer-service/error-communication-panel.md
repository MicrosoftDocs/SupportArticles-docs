---
title: Error in communication panel
description: Provides a solution to error when you sign in to the communication panel in Unified Service Desk client application.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---


# An error occurred in the communication panel

This article provides a solution for an error that occurs in the communication panel after you sign in to the Unified Service Desk client application.

## Symptom

After you sign in to the Unified Service Desk client application, you see the following error message:

**An error occurred in the Communication panel. Restart Unified Service Desk and try again. (Error Code - AAD_ID_MISMATCH - Azure ADID mismatched with logged-in user id)**

   > [!div class=mx-imgBorder]
   > ![Unified Service Desk application error.](media/usd-communication-panel-error.png "Unified Service Desk application error")

## Cause

When signing in to Unified Service Desk, you must enter the Customer Service app credentials to sign in, and then again, you're shown a dialog to enter credentials to connect to Dataverse server. If you enter different credentials, this issue occurs. 

## Resolution

If you use **Chrome process** to host applications, go to `C:\Users\<USER_NAME>\AppData\Roaming\Microsoft\USD` and delete the **CEF** folder. Now, sign in to Unified Service Desk client application and try again.
