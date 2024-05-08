---
title: Permission error when Microsoft 365 access is enabled
description: Provides a resolution for the Microsoft 365 permission error that occurs in Dynamics 365 Business Central.
ms.author: mikebc
ms.reviewer: jswymer
ms.date: 05/08/2024
---
# A permission error occurs even though Microsoft 365 access has been enabled

This article provides a resolution for an issue where users receive a permission error even though Microsoft 365 access has been enabled in Dynamics 365 Business Central.

## Symptoms

Access with Microsoft 365 has been enabled in Business Central admin center, but users get a permission error when accessing records.

## Cause

This is a by design behavior. Administrators must first configure what data can be accessed in Teams. If the administrator enables access in the Business Central admin center, but doesn't assign permissions on the **License Configuration** page, a user who tries to access Business Central records in Teams will have their user record provisioned without permission to any objects.

## Resolution

> [!NOTE]
> You need tenant administrator permissions in Business Central.

Customizing permissions on the **License Configuration** page will only affect newly created users. You must also assign the missing permissions to users that have already been created through the **Users list** page.

## More information

[Create users according to licenses.](/dynamics365/business-central/ui-how-users-permissions)
