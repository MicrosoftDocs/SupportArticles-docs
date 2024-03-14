---
title: Project Publish jobs process remains at 80 percent for a long time
description: Resolves an issue in which Project Publish jobs remain at 80 percent for a long time before being completed.
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
  - Project Online
  - Project Server 2013
ms.date: 03/31/2022
---

# Project Publish jobs remain at 80 percent for a long time before completing

## Symptoms

When publishing your Project plan, you notice on the Project Server Manage Queue Jobs page that the Project Publish job takes a long time to complete. Specifically, the progress spends a lot of time at the 80 percent mark.

## Cause

This issue occurs because your Project plan contains a large number of Tasks and Assignments. What is occurring is that the publish operation is trying to synchronize the task information in the Project plan with the associated SharePoint task list, and that can take time, especially if there is a large amount of tasks to be synchronized. 

## Resolution

Here is a possible workaround for customers who do not need the following features: 

- If you do not use the Project Site Task list to review tasks in your Project plan (most customers use the Project Center to view their Enterprise Project).
- If you do not have to link Issues, Risks and Documents to your Tasks. 

   **Note** Icons that indicate an issue, risk, or document that is associated with the Project will still be displayed in the Project Center view for that project as long as an item exists.    

Here are steps to either disable syncing or to remove the Task List, which in turn will skip the task synchronization process, thus speeding up the Project Publish operation. 

### This section applies to Project Server 2013

Steps to disable syncing of Task List for a specific Project site by using PowerShell

In Project Server 2013, if customers have Project Server Service Pack 1 or a later version deployed, there are a set of PowerShell cmdlets that enable or disable syncing of Task Lists on a per-Project Site level:

- Get-SPProjectEnterpriseProjectTaskSync   
- Disable-SPProjectEnterpriseProjectTaskSync   
- Enable-SPProjectEnterpriseProjectTaskSync   

This approach works well for on-premise deployments of Project Server 2013, and for customers who have several Projects that have many tasks, assignments, or both. To disable syncing of Task List for a specific Project site using PowerShell, follow these steps:

1. Log on to the server in your SharePoint farm that hosts the SharePoint Central Administration site.   
2. Start **SharePoint 2013 Management Shell**.    
3. Use the Disable-SPProjectEnterpriseProjectTaskSync cmdlet as follows to disable site synchronization: 
   ```powershell
   Disable-SPProjectEnterpriseProjectTaskSync -Url http:// servername /PWA/TestProject
   ```    
TipGet-SPProjectEnterpriseProjectTaskSync will only return a value if it was configured by using the related Enable or Disable cmdlets. Otherwise, a default site will return no value. In its default state, Task List synchronization is always enabled. 

### This section applies to Project Online and Project Server 2013

The instructions in this section are intended for Project Online customers, as the option for disabling task synchronization is not available through PowerShell. The alternative approach would be to remove the Task List to skip the task synchronization process. 

Steps to remove the Tasks List from the associated Project site

1. Log on to Project Web App (PWA), and move to **Server Settings** > **Connected SharePoint Sites**.   
2. In the **Site Address** column, locate the associated Project site for your Project plan that is taking a long time to publish, and then click on the link to move to it.    
3. On the Project site, click the **Tasks** link in the left navigation pane.  
4. On the top ribbon bar, select the **List** tab. This will open the ribbon for the tab.   
5. Click **List Settings**.   
6. In the Settings page for this specific Tasks list, click the option **Delete this list**. If you are prompted, click **Yes** to send the list to the recycle bin.   

**How to Restore the Tasks List**

If you need to use the Task List after deleting it, you can recover it by going to the Recycle bin and then restoring the List item from there. To reach the Recycle Bin, follow these steps:

1. Browse to the Project site where you deleted the Task List. On the left navigation pane, click **Site Contents**.   
2. On the upper-right section of the **Site Content** page, click **Recycle Bin**.   
3. Select the recently deleted **Tasks List**, and then click **Restore Selection** to restore it.   

**How to configure a new EPT**

This section covers steps on how to configure a new EPT to use a changed Project Site template with the Task List removed. We recommend this only be done after carefully considering your Project plan data profile. 

**Note** Only create Projects using this custom EPT if you never have to use the Task List in the Project site, and if the Projects created using this EPT are expected to have many Tasks, Assignments, or both. We do not recommend creating all Projects by using an EPT configured this way. 

**How to configure a custom EPT with a changed Project Site template with the Task List removed**

First we'll start with creating a new template from a default Project site:

1. Log on to PWA, and then click **Server Settings** > **Site Contents**.   
2. On the **Site Contents** page, click **new subsite**.   
3. When you are prompted, provide a **Title** and **URL name** of your choice. For the **Template Selection**, make sure that you select **Project Site**, leave all other settings as default, and then click **Create**.   
4. After the Project site is created, you will automatically be taken to it. When it loads, click on the **Tasks** link in the left navigation pane.   
5. On the ribbon bar at the top, select the tab named **List**. This will open the List options in the ribbon.    
6. Click **List Settings**.   
7. In the **Settings** page for this specific **Tasks** list, click the option **Delete this list**. When you are prompted, click **Yes** to send the list to the Recycle Bin.   
8. Move to **Site Settings** > **Save Site as Template**.   
9. Specify the **File Name** and the **Template Name** as **Project Site with No Tasks List**.   
10. Leave the **Include Content** option cleared, and then click **OK**.   

Next, we will create a new Enterprise Project Type (EPT), and then pair it with the newly created Project Site template:

1. In PWA, move to **Server Settings** > **Enterprise Project Types**.   
2. Click **New Enterprise Project Type**.   
3. Model a new EPT based on the Enterprise Project EPT:
   1. In the **Name** box, type Enterprise Project with No Task List.   
   2. In the **New Project Page** box, select **Project Information**.   
   3. In the **Available Project Detail Pages** box, select **Schedule, Project Details**.   
   4. In the **Project Site Template** box, select the **Project Site with No Tasks** list. Click **Save** to save the new EPT.   
4. Now, try and create a new Enterprises Project. Browse to the Project site, and then verify that the Tasks list is no longer there.
