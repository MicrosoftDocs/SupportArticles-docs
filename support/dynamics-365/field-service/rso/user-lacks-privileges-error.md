---
title: User lacks privileges error in Resource Scheduling Optimization
description: Resolves errors with privileges in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 10/19/2023
---
# "User lacks privileges" error occurs in Resource Scheduling Optimization

This article helps administrators resolve errors with privileges in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization job](/dynamics365/field-service/rso-schedule-optimization) fails with the "Related failed to update bookings" error message. When you go to the **Bookings** tab and search for failed bookings, the failed bookings show a more detailed error message: "User lacks privileges."

## Resolution

To fix this issue, make your Resource Scheduling Optimization user have the correct security roles and field security profiles:

Security roles:

- Resource Scheduling Optimization

Field security:

- Resource Scheduling Optimization - Administrator
- Resource Scheduling Optimization - Dispatcher

### Copy security user roles

1. Sign in to the environment as an administrator.
1. Go to **Settings** > **Security** > **Users** and choose the **Application Users** view.
1. Find the user named "Resource Scheduling Optimization" that the system creates during the deployment.
1. Edit columns to include the created date to easily decipher when the Resource Scheduling Optimization user was created. Use **Advanced Find** to find users whose names contain "Resource Scheduling" and create a custom view.
1. Go to the newly created user view and make sure both Resource Scheduling Optimization users have the same roles, including "Resource Scheduling Optimization."

### Copy field security profiles

1. Sign in to the environment as an administrator.
1. Go to **Settings** > **Security** and choose the **Field Security Profiles** view.
1. Find the user named "Resource Scheduling Optimization." This user is created when Resource Scheduling Optimization is deployed. Use **Advanced Find** to find field security profiles that have users whose names contain "Resource Scheduling."
1. Add the Resource Scheduling Optimization users to the "Resource Scheduling Optimization - Administrator" and "Resource Scheduling Optimization-Dispatcher" field security profiles.
1. Ensure field security profiles have consistent permissions when comparing the old and new app users.
