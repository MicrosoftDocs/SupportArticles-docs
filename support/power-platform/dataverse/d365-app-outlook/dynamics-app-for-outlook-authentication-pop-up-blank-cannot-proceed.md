---
title: Dynamics 365 App for Outlook Authentication Pop-Up Is Blank
description: Solves the issue that the authentication pop-up is blank and you can't sign in to Dynamics 365 App for Outlook.
ms.reviewer: mkelan
ms.author: smurkute
author: shwetamurkute
ms.date: 02/20/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# App for Outlook authentication pop-up is blank and unable to sign in

The article solves an issue where you can't sign in to Microsoft Dynamics 365 App for Outlook successfully due to a blank authentication pop-up.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook

## Symptoms

When you open [Dynamics 365 App for Outlook](/dynamics365/outlook-app/overview), it prompts you to allow an authentication pop-up. After you allow it, the pop-up opens. However, it's blank and prevents you from selecting an account to authenticate and sign in.

## Cause

This behavior is due to a recent regression that has been mitigated. However, users who have previously signed in might still experience this issue until they clear their session and sign in again.

## Resolution

> [!NOTE]
>
> - If you're using Outlook on the web (OWA) or the classic Outlook desktop app on Windows, follow steps 1 to 3 to solve the issue.  
>
> - If you're using [the new Outlook for Windows](https://support.microsoft.com/office/switch-to-new-outlook-for-windows-f5fb9e26-af7c-4976-9274-61c6428344e7) or Outlook on Mac, follow [these steps](#open-the-developer-tools-in-the-new-outlook-for-windows-and-outlook-on-mac) to open the Developer Tools, and then follow steps 1 to 3 to resolve the issue.

### Step 1: Clear local storage and session storage from the add-in

1. Open the classic Outlook desktop app or OWA.
2. Open **Dynamics 365 App for Outlook**.
3. Right-click anywhere inside the add-in and select **Inspect**. The **Developer Tools** window will open.
4. Select the **Application** tab.
5. Under **Storage**, select **Local Storage** and delete all stored data.
6. Select **Session Storage** and delete all stored data.
7. Close the **Developer Tools** window.

### Step 2: Clear local storage and session storage from the authentication window

1. Reopen **Dynamics 365 App for Outlook**.
2. If the authentication window appears, right-click inside it and select **Inspect**. The **Developer Tools** window will open.
3. Select the **Application** tab.
4. Under **Storage**, select **Local Storage** and delete all stored data.
5. Select **Session Storage** and delete all stored data.
6. Close the authentication window.

### Step 3: Reopen the add-in and complete authorization

1. Close and reopen Outlook.
2. Open **Dynamics 365 App for Outlook**.
3. If prompted, sign in with your credentials.
4. Complete the authentication process.

### Open the Developer Tools in the new Outlook for Windows and Outlook on Mac

- For the new Outlook for Windows:

  1. Ensure Outlook is fully closed in Task Manager.
  2. Select <kbd>WIN</kbd>+<kbd>R</kbd>, and then run the `olk.exe -devtools` command to open Outlook with the Developer Tools.

- For Outlook on Mac:

  To open the Developer Tools, see [Debug Office Add-ins on a Mac](/office/dev/add-ins/testing/debug-office-add-ins-on-ipad-and-mac#debugging-with-safari-web-inspector-on-a-mac).
