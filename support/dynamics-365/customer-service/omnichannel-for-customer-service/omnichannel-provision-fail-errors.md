---
title: Omnichannel provisioning fails due to permissions issue
description: Provides a resolution for the error that occurs when you provision Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: nahadda
ms.date: 05/23/2023
---
# "Unable to perform the requested operation..." or "Request validation failed" error when provisioning Omnichannel

This article provides a resolution for the issue where an error occurs when you provision Omnichannel for Customer Service.

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
