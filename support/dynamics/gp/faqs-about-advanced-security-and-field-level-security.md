---
title: FAQs about Advanced Security and Field Level Security
description: Discusses frequently asked questions about how to set up and use Advanced Security and Field Level Security.
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Frequently asked questions about Advanced Security and about Field Level Security in Microsoft Dynamics GP and in Microsoft Great Plains

This document discusses frequently asked questions about how to set up and use Advanced Security and Field Level Security in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894705

## Advanced Security

Question 1: Where is the Advanced Security module located in Microsoft Great Plains or in Microsoft Dynamics GP?

Answer 1: To access the Advanced Security module in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0, click **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**.

Question 2: Does Advanced Security extend the security model in Microsoft Great Plains or in Microsoft Dynamics GP?

Answer 2: No. Advanced Security is just a new interface for the existing security model. Advanced Security uses the same security tables that Standard Security uses.

Question 3: What are the differences between Advanced Security and Standard Security?

Answer 3: Standard Security uses separate dialog boxes that let you control security for a single user or for a user class. Standard Security uses a third dialog box to set access to SmartList favorites. To change security for a dialog box, you must know the exact name of the dialog box and the exact name of the series to which the dialog box belongs. To set security for modified, alternate, or modified alternate windows, you must change views.

Advanced Security provides an explorer-style interface that lets you control different types of security at the same time in the same dialog box. These types of security include the following:

- Security for multiple users, companies, and classes
- SmartList security

Advanced Security provides multiple views that include the **By Menu** view. The **By Menu** view lets you set security by using the navigation model. Additionally, changes at upper levels of the tree are automatically rolled down to child resources. You can access modified, alternate, or alternate modified resources by clicking the dictionary that you want to use. And you can do this without changing views.

Question 4: What are some of the benefits of using Advanced Security?

Answer 4: Among the benefits of using Advanced Security are the following:

- Advanced Security enables security to be set up for multiple users, companies, and classes at the same time. When class changes are made, Advanced Security does not overwrite user-level changes.
- Advanced Security lets you set security based on the navigation model.
- Advanced Security has a **By Alternate, Modified, and Custom** view that displays security only for customized resources to make it easier to control access to customizations. When security is granted back to resources, Advanced Security gives you the option to automatically select alternate and modified resources if they exist.
- Advanced Security lets you quickly show the resources to which the selected user and company have access. At the same time, Advanced Security lets you show which other users in the company have access to the selected resource.
- Advanced Security lets you copy security settings to other companies or users.
- Advanced Security lets you roll down class security settings to selected users of a class by using the option to overwrite user-level changes. You can do this by clicking to select the **Revert First** option.
- Advanced Security can roll up a user's security settings to a class.
- Advanced Security can change user security settings back to their initial state.
- Advanced Security can verify security settings to make sure that they are valid and that all customizations that are pointed to actually exist.
- Advanced Security can export and import security settings between systems or for backup purposes by using .xml files.
- Advanced Security can selectively print the security settings for a user and company or for a class.
- Advanced Security provides an interactive dialog box that can identify and fix security problems. Advanced Security lets you give temporary or permanent window access back to a user without having to change logins or to use a different computer.

    > [!NOTE]
    >
    > - To be prompted by the interactive dialog box, you must have a system password configured. You must enter the system password to make the security changes through the interactive dialog box.
    > - The interactive dialog box is controllable in Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0. By default, this dialog box is turned off in Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0.

Question 5: What does the Advanced Security Accelerator do?

Answer 5: The Advanced Security Accelerator includes an accelerator table that is a cache of the status of every node in the security tree for every user, company, or class combination in Microsoft Great Plains and in Microsoft Dynamics GP. The Advanced Security Accelerator lets you obtain the status of a node quickly, because you do not have to read all the levels of child nodes.

Question 6: What Advanced Security Accelerator options should be selected or not selected, and what do they mean?

Answer 6: Following are recommendations for the Advanced Security Accelerator options that should be selected or not selected. To view these options, click **Options** when you are within Advanced Security.

- **Run accelerator in background while Advanced Security is open** should be selected. It is worthwhile leaving Advanced Security open so that the accelerator can finish processing. Even though you can still use Advanced Security when the accelerator is processing, Advanced Security runs faster after the background processing has finished.

