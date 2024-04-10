---
title: You aren't part of this organization
description: Describes an error that occurs when you try to use the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# You are not part of this organization. Please contact your administrator error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4555668

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you see the following message:

> "You are not part of this organization. Please contact your administrator."

## Cause

This error can occur if there's a security group associated with the Dynamics 365 instance, and you aren't a member of that security group.  

## Resolution

Ask your Dynamics 365 administrator to add you to the security group that is associated with the Dynamics 365 environment you're trying to access.

If you're a Dynamics 365 administrator, navigate to the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/). Select the name of the environment that the user is unable to access, and then select the **Edit** button. If the Security Group field is populated, verify the user is a member of that group. If the security group is managed in Office 365, you can add the user to the group from the Users area or the Groups area within the Office 365 portal.

## More information

- [Control user access to environments: security groups and licenses](/power-platform/admin/control-user-access)
- [You encounter an error trying to sign in to Dynamics 365 (online)](https://support.microsoft.com/help/3210340)
