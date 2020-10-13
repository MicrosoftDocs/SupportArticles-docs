---
title: Self-help diagnostics for Teams administrators
ms.author: v-todmc
author: mccoybot
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

As Microsoft Teams usage grows, Microsoft has developed 17 Teams-specific diagnostic scenarios that cover top support topics and the most common tasks for which administrators request configuration help. It is important to note that while these diagnostics cannot make changes to your tenant, they do provide insight into known issues and the instructions that you’ll need to fix the issues quickly. 

## More information

While you’re logged in as an administrator, visit your [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home). In the navigation pane, select **Show all** > **Support** > **New service request**. After you briefly describe your issue (for example, “I can't invite a guest to Teams”), the system determines whether a diagnostic scenario matches your issue. 

> [!note]
> As you type search terms, a type-ahead query assists you to find the topics that you’re searching for. 

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-1.png" alt-text="Teams diagnostic query screen.":::
 
 
Enter your organization’s root URL. In the Guest Access diagnostic, select the drop-down arrow, select a pre-populated URL from your tenant, and then select **Run tests**.

After the diagnostic checks finish and the configuration issue is found, the system provides the steps to resolve the issue. In this example, the Tenant Admin had not turned on Guest Access:

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-2.png" alt-text="Example diagnostics response screen.":::
 
### What scenarios are currently covered?
The following diagnostics are currently available with brief scenario descriptions:
- Diag: Teams Sign-in
- Diag: Teams Direct Routing
- Diag: Teams Call Queue
- Diag: Teams Remove Number from Conference Bridge
- Diag: Teams Dial Pad is missing 
- Diag: Teams Calendar App 
- Diag: Teams Federation 
- Diag: Teams Files Guest Access 
- Diag: Teams Add-in is missing in Outlook 
- Diag: Unable to invite Guest users to Teams 
- Diag: Unable to make domestic PSTN calls in Teams 
- Diag: Unable to make International PSTN calls in Teams 
- Diag: Unable to create a Teams conference call 
- Diag: Unable to join a Teams conference call 
- Diag: Teams Auto-Attendant 
- Diag: We Can't Get Your Files 
- Diag: Unable to Schedule a Teams Meeting on behalf of Delegate in Outlook  

More diagnostics will be added at a future date.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).