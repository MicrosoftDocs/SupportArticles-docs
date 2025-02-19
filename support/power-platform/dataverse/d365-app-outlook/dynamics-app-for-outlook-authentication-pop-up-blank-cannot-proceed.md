---
title: Dynamics App for Outlook authentication pop-up is blank and unable to proceed
description: Provides a resolution for the issue that occurs when you try to sign in to Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 02/19/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Dynamics App for Outlook authentication pop-up is blank and unable to proceed

## Symptoms

When opening D365 app for outlook, it asks to allow the authentication pop-up to open. Upon allowing it, the pop-up opens but its blank. You don’t have the option to choose the account to authenticate and login.

## Cause

This was caused by a recent regression that has been mitigated since. However users who have previously signed in will continue to see this issue until they have cleared their session and login again.

## Resolution

Use the below steps to clear the cache/cookies and do a fresh login.

For Outlook web access or Classic Outlook desktop app on windows, follow the below steps. If you are using new outlook or Outlook on MAC, you will not be able to open the dev tools by right clicking. Look for instructions down below to open the dev tools and then follow the Steps 1 through 3 to mitigate the issue.

### Step 1: Clear Local Storage and Session Storage from Add-in Dev Tools

1. Open **Outlook Desktop App** or **Outlook Web (OWA)**.
2. Open the **Dynamics 365 App for Outlook**.
3. Right-click anywhere inside the add-in and select **Inspect**.
4. The **Developer Tools** window will open.
5. Click on the **Application** tab.
6. Under **Storage**, click on **Local Storage** and delete all stored data.
7. Click on **Session Storage** and delete all stored data.
8. Close the **Developer Tools** window.

### Step 2: Clear Local Storage and Session Storage from the Login Popup Window

1. Relaunch the **Dynamics 365 App for Outlook**.
2. If the authentication window appears, right-click inside it and select **Inspect**.
3. The Developer Tools window will open.
4. Click on the Application tab.
5. Under Storage, click on Local Storage and delete all stored data.
6. Click on Session Storage and delete all stored data.
7. Close the authentication popup.

### Step 3: Relaunch the Add-in and Complete Authorization

1. Close and reopen **Outlook**.
2. Open the **Dynamics 365 App for Outlook**.
3. If prompted, log in with your credentials.
4. Complete the authentication process.

If you are using the new outlook, to open devtools,

1. Close the outlook. Open task manager and confirm outlook is fully closed.
2. Press WIN+R and run “olk.exe –devtools” command. This will open outlook with devtools.
3. Perform the Steps 1-3 listed in the above section,

If you are on MAC device, follow the instructions on [Debug Office Add-ins on a Mac - Office Add-ins](/office/dev/add-ins/testing/debug-office-add-ins-on-ipad-and-mac#debugging-with-safari-web-inspector-on-a-mac) to turn on developer tools.
