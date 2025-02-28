---
title: Permission error when Microsoft 365 access is enabled
description: Provides a resolution for the Microsoft 365 permission error that occurs in Dynamics 365 Business Central.
ms.author: mikebc
ms.reviewer: jswymer
ms.date: 05/20/2024
ms.custom: sap:Integration\Teams
---
# A permission error occurs even though Microsoft 365 access has been enabled

This article describes how to resolve a permission-related problem users might encounter when trying to access Business Central records from Microsoft Teams, even though access with Microsoft 365 licenses is properly enabled in the Business Central admin center.

## Symptoms

When a user selects a link or card for a Business Central record in a Microsoft Teams conversation, they receive an error message similar to "Sorry, the current permissions prevented the action."

## Cause

This behavior is by design. Administrators must first configure what data can be accessed in Microsoft Teams. If the administrator enables access in the Business Central admin center, but doesn't assign permissions on the **License Configuration** page, a user who tries to access Business Central records in Microsoft Teams will have their user record provisioned without permission to any objects.

## Resolution

> [!NOTE]
> To solve this issue, you need tenant administrator permissions in Business Central.

In addition to enabling Microsoft 365 access in Dynamics 365 Business Central admin center, also assign permissions on the **License Configuration** page. However, permissions assigned on the **License Configuration** page will only apply to newly created users. For users that have already been created, you must also assign the missing permissions through the **Users list** page.

## More information

[Create users according to licenses](/dynamics365/business-central/ui-how-users-permissions)