- **Reset accelerator on window close (temporary cache)** should not be selected. If this option is selected, the accelerator will re-create itself from scratch every time that you open the window.

- **Keep accelerator synchronized at all times** should be selected. This option ensures that any changes that were made by using the old windows are carried over into the accelerator.
- Also, for performance reasons, you should set the default path to be local on the computer from which you make most of the security changes. The **Local Path** box should be blank on all workstations except for the workstation where the default path is actually local.

    > [!NOTE]
    > Microsoft Great Plains 8.0 and Microsoft Dynamics GP 9.0 Advanced Security does not have the external accelerator option. When it uses a SQL-based accelerator table, Microsoft Great Plains 8.0 and Microsoft Dynamics GP 9.0 Advanced Security is 10 to 20 times faster than previous versions.

Question 7: What occurs if I turn off the Advanced Security Accelerator?

Answer 7: If you turn off the Advanced Security Accelerator, you experience the following results:

- You lose the ability to see or change security settings except at the very lowest levels of the tree. You must drill down to the specific node to see whether access is granted or denied.
- You cannot roll down security from a menu to all the entries on that menu.

Question 8: How do I turn off the Advanced Security Accelerator?

Answer 8: To turn off the Advanced Security Accelerator, follow these steps:

1. Within Advanced Security, click **Options**.
2. Click **Do not use accelerator and do not display status of parent objects**.
3. When you are prompted whether you want to reset the accelerator, click **Yes**.
4. Click **OK** to close the **Advanced Security Options** dialog box.

Question 9: Why does Advanced Security process the accelerator every time that I open the **Advanced Security** dialog box?

Answer 9: If background processing is on, the accelerator runs when you open the **Advanced Security** dialog box. The accelerator first tries to determine whether you have added any customizations. The accelerator then continues to process users, companies, or classes until the accelerator has processed all combinations. After the accelerator is finished, the **Advanced Security** dialog box opens more quickly.

Question 10: What tables are used by the Accelerator?

Answer 10: The Accelerator uses two lookup tables and the main Accelerator table. The two lookup tables are the WDC_Security_Children_Menu_REL (WDC51102) table and the WDC_Security_Children_MSTR (WDC51100) table. The main Accelerator table is the WDC_Security_Children_TEMP (WDC51101) table. These tables function as follows:

- The WDC_Security_Children_Menu_REL (WDC51102) table maps the three 16-bit integers that are the unique identifier for a menu to a single, internal 32-bit number. This is because Advanced Security can handle two 16-bit integers. But the menus in Microsoft Business Solutions - Great Plains 8.0 and in later versions of Microsoft Dynamics GP have three 16-bit integers.

- The WDC_Security_Children_MSTR (WDC51100) table maps a User/Company combination or a User Class to an Entity ID. This Entity ID is then used in the main cache table. You can run the following query to calculate the number of entities in the system.

    ```sql
    SELECT (SELECT COUNT(*) FROM SY60100) + (SELECT COUNT(*) FROM SY40400)
    ```

- The WDC_Security_Children_TEMP (WDC51101) table is the cache of the status of every node in the security tree for every Entity ID in the system. This main Accelerator table also functions as a three-way linked list in which each node (record) in the table knows what the record's parent node is in the three views. These three views are **By Menu**, **By Dictionary**, and **By Custom**. Approximately 5,000 records are stored for each Entity ID. The exact number of records varies between systems, depending on which products that are installed. You can run the following query to calculate the number of records that are stored for an entity in the system.

    ```sql
    SELECT COUNT(*) FROM WDC51101 WHERE WDC_Entity_ID = 1
    ```

    To estimate the total number of records in the Accelerator, you can multiply the results of the two previous queries by running the following query.

    ```sql
    SELECT (SELECT COUNT(*) FROM WDC51101 WHERE WDC_Entity_ID = 1) * ((SELECT COUNT(*) FROM SY60100) + (SELECT COUNT(*) FROM SY40400))
    ```

    The actual number of records in the Accelerator is displayed in the lower-left corner of the Advanced Security Options window.

Question 11: What can I do when the Accelerator becomes too large?

