---
title: An invalid policy blocks a SharePoint site deletion
description: Provides a fix for errors that occur when you try to delete a SharePoint or OneDrive site, or delete documents on them. 
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 11/15/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 162476
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.reviewer: prbalusu
---

# Can't delete a site because of an invalid retention policy or eDiscovery hold

## Symptoms

You might experience one of the following scenarios.

**Scenario 1:** When you try to delete a Microsoft SharePoint site, you receive the following error message:

> Can't delete site.  
> A compliance policy is currently blocking this site deletion.

**Scenario 2:** When you try to delete a version of a document that's on a SharePoint site or on a Microsoft OneDrive site, you receive the following error message:

> Versions of this item cannot be deleted because it is on hold or retention policy.

**Scenario 3:** You've excluded or removed a SharePoint site or a OneDrive site from a retention policy. More than 24 hours after you make these updates, you try to delete the affected site or a version of a document on the site. However, the attempt is unsuccessful, and you receive one of the error messages that are mentioned in scenarios 1 and 2.

**Scenario 4:** You've excluded or removed a SharePoint or a OneDrive site from an eDiscovery hold. The hold remain in effect during a 30-day grace period and prevents the site from being deleted. Additionally, you receive the error message that's mentioned in scenario 1. 

## Cause

Each of these error messages is generated when a retention policy on the affected site blocks a deletion even after you exclude or remove the site from the policy or eDiscovery hold. This indicates that the retention policy might be invalid or there is a grace period for the eDiscovery hold.

## Resolution

To verify the validity of the retention policy or grace eDiscovery hold and delete it if it's invalid, run the following test in the Microsoft 365 admin center. You must have **Global** or **Compliance** administrator permissions to use the following steps.

> [!NOTE]
> This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

1. Select the **Run Tests: Invalid Retention or grace eDiscovery Hold** button to populate the associated test in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Invalid Retention or grace eDiscovery Hold](https://aka.ms/PillarInvalidRetention)

2. In the **Run diagnostics** section, either type or copy and paste the URL of the affected SharePoint site or OneDrive site.

3. Select **Run Tests**.

4. If the test finds an invalid retention policy that might be blocking the deletion, you can choose to remove the policy.

## More information

A new command, [Invoke-HoldRemovalAction](/powershell/module/exchange/invoke-holdremovalaction), was introduced to facilitate the removal of eDiscovery holds that are invalid, legacy, and within the 30-day grace period. Scenario 4 is a situation in which the diagnostic and the command overlap.
