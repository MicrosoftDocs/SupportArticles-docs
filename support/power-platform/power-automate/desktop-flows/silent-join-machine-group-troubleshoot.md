---
title: Can't silently join machine group
description: Provides a troubleshoot guide for an issue when joining a machine group using power automate desktop silent app.
ms.reviewer: 
ms.author: fanedjad
ms.date: 01/12/2024
ms.subservice: power-automate-desktop-flows
---
# Can't silently join machine group


## Prerequires
Ensure you have the latest Power Automate version installed and have followed the guidelines outlined in the following documentation [Silent registration for machines](/machines-silent-registration#silently-join-a-machine-group).


## Symptoms
If you encounter the error **NotFound** while attempting to join a machine group using silent mode with the following details:
> Error code:0x80040217.Http status code: NotFound. Request ids:REQ_ID:{guid}.
> Correlation id: {guid}

## Cause
This error occurs when the service cannot locate the specified machine group.

## Resolution
Follow these steps to resolve the issue:
1. **Verify Machine Group Environment**

   Ensure that the machine group exists in the same environment as your machine. During machine registration, you can specify the environment by using the -environmentId optional command argument.

   Refer to the [Silent registration for machines](/machines-silent-registration#silently-join-a-machine-group) documentation for guidance.

2. **Check Machine Group Sharing**
   
   Confirm that the machine group is shared with the user who owns the machine.
   
   Refer to the [Manage machine groups - Share a machine group](/manage-machine-groups#share-a-machine-group) documentation for instructions on managing group sharing.

3. **Check Permissions**

   Ensure that the user attempting to join the machine group has the necessary permissions.
  
   You can update user permissions through the [Manage machine groups - Update permissions](/manage-machine-groups#update-permissions-based-on-security-role) documentation.

> [!NOTE]
> Make sure the user listed as the "Owner" of the machine in the portal and the user performing the join operation have appropriate permissions to the machine group
