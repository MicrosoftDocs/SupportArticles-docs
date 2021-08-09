---
title: Intune-licensed users prompted for enrollment
description: Describes a behavior that causes Intune-licensed users to be prompted for enrollment when they are targeted by Office 365 MDM security policies.
ms.date: 05/20/2020
ms.prod-support-area-path: Create and assign Conditional Access policy
---
# Intune-licensed users are prompted for enrollment when they are targeted by Office 365 MDM security policies

This article discusses a by design behavior that users are unexpectedly prompted to enroll in Microsoft Intune when they try to access Office 365 resources.

_Original product version:_ &nbsp; Microsoft Intune, Mobile Device Mgmt for O365  
_Original KB number:_ &nbsp; 4516689

## Symptoms

Consider the following scenario:

- You previously used Mobile Device Management (MDM) for Office 365 or Office 365 MDM Coexistence together with Intune.
- You [created and deployed an Office 365 MDM security policy](https://support.office.com/article/Create-and-deploy-device-security-policies-d310f556-8bfb-497b-9bd7-fe3c36ea2fd6) to users.
- You assign Intune licenses to users, and then assign Intune policies to the users.
- Conditional Access in Azure isn't configured to enforce Intune MDM enrollment.

In this scenario, users are unexpectedly prompted to enroll in Intune when they try to access Office 365 resources.

## Cause

This behavior is by design.

This behavior occurs if Office 365 MDM security policies are still deployed to a group that contains the affected users. When users are targeted by Office 365 MDM security policies, Conditional Access will be evaluated by Azure AD authentication services. These services check a user's group membership. Azure AD authentication services don't check the user authority (Intune instead of Office 365 MDM) when they enforce Conditional Access.

## Resolution

To change this behavior, remove the affected users from any groups that are still assigned an Office 365 MDM security policy. Or, remove the Office 365 MDM security policy, if it's no longer needed.
