---
title: Blank page appears
description: Provides a solution to an issue where a blank page appears when you use the Dynamics 365 App for Outlook on Outlook desktop.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Blank page appears within Microsoft Dynamics App for Outlook

This article provides a solution to an issue where a blank page appears when you use the Dynamics 365 App for Outlook on Outlook desktop.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4091345

## Symptoms

When attempting to use the Dynamics 365 App for Outlook on Outlook desktop, you see a blank page instead of the application loading as expected.

## Cause

**Cause 1:** It can occur if not all of the URLs used to authenticate and access Dynamics 365 are in the same Internet Explorer security zone.

**Cause 2:** It can occur if the LocalLow folder has an incorrect integrity level. The correct setting is to have the integrity level set to low as the folder name indicates.

**Cause 3:** This issue can occur if an issue is cached in Internet Explorer or Edge. If it was previously working but quit working recently, it's most likely the cause.

**Cause 4:** Microsoft is aware of an issue that can occur under the following conditions:

- You're using Windows 10 with update 1903 or higher.
- Your organization is configured to use Dynamics 365 Online with Exchange on-premises.
- You're using Office 365 ProPlus with a version before 1910.

## Resolution

**Resolution 1:**  
Use the steps in ["Something went wrong during sign-in" error using Dynamics 365 App for Outlook](https://support.microsoft.com/help/4035750) to verify each of the necessary URLs are in the same Internet Explorer security zone.

**Resolution 2:**

1. Open a command prompt.
2. Run the following command:  
    `icacls %userprofile%\Appdata\LocalLow /t /setintegritylevel (OI)(CI)L`

**Resolution 3:**  
If you're using Office 365 version 16.0.11629 and Windows 10 version 1903 or later, follow these steps as Office Add-ins are now using [Microsoft Edge WebView for Office Add-ins](https://developer.microsoft.com/office/blogs/microsoft-edge-webview-for-office-add-ins/):

1. Install [Microsoft Edge DevTools Preview](https://www.microsoft.com/p/microsoft-edge-devtools-preview/9mzbfrmz0mnj#activetab=pivot:overviewtab).
2. In Outlook, launch the Dynamics 365 app for Outlook.
3. Run Microsoft Edge DevTools Preview.
4. You should see Dynamics 365 (EXP) as a debug target.
5. Select it to launch the **F12** tools.
6. Go to the **Console** tab.
7. Run: window.localStorage.clear().
8. Open the app again in Outlook.

If you're using early versions of Office 365 and Windows, use the steps in [Troubleshooting errors when attempting to open Dynamics 365 App for Outlook](https://support.microsoft.com/help/4345548) to clear your Internet Explorer cache.
  
If you're using a Mac, see [Clearing the Office application's cache on a Mac](/office/dev/add-ins/testing/debug-office-add-ins-on-ipad-and-mac#clearing-the-office-applications-cache-on-a-mac).

**Resolution 4:**  
If the conditions mentioned in Cause 4 are true, install [Version 1910: October 30](/officeupdates/monthly-channel-2019#version-1910-october-30) or later that includes a fix for this type of issue.
