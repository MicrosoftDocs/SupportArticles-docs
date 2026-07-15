---
title: Can't Access Teams Premium Features 
manager: dcscontentpm
ms.date: 07/13/2026
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
ai-usage: ai-assisted
description: Resolves issues that occur when users try to access Microsoft Teams Premium features in the Teams app.
---

# Can't access Teams Premium features

## Summary

This article describes the possible issues that you might encounter when you try to access Microsoft Teams Premium features, and why they might occur. The issues include features not showing or being unavailable in the Teams app, and they might occur because of issues with the Teams license, missing service plans required to use Teams Premium or an incorrect SKU assignment. The article also provides steps to resolve each issue. 

## Symptoms

Users who have a valid license for Microsoft Teams Premium features might experience any of the following issues when they try to access the features:  

- The features don't appear in the Teams app.
- The features aren't available immediately after a license is purchased and assigned, but they become available after a delay of up to 24 hours.
- The features are never available for use.
- The features don't appear even though a valid license is provisioned.

## Cause

These issues might occur for any of the following reasons:

- The trial license that's assigned to a user is expired.
- The assigned license isn't provisioned yet. It takes up to 24 hours for the process to finish.
- The necessary services weren't enabled after a license was assigned.
- A base Teams service or Teams Premium service plan that's required isn't enabled on the user's license. This requirement expands the existing "necessary services" clause.
- The tenant has both a current Teams Premium and a Teams Premium (Legacy) license. Either the wrong SKU is assigned to the user or the two licenses are in conflict. So Teams Premium features aren't recognized.
- Because of similar naming, the wrong SKU is purchased (for example Teams Premium Legacy instead of Teams Premium, or vice versa).

## Resolution

### Expired trial licenses

If users are assigned trial licenses, check the validity of the licenses. Trial licenses are valid for 30 days from the purchase date. After the [30-day limit](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#can-i-experience-teams-premium-before-buying-licenses) is passed, the license is expired. If users still need Teams Premium features, you must [purchase Teams Premium licenses](/microsoftteams/teams-add-on-licensing/licensing-enhance-teams#how-do-i-purchase-teams-premium-licenses) for them.

### Services not enabled

If user licenses are valid, run the Teams Premium Details connectivity test in the Microsoft Remote Connectivity Analyzer tool for each affected user. This tool is used to troubleshoot connectivity issues that affect Teams. 

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

### Base Teams service required

Confirm that the underlying base services and service plans are enabled. Teams Premium requires a valid base Teams license in addition to the Premium add-on license (for example, with Business Standard, verify Teams is provisioned), and the Teams Premium service plans must be enabled under the user's Licenses and apps > Apps. Allow up to 24 hours after assignment for provisioning to finish.

Teams Premium features require the underlying services to be present and turned on:

1. Confirm that the user has a valid base Teams license in addition to Teams Premium.
1. Select **Users** > **Active users**, and then select the afftected user from the list.
1. Select **Licenses and apps** > **Apps**.
1. Verify that the Teams Premium service plans are turned on and not disabled. Turn on any service plan that is turned off.

Allow up to 24 hours for the updates to propagate, and then rerun the [Teams Premium Details](https://testconnectivity.microsoft.com/tests/TeamsPremiumDetails/input) connectivity test.

### Wrong SKU assigned

Check whether the tenant has both the current and Legacy Teams Premium SKUs:

1. In the Microsoft 365 admin center, go to Billing > Your products, and check whether both Teams Premium and Teams Premium (Legacy) are present.
1. Confirm which SKU is assigned to the affected user under Users > Active users > (user) > Licenses and apps.
1. If both are present, make sure the user is assigned the current Teams Premium SKU, and then remove or reassign the conflicting or legacy SKU so that it doesn't suppress feature enablement.

Allow up to 24 hours for the change to take effect, and then recheck.

### Wrong SKU purchased

To make sure that you order the correct license and avoid purchasing a similarly-named Legacy SKU, see [purchase Teams Premium licenses](https://www.microsoft.com/microsoft-teams/premium).
