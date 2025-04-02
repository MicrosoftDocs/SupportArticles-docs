---
title: You don't have the required role or privilege to complete this action error
description: Solves an error that occurs when you try to use Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/14/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# "You don't have the required role or privilege to complete this action" error in Dynamics 365 App for Outlook

This article provides a resolution for the issue that you can't use Microsoft Dynamics 365 App for Outlook due to the "You don't have the required role or privilege to complete this action" error.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4557523, 4555675  

## Symptoms

When you try to use Dynamics 365 App for Outlook, you receive the following error message:

> You don't have the required role or privilege to complete this action. Please contact your administrator to get necessary access.

## Cause

This error occurs when a user without the System Administrator role tries to open Dynamics 365 App for Outlook and their mailbox is set up with a [Dynamics 365 sandbox](/power-platform/admin/sandbox-environments) environment with [administration mode](/power-platform/admin/sandbox-environments#administration-mode) enabled. Only users with the System Administrator role can access the environment when administration mode is enabled.

## Resolution

To solve this issue, you can [disable administration mode](/power-platform/admin/admin-mode#set-administration-mode) or take the following steps to ensure the user is assigned the appropriate security role when administration mode is enabled:

1. Access Microsoft Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Security**.
3. Select **Users**.
4. Select your user and select **Manage Roles**.
5. Select the **Dynamics 365 App for Outlook User** security role and then select **OK**.
6. Try to open Dynamics 365 App for Outlook again.