Answer 11: In large systems that contain many companies and users, the WDC_Security_Children_TEMP (WDC51101) table can grow to contain many records. In these situations, you have the following options when you set up the Accelerator Options:

- Click to select the **Do not use accelerator and do not display status of parent objects** check box, and then click **Yes** when you are prompted to Reset. This will turn off the Accelerator and delete the records from the tables. Additionally, this will reduce the level of functionality that is available.

- Use the following settings:
  - Click to clear the **Run accelerator in background while Advanced Security is open** check box.
  - Click to clear the **Reset accelerator on window close (temporary cache)** check box.
  - Click to select the **Keep accelerator synchronized at all times** check box.

    This will stop Advanced Security from populating the Accelerator in the background and enable Advanced Security to only create records on demand for the entities that are being edited. If the Accelerator starts to become too large, you can click **Reset Accelerator** to delete the records. This is the recommended setting for large systems.

- Click to clear the **Run accelerator in background while Advanced Security is open** check box, and then click to select the **Reset accelerator on window close (temporary cache)** check box. This will automatically reset the Accelerator when Advanced Security is closed. This keeps the Accelerator from growing, but all Entities will have to be re-read on demand every time that Advanced Security is used.

Question 12: Why is Advanced Security faster when I turn off the Advanced Security Accelerator?

Answer 12: Performance may appear to improve when you turn off the Advanced Security Accelerator. However, you lose certain functionalities. For example, if you turn off the Advanced Security Accelerator and then try to show the status of the nodes in all levels of the tree, the user interface would be unusable. If you turn off the Advanced Security Accelerator, you also lose the ability to change or to view security at all levels except for the lowest level of the tree. If this loss of functionality is acceptable to you, you might consider turning off the Advanced Security Accelerator. When you turn off the Advanced Security Accelerator, make sure that you reset it.

Question 13: Why does Advanced Security still update the Advanced Security Accelerator after I turn off the Advanced Security Accelerator?

Answer 13: When you turn off the Advanced Security Accelerator, it is not displayed. However, if Advanced Security Accelerator records exist, the records are maintained so that the records will be valid if you turn on the Advanced Security Accelerator. If you do not want the records to be maintained, turn on the Advanced Security Accelerator, and then turn it off again. When you are prompted to reset the Advanced Security Accelerator and to clear the records, click **Yes**.

Question 14: Why does Advanced Security stop me from exiting Microsoft Great Plains or Microsoft Dynamics GP or from changing to another company?

Answer 14: When you close the **Advanced Security** dialog box, the accelerator is still processing in the background. A small window is displayed to indicate that the accelerator is still processing. When the accelerator has finished processing, you can exit Microsoft Great Plains or Microsoft Dynamics GP or change to another company.

Question 15: What is the difference between the views in Advanced Security?

Answer 15: The views in Advanced Security let you see the different areas of the system for which security can be controlled. The **By Menu**, **By Dictionary** and **By Alternate, Custom and Modified** views all derive their displays from the same data. A change that you make when you are in any one of these views will be reflected when you are in any one of the other views.

- The **By Menu** view is based on the navigation model of Microsoft Great Plains and of Microsoft Dynamics GP. The **By Menu** view is a good view to use when you change security, because you cannot easily deny access to system resources or to lookups by mistake.

- The **By Dictionary** view shows all resources in the system. In this view, system resources are sorted by dictionary, by type, and by series. The **By Dictionary** view can be used to fine-tune security for resources that are not in the navigation model.

- The **By Alternate, Modified and Custom** view shows only the resources that have been customized. Following is a list of resources that can be customized:
  - Alternate forms and reports. These resources are created by a developer.

    > [!NOTE]
    > In this view, an alternate window will appear under the dictionary for which the window exists instead of under the original dictionary.
  - Modified forms and reports. These resources are created by an end user.
  - Custom reports. These resources are created by an end user.

Question 16: Where do I find my alternate and modified windows and reports?

Answer 16: Alternate and modified windows are displayed under the original window in the tree structure. To find them, find the original window in the **By Menu** or **By Dictionary** view, and then expand the window to display the dictionaries in which the window exists. You can then select which version you want to use. Another way to view alternate and modified windows and reports is to change the view by clicking the down arrow and then clicking **By Alternate, Modified and Custom**.

