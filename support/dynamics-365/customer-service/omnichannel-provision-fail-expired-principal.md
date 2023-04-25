---
title: Omnichannel provisioning fails due to an expired Teams service principal
description: Provides a resolution for the issue where provisioning fails due to an expired Teams service principal in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# Omnichannel provisioning fails due to an expired Teams service principal

This article provides a resolution for the issue where an error occurs when you provision Dynamics 365 Omnichannel for Customer Service.

## Symptoms

When you provision Omnichannel for Customer Service, one of the following error messages appears:

> Unable to perform the requested operation due to lack of permissions

> Request validation failed. Failed to execute action in CRM for selected environment

## Cause

The user is either logged in as a System Administrator on a child business unit (instead of the root business unit), or they don't have read privileges for system roles.

## Resolution

To resolve this issue:

- Check the permissions for the user, and change the business unit of the system user to the root business unit.
- Ensure that the user is assigned at least one security role (preferably Omnichannel Administrator) other than the System Administrator role.

