---
title: Can't access Teams Premium features 
manager: dcscontentpm
ms.date: 12/03/2024
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
ms.reviewer: salarson
description: Resolves issues that occur when users try to access Microsoft Teams Premium features in the Teams app.
---

# Can't access Teams Premium features

## Symptoms  

Your users with a valid license might experience any of the following issues when accessing Microsoft Teams Premium features:  

- The features don't display in the Teams app.
- The features aren't available immediately after a license is purchased and assigned.
- The features aren't available for use.

## Cause

These issues might occur for any of the following reasons:

- The trial license that's assigned to the user has expired.
- The assigned license isn't provisioned yet. It takes up to 24 hours for the process to complete.
- The necessary services haven't been enabled after a license is assigned.

## Resolution  

If your users were assigned trial licenses, check their validity. If it's [past the 30 day limit](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#can-i-experience-teams-premium-before-buying-licenses) from when the trial licenses were purchased, the licenses have expired. If the users need to continue using Teams Premium features, you must [purchase Teams Premium licenses](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#how-do-i-purchase-teams-premium-licenses) for them.

If your users are using licenses that are still valid, run the Teams Premium Details connectivity test in the Microsoft Remote Connectivity Analyzer tool for each affected user. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies whether a user account meets the requirements to use Teams Premium features.  

As part of the checks that it performs, the connectivity test verifies the following conditions:

- Does the user account have a valid Teams license?
- Does the user account have a valid Teams Premium license?
- Have the appropriate services been enabled for Teams Premium features?

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

To run the connectivity test, follow these steps:  

1. Open a web browser and navigate to the [Teams Premium Details](https://testconnectivity.microsoft.com/tests/TeamsPremiumDetails/input) test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**.  
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.  

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.