> [!NOTE]
> If a product has no windows of its own and it only has alternate windows or reports, the product will not be displayed in the **By Dictionary** view.

Question 17: How do the "Grant Security: All Alternate windows and reports" and "Grant Security: All Modified windows and reports" options work?

Answer 17: These options are enabled when access is being granted back to a resource after the access was denied. If there is a single alternate window or report, it will be chosen instead of the original dictionary if the **Alternate** option is chosen. If there is more than one alternate window or report, Advanced Security keeps to the original version. After Advanced Security chooses a dictionary, a modified version of the window or report is chosen if there is a modified version of the window or report and if the **Modified** option is chosen.

Question 18: How can I select classes in Advanced Security?

Answer 18: By default, the list in the lower-right section of the **Advanced Security** dialog box shows only users only. You can change the view by clicking **View** and then clicking **Users and Classes** or **Classes Only**. The default view can be changed in the Advanced Security Options window.

Question 19: How can I speed up changes by User Class?

Answer 19: When you change the security settings by User Class, you are not required to select a company. The changes that you made for the User Class are automatically applied to all the companies of all the users who are assigned to that Class. The performance can be improved while you make the changes by clicking to clear the **Display class changes on affected users** check box in the Advanced Security Options window. If you do this, you will not see the changes that you made for the Classes as you make them. However, the changes will still be applied if you click **OK** or **Apply**. The time to apply the changes will still be the same. However, the changes are not applied to the users while you make the changes to the Class.

Question 20: How can I use Advanced Security to quickly give access to customizations?

Answer 20: To use Advanced Security to quickly give access to customizations, follow these steps:

1. In the **Advanced Security Options** dialog box, click **All alternate windows and reports** and **All modified windows and reports** in the **Grant Security** section.
2. In the **Default Resource View** box, click **By Alternate, Custom and Modified**.
3. Remove access to the resources that are shown in the view, and then grant access back. Removing access and then granting access back grants access to the customizations where they exist.

> [!NOTE]
> You must look for situations where more than one alternate window or report exists. In these situations, you may want to manually select a resource to use.

Question 21: What does it mean when the **No Dictionary** option is selected for a window or for a report?

Answer 21: The **No Dictionary** option indicates that one of the following conditions is true:

- The security record is pointing to a dictionary that is not currently loaded on the computer.
- A modified version of a window or of a report does not exist on the computer.

Question 22: Can I hide menu items to which a user does not have access?

Answer 22: In Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0, users do not see menu items to which they do not have access.

> [!NOTE]
> Make sure that security is active for all companies within Microsoft Great Plains and Microsoft Dynamics GP. To verify this, click **Tools**, point to **Setup**, point to **Company**, and then click **Company**. Make sure that the **Security** option is selected.

Question 23: Why do I lose access to my customizations when I click **Revert**?  

Answer 23: The **Revert** option is designed to restore the security to the state in which it was when a user was first created. The **Revert** option grants access to the unmodified version for all resources except for advanced lookups. Advanced lookups are automatically selected from the Smartlist dictionary. In other words, access to alternate or modified versions of forms and reports is removed, and access to the original is granted back.

Question 24: What does the **Revert Security First** option do?

Answer 24: The Copy, Rollup, and Rolldown features of Advanced Security include the **Revert security first** option. If this option is selected, the target entity is granted access to the unmodified version for all resources before the copying occurs. When the copy process starts, only non-default security is copied. A resource that has non-default security is granted access unless you specifically deny access. If you grant access to the original resource, no record is stored in the table for that resource. Therefore, if **Revert security first** is selected, the target entity grants access back to all resources, and then the denied security and alternate or modified security are applied. This process duplicates the source security.

If **Revert Security first** is not selected, all the security for the target entity is maintained, and all the denied security and alternate or modified security from the source entity is overwritten. This process actually combines the security records for the target with the records for the source. Remember that the process combines only the non-default security. Therefore, if access is granted to one entity but is denied to another, the result is denied. For more information, see question 24.

> [!NOTE]
> Default security is used to grant access to the original resource. Non-default security is used when access has been denied or access has been granted to a modified, alternate, or modified alternate version of a resource.

