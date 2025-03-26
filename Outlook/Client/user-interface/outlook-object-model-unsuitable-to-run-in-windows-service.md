---
title: Outlook Object Model can't run in a Windows service
description: This article describes the limitations of the Outlook Object Model that make it unsuitable for use in a Windows NT service.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Add-in errors
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 03/25/2025
---

# The Outlook Object Model is unsuitable to run in a Windows service

_Original KB number:_ &nbsp; 237913

The Outlook Object Model (OOM) is unsuitable for use by an application that's designed to be run as, or spawned by, a Windows Service application. This includes Active Server Page (ASP) applications that run under Internet Information Service (IIS), and applications that run together with the AT Scheduler or Task Scheduler services.

OOM is an automation model for Outlook that is designed to run in a logged-on user's session in which a user can respond to dialog boxes.

This is a design limitation of Outlook.

## OOM limitations

OOM has four major limitations that make it unsuitable for use in a Windows Service application, as follows:

- MAPI stores profiles for each user under the `HKEY_CURRENT_USER` hive of the registry. This registry hive isn't loaded when a Windows Service application runs. This particular issue can be deceptive because, during a development cycle, the developer is signed in to the system interactively. This causes the `HKEY_CURRENT_USER` hive to be loaded so that everything works as expected. After the service is tested without the owner of the profile logged on interactively, the service fails to locate the profile.
- Only one instance of Outlook (the application that exports the Outlook Object Model) can run at a time in one user context by using a single profile. If the same user tries to sign in by using a second profile, this attempt joins the user to the existing Outlook session. If the user tries to start another copy of Outlook (or OOM) from a different user context, the attempt fails. For example, if an application impersonates a different user, such as a Windows Service application, the attempt fails. This failure has unpredictable results, such as a modal dialog box or an application error that causes Outlook to stop responding to the system.
- OOM always starts the MAPI spooler during logon. MAPI client applications that run as Windows Service applications must follow several limitations when they signing in to the MAPI subsystem. Because Outlook wasn't designed to run as a Windows Service application, these conventions aren't followed.

  For more information, see [Introduction to Windows Service Applications](/dotnet/framework/windows-services/introduction-to-windows-service-applications).
- Some actions that use the OOM raise modal dialog boxes that can't be prevented and that require user intervention. This would cause the application to seem to hang.

We recommend that you use Extended MAPI code instead of the OOM in your Windows Service applications. If the code doesn't have to work with Outlook directly and can, instead, run against the mailbox in Exchange, you should consider using Exchange APIs, such as Graph, Exchange REST, and Exchange Web Services (EWS).

For more information, see [Considerations for server-side automation of Office](https://support.microsoft.com/help/257757).
