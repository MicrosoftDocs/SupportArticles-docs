---
title: Can't sign in to Dynamics 365 or use Dynamics 365 App for Outlook
description: Solves an error that occurs when you try to sign in to Microsoft Dynamics 365 or use Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# An error occurs when you sign in to Dynamics 365 customer engagement apps or use Dynamics 365 App for Outlook

This article provides a solution to an error that might occur when you try to sign in to Microsoft Dynamics 365 customer engagement apps or use Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3210340, 4555668

## Symptoms

When you try to sign in to Dynamics 365 customer engagement apps or use Dynamics 365 App for Outlook, you receive one of the following errors:

- > You are not part of this organization. Please contact your administrator.

- > You are not a member of this organization  
  > You (\<username>) do not belong to the organization \<organization name>. Verify the organization name and try to sign in again.

- > Your account has been disabled  
  > Your account (\<username>) is disabled, and you no longer have the privilege to access this organization. Contact your Microsoft Dynamics CRM Online administrator for assistance.

- > no instances found for this user ID  
  > You have signed in with a user ID that cannot log into Dynamics 365. Contact your administrator to make sure that you have a valid Dynamics 365 user account.

- > Invalid User Authorization  
  > The user authentication passed to the platform is not valid.

## Cause

The error can occur if you aren't a member of the security group that's associated with the Dynamics 365 environment.

## Resolution

To solve this issue, contact your Dynamics 365 administrator to add you to the security group that's associated with the Dynamics 365 environment you're trying to access.

If you're a Dynamics 365 administrator, navigate to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/). Select the environment that the user can't access and then select **Edit**. If the **Security group** field is populated, ensure the user is a member of that group. If the security group is managed in Microsoft 365, you can add the user to the group from the [Users area](https://portal.office.com/adminportal/home#/users) or the [Groups area](https://portal.office.com/adminportal/home#/groups) in the Microsoft 365 portal. For more information about how to add a security role in Power Platform admin center, see [Assign a security role to a user](/power-platform/admin/assign-security-roles).

If you still can't access Dynamics 365 customer engagement apps, try [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) to troubleshoot sign-in issues.

## More information

- For more information about the ways to sign in and access your Dynamics 365 and Office apps, see [Sign in to Dynamics 365 and Office apps](/power-platform/admin/sign-in-office-365-apps).
- For more information on controlling user access with security groups, see [Control user access to environments: security groups and licenses](/power-platform/admin/control-user-access).