Question 25: When I use Import/Export, what does the **Only import non-default security** option do?

Answer 25: When the **Only import non-default security** option is not selected, Advanced Security imports all the settings from the .xml file. In this situation, an identical copy of the security in the .xml file is made. When the **Only import non-default security** option is selected, Advanced Security imports only the non-default security from the .xml file. You can leave the **Revert security first** option selected to make sure that an identical copy is imported. Or, you can clear the selection to combine or merge the security settings as described in the answer to question 23. When you have both the **Only import non-default security** and **Revert security first** options selected, Advanced Security produces the same result as when neither option is selected. However, you may experience improved performance.

> [!NOTE]
> Default security is used to grant access to the original resource. Non-default security is used when access has been denied or access has been granted to a modified, alternate, or modified alternate version of a resource.

Question 26: Can I use regular security after Advanced Security has been used?

Answer 26: Yes. You can use both regular security and Advanced Security. However, if you make a change to one security window, you must make sure that the other security window is not open.

When you use the old **Class** and **Security** dialog boxes, the accelerator must process every time that you change back to the **Advanced Security** dialog box. When you use the old **Class** and **Security** dialog boxes, sections of the accelerator are dropped. Therefore, these sections of the accelerator will be reread the next time that you use Advanced Security. It is faster to drop sections of the accelerator table and then reread the data when the data is next required than it is to try to keep the accelerator synchronized record by record.

Question 27: What are some tips and tricks for setting up security within Advanced Security?

Answer 27: Following are some tips and tricks for setting up security within Advanced Security:

- To reset security to give a user access to all resources, revert the user. For more information, see the answer to question 17.
- To give access to custom resources, use the **By Alternate, Custom and Modified** view. For more information, see the answer to question 10.
- To remove access to sections of the navigation menus in Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0, use the **By Menu** view.
- To fine-tune access to windows that are not directly on the menus, use the **By Dictionary** view.

    > [!NOTE]
    >
    > - In Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0, users do not see the menu items to which they do not have visual access.
    > - Make sure that security is active for all companies within Microsoft Great Plains and Microsoft Dynamics GP. To verify that this is the case, click **Tools**, point to **Setup**, point to **Company**, and then click **Company**. The **Security** option should be selected.

Question 28: How can I optimize performance for Advanced Security?  

Answer 28: To optimize performance for Advanced Security, follow these steps:

1. Turn the accelerator off.

    > [!NOTE]
    > After you turn the accelerator off, you cannot view or change security settings except at the lowest level of the tree.

2. Optimize the accelerator settings. To do this, use the **Advanced Security Options** dialog box, and follow the following recommendations:
    - Use the external accelerator, and store the tables on a shared folder that is available to all computers. You can use a UNC path.
    - On the computer that hosts the external accelerator, set a local path for the accelerator. This action bypasses the network subsystem for that workstation.
    - Perform the major security maintenance on the computer that hosts the external accelerator.
    - If you have fewer than 300 users, companies, and classes combined, use background processing, and let the processing finish. If you have more than 500 users, companies, and classes combined, turn background processing off, and let the system cache on demand. To set this functionality, click **Options** within Advanced Security, and then either select or click to clear **Run accelerator in background while Advanced Security is open**, depending on the total number of users, companies, and classes in your environment.

        > [!NOTE]
        > You can continue to work with Advanced Security when background processing is continuing.

3. When you make changes, select only one user or one class at a time. If you select multiple users or multiple classes at the same time, or if you select both a user and a class at the same time, it takes longer to process changes.

4. If you use classes, you can choose not to show class changes for users as the changes are made. If you select this option, performance improves, and the changes are still applied to the users when the class changes are applied. To choose not to show class changes for users as the changes are made, click **Options** within Advanced Security, and then click **Display class changes on affected users**.

Question 29: What does the Checklinks feature in Advanced Security do?

Answer 29: You can use the Checklinks feature in Advanced Security to remove data for orphaned records, such as missing companies or missing users. The Checklinks feature also prompts you to use the Verify feature when dictionary-related errors might be present.

Question 30: What does the yellow question mark mean in Advanced Security?

Answer 30: A yellow question mark is displayed when Advanced Security cannot control the resources. This condition occurs because of the resource type or because of the current selections. The following are conditions that cause the yellow question mark to be displayed:

