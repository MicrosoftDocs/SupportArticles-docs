---
title: Diagnose issues with Direct Routing
description: Describes how to troubleshoot your Direct Routing configuration by using a diagnostic tool. 
ms.date: 10/30/2023
author: helenclu
ms.author: luche
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

# Diagnose issues with Direct Routing

To troubleshoot issues with Direct Routing, administrators can run a diagnostic tool in the Microsoft 365 admin center to validate that a user is correctly configured for Direct Routing in Microsoft Teams. 

1. Select **Run Tests** below to populate the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Direct Routing](https://aka.ms/TeamsDirectRoutingDiag)

2. In the Run diagnostic pane, enter the email of the user you want to test in the **Username or Email** field, and then select **Run Tests**.

3. The test result will indicate whether the user is configured correctly for Direct Routing. If the user isn't configured correctly, the diagnostic will provide information on next steps that you can use to address issues with tenant, user, or policy configurations.

Moreover, administrators can use the SIP call flow available in the Teams Admin Center to view the Session Initiation Protocol (SIP) requests, responses, and associated Session Description Protocol (SDP) data exchanged between the Microsoft Teams proxy and the Session Border Controller (SBC) for a selected call, see [SIP call flow for Direct Routing in Teams Admin Center](/microsoftteams/direct-routing-monitor-sip-ladder).

For more information about the most common errors and recommended actions for further troubleshooting, see [Microsoft and SIP response codes](./microsoft-sip-response-codes.md).
