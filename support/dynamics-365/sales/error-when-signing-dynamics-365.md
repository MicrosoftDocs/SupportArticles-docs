---
title: Error when signing in to Dynamics 365
description: Provides a solution to error messages display when you try to sign in to Microsoft Dynamics 365 (online).
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# Error messages display when you try to sign in to Microsoft Dynamics 365 (online)

This article provides a solution to error messages display when you try to sign in to Microsoft Dynamics 365 (online).

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3210340

## Symptoms

When you try to sign in to Microsoft Dynamics 365 (online), you receive one of the following errors:

> "You are not a member of this organization  
You (\<username>) do not belong to the organization \<organization name>. Verify the organization name and try to sign in again."

> "Your account has been disabled  
Your account (\<username>) is disabled, and you no longer have the privilege to access this organization. Contact your Microsoft Dynamics CRM Online administrator for assistance."

> "no instances found for this user ID  
You have signed in with a user ID that cannot log into Dynamics 365. Contact your administrator to make sure that you have a valid Dynamics 365 user account."

> "Invalid User Authorization  
The user authentication passed to the platform is not valid."

## Cause

This error can occur if there's a security group associated with the Dynamics 365 instance and you aren't a member of that security group.

## Resolution

Ask your Dynamics 365 administrator to add you to the security group that is associated with the Dynamics 365 instance you're trying to access.

If you're a Dynamics 365 administrator, navigate to the Dynamics 365 Administration Center. Select the Dynamics 365 instance that the user is unable to access and then select the **Edit** button. If the Security Group field is populated, verify the user is a member of that group. If the security group is managed in Office 365, you can add the user to the group from the [Users area](https://portal.office.com/adminportal/home#/users) or the [Groups area](https://portal.office.com/adminportal/home#/groups) within the [Office 365 portal](https://www.office.com/).

If you're still unable to access Dynamics 365 (online), see [About the Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant), which includes a diagnostically designed to troubleshoot sign in issues.

## More information

For more information about how to access the Dynamics 365 Administration Center from [Office 365 portal](https://www.office.com/), select [here](https://technet.microsoft.com/library/dn786374.aspx#bkmk_portalsignin).

For more information about controlling access to Dynamics 365 instances using security groups, select [Sign in to Dynamics 365 and Office apps](/power-platform/admin/sign-in-office-365-apps#bkmk_portalsignin).