1. A yellow question mark is displayed in the **By Menu** view or **By Toolbar** view of the Security tree in the left pane if the menu item that is represented in the view is one of the following:
   - A script that can perform various actions, including opening a form in Microsoft Great Plains 8.0 and in Microsoft Dynamics GP 9.0.
   - A form from a dictionary that is not installed on the current workstation. Advanced Security can only show a resource correctly in the **By Menu** view or in the **By Toolbar** view if the resource refers directly to a form that is available in the dictionaries that are loaded on the current workstation.

2. A yellow question mark is displayed in the Security tree if there are no users or user classes selected in the User list in the lower-right pane.

3. A yellow question mark is displayed in the User list and in the Company list if there is no company selected or if the selected resource in the Security tree is already marked with a yellow question mark.

Question 31: What does the graphic that shows a red circle that has a line through it mean in Advanced Security?

Answer 31: Advanced Security displays this graphic in the **By Menu** view or in the **By Dictionary** view in the **Security** console tree. Advanced Security displays this graphic when you try to view a form if the following conditions are true:

- The form belongs to a module that is not registered.
- Control of the unregistered module is not enabled.

In Advanced Security, you can use one of the following methods to handle forms that belong to a module that is not registered:

- In the **Security** console tree, you can configure Advanced Security to exclude forms that belong to a module that is not registered. To use this mode, make sure that the **Do not display unregistered modules** check box is selected in Advanced Security.

- You can configure Advanced Security as follows:
  - In the **Security** console tree, Advanced Security displays forms from modules that are not registered.
  - Advanced Security prevents users from changing settings. To use this mode, make sure that the **Do not display unregistered modules** and **Enable control of unregistered modules** check boxes in Advanced Security are not selected. In this mode, Advanced Security displays the graphic.

- Advanced Security can display forms from unregistered modules in the console tree and let users change settings. To select this mode, make sure that the **Do not display unregistered modules** check box is not selected in Advanced Security. Then, make sure that the **Enable control of unregistered modules** check box is selected. In this mode, a form from an unregistered module is not treated differently from any other form.

Question 32: What does the Verify feature in Advanced Security do?

Answer 32: You can use the Verify feature to fix issues in which Advanced Security points to resources that do not exist. For example, you can use this feature when modified reports or custom reports have been deleted, but Advanced Security was not adjusted back to the original report. You can also use the Verify feature when Advanced Security is not adjusted after a product is uninstalled. Before you use the Verify feature, make sure that the workstation has all the dictionaries and all the customizations installed. The dictionaries and the customizations are not installed automatically because you must decide which issues you want to fix, and you must decide how you want to fix those issues.

Question 33: How can I identify a form that is causing a security privileges error?

Answer 33: You may receive one of the following error messages.

- Error message 1

    > You don't have security privileges to open this window. contact your system administrator for assistance.

- Error message 2

    > Not privileged to open this form.

You may not know which form, which report, or which table is causing the problem. You can use the interactive dialogs of Advanced Security to identify the resource that is causing the problem, and to fix the problem at the time that the error occurs. To do this, follow these steps:

1. Click **Tools**, click **Setup**, click **System**, and then click **Advanced Security**.
2. In the Advanced Security window, click **Options**, and then click to select the **Allow security override using the system password** check box.

The next time that the error occurs, Advanced Security identifies the resource and provides options to change the security settings. You can disable the option after the security issue is fixed, or you can leave it active.

> [!NOTE]
> You can change the security settings only if there is a system password, and if the system password is entered correctly.

Question 34: Can I merge security from two users or two classes together?

Answer 34: You can combine security for two users or for two classes. However, the advanced security setup may not behave as expected. When you copy security, roll down security, or roll up security, the status of the **Revert Security first** check box determines whether you make an exact duplicate, or whether you combine the security settings of the source entity with the security settings of the target entity. The source entity and the target entity are either a user, a company, or a class. By default, the **Revert Security first** check box is selected. If the **Revert Security first** check box is selected, a copy of the source entity settings replaces the target entity's settings. This process occurs because the target entity reverts to the default before the settings are copied.

