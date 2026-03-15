---
title: Diagnose issues that affect Direct Routing
description: Discusses how to troubleshoot your Direct Routing configuration by using a diagnostic tool. 
ms.date: 03/14/2026
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
  - SME: filippse
---

# Diagnose issues that affect Direct Routing

## Summary

As a tenant administrator, you can troubleshoot issues that affect Direct Routing by using the test capabilities built into the Microsoft 365 admin center. The test results provide suggestions about how to resolve the issues.

## Create a test suite

To investigate whether a user is configured correctly for Direct Routing in Microsoft Teams, you create a test suite in the Microsoft 365 admin center, add the tests that you want to run, along with details of test users, and configure the tests. Then you run the tests on a Session Border Controller (SBC) in your organization by using your test user’s credentials. 
To create a test suite, follow these steps:

1.	In the Microsoft Teams admin center, navigate to **Voice** > **Direct Routing** > **SBC test cases** tab.
2.	Select **Add** to create a new test suite.
3.	Type a name for the test suite and select the SBC on which you want to run the test.
4.	Select the tests that you want to run on the SBC, and then select **Next**. The following tests are available:

    - Outbound-Inbound
    - Simultaneous ring
    - Media escalation
    - Consultative transfer

5.	For each test that you selected, add the relevant details for a test user such as their username, password and phone number as appropriate, and then select **Next**. The test user’s details are required for the test user to connect to the test environment.
6.	Optionally, you can specify a value in minutes for the **Call duration** and **Media validation interval** test parameters, and then select **Next**. 
The new test suite is listed in the SBC test cases tab.
7.	When you’re ready to run the test, select the test from the list and then select **Run test**.
8.	After the test completes, select the test and then select the **View results** link to see the outcome of the test and suggestions to resolve issues that affect the tenant, user, or policy configuration.

## More information

For details about the most common Direct Routing errors and recommended actions for further troubleshooting, see [Microsoft and SIP response codes](./microsoft-sip-response-codes.md).

Additionally, as an administrator you can use the [SIP call flow](/microsoftteams/direct-routing-monitor-sip-ladder) feature in the Microsoft Teams admin center to view the Session Initiation Protocol (SIP) requests, responses, and related Session Description Protocol (SDP) data that's exchanged between the Microsoft Teams proxy and the Session Border Controller (SBC) for a selected call.
