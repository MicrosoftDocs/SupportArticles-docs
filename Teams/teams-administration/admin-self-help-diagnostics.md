---
title: Self-help diagnostics for Teams administrators
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 10/13/2020
audience: Admin|ITPro|Developer
ms.topic: article
ms.prod: microsoft-teams
ms.technology: microsoft-graph
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Teams
ms.custom: 
- CI 124054
- CSSTroubleshoot 
ms.reviewer: salarson 
description: How to run self-help diagnostics in Microsoft Teams
---

# Self-help diagnostics for Microsoft Teams administrators

## Summary

As Microsoft Teams usage grows, Microsoft has developed Teams-specific diagnostic scenarios that cover top support topics and the most common tasks for which administrators request configuration help. It is important to note that while these diagnostics cannot make changes to your tenant, they do provide insight into known issues and the instructions that you’ll need to fix the issues quickly. 

> [!NOTE]
> This feature is not available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany. 

## More information

While you’re logged in as an administrator, visit your [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home). In the navigation pane, select **Show all** > **Support** > **New service request**. After you briefly describe your issue (for example, “I can't invite a guest to Teams”), the system determines whether a diagnostic scenario matches your issue. 

> [!note]
> As you type search terms, a type-ahead query assists you to find the topics that you’re searching for. 

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-1.png" alt-text="Teams diagnostic query screen.":::
 
 
Enter your organization’s root URL. In the Guest Access diagnostic, select the drop-down arrow, select a pre-populated URL from your tenant, and then select **Run tests**.

After the diagnostic checks finish and the configuration issue is found, the system provides the steps to resolve the issue. In this example, the Tenant Admin had not turned on Guest Access:

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-2.png" alt-text="Example diagnostics response screen.":::
 
### What scenarios are currently covered?

> [!note]
> You must be an M365 Administrator to run diagnostics.

The following diagnostics are currently available with brief scenario descriptions and shortcut commands:

| Diagnostic | Description | Shortcut cmd |
|---|---|---|
| Teams Sign-in | Validates that a user can sign in to the Teams app.	 | Diag: Teams Sign-In|
| Teams Direct Routing | Validates that a user is correctly configured for direct routing.	 | Diag: Teams Direct Routing|
| Teams Call Queue | Validates that a call queue is able to receive calls.	 | Diag: Teams Call Queue|
| Teams Remove Number from Conference Bridge | Validates that the number can be removed from the conference bridge.	 | Diag: Remove Conf Bridge Number|
| Teams Dial Pad is Missing | Validates that the dial pad is visible within Teams.	 | Diag: Teams Dial Pad Missing|
| Teams Calendar App | Validates that the pre-requisites are properly configured for the Microsoft Teams calendar app to function. 	 | Diag: Teams Calendar App|
| Teams Federation | Validates that the Teams user can communicate with a federated Teams user.	 | Diag: Teams Federation|
| Teams Files Guest Access | Validates that guest users can be added to Teams and the Team is shared with the user.	 | Diag: Teams Files Guest Access|
| Teams Add-in is Missing in Outlook | Validates that a user has the correct policies to enable the Teams Outlook add-in.	 | Diag: Teams Add-in Missing in Outlook|
| Unable to Invite Guest Users to Teams | Validates that a specific guest can sign into Teams.	 | Diag: Teams Guest Access|
| Unable to Make Domestic or International PSTN calls in Teams | Validates that a user has the ability to make or receive domestic or international PSTN calls.	 | Diag: Teams PSTN|
| Unable to Join or Create a Teams Conference Call | Validates that a user has the ability to create or join a PSTN conference call.	 | Diag: Teams Conference|
| Teams Auto-Attendant | Validates that an auto attendant is able to receive calls.	 | Diag: Teams Auto Attendant
| We Can't Get Your Files | Validates that a Team is provisioned and accessible by the specified user.	 | Diag: Teams Files Error|
| Teams presence | Validates that a user's Teams presence can be correctly displayed. | Diag: Teams presence |
| Teams Live Events | Validates that a user is able to schedule Teams live events. | Diag: Teams Live Events |
| Teams Meeting Recordings | Validates that the user is properly configured to record a meeting in Teams. | Diag: Meeting Recording
| Teams Voicemail | Validates that a user is properly configured to use Voicemail in Teams. | Diag: Voicemail |
| Teams Call Forwarding | Validates that a user is properly configured to forward calls to a specified number. | Diag: Teams Call Forwarding |
| Unable to upload files to Teams chat | Validates if the specified user can upload files in Teams chat. | Diag: Unable to upload files to Teams chat |
| Unable to access files shared in Teams chat | Validated that a specified user being unable to access files shared by another user in chats. | Diag: Unable to access files shared in Teams chat |
| Unable to access files in a team | Validates that a specified user has access to files in the Team. | Diag: Unable to access files in a team |
| Meeting Recording Missing | Attempts to locate a missing Teams Meeting Recording | Diag: Missing Recording |

More diagnostics will be added at a future date.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