> [!NOTE]
> By default, security is set to access all original forms, except for the Advanced Lookup alternate windows in the Smartlist dictionary. If the **Revert Security first** check box is not selected, you will combine the entities. But you will combine the non-default security with the source entity's settings, and you will overwrite the target entity's settings. The following table provides details.

|Source|Target|Result|
|---|---|---|
|Original|Original|Original|
|Original|Denied|Denied|
|Original|Alternate2|Alternate2|
|Original|Modified2|Modified2|
|Denied|Original|Denied|
|Denied|Denied|Denied|
|Denied|Alternate2|Denied|
|Denied|Modified2|Denied|
|Alternate1|Original|Alternate1|
|Alternate1|Denied|Alternate1|
|Alternate1|Alternate2|Alternate1|
|Alternate1|Modified2|Alternate1|
|Modified1|Original|Modified1|
|Modified1|Denied|Modified1|
|Modified1|Alternate2|Modifed1|
|Modified1|Modified2|Modified1|
  
In summary, the security settings of the source entity are applied, except where it has access granted to the original. In those cases, the security settings are left with the target entity's previous setting.

Question 35: Why are there check boxes on both the left pane and the right pane of Advanced Security?

Answer 35: The check boxes on the resource tree in the left pane let you see and change the security settings for the selected users, companies, and classes. The right pane contains a user list. The check boxes in the user list let you see and change the security settings for the selected node in the resource tree. Because there are two panes, there are two views of the same data. For example, you can view the access for each user. Or you can view who has access to an item.

Question 36: Why does the **By Menu** view not work for some menu items?

Answer 36: Some menu items run scripts that open forms. Because the scripts are not directly linked to the forms, Advanced Security cannot identify the forms. Therefore, Advanced Security cannot control the security. For these forms, use the **By Dictionary** view to change the Security settings.

Question 37: How can I compare two users or two classes?

Answer 37: For a quick visual comparison, you can select both users or both class entities in the details pane. Differences in access appear as shaded check boxes in the navigation pane. Notice that the differences do not appear if both entities have access to different versions of the same window. For an exact list of the differences in security settings, copy the security from one entity to the other entity by using the Duplicate command, the Rollup command, or the Rolldown command. Then, any differences will appear as yellow "pending" dots. A hyperlinked number that represents the pending changes appears at the lower left corner of the window. Click this number to display a list of the differences. If you do not want to complete the copy process, close Advanced Security without applying the pending changes.

Question 38: How can I clear the activity records for Advanced Security?

Answer 38: You may receive an "Another user is using advanced security. Try again later" message when you try to access Advanced Security even if no other users are logged into the system. This occurs because a user did not exit Advanced Security correctly. Therefore, an activity record for that user still exists. To remove the activity record, use one of the following methods:

- Method 1
-
    1. Start Microsoft Dynamics GP.
    2. Log in by using the same user and company information that appears in the activity record.
    3. Click **Tools**, click **Setup**, click **System**, and then click **Advanced Security**.
    4. Close the Advanced Security window.

- Method 2

    1. Start Microsoft SQL Query Analyzer or SQL Server Management Studio.
    2. To delete the Advanced Security activity record from the SY_ResourceActivity (SY00801) table, run the following script:

    ```sql
    delete from DYNAMICS..SY00801 where RSRCID = 'WDC_ADVSEC_SECURITY'
    ```

## Field Level Security

Question 1: Why am I denied access to the Customization Status window?

Answer 1: In Microsoft Great Plains, the Customization Status window shows the dictionaries that are installed. You can use this window to temporarily disable the Dexterity triggers that are used by each dictionary. You can also use this window to print a report of all the triggers that are registered in the system.

Sometimes you may be denied access to the Customization Status window even if the system administrator previously verified that the security was available for you. This situation occurs when Field Level Security is registered and at least one Field Level Security ID is enabled for the current user or for the current company.

In this situation, all access to the Customization Status window is denied. This safeguard prevents anyone from using the window to disable the triggers for Field Level Security in order to bypass the security level that has been applied.

> [!NOTE]
> To open the Customization Status window, click **Customize** on the **Tools** menu, and then click **Customization Status**.

Question 2: What is Field Level Security?

