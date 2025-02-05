---
title: FAQs about Advanced Security and Field Level Security
description: Discusses frequently asked questions about how to set up and use Advanced Security and Field Level Security.
ms.reviewer: theley, kyouells
ms.date: 02/05/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Frequently asked questions about Advanced Security and about Field Level Security in Microsoft Dynamics GP

This document discusses frequently asked questions about how to set up and use Advanced Security and Field Level Security in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894705

## Advanced Security

**Question 1: Where is the Advanced Security module located in Microsoft Dynamics GP?**

Answer 1: To access the Advanced Security module in Microsoft Dynamics GP 9.0 or an earlier version, select **Tools** > **Setup** > **System** > **Advanced Security**.

> [!NOTE]
> Advanced Security was phased out with Dynamics GP 10's role-based security and isn't available in versions higher than Dynamics GP 10.0.

**Question 2: What are the differences between Advanced Security and Standard Security?**

Answer 2: Standard Security uses separate dialog boxes that let you control security for a single user or for a user class. Standard Security uses a third dialog box to set access to SmartList favorites. To change security for a dialog box, you must know the exact name of the dialog box and the exact name of the series to which the dialog box belongs. To set security for modified, alternate, or modified alternate windows, you must change views.

Advanced Security provides an explorer-style interface that lets you control different types of security at the same time in the same dialog box. These types of security include the following:

- Security for multiple users, companies, and classes
- SmartList security

Advanced Security provides multiple views that include the **By Menu** view. The **By Menu** view lets you set security by using the navigation model. Additionally, changes at upper levels of the tree are automatically rolled down to child resources. You can access modified, alternate, or alternate modified resources by selecting the dictionary that you want to use. And you can do this without changing views.

**Question 3: What are some of the benefits of using Advanced Security?**

Answer 3: Among the benefits of using Advanced Security are the following:

- Advanced Security enables security to be set up for multiple users, companies, and classes at the same time. When class changes are made, Advanced Security doesn't overwrite user-level changes.
- Advanced Security lets you set security based on the navigation model.
- Advanced Security has a **By Alternate, Modified, and Custom** view that displays security only for customized resources to make it easier to control access to customizations. When security is granted back to resources, Advanced Security gives you the option to automatically select alternate and modified resources if they exist.
- Advanced Security lets you quickly show the resources to which the selected user and company have access. At the same time, Advanced Security lets you show which other users in the company have access to the selected resource.
- Advanced Security lets you copy security settings to other companies or users.
- Advanced Security lets you roll down class security settings to selected users of a class by using the option to overwrite user-level changes. You can do this by selecting the **Revert First** option.
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

**Question 4: Where do I find my alternate and modified windows and reports?**

Answer 4: Alternate and modified windows are displayed under the original window in the tree structure. To find them, find the original window in the **By Menu** or **By Dictionary** view, and then expand the window to display the dictionaries in which the window exists. You can then select which version you want to use. Another way to view alternate and modified windows and reports is to change the view by selecting the down arrow and then selecting **By Alternate, Modified and Custom**.

> [!NOTE]
> If a product has no windows of its own and it only has alternate windows or reports, the product won't be displayed in the **By Dictionary** view.

**Question 5: How do the "Grant Security: All Alternate windows and reports" and "Grant Security: All Modified windows and reports" options work?**

Answer 5: These options are enabled when access is being granted back to a resource after the access was denied. If there is a single alternate window or report, it will be chosen instead of the original dictionary if the **Alternate** option is chosen. If there is more than one alternate window or report, Advanced Security keeps to the original version. After Advanced Security chooses a dictionary, a modified version of the window or report is chosen if there is a modified version of the window or report and if the **Modified** option is chosen.

**Question 6: How can I speed up changes by User Class?**

Answer 6: When you change the security settings by User Class, you aren't required to select a company. The changes that you made for the User Class are automatically applied to all the companies of all the users who are assigned to that Class. The performance can be improved while you make the changes by clearing the **Display class changes on affected users** checkbox in the **Advanced Security Options** window. If you do this, you won't see the changes that you made for the Classes as you make them. However, the changes will still be applied if you select **OK** or **Apply**. The time to apply the changes will still be the same. However, the changes aren't applied to the users while you make the changes to the Class.

**Question 7: What does it mean when the **No Dictionary** option is selected for a window or for a report?**

Answer 7: The **No Dictionary** option indicates that one of the following conditions is true:

- The security record is pointing to a dictionary that isn't currently loaded on the computer.
- A modified version of a window or of a report doesn't exist on the computer.

**Question 8: Can I use regular security after Advanced Security has been used?**

Answer 8: Yes. You can use both regular security and Advanced Security. However, if you make a change to one security window, you must make sure that the other security window isn't open.

**Question 9: How can I clear the activity records for Advanced Security?**

Answer 9: You might receive an "Another user is using advanced security. Try again later" message when you try to access Advanced Security even if no other users are signed in to the system. This occurs because a user doesn't exit Advanced Security correctly. Therefore, an activity record for that user still exists. To remove the activity record, use one of the following methods:

- Method 1

    1. Start Microsoft Dynamics GP.
    2. Sign in by using the same user and company information that appears in the activity record.
    3. Select **Tools** > **Setup** > **System** > **Advanced Security**.
    4. Close the **Advanced Security** window.

- Method 2

    1. Start Microsoft SQL Query Analyzer or SQL Server Management Studio.
    2. To delete the Advanced Security activity record from the `SY_ResourceActivity (SY00801)` table, run the following script:

        ```sql
        delete from DYNAMICS..SY00801 where RSRCID = 'WDC_ADVSEC_SECURITY'
        ```

## Field Level Security

**Question 1: Why am I denied access to the Customization Status window?**

Answer 1: In Microsoft Great Plains, the Customization Status window shows the dictionaries that are installed. You can use this window to temporarily disable the Dexterity triggers that are used by each dictionary. You can also use this window to print a report of all the triggers that are registered in the system.

Sometimes you may be denied access to the Customization Status window even if the system administrator previously verified that the security was available for you. This situation occurs when Field Level Security is registered and at least one Field Level Security ID is enabled for the current user or for the current company.

In this situation, all access to the Customization Status window is denied. This safeguard prevents anyone from using the window to disable the triggers for Field Level Security in order to bypass the security level that has been applied.

> [!NOTE]
> To open the Customization Status window, select **Customize** on the **Tools** menu, and then select **Customization Status**.

**Question 2: What is Field Level Security?**

Answer 2: Field Level Security increases the options for security on forms. Field Level Security also provides options for security on windows and on fields. You can use Field Level Security to apply passwords to forms and to windows. Or, you can block access to forms and to windows so that anyone who tries to access them receives a warning message instead. You can also apply passwords to fields. Or, you can hide, lock, or disable fields.

**Question 3: What happened to Field Level Security Scripting?**

Answer 3: Field Level Security Scripting is no longer in distribution and can no longer be registered. The scripting functionality was perceived as a security risk that could be used by malicious users to bypass the application security. Malicious users could use the scripting functionality to damage data or to retrieve data inappropriately. In compliance with the "Trustworthy Computing" program, the scripting functionality was removed in order to avoid the potential security risk.

**Question 4: Can I create functionality for row level security with Field Level Security?**

Answer 4: Before the scripting functionality was removed, you could create functionality for row level security with Field Level Security. To create functionality for row level security now, you have to customize Microsoft Great Plains by using Microsoft Visual Basic for Applications (VBA) or Dexterity.

**Question 5: Why does Field Level Security sometimes not work?**

Answer 5: Field Level Security works by registering triggers against specific events and then by executing code to change the user interface. There are situations in which existing code in the window is run after Field Level Security runs. The existing code overrides the changes that Field Level Security applied. Therefore, Field Level Security appears not to have worked.

The Security modes, the Hide field, the Disable field, and the Lock field are run when the window is opened. If code in the window shows, enables, or unlocks a field, the code overrides the changes that Field Level Security applied. This problem typically affects multicurrency fields because the multicurrency functionality is frequently implemented so that the following fields overlap:

- Originating
- Functional

Depending on the view, only one of these fields is displayed. When only one field is displayed, you can configure Field Level Security by using the Hide field or by using the Disable field. If you want to prevent a user from changing a field, you can use the Password Before mode or the Warning Before mode. These modes are run whenever the field becomes active. These modes work when the Hide field, the Disable field, and the Lock field do not. When multicurrency fields are used, you might have to apply a Field Security ID to each multicurrency field. Sometimes, it is better to use Modifier to move a field outside the visible area of a window than it is to use Field Level Security.

**Question 6: How can I use Field Level Security to prevent saving a record in a maintenance window?**

Answer 6: There are seven events that can lead to saving a record in a maintenance window. These events are as follows:

- You use the **Save** button.
- You use the lookup button to change a record.
- You use one of the four browse buttons to change a record and then you close the window.

If you hide the **Save** button, only one of these events is used. Therefore, the remaining six events still work. These six events would typically run the Handle Changes script. This script prompts you with a message that resembles the following:

> Do you want to Save, Discard or Cancel?

This prompt is a system dialog and isn't a Dexterity form. Even though the dialog box can be created from Dexterity, you cannot address, trigger, or control this kind of dialog from Dexterity. Therefore, Dexterity and Field Level Security cannot control system dialogs. (Field Level Security is written in Dexterity.)

Most of the windows in Microsoft Dynamics GP call either a Save_Record form level procedure or a Save Record field script to perform the actual saving of the data. All the previously mentioned events call the Save Record field script.

For the windows that use the Save Record field script, you can use Field Level Security to request a password before the data is saved. You must set the Security Mode to the Password After option and then create or select a password ID.

For windows that use a Save_Record form level procedure, Field Level Security cannot prevent the record from being saved. The other alternatives to prevent the record from being saved are as follows:

- You can either use a Dexterity Trigger on the Save_Record form level procedure or use the Save Record field script to stop the save.
- You can use the `Window_BeforeModalDialog()` event in Microsoft Visual Basic for Applications (VBA) to always answer Cancel when you are prompted with the system dialog and to then disable the **Save** button.
