---
title: Can't silently join a machine group
description: Provides a resolution for an issue where you can't join a machine group silently using the Power Automate for desktop app.
ms.reviewer: matp, kenseongtan, johndund
ms.author: fanedjad
ms.date: 01/24/2024
ms.subservice: power-automate-desktop-flows
---
# Can't silently join a machine group using Power Automate for desktop

This article provides a resolution for an issue where you can't join a machine group silently using the Power Automate for desktop app.

_Applies to:_ Power Automate

## Prerequisites

Ensure you've installed the latest Power Automate version and followed the guidelines in [Silent registration for machines](/power-automate/desktop-flows/machines-silent-registration#silently-join-a-machine-group).

## Symptoms

When you try to join a machine group using silent mode, you receive a "NotFound" error:

> Error code:0x80040217. Http status code: NotFound. Request ids:REQ_ID:{guid}.  
> Correlation id: {guid}

## Cause

This error occurs when the service can't locate the specified machine group.

## Resolution

Follow these steps to resolve the issue:

1. Verify the machine group environment.

   Ensure that the machine group exists in the same environment as your machine. During machine registration, you can specify the environment by using the `-environmentId` optional command argument.

   For more information, see [Silent registration for machines](/power-automate/desktop-flows/machines-silent-registration#silently-join-a-machine-group).

2. Check the machine group permissions.

   Confirm that the machine group is shared with the user who owns the machine.

   For instructions on managing group sharing, see [Share a machine group](/power-automate/desktop-flows/manage-machine-groups#share-a-machine-group).

3. Check user permissions.

   Ensure that the user attempting to join the machine group has the necessary permissions.

   You can [update user permissions based on security roles](/power-automate/desktop-flows/manage-machine-groups#update-permissions-based-on-security-role).

> [!NOTE]
> Make sure the user is listed as the "Owner" of the machine in the [Power Automate portal](https://make.powerautomate.com/) and that the user performing the join operation has the appropriate permissions to the machine group.