Answer 2: Field Level Security increases the options for security on forms. Field Level Security also provides options for security on windows and on fields. You can use Field Level Security to apply passwords to forms and to windows. Or, you can block access to forms and to windows so that anyone who tries to access them receives a warning message instead. You can also apply passwords to fields. Or, you can hide, lock, or disable fields.

Question 3: What happened to Field Level Security Scripting?

Answer 3: Field Level Security Scripting is no longer in distribution and can no longer be registered. The scripting functionality was perceived as a security risk that could be used by malicious users to bypass the application security. Malicious users could use the scripting functionality to damage data or to retrieve data inappropriately. In compliance with the "Trustworthy Computing" program, the scripting functionality was removed in order to avoid the potential security risk.

Question 4: Can I create functionality for row level security with Field Level Security?

Answer 4: Before the scripting functionality was removed, you could create functionality for row level security with Field Level Security. To create functionality for row level security now, you have to customize Microsoft Great Plains by using Microsoft Visual Basic for Applications (VBA) or Dexterity.

Question 5: Why does Field Level Security sometimes not work?

Answer 5: Field Level Security works by registering triggers against specific events and then by executing code to change the user interface. There are situations in which existing code in the window is run after Field Level Security runs. The existing code overrides the changes that Field Level Security applied. Therefore, Field Level Security appears not to have worked.

The Security modes, the Hide field, the Disable field, and the Lock field are run when the window is opened. If code in the window shows, enables, or unlocks a field, the code overrides the changes that Field Level Security applied. This problem typically affects multicurrency fields because the multicurrency functionality is frequently implemented so that the following fields overlap:

- Originating
- Functional

Depending on the view, only one of these fields is displayed. When only one field is displayed, you can configure Field Level Security by using the Hide field or by using the Disable field. If you want to prevent a user from changing a field, you can use the Password Before mode or the Warning Before mode. These modes are run whenever the field becomes active. These modes work when the Hide field, the Disable field, and the Lock field do not. When multicurrency fields are used, you might have to apply a Field Security ID to each multicurrency field. Sometimes, it is better to use Modifier to move a field outside the visible area of a window than it is to use Field Level Security.

Question 6: How can I use Field Level Security to prevent saving a record in a maintenance window?

Answer 6: There are seven events that can lead to saving a record in a maintenance window. These events are as follows:

- You use the **Save** button.
- You use the lookup button to change a record.
- You use one of the four browse buttons to change a record and then you close the window.

If you hide the **Save** button, only one of these events is used. Therefore, the remaining six events still work. These six events would typically run the Handle Changes script. This script prompts you with a message that resembles the following:

> "Do you want to Save, Discard or Cancel?"

This prompt is a system dialog and is not a Dexterity form. Even though the dialog box can be created from Dexterity, you cannot address, trigger, or control this kind of dialog from Dexterity. Therefore, Dexterity and Field Level Security cannot control system dialogs. (Field Level Security is written in Dexterity.)

Most of the windows in Microsoft Dynamics GP call either a Save_Record form level procedure or a Save Record field script to perform the actual saving of the data. All the previously mentioned events call the Save Record field script.

For the windows that use the Save Record field script, you can use Field Level Security to request a password before the data is saved. You must set the Security Mode to the Password After option and then create or select a password ID.

For windows that use a Save_Record form level procedure, Field Level Security cannot prevent the record from being saved. The other alternatives to prevent the record from being saved are as follows:

- You can either use a Dexterity Trigger on the Save_Record form level procedure or use the Save Record field script to stop the save.
- You can use the Window_BeforeModalDialog() event in Microsoft Visual Basic for Applications (VBA) to always answer Cancel when you are prompted with the system dialog and to then disable the **Save** button.

## References

For more information, see the AdvancedSecurity.pdf document.

This document is located on CD 1 of the Microsoft Great Plains or Microsoft Dynamics GP installation CD set. Documentation may also be located in the installation folder on each workstation. By default, the installation folder is the following folder:

- Microsoft Dynamics GP 9.0:

    C:\\Program Files\\Microsoft Dynamics\\GP

- Microsoft Great Plains 8.0 or Microsoft Great Plains 7.5:

    C:\\Program Files\\Microsoft Business Solutions\\Great Plains
