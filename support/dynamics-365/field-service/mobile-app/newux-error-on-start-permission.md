---
title: Error on start due to permission/privilege issues
description: Resolves the permission issue where the mobile app fails to launch in Microsoft Dynamics 365 Field Service.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 10/28/2024
ms.custom: sap:Mobile application
---

# Error on start due to permission/privilege issues

The new user experience for the Field Service mobile app requires some privileges added to the security roles that the user belongs to.

## Symptoms

The Field Service mobile app fails to launch with the following error: `Principal user (Id=<GUID>, …) is missing 'prvReadmsdyn_Mobile' privilege (Id=<GUID>) on OTC=<INT> for entity 'msdyn_mobilesource' …`

## Resolution

The new experience for Field Service mobile app requires privileges for users' security roles. The system automatically adds these privileges to all default security roles. If your organization uses custom security roles, you need to [edit the security roles](/power-platform/admin/create-edit-security-role) by adding the following [table privileges](/power-platform/admin/security-roles-privileges#table-privileges):

- Name=`"msdyn_richtextfile"` Permission="Create" Value="User"
- Name=`"msdyn_richtextfile"` Permission="Delete" Value="User"
- Name=`"msdyn_richtextfile"` Permission="Read" Value="User"
- Name=`"msdyn_richtextfile"` Permission="Write" Value="User"
- Name=`"msdyn_MobileSource"` Permission="Read" Value="Organization"
- Name=`"msdyn_solutioncomponentsummary"` Permission="Read" Value="Organization"
- Name=`"SettingDefinition"` Permission="Read" Value="Organization"
- Name=`"Solution"` Permission="Read" Value="Organization"
- Name=`"SettingDefinition"` Permission="Read" Value="Organization"

> [!TIP]
> If you don't know the name of the custom security role, expand **Users + permissions**, select **Users** and look for the user that reported seeing the error message. Take note of the user's security role and review the table privileges for that security role.
