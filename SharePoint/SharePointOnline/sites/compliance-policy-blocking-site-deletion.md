---
title: An invalid policy blocks a SharePoint site deletion
description: Provides a fix for errors when deleting a SharePoint or OneDrive site, or documents on them. 
author: helenclu
ms.author: prbalusu
manager: dcscontentpm
localization_priority: Normal
ms.date: 6/13/2021
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

# Unable to delete a site due to invalid retention policy

## Symptoms

You might experience one of the following scenarios:

**Scenario 1:** When you try to delete a SharePoint site, you see the following error message:

> Can't delete site.  
> A compliance policy is currently blocking this site deletion.

**Scenario 2:** When you try to delete a version of a document on a SharePoint site or a OneDrive site, you see the following error message:

> Versions of this item cannot be deleted because it is on hold or retention policy.

**Scenario 3:** You've excluded or removed a SharePoint site or a OneDrive site from a retention policy. More than 24 hours after you've made these updates, when you try to delete the affected site or a version of a document on the site, you see one of the error messages displayed in scenarios 1 and 2.

## Cause

Each of these error messages is generated when a retention policy on the affected site has blocked a deletion action even after excluding or removing the site from the policy. This indicates that the retention policy might be invalid.

## Resolution

To verify the validity of the retention policy and delete it if it's invalid, run the following test in the Microsoft 365 admin center. You must have administrator permission to use the following steps.

> [!NOTE]
> This test isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the **Run Tests: Invalid Retention Hold** button to populate the associated test in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Invalid Retention Hold](https://aka.ms/PillarInvalidRetention)

2. In the **Run diagnostics** section, either type, or copy and paste the URL of the affected SharePoint site or OneDrive site.

3. Select **Run Tests**.

4. If the test finds an invalid retention policy that might be blocking the deletion, you can choose to remove the policy.
