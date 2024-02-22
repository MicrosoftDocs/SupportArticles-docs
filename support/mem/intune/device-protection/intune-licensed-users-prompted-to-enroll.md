---
title: Licensed user accessing Microsoft 365 prompted to enroll in Intune
description: Describes a behavior that causes Intune-licensed users to be prompted for enrollment when they are targeted by Basic Mobility and Security for Microsoft 365 security policies.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Create and assign Conditional Access policy
ms.reviewer: kaushika
---
# Intune-licensed users are prompted for enrollment when they try to access Microsoft 365 resources

This article discusses a by design behavior that users are unexpectedly prompted to enroll in Microsoft Intune when they try to access Microsoft 365 resources and are targeted by Basic Mobility and Security for Microsoft 365 security policies.

## Symptoms

Consider the following scenario:

- You previously used Basic Mobility and Security for Microsoft 365 or Basic Mobility and Security for Microsoft 365 [coexistence](/mem/intune/fundamentals/mdm-authority-set#coexistence) together with Intune.
- You [created and deployed a device security policy in Basic Mobility and Security](/microsoft-365/admin/basic-mobility-security/create-device-security-policies) to users.
- You assign Intune licenses to users, and then assign Intune policies to the users.
- Conditional Access in Azure isn't configured to enforce Intune MDM enrollment.

In this scenario, users are unexpectedly prompted to enroll in Intune when they try to access Microsoft 365 resources.

## Cause

This behavior is by design.

This behavior occurs if Basic Mobility and Security security policies are still deployed to a group that contains the affected users. When users are targeted by Basic Mobility and Security security policies, Conditional Access will be evaluated by Microsoft Entra authentication services. These services check a user's group membership. Microsoft Entra authentication services don't check the user authority (Intune instead of Microsoft 365) when they enforce Conditional Access.

## Solution

To change this behavior, remove the affected users from any groups that are still assigned a Basic Mobility and Security security policy. Or, remove the Basic Mobility and Security security policy if it's no longer needed.
