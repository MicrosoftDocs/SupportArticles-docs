---
title: License errors when accessing Process Mining Process
description: Common Power Automate Process Mining license errors.
ms.reviewer: hamenon
ms.date: 09/10/2024
ms.custom: 
---
# Licensing errors when accessing Process Mining Process

This article highlights common Licensing errors when accessing Process Mining Processes.  For more information about Process Mining in Power Automate, see [Overview of process mining](/power-automate/process-advisors-overview).

_Applies to:_ &nbsp; Power Automate Process Mining


## License error when accessing a process which is shared with a user without a license

### Error loading users for this process

> Error loading users for this process: the user (id=*guid*) has not been assigned any License. Please contact your system administrator to assign license to this user for the action to succeed. 

This error occurs if the user that the process is shared with does not have an associated power automate license. In most cases this occurs when the user the process has been shared with has left the organization. 

Use one of the following methods in order to address this issue:

#### Solution 1: Delete the user from Dataverse
Follow the documentation detailed here to remove the user from the environment: [Delete a user](https://learn.microsoft.com/power-apps/developer/data-platform/user-team-entities#delete-a-user)

#### Solution 2: Revoke sharing permissions from the user using a Power Automate flow
Go to My flows in the Power automate portal and select "“+ New flows” at the top and choose“Instant cloud flow”.

Then, add an action “Perform an unbound action”

Enter: 

Action name: “Revoke Access”

Target: “/msdyn_pminferredtasks(PROCESS-ID)”, with PROCESS-ID being the process id that needs to be revoked. This can be found in the url

Revokee: 
{
  "systemuserid": "USER-ID",
  "@{string('@odata.type')}": "#Microsoft.Dynamics.CRM.systemuser"
}

With USER-ID being the id of the user that needs to be revoked. This id would appear in the error message
