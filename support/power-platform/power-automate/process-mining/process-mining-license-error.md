---
title: Licensing error when accessing the process mining capability
description: Provides resolutions for the user has not been assigned any license error that occurs when accessing a process in Power Automate.
ms.reviewer: hamenon
ms.date: 09/14/2024
ms.custom: sap:Process advisor\Process Mining
---
# "The user has not been assigned any license" error when accessing a process in the process mining capability

This article resolves a licensing error that occurs when you access a process in the [process mining](/power-automate/process-mining-overview) capability in Power Automate.

_Applies to:_ &nbsp; Power Automate Process Mining

## Symptoms

When you access a process that is shared with a disabled user or a user without a license, the following error occurs:

> Error loading users for this process: the user (id=\<GUID>) has not been assigned any License. Please contact your system administrator to assign license to this user for the action to succeed.

## Cause

The error occurs because the user that the process is shared with doesn't have an associated Power Automate license. In most cases, this issue occurs when the user the process is shared with already left the organization or has been disabled.

For more information about licensing and process mining capabilities offered with different licenses, see [Overview of process mining and task mining in Power Automate](/power-automate/process-advisor-overview#licensing).

## Resolution 1: Delete the user from Dataverse

For more information, see [Delete a user](/power-apps/developer/data-platform/user-team-entities#delete-a-user).

## Resolution 2: Revoke sharing permissions from the user using a Power Automate flow

1. In [Power Automate](https://make.powerautomate.com/), on the left pane, select **My flows** > **+ New flows** > **Instant cloud flow**.

2. Add a **Perform an unbound action**. Enter the following details:

    **Action Name**: *Revoke Access*

    **Target**: */msdyn_pminferredtasks(\<PROCESS-ID>)*.

    The `PROCESS-ID` should be the process ID that needs to be revoked. The ID can be found in the URL.

    **Revoke**:

    ```http
    {
      "systemuserid": "USER-ID",
      "@{string('@odata.type')}": "#Microsoft.Dynamics.CRM.systemuser"
    }
    ```

    The `USER-ID` should be the ID of the user that needs to be revoked. The ID can be found in the error message.
