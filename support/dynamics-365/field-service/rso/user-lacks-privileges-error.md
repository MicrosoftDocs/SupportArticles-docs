---
title:  "Resource Scheduling Optimization add-in error message: User lacks privileges"
description: Resolve errors with privileges in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service
ms.author: feifeiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Resource Scheduling Optimization add-in error message: User lacks privileges

This article helps administrators resolve errors with privileges in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.

## Symptoms

You experience an optimization job failure with the error message "Related failed to update bookings". Go to the Bookings tab and search for failed bookings. Bookings show a more detailed error message: "User lacks privileges".

## Resolution

To fix this issue, make your Resource Scheduling Optimization user has the correct security roles and field security profiles:

Security roles:

- Resource Scheduling Optimization

Field security:

- Resource Scheduling Optimization - Administrator
- Resource Scheduling Optimization - Dispatcher

### Copy security user roles

1. Sign into the environment as administrator.

1. Go to **Settings** > **Security** > **Users** and choose the **Application Users** view.

1. Find the user named "Resource Scheduling Optimization", which the system creates during the deployment.

1. Edit columns to include created date to easily decipher when the Resource Scheduling Optimization user was created. Use advanced find users with the first name containing "Resource Scheduling" and create a custom view.

1. Go to the newly created user view and make sure both Resource Scheduling Optimization users have the same roles including "Resource Scheduling Optimization".

### Copy field security profiles

1. Sign into the environment as an administrator.

1. Go to **Settings** > **Security** > **Field Security Profiles** view.

1. Find the user named "Resource Scheduling Optimization." This user is created when Resource Scheduling Optimization is deployed. Use advanced find field security profiles that have users with the first name containing "Resource Scheduling."

1. Add Resource Scheduling Optimization users to the "Resource Scheduling Optimization - Administrator" and "Resource Scheduling Optimization-Dispatcher" field security profiles.
  
1. Ensure field security profiles have consistent permissions when comparing the old and new app users.
