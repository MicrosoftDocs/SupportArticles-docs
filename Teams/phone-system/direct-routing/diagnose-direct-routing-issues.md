---
title: Diagnose issues that affect Direct Routing
description: Discusses how to troubleshoot your Direct Routing configuration by using a diagnostic tool. 
ms.date: 03/24/2023
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CSSTroubleshoot
ms.reviewer: 
---

# Diagnose issues that affect Direct Routing

To troubleshoot issues that affect Direct Routing, administrators can run a diagnostic tool in the Microsoft 365 admin center to verify that a user is correctly configured for Direct Routing in Microsoft Teams. Follow these steps:

1. Select the **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Direct Routing](https://aka.ms/TeamsDirectRoutingDiag)

2. In the **Run diagnostic** section, enter the email address of the user that you want to test in the **Username or Email** field, and then select **Run Tests**.

The test results indicate whether the user is configured correctly for Direct Routing. If the user isn't configured correctly, the diagnostic provides information about the next steps that you can use to resolve issues that affect the tenant, user, or policy configurations.

For more information about the most common Direct Routing errors and recommended actions for further troubleshooting, see [Microsoft and SIP response codes](./microsoft-sip-response-codes.md).

Additionally, administrators can use the [SIP call flow](/microsoftteams/direct-routing-monitor-sip-ladder) feature in the Teams admin center to view the Session Initiation Protocol (SIP) requests, responses, and related Session Description Protocol (SDP) data that's exchanged between the Microsoft Teams proxy and the Session Border Controller (SBC) for a selected call.
