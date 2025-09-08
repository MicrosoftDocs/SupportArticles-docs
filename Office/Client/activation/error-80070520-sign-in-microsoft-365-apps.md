---
title: Error 80070520 when signing in to Microsoft 365 apps
description: Provide guidelines on how to prevent authentication error codes 80070520, -2147023584, or 2147943712 when you sign in to Microsoft 365 apps.
ms.reviewer: alextok, balram
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CSSTroubleshoot
  - CI 6246
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps
ms.date: 06/30/2025
---

# Error code 80070520, -2147023584, or 2147943712 when signing in to Microsoft 365 apps

## Symptoms

When you try to sign in to a Microsoft 365 app, authentication fails. When this issue occurs, one of the following error codes appear in the sign-in window and might be logged in the Microsoft 365 Apps sign-in logs:

- 80070520
- -2147023584
- 2147943712

:::image type="content" source="./media/error-80070520-sign-in-microsoft-365-apps/error-code.png" alt-text="Screenshot of error code -2147023584 in the sign-in window.":::

These error codes indicate that the specified logon session doesn't exist.

## Cause

This issue can occur for the following reasons:

- User impersonation

  You start the Microsoft 365 app by using impersonation methods that change the user context, such as:

  - Run as administrator
  - Run as different user
  - Run with elevated access

  These methods interfere with the app's authentication flow. They aren't supported in most scenarios.

  > [!NOTE]
  > If the currently logged-on user account and the administrator account are the same, using "Run as administrator" is supported.
- Invalid or mismatched authentication tokens

  Authentication tokens typically include device-specific claims and are tied to a user session. When users switch devices or use shared devices in environments that have roaming profiles, tokens might become invalid or mismatched. This causes authentication failures.

  > [!IMPORTANT]
  > We recommend that you don't manually delete tokens.

## Resolution

To prevent this issue, follow these guidelines:

- Don't start Microsoft 365 apps by using impersonation techniques, including [Microsoft Intune Endpoint Privilege Management (EPM)](/intune/intune-service/protect/epm-deployment-considerations-ki#network-and-cloud-resource-access-limitations) or any [server-side automation](https://support.microsoft.com/topic/considerations-for-server-side-automation-of-office-48bcfe93-8a89-47f1-0bce-017433ad79e2). Always start the apps under the same user context as the signed-in Windows session.
- On shared devices, make sure that each user signs in by using their own Windows account.
