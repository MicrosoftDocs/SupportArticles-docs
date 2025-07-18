---
title: Can't Access Teams Premium Features 
manager: dcscontentpm
ms.date: 02/11/2025
ms.topic: troubleshooting
search.appverid:
  - SPO160
  - MET150
appliesto:
  - Teams
ms.custom:
  - sap:Teams Admin
  - CI 3540
  - CSSTroubleshoot
ms.reviewer: cafarric
description: Resolves issues that occur when users try to access Microsoft Teams Premium features in the Teams app.
---

# Can't access Teams Premium features

## Symptoms

Users who have a valid license for Microsoft Teams Premium features might experience any of the following issues when they try to access the features:  

- The features don't appear in the Teams app.
- The features aren't available immediately after a license is purchased and assigned, but they become available after a delay of up to 24 hours.
- The features are never available for use.

## Cause

This issue might occur for any of the following reasons:

- The trial license that's assigned to a user is expired.
- The assigned license isn't provisioned yet. It takes up to 24 hours for the process to finish.
- The necessary services weren't enabled after a license was assigned.

## Resolution

If users were assigned trial licenses, check the validity of the licenses. Trial licenses are valid for 30 days from the purchase date. After the [30-day limit](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#can-i-experience-teams-premium-before-buying-licenses) is passed, the license is expired. If users still have to use Teams Premium features, you must [purchase Teams Premium licenses](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#how-do-i-purchase-teams-premium-licenses) for them.

If users are using licenses that are still valid, run the Teams Premium Details connectivity test in the Microsoft Remote Connectivity Analyzer tool for each affected user. This tool is used to troubleshoot connectivity issues that affect Teams. 

The connectivity test confirms whether a user account meets the requirements to use Teams Premium features. Among the checks that it performs, the connectivity test examines the following conditions:

- Does the user account have a valid Teams license?
- Does the user account have a valid Teams Premium license?
- Were the appropriate services enabled for Teams Premium features?

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps: 

1. Open a web browser, and navigate to the [Teams Premium Details](https://testconnectivity.microsoft.com/tests/TeamsPremiumDetails/input) test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**. 
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**. 

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed warnings. Select the provided links for more information about the warnings and failures and the methods to resolve them.
