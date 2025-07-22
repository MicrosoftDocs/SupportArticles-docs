---
title: An invalid policy blocks a SharePoint site deletion
description: Provides a fix for errors that occur when you try to delete a SharePoint or OneDrive site, or delete documents on them. 
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Delete Site
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

# Can't delete a site because of a retention policy or eDiscovery hold

## Symptoms

You might experience one of the following scenarios.

**Scenario 1:** When you try to delete a Microsoft SharePoint site, you receive the following error message:

> Can't delete site.  
> A compliance policy is currently blocking this site deletion.

**Scenario 2:** When you try to delete a version of a document that's on a SharePoint site or on a Microsoft OneDrive site, you receive the following error message:

> Versions of this item cannot be deleted because it is on hold or retention policy.

**Scenario 3:** You've excluded or removed a SharePoint or a OneDrive site from a retention policy. More than 24 hours after you make these updates, you try to delete the site or a version of a document on the site. However, the attempt is unsuccessful, and you receive one of the error messages that are mentioned in scenarios 1 and 2.

**Scenario 4:** You've excluded or removed a SharePoint or a OneDrive site from an eDiscovery hold. When you try to delete the site, the attempt is unsuccessful, and you receive the error message that is mentioned in scenario 1.

## Cause

Each of these error messages is generated when you try to delete a SharePoint or OneDrive site in either of the following situations:
- You exclude or remove the site from a retention policy. However, the retention policy is invalid.
- The eDiscovery hold is within a 30-day grace period that prevents the site from being deleted. 

## Resolution

Verify the validity of the retention policy or determine whether the eDiscovery hold is within the grace period. To do this, run the following test in the Microsoft 365 admin center. You must have **Global** or **Compliance** administrator permissions to use these steps.

> [!NOTE]
> This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

1. Select the **Run Tests: Invalid Retention or grace eDiscovery Hold** button to populate the associated test in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Invalid Retention or grace eDiscovery Hold](https://aka.ms/PillarInvalidRetention)

2. In the **Run diagnostics** section, either type or copy and paste the URL of the SharePoint or OneDrive site that you want to delete.

3. Select **Run Tests**.

If the test finds an invalid retention policy that might be blocking the deletion, you can choose to remove the policy. 

If the test finds that the eDiscovery hold is within the 30-day grace period, you can choose to remove the hold.

## More information

To resolve the error in Scenario 4, manage holds using the [Get-CaseHoldPolicy](/powershell/module/exchange/get-caseholdpolicy) command or the Microsoft Purview portal and ensure the location is released from the case hold policy before attempting deletion. If the hold is not released, use the [Set-CaseHoldPolicy](/powershell/module/exchange/set-caseholdpolicy) command to release it, and if the policy cannot be found by using the Get-CaseHoldPolicy commnad or the Purview portal, use the [Invoke-HoldRemovalAction](/powershell/module/exchange/invoke-holdremovalaction) command to clean up the orphan hold.

