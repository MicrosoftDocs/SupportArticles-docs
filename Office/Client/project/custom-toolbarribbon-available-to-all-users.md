---
title: Make a custom toolbar/ribbon available to all users in Project client
description: Describes how to create a custom toolbar that has a button to run a macro. Includes information about how to make the toolbar available to all users of Project client.  Also talks about how to do the same for the Ribbon in 2010. Also makes mention of an error when opening plans The Enterprise Global already contains, it could be a view, a table or any other Project object that has a duplicate name.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-jomcc
search.appverid: 
  - MET150
appliesto: 
  - Project Server 2013
  - Project Professional 2013
  - Project Server 2010
  - Project Professional 2010
  - Microsoft Office Project Server 2007
  - Microsoft Office Project Professional 2003
ms.date: 03/31/2022
---

# Make a custom toolbar/ribbon available to all users in Project client

## Introduction

This article describes how to create a custom macro, and toolbar/ribbon that contains buttons to run macros). Additionally, this article describes how to deploy the custom objects to either the local global template (Global.mpt) or the enterprise global template if using Project Server. This allows the custom toolbar/ribbon to be available to all users of Microsoft Office Project clients whether users connect to Microsoft Office Project Server or use standalone Project clients.

## More Information

When a project is opened it uses information in the local file, as well as the global template file, to set defaults for the plan. The global template file
contains, views, reports, modules (macros), tables, filters, calendars, maps, fields, and groups (Toolbars are available in Project 2007 or earlier global template files but not 2010, the ribbon was introduced in 2010). Your project plan will use the defaults from the global template unless you create new or modify the existing objects . Customized objects are stored to the local project unless you take steps to copy the information to the global file. This global template can be shared with other Project client users, either by sending them the global.mpt file to save locally or share it via a network location.

When an enterprise project is opened from Project Server, the enterprise global template settings are applied to the project.  After the enterprise global template is applied to the project, any items in the local global file that do not have the same names as the items in the enterprise global template are also applied to the project file. Therefore, if you created a custom view, table, or filter that has the same name as an item in the enterprise global template, you are prompted to rename or overwrite the custom item. The error message you receive is similar to the error below:

"The Enterprise Global already contains a (an object such as a view, table, calendar, etc.) named "\<ObjectName>". Rename or Replace."

Renaming the object will resolve the issue and allow you to continue to open the plan. Also a second version of the object is retained if needed.

Typically, the enterprise global template takes precedence over other templates. However, the precedence of ribbons, toolbars and menus is treated differently from other items in the enterprise global template. Ribbons, toolbars and menus in the local global file take precedence over ribbons, toolbars and menus that have the same name in the enterprise global template. Additionally, different language versions of ribbons, toolbars and menus in the local global file take precedence over ribbons, toolbars and menu items in the enterprise global template. However, a custom ribbon or toolbar that has a unique name in the enterprise global template file in Project Server will be available to all users of Project. 

The general steps used to move customized objects from a local plan into the local global file are pretty straight forward:

1. Create the custom object in your local plan.   
2. Open the Organizer which shows the objects in the local global template and the plan side by side.   
3. Move the customized object from the plan to the global template and you are done.    

These steps will work for all versions of Project through 2010.

However, if you want to add customized objects to the Enterprise Global Template (because you are using Project Server) the Enterprise Global can only be accessed by a user with rights to open the Enterprise Global Template from Project Server Settings. This action then launches Project Professional with the Enterprise Global Template open in memory. You can move objects from the local Global or any open project plan to the open Enterprise Global Template.

To include a custom ribbon tab that has a command button to run a macro in your enterprise global template file in Project 2010, follow these steps:

### Steps to Create a custom macro


1. Start Project client.   
2. Start a new project. It's name is Project1.   
3. On the View tab, click the Macros drop down list, and then click RecordMacro.    
4. In the Macro name box, type a name. For example, Macro1 is the default.   
5. In the Store Macro in list, click Global file. If you select This Project then the macro is only available in Project 1.    
6. Click the other appropriate options, and then click OK.   


### Steps to copy the module that includes the macro to the local global template if needed


1. On the Info page of the File tab, click the Organizer button ot the left of OrganizeGlobal Template.

   Note: the name of the files currently open will appear at the top of each window. You can change the file to another open file using the drop down lists at the bottom of each window.   
2. Click the Modules tab   
3. Where you see the module that contains the macro created in the steps above, select it.   
4. Between the panes, click Copy, and then click Close.   

The global will is automatically saved. The module and macro will now be available to all plans that use this local global template.

### Steps to copy the module to the enterprise global template in 2007 or 2010.


1. Launch Project Web Access as a user with permissions to modify the Enterprise Global Template.   
2. Click Server Settings > Enterprise Global and click the button Configure Project Professional. Project Professional will launch with the Enterprise Global template in memory.   
3. Click the File tab, select Info and Manage Global Template.    
4. Open the plan where your macro is stored if not already in the Global (+ non-cached enterprise).   
5. Click the Module tab and then select the module you wish to copy into the Enterprise Global Template.   
6. Between the panes, click **Copy**, and then click **Close**.   
7. Click the Task tab and then click Save to save the enterprise global template.   
8. Exit Project Professional.    

The next time a user opens any enterprise plan, the macro will be available.

### Steps to create a custom toolbar and add the macro to a button in 2007 and earlier.

1. Start th Project client.   
2. On the **Tools** menu, point to **Customize**, and then click **Toolbars**.   
3. On the **Toolbars** tab, click **New**, and then type a name in the **Toolbar name** box. For example, type CustToolbar1, and then click OK.   
4. Click the **Commands** tab.   
5. In the **Categories** list, click **All Macros**.   
6. Drag the ****Macro1**** command from the **Commands** list to the toolbar.   
7. Click the newly added macro button on the toolbar.   
8. In the **Customize** dialog box, click **Modify Selection**.   
9. Click **Edit button image** or **Change button image**, and then make the necessary changes.   
10. Click **Close**.   
11. Open the enterprise global template or the toolbar is saved to the local global template file.   
12. With the newly added button selected, click **Modify Selection**, and then click **Assign Macro**.   
13. Make sure that the macro that you created appears in the **Command** box. This macro must not be a file-specific macro.   
14. Click **Close**.   
15. Exit Project client.
