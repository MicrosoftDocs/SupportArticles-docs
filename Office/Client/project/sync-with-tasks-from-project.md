---
title: Sync with SharePoint tasks list from Project Professional
description: Describes a Project Professional feature that lets you sync .mpp files to a new or existing SharePoint site. Updated for Project 2016.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2019
  - Project Professional 2019
  - SharePoint Server 2016
  - Project Professional 2016
  - Project Professional 2013
  - SharePoint Server 2013
  - Project Online Desktop Client
  - SharePoint Online
ms.date: 03/31/2022
---

# Sync with SharePoint tasks list from Project Professional

## Summary

 The Sync with SharePointfeature lets a Project Manager share an .mpp project file with Microsoft SharePoint users. This feature is available to use with SharePoint Server 2013, SharePoint Server 2016, SharePoint Server 2019, and SharePoint Online through Project Professional 2013, Project Professional 2016, Project Professional 2019, and Project for Microsoft 365. This feature creates a SharePoint Project site. This site contains a Project Summary and Timeline, a tasks list, and a Calendar. Synchronizing also saves the .mpp file to the site assets for future editing.

> [!NOTE]
> The Project Manager must be part of the SharePoint Owners group (or at the least have designer permissions) on the parent site collection where the new or existing site resides.

Synchronization goes the other way, too. If you have a SharePoint tasks list, there's an **Open with Project** button that opens the plan in Project Professional. This feature lets you use the Project Scheduling Engine to make schedule updates in Project Professional 2013, Project Professional 2016, Project Professional 2019, or Project for Microsoft 365 and then synchronize the static list back to the tasks list on the SharePoint Project site.

Managing a Project Site tasks list in this manner is also known as lightweight project management. Project Server is not required for this functionality. SharePoint Foundation 2013, SharePoint Foundation 2016, or SharePoint Foundation 2019 is the minimum requirement for using the **Sync to SharePoint**feature.

When you use SharePoint Server, you can use the "All My Work in One Place" feature to display all tasks that are specifically assigned to you. From your "My site" personal tasks list, you can view, organize, and update all your work from this one location. The following URL is for a SharePoint personal tasks list:

> `https://TenantName-my.sharepoint.com/personal/Name_TenantName_onmicrosoft_com/AllTasks.aspN`

**Scenarios for using Project Professional with SharePoint Server or SharePoint Online**

- Create a plan in Project, and then sync by using NEW SharePoint Site. A site and tasks list are created.
- Create a plan in Project, and then sync by using Existing SharePoint Site. This updates an existing list or creates a new list, depending on your selection.
- In SharePoint when you have tasks in a tasks list, you can use Open with Projectto open the plan in Project Professional for editing and then sync back to the existing SharePoint site. The .mpp file is saved to the site assets for future editing.

The following Office article describes how to synchronize a Project plan with SharePoint, and how to sync to create a New Project site and an Existing Project site:

- [Sync with a SharePoint tasks list](https://office.microsoft.com/project-help/sync-with-a-sharepoint-tasks-list-ha102828524.aspx)

## More Information

### Considerations

**MPP**

 Because we save the .mpp file to the Project Site's Site Assets, you should not save a local copy of the plan for editing. You will always use **Open with Project** when you want to use Project to update either the SharePoint tasks list or the .mpp file. These two entities are now linked, and the SharePoint tasks list is considered the "master." Opening the .mpp file from any location other than Site Assets will damage the link and cause issues, such as duplicate tasks on the SharePoint tasks list. You may also receive an error message, which is discussed later in this article.

**Save**

 After you sync a plan to a SharePoint tasks list, the next time you want to update the tasks list just click Save in Project.

**Manual versus Auto scheduled tasks**

 When you open a SharePoint tasks list in Project Professional for the first time, the tasks will be set to **Manual** or **Auto scheduled**, depending on the **New tasks created**setting in your Project client. You can find this setting on the **File** menu, by clicking **Options**, and then selecting the **Schedule** tab.

**Predecessors**

 Currently, a single task cannot contain more than 89 links to other tasks. Project Professional may crash if it has a larger number of predecessors. 

**External links**

When you try to sync a plan that contains external links to tasks in other plans, you receive an error message that contains the wrong information. The error message should tell you that you cannot sync a plan with external links. Instead this is the message that you receive:
```adoc
Cannot access the site due to one of the following reasons:
- The Sharepoint site url is invalid
- The Sharepoint site is currently unavailable
- The user does not have full or design permissions in the Sharepoint site
```

The plan may save to the tasks list, but the .mpp is not saved to the Site Assets. Therefore, you cannot use the .mpp file again for updating the tasks list. In this situation, we recommend that you delete the subsite and begin again, if possible.

**Large number of tasks**

 SharePoint has a limit of 5,000 items in a list. However, you will experience severe performance issues if there are 1,000 tasks in a list. Project best practices suggest that 750 is the largest number of tasks that you should include a project plan. A SharePoint list should be even smaller for optimal functionality and usability. For example, 100 tasks in a SharePoint tasks list is a reasonable number to work with.

**Resources**

 If there are resources assigned in your plan that are not resources in SharePoint, you receive a warning message stating that these resources will not be added to the SharePoint tasks list but that the tasks will sync to the list. This error message resembles the following:

> We can't sync resource \<resource name> to the tasks list because the resource does not exist on the SharePoint server. This resource, and any other resource that doesn't exist in SharePoint, will remain assigned to the tasks in your project plan.  

To add these users to SharePoint, contact your SharePoint administrator. It's a best practice to always use the People Picker when you assign users to tasks.

**Starting with a SharePoint tasks list**

 If you, the Project Manager, begin in SharePoint by having a tasks list, they can decide at any time that you want to use Project's scheduling engine to calculate a more precise schedule. You can click the **Open with Project** button from the **List** ribbon, the Project client starts as the currently logged-on user, and you can begin editing.

**Open with Project**

 When the plan opens, the tasks will be either Manually Scheduled or Auto Scheduled based on the value of **File**> **Options** > **Schedule** > **New tasks Created**. Tasks can be added or edited by using any or all features in the Project client and then synced back to the SharePoint tasks list just by clicking **Save**.

**Map Fields**

 Only the fields that are mapped between the two products will synchronize. The following fields sync between your SharePoint list and Project by default:

- Task Name  
- Start date  
- Finish (due) date  
- % Complete  
- Resource Name  
- Predecessors

 If you want to map more fields to be synced between Project and SharePoint, you can do this on the **Info** tab on the **File** menu with in Project. Specifically, open the **Map Fields** dialog box, and then select the new fields that you want to sync. This way, you can have your team members report on other custom fields, or you can generate reports based on non-default SharePoint columns.

**Synchronizing to an existing task list**

 If you sync to an existing tasks list that has already been linked to another plan (or if the original sync did not copy the .mpp to site assets), you receive the following error message:

> The tasks list is linked to a different project plan. If you continue with the synchronization the task list link will be changed to the current project plan.
>
> Would you like to continue with the synchronization?

**Conflict resolution**

 If the .mpp file is open in Project at the same time that a user adds or edits task info in the SharePoint tasks list, a conflict dialog box is displayed the next time that the .mpp file is saved. This dialog box gives the user the following options:

- Keep Microsoft Project version for all fields
- Keep SharePoint version for all fields
- Choose between SharePoint and Microsoft project versions

**Outlook Sync**

 Tasks can be updated in Outlook, but they cannot be created in Outlook and then inserted into a SharePoint tasks list.
