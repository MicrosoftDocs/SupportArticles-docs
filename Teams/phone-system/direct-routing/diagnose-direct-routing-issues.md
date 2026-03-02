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

To troubleshoot issues that affect Direct Routing, administrators can create relevant test suites, populate them with tests and run them in a diagnostic tool in the Microsoft 365 admin center (Voice - Direct Routing - SBC test cases tab) to verify that a user is correctly configured for Direct Routing in Microsoft Teams. 

To create a test suite follow these steps:

1. Under **SBC test cases** tab select the **Add** button to create a new test suite.

1. Name the test suite, select the SBC to run the tests on and choose which tests to add to the test suite.

1. Following test scenarios are supported:

   - Outbound-Inbound 
   
   - Simultaneous ring 
   
   - Media escalation 
   
   - Consultative transfer 
   
1. For each test add a test users' accounts data.

1. Setup call duration and media validation interval in minutes.

To run tests follow these steps:

1. Select the test suite by clicking on the appropriate row in the table.

1. Select the **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center.

To check test results follow these steps:

1. Select the test suite by clicking on the appropriate row in the table.

1. Select the **View results** button

The test results indicate whether the user is configured correctly for Direct Routing. If the user isn't configured correctly, the diagnostic provides information about the next steps that you can use to resolve issues that affect the tenant, user, or policy configurations.

In the context of tests internal user means user within the same tenant, and external user is the user outside the tenant.

For more information about the most common Direct Routing errors and recommended actions for further troubleshooting, see [Microsoft and SIP response codes](./microsoft-sip-response-codes.md).

Additionally, administrators can use the [SIP call flow](/microsoftteams/direct-routing-monitor-sip-ladder) feature in the Teams admin center to view the Session Initiation Protocol (SIP) requests, responses, and related Session Description Protocol (SDP) data that's exchanged between the Microsoft Teams proxy and the Session Border Controller (SBC) for a selected call.
