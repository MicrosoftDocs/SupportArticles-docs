---
title: User lacks privileges error in Resource Scheduling Optimization
description: Resolves errors with privileges in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.reviewer: anclear, v-wendysmith, v-shaywood
ms.date: 04/14/2026
ms.custom: sap:Resource Scheduling Optimization
---
# "User lacks privileges" error occurs in Resource Scheduling Optimization

## Summary

This article helps administrators resolve errors with privileges in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization job](/dynamics365/field-service/rso-schedule-optimization) fails with the "Related failed to update bookings" error message. When you go to the **Bookings** tab and search for failed bookings, they show a more detailed error message: "User lacks privileges."

## Solution

Make sure your Resource Scheduling Optimization user has the correct [security roles and column security profiles](/dynamics365/field-service/security-permissions):

**Security roles:**

- Resource Scheduling Optimization

**Column security profiles:**

- Resource Scheduling Optimization - Administrator
- Resource Scheduling Optimization - Dispatcher

### Copy security user roles

1. Sign in to your Field Service environment as an administrator.
1. Go to **Settings** > **Advanced settings** > **Security** > **Users** and choose the **Application Users** view.
1. Find the user named "Resource Scheduling Optimization," which the system created during deployment.
1. Add the **Created On** column to identify when each Resource Scheduling Optimization user was created. Or, use **Advanced Find** to find users whose names contain "Resource Scheduling" and create a custom view.
1. Verify that both Resource Scheduling Optimization users have the same roles, including "Resource Scheduling Optimization."

### Copy column security profiles

1. Sign in to your Field Service environment as an administrator.
1. Go to **Settings** > **Advanced settings** > **Security** and choose the **Column Security Profiles** view.
1. Use **Advanced Find** to find column security profiles associated with users whose names contain "Resource Scheduling."
1. Add the Resource Scheduling Optimization users to the "Resource Scheduling Optimization - Administrator" and "Resource Scheduling Optimization - Dispatcher" column security profiles.
1. Verify that the column security profiles have consistent permissions for both the old and new app users.

## Related content

- [Deploy the Resource Scheduling Optimization Add-in](/dynamics365/field-service/rso-deployment)
- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Security roles and privileges for Dataverse](/power-platform/admin/security-roles-privileges)
