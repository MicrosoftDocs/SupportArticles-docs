---
title: Project Server Sync Jobs take a long time to complete
description: Explains why sync jobs can take a long time and how to mitigate the issue.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Project Server 2013
  - Project Server 2010
  - Microsoft Office Project Server 2007
ms.date: 03/31/2022
---

# Project Server Sync Jobs take a long time to complete and users get Access Denied

## Symptoms

Part of the Project Security model includes checking user permissions to access the Project Web App (PWA) home page and the Project sites (workspaces) associated with project plans.  Whenever a category, group or individual user is modified, Project Server will validate a user's access.  Depending on the number of users and the number of project sites within your PWA instance, the jobs that check user permissions may take a very long time to complete or fail to complete.  Additionally users may see "Access Denied" errors when attempting to access PWA or Project site/workspace. 

## Cause

During the permissions check, several jobs are placed into the Queue for processing. During a Sync job, users are taken off the top level PWA site and any Project sites/workspaces that they were assigned to. Then the user is added back to the sites based on their individual, group or category permissions as well as their role in each plan. The number of users and projects contribute to how long it will take for Sync jobs to complete. 

For example Sync jobs are kicked off in the follow scenarios:

- When a new plan is published and a project site/workspace is created or synchronized.
- When an Active Directory Sync job runs to synchronize either the Enterprise Resource Pool or Security Groups. 
- When a user account is modified.

Other possible causes for slow performance:

There are also network and hardware considerations that also contribute to the time it takes for the Queue to process jobs. One example is when there are multiple servers in one Farm, if the clocks on the servers are not synchronized this can cause delays in processing job requests.

## Resolution

- If the queue jobs are processing, then wait and let them complete.  Once the jobs complete all users will again have access to PWA and project sites/workspaces.  

- If the queue job has failed, the PWA Admin should review the error message in the queue to gather more information as to the nature of the failure.  The Farm Admin can also collect the ULS logs to gather additional information on the error.  Open a support incident if needed.

- If there are a large number of users/projects in the PWA instance, there are a number of best practices that can mitigate the performance issues.  In the More Information section are links to a number of detailed articles.  The main point of the articles say to plan/limit the number of users that need access to PWA and Project Sites/workspaces and design security groups and categories to mitigate performance issues. 

   Such as, use the Project Server security to control the number of projects/site a user has access to by setting up Resource Breakdown Structure for users in conjunction with the security category filters to limit which projects users can see. Controlling the number of projects a user can see determines which workspaces the user can access. By using the Project Server security model, users are added to SharePoint groups instead of added individually, to mitigate the chance of hitting the SharePoint limit of 5000 security objects per web application.  This method works well for Project server 2013, 2010 and 2007.

   Use SharePoint Security mode in Project Server 2013 which does not synchronize users to Project Sites but instead the Project Manager manually shares sites with users.

- Turn off the feature to synchronize Project sites/workspaces. It is possible to turn off the feature that adds users to project sites/workspaces in which case the Project Manager would then add them manually.

To turn off the synchronization feature follow the steps below for your version of Project Server:

For Project Server 2007:

Go to Server Settings, click Project Workspace Provisioning Settings. 
In the section "Workspace Permissions", clear the box to Check to automatically synchronize PWA users.... 

For Project Server 2010:

Go to Server Settings, click Project Site Provisioning Settings.
In the section "Project Site Permissions", clear the box to Check to automatically synchronize PWA users...

For Project Server 2013 in Project Server security mode:

Go to Server Settings, click Manage User Sync Settings. You can disable one or both sync options, PWA or Project Site sync.

Lastly check the clocks among all the servers to verify they are in sync. Out of sync servers will result in delayed pickup of queue jobs.

## More information

The SQL server may time out when attempting to add users to workspaces. When reviewing a SQL Profiler trace you see Exception 1222 Severity 16 State 18 when the stored procedure MSP_Resource_ReadUserSummariesActive is executed. This is a timeout error.

At the same time SharePoint Server has a limit of 5000 security objects per web application. Project Server Admins should use SharePoint best practices to avoid such limitation. The following document link has more information on SharePoint limits: [Software boundaries and limits for SharePoint Servers 2016 and 2019](/sharepoint/install/software-boundaries-limits-2019).

[Best practices for managing a large number of resources in Project Server 2010](/previous-versions/office/project-server-2010/hh670402(v=office.14))
