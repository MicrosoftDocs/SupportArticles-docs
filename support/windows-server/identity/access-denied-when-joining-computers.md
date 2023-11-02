---
title: Access is denied when joining computers
description: Provides a solution to an error message when non-administrator users who have been delegated control try to join computers to a domain controller.
ms.date: 01/17/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-jomcc, davete
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Error: Access is denied when non-administrator users who have been delegated control try to join computers to a domain controller

This article provides a solution to an error message when non-administrator users who have been delegated control try to join computers to a domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 932455

## Symptoms

On a domain controller, non-administrator users may experience one or more of the following symptoms:

- After a specific user or a specific group is provided with the permission to add or to remove computer objects to the domain on an organizational unit (OU) through the Delegation Wizard, users can't add some of the computers to the domain. When the user tries to join a computer to a domain, users may receive the following error message:
    > Access is denied.
    > [!NOTE]
    > Administrators can join computers to the domain without any issues.
- Users who are members of the Account Operators group or who have been delegated control can't create new user accounts or reset passwords when they sign in locally or when they sign in through Remote Desktop to the domain controller.

    When users try to reset a password, they may receive the following error message:
   > Windows cannot complete the password change for **username** because: Access is denied.

    When users try to create a new user account, they receive the following error message:

    > The password for username cannot be set due to insufficient privileges, Windows will attempt to disable this account. If this attempt fails, the account will become a security risk. Contact an administrator as soon as possible to repair this. Before this user can log on, the password should be set, and the account must be enabled.

## Cause

These symptoms may occur if one or more of the following conditions are true:

- A user or a group hasn't been granted the Reset Passwords permission for the computer objects.

    > [!NOTE]
    > A user or a group cannot join a computer to a domain if the specified user or specified group does not have the Reset Password permission set for the computer objects. Users can create new computer accounts for the domain without this permission. But if the computer account is present in Active Directory already, they will receive the "Access is denied" error message because the Reset Password permission is required to reset the computer object properties for the existing computer object.

- Users have been delegated control of the Account Operators group or are members of the Account Operators group. These users haven't been granted the Read permission on the built-in OU in "Active Directory Users and Computers."

## Resolution

To resolve the issue in which users can't join a computer to a domain, follow these steps:

1. Select **Start**, select **Run**, type **dsa.msc**, and then select **OK**.
2. In the task pane, expand the domain node.
3. Locate and right-click the **OU** that you want to modify, and then select **Delegate Control**.
4. In the Delegation of Control Wizard, select **Next**.
5. Select **Add** to add a specific user or a specific group to the **Selected users and groups** list, and then select **Next**.
6. In the **Tasks to Delegate** page, select **Create a custom task to delegate**, and then select **Next**.
7. Select **Only the following objects in the folder**, and then from the list, click to select the **Computer objects** check box. Then, select the check boxes below the list, **Create selected objects in this folder** and **Delete selected objects in this folder**.
8. Select **Next**.
9. In the **Permissions** list, click to select the following check boxes:
   - **Reset Password**  
   - **Read and write Account Restrictions**  
   - **Validated write to DNS host name**  
   - **Validated write to service principal name**
10. Select **Next**, and then select **Finish**.
11. Close the "Active Directory Users and Computers" MMC snap-in.

To resolve the issue in which users can't reset passwords, follow these steps:

1. Select **Start**, select **Run**, type **dsa.msc**, and then select **OK**.
2. In the task pane, expand the domain node.
3. Locate and right-click **Builtin**, and then select **Properties**.
4. In the **Builtin Properties** dialog box, select the **Security** tab.
5. In the **Group or user names** list, select **Account Operators**.
6. Under **Permissions for Account Operators**, click to select the **Allow** check box for the **Read** permission, and then select **OK**.

   > [!NOTE]
   > If you want to use a group or a user other than the Account Operators group, repeat steps 5 and 6 for that group or that user.
7. Close the "Active Directory Users and Computers" MMC snap-in.
