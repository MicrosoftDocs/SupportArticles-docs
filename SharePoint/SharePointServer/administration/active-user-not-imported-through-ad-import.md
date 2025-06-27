---
title: Active users aren't imported through AD Import
description: Discusses an issue in which active users aren't imported into the Profile database through AD Import. Provides a workaround.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CI 109531
  - CSSTroubleshoot
ms.reviewer: bpeterse, dhirmeht
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Can't import active users through AD Import in a User Profile application in SharePoint

## Symptoms

Consider the following scenario:

- In a Microsoft SharePoint Server 2019, 2016, or 2013 farm, you set up a User Profile service application that has an Active Directory (AD) Import sync connection.
- You use an organizational unit (OU) that's named Accounting and that contains a user, Testuser1.
- TestUser1 is active in the Active Directory domain and is selected during the AD Import sync connection in the User Profile application.

When you run Full or Incremental AD Import process, TestUser1 isn't imported into the Profile database. The ULS logs show no errors or entries that are related to this user. All other users from the same OU are imported successfully into the Profile database.

## Cause

This problem occurs when a user has the **LastKnownParent** property set to another OU, and the other OU isn't selected during AD Import sync connection in the User Profile application.

For a detailed example of this situation, see the "More Information" section.

## Workaround

To work around this problem, restore the users to the same OU from which they were deleted in the Active Directory domain. For example, if the user was deleted from Sales OU, restore the user to Sales OU only. This sets the user's **LastKnownParent** attribute to the same OU. When you then select Sales OU during the AD Import Sync connection in the User Profile application, the user is successfully imported into the Profile database.

If the problem that's mentioned in the "Symptoms" section does occur, you can locate the affected users and clear the **LastKnownParent** attribute for those users. Then, run another Full or Incremental AD Import process to import the user successfully.

**Note** Because **LastKnownParent** is an editable property, you can use either Windows PowerShell or ADSIEdit to clear it.

## More Information

This problem occurs when the following conditions are true for a situation that resembles the following example:

- You have two organizational units, Accounting OU and Sales OU.
- TestUser1 is included in Accounting OU and has the LastKnownParent attribute set to Sales OU.
- Accounting OU is selected during the AD Import sync connection.
- Sales OU isn't selected during the AD Import sync connection. 

In this situation, TestUser1 isn't imported into the Profile database by running a Full or Incremental AD Import process.

**Note** When a user is deleted from the Active Directory domain and is then restored, the Active Directory domain sets the LastKnownParent property to the OU from which the user was deleted.

**Sample scenarios**

Scenario 1:

- TestUser1 is included in Sales OU.
- TestUser1 is deleted from the Active Directory domain.
- TestUser1 is restored to Sales OU.

   **Note** In this case, the **LastKnownParent** property is set to Sales OU because the user was deleted from Sales OU.

Scenario 2:

- TestUser1 is included in Sales OU.
- TestUser1 is deleted from the Active Directory domain.
- TestUser1 is restored to Accounting OU.

   **Note** In this case, the **LastKnownParent** property is set to Sales OU because the user was deleted from Sales OU.

In Scenario 2, if we select Accounting OU but don't select Sales OU during the AD Import sync connection in the User profile application, TestUser1 isn't imported through AD Import because its **LastKnownParent** property is set to Sales OU. (This is because Sales OU isn't selected as part of the AD Import sync connection).

## Status

This behavior is by design. This behavior is included to avoid unexpected scenarios in multitenant situations. However, it also applies to single tenant, on-premises SharePoint 2019, 2016, and 2013 farms.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
