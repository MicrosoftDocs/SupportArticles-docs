---
title: Tips for upgrading Dexterity-based app
description: Provides tips to help you upgrade an existing Great Plains Dexterity-based project to Great Plains 8.0 Dexterity.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Tips and references for upgrading your Great Plains Dexterity-based application to Great Plains 8.0 Dexterity

This article contains tips and references for upgrading your Great Plains Dexterity-based application to Great Plains 8.0 Dexterity.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894701

## Introduction

When you upgrade your Microsoft Business Solutions-Great Plains Dexterity-based application to version 8.0, there are several issues to consider beyond the standard upgrade process.

## More information

- Great Plains 8.0 navigation changes include the removal of the Palettes navigation window and the removal of the fixed toolbar. These items have been replaced with menus, commands, lists, and toolbars that you can customize.
- In prior versions, system series windows were hidden from the navigation model. The system series windows could not be added by the user to the Shortcuts toolbar or to the Palettes navigation window. In Great Plains 8.0, you can control whether a form can be added to the Shortcuts toolbar by adding the SHORTCUT constant as a form-level constant.
- The AutoComplete feature is a new feature in Great Plains 8.0 Dexterity. To use the AutoComplete feature, you must set the field property of the AutoComplete feature to true. This property can be set for all string key fields that have lookup buttons.
- Great Plains 8.0 Dexterity supports Microsoft Windows XP themes, and it rounds the corners of buttons. If your lookup window uses buttons in columns, you have to draw two-dimensional boxes around the buttons. You also have to change the Appearance property of the buttons to **3D Highlight**. You may want to reduce the size of the buttons by one pixel in each direction so that the buttons fit perfectly in the boxes that you draw around them.

    > [!NOTE]
    > Press CTRL + UP ARROW to increase the pixel size. Press CTRL + DOWN ARROW to decrease the pixel size.
- The value of the **SOP Type** field in the tables no longer has a direct relationship to the **SOP Type** list in the windows. The value doesn't have a direct relationship because of the addition of the Fulfillment Orders document type when you're registered for Advanced Distribution.
- Great Plains 8.0 examines the Microsoft SQL Server permissions of a user to decide whether the user can do certain actions in the database such as creating tables or adding users. You can use two new Great Plains 8.0 Dexterity functions to verify that a user has the rights to do an action.

    The following example is the syUserIsDBO function.

    ```sql
    syUserIsDBO()
    function returns boolean O_fIsUserDBO;
    in'User ID'I_sUserID;
    instringI_sDatabase;
    ```

    The following example is the syUserInRole function.

    ```sql
    syUserInRole()
    function returns boolean O_fUserInRole;
    in'User ID'I_sUserID;
    instringI_sRole;
    optional in 'Intercompany ID'I_sDatabase;
    ```

    In each function, the values for the *I_sRole* parameter can be any one of the following constants. You can use the following constants for fixed server roles:

  - ROLE_SYSADMIN
  - ROLE_SECURITYADMIN
  - ROLE_DBCREATOR

    You can use the following constants for fixed database roles:

  - ROLE_DBOWNER
  - ROLE_DBACCESSADMIN
  - ROLE_DBSECURITYADMIN
  - ROLE_DBBACKUPOPERATOR

    The value for the *I_sDatabase* parameter can be any one of the following situations:

  - The company ID of the company master table for company databases
  - The company ID of global variables for the current company database
  - The name of the SQL Server system database

## References

For more information, see the following sections of the Great Plains *Integration guide*. The *Integration guide* is installed with Great Plains 8.0 Dexterity.

- For more information about the navigation changes in Great Plains 8.0, see Part 5,"Navigation" and Part 6, "Lists." Also, see the sample Develop.cnk file that is installed with Dexterity for a demonstration of the requirements.
- For more information about how to add shortcuts by using form-level constants, see Chapter 24, "Shortcuts."
- For more information about the AutoComplete feature, see Chapter 20, "Data entry conventions."
- For more information about lookup buttons, see Chapter 16, "Lookups."
