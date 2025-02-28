---
title: Can't apply user Group Policy settings if computer objects don't have GPO Read permissions
description: Provides a solution to a problem in which you can't apply Group Policy settings to users because of a permissions problem.
ms.date: 01/15/2025
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:group policy\group policy management (gpmc or gpedit)
- pcy:WinComm Directory Services
keywords: GPMC, Group Policy, permissions, user policies
---

# Can't apply user Group Policy settings if computer objects don't have GPO Read permissions

This article provides a solution to a problem in which you can't apply Group Policy settings to users because of a permissions problem.

_Applies to:_ &nbsp; Windows Server (all supported versions), Windows Client (all supported versions)

## Symptoms

After you remove the default permissions for the **Authenticated Users** group from one or more Group Policy Objects (GPOs), you can't successfully apply Group Policy settings to users.

## Cause

When a user signs in to Windows, Windows retrieves the user Group Policy settings that apply to that user. Before security update [MS16-072: Security update for Group Policy: June 14, 2016](https://support.microsoft.com/topic/ms16-072-security-update-for-group-policy-june-14-2016-7570425d-d460-3003-b2ac-a464c874725d), Windows used the user security context for this operation. This security update changed this functionality so that Windows uses the computer's security context to retrieve user Group Policy settings.

Because of this change, the computer account has to have **Read** permissions for GPOs that apply to the signed-in user. By default, the **Authenticated Users** group has **Read** and **Apply group policy** permissions for all GPOs in the domain. All the computer accounts in the domain belong to the **Authenticated Users** group, and they inherit these permissions.

If the default permissions are in place, the **Scope** tab of the Group Policy Management Console (GPMC) lists **Authenticated Users** in the **Security Filtering** section, as shown in the following screenshot.  

:::image type="content" source="media/cannot-apply-user-gpo-when-computer-objects-dont-have-read-permissions/gpmc-policy-scope-security-filtering.png" alt-text="Screenshot that shows the Security Filtering section of the G.P.M.C. Scope tab.":::  

Additionally, the **Delegation** tab lists the allowed permission for **Authenticated Users** as **Read (from Security Filtering)**. This permission corresponds to the Windows permissions, **Read** and **Apply Group Policy**.  

:::image type="content" source="media/cannot-apply-user-gpo-when-computer-objects-dont-have-read-permissions/gpmc-policy-delegation-acls.png" alt-text="Screenshot that shows the default permissions of the Authenticated Users group, accessed on the G.P.M.C. Delegation tab.":::  

Some administrators remove **Authenticated Users** from **Security Filtering** to improve security or to use more granular security groups for filtering. This action removes both the **Read** and the **Apply group policy** permissions from the group and all its members. In order for user GPOs to function correctly, you must restore the **Read** permission to the computer objects.

> [!NOTE]  
> This problem usually does not affect users who use domain controllers to sign in to a domain. By default, the built-in **Enterprise Domain Controllers** group has the **Read** permission for all GPOs in the domain. Therefore, domain controllers do not rely on the **Authenticated Users** group for this permission.

## Resolution

If you remove the **Read (from Security Filtering)** permission from **Authenticated Users**, you have to use an alternative method to assign the **Read** permission to the computer objects:

- Assign **Read** permission to the **Authenticated Users** group.

  This approach restores the **Read** permission without restoring the **Apply group policy** permission.

- Assign **Read** permission to the **Domain Computers** group.

  All the computers in the domain belong to the **Domain Computers** group in that domain.

- Assign **Read** permission to specific computer objects or to a security group that the computers belong to.

> [!IMPORTANT]  
> Whenever you modify Group Policy permissions, make sure that user objects, computer objects, or groups to which those objects belong are not explicitly denied access to the GPOs. An explicit denial always overrides a permission that would otherwise allow access.

To resolve the problem, follow these steps:

1. In GPMC, on the **Delegation** tab, select **Add**.

1. In the **Add Group or User** dialog box, select the group or object that you want. Then, in the **Permissions** box, select **Read**.

1. Select **OK**.

After you finish these steps, the **Delegation** tab lists the allowed permission for the selected object or group as **Read** instead of **Read (from Security Filtering)**. This difference indicates that the object or group doesn't have the **Apply group policy** permission.

:::image type="content" source="media/cannot-apply-user-gpo-when-computer-objects-dont-have-read-permissions/gpmc-policy-delegation-reduced-perms.png" alt-text="Screenshot that shows the reduced permissions of the Authenticated Users group, accessed from the G.P.M.C. Delegation tab.":::  

### Example scenario

Consider a GPO that defines only user settings. You want to apply the GPO to specific users who all belong to a group that's named **contoso_user_group**. In GPMC, on the **Scope** tab for the GPO, you add **contoso_user_group** to the **Security Filtering** list. To limit the GPO to only the users in that group, you remove **Authenticated Users** from the list.

To test this configuration, you run `gpresult /h gpresult.html` on a user's computer, and then open the *gpresult.html* file to view the policy results. In this scenario, the report indicates an error (listed at the bottom of the following screenshot).  

:::image type="content" source="media/cannot-apply-user-gpo-when-computer-objects-dont-have-read-permissions/gpo-client-report-access-denied.png" alt-text="Screenshot that shows the resultant Group Policy report from a client computer that doesn't have the correct permissions.":::  

To resolve this error, you have to grant the **Read** permission to the computer objects that represent the computers that the members of **contoso_user_group** use to sign in. In this scenario, you could create a group that's named **contoso_computer_group**, and add the affected computers to that group. Then, by using the procedure from the "Resolution" section, you could use the GPMC **Delegation** tab to assign the **Read** permission to that group. After these changes are made, the **Delegation** tab lists the permissions as shown in the following screenshot.  

:::image type="content" source="media/cannot-apply-user-gpo-when-computer-objects-dont-have-read-permissions/gpmc-delegation-example-permissions.png" alt-text="Screenshot that shows the correct permissions on the Delegation tab for the example scenario.":::  
