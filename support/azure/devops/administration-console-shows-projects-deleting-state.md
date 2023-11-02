---
title: Console shows projects in Deleting state
description: This article provides resolutions for problem that projects in the Team Foundation Server Administration Console are displayed in Deleting state.
ms.date: 08/14/2020
ms.custom: sap:Installation, Migration, and Move
ms.service: azure-devops-server
---
# Administration Console shows projects in 'Deleting' state after Team Foundation Server 2015 upgrade

This article helps you resolve the problem that projects in the Team Foundation Server Administration Console are displayed in **Deleting** state.

_Original product version:_ &nbsp; Team Foundation Server 2015, Team Foundation Server 2015 Express  
_Original KB number:_ &nbsp; 3081117

## Symptoms

After you upgrade to Team Foundation Server 2015, you see projects in the Team Foundation Server Administration Console that are in the **Deleting** state and that include the following description:

> This placeholder project was created during the upgrade to Team Foundation Server 2015 in support of requirements introduced by Team Project rename.

## Cause

In pre-Team Foundation Server 2015 versions of Team Foundation Server, paths are allowed in Team Foundation Version Control without corresponding team projects. For example, the `$/Foo` folder can exist in Version Control without a team project that's named _Foo_. There are several scenarios in which this behavior can occur:

- Deleting a team project before Team Foundation Server 2010 checks in a delete of the team project folder. For example, deleting a team project that's named _Foo_ leaves behind a deleted folder named `$/Foo` in Version Control, with all of its history preserved. In Team Foundation Server 2010 and later, deleting a team project destroys the history of the corresponding folder in Version Control. Therefore, this scenario does not occur.

- In earlier versions of Team Foundation Server, it's possible to call `VersionControlServer`.`CreateTeamProjectFolder()` in the client object model without an existing team project with the same name. This scenario is no longer permitted in Team Foundation Server 2015.

In Team Foundation Server 2015, paths in Team Foundation Version Control are not permitted without corresponding team projects. When you upgrade to Team Foundation Server 2015, this creates placeholder projects in the **Deleting** state that include the description that was described in the [Symptoms](#symptoms) section.

## Resolution

If you no longer need the data in a placeholder team project, you can delete it by following the steps in [Delete a project](/azure/devops/organizations/projects/delete-project). Otherwise, no action is required. Placeholder team projects are hidden in Web Access and Team Explorer in Visual Studio. Therefore, they have no significant effect on day-to-day usage. As with any other deleted item in Version Control, you can still access the corresponding project in Source Control Explorer if the **Show/Hide Deleted Items** button is enabled.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
