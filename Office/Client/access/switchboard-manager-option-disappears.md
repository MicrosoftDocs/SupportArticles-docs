---
title: Switchboard Manager option doesn't appear
description: Fixes an issue in which you can't locate the Switchboard Manager option in the ribbon when you create a new switchboard form in an .accdb client database in Access.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 106913
  - CSSTroubleshoot
ms.reviewer: denniwil
appliesto: 
  - Access 2010
  - Access 2013
  - Access 2016
  - Access 2019
  - Access for Microsoft 365
search.appverid: MET150
ms.date: 05/26/2025
---
# Switchboard Manager does not appear in the ribbon

## Symptoms

When trying to create a new switchboard form in an *.accdb* client database in recent versions of Microsoft Access, you are unable to locate the **Switchboard Manager** option in the ribbon. In a *.mdb* database, the **Switchboard Manager** option appears in the **Administer** group on the **Database Tools** tab; however, the **Administer** group does not appear on the ribbon in an *.accdb* file.

## Cause

The Switchboard Manager option is deprecated from the Database Tools tab for *.accdb* databases starting in Access 2010.

## Resolution

You can launch the Switchboard Manager in an *.accdb* file in Access 2010 or later by using one of the following methods:

### Method 1: Run the Switchboard Manager by using VBA Code

1. Open the Visual Basic Editor by pressing Ctrl+G.
2. In the Immediate Window, type the following command:

   ```vb
   DoCmd.RunCommand acCmdSwitchboardManager
   ```

3. In the Microsoft Access window, you will see the message "The Switchboard Manager was unable to find a valid switchboard in this database. Would you like to create one?" Click **Yes**.

### Method 2: Run the Switchboard Manager by creating a macro

1. On Microsoft Access ribbon, select the **Create** tab. In the **Macros & Code** group, click **Macro**.
2. Select the action `RunMenuCommand`.
3. Select the command `SwitchboardManager`.
4. Save the macro and run it.
5. You will see the message "The Switchboard Manager was unable to find a valid switchboard in this database. Would you like to create one?" Click **Yes**.

### Method 3: Customize the ribbon by creating a custom group and adding the "Switchboard Manager" command

1. Open your *.accdb* client database in Microsoft Access.
2. Select the **File** tab > **Options** > **Customize Ribbon**.
3. In the right column, highlight **Database Tools**.
4. Click **New Group**. Click **Rename** to name the group "Administer."
5. In the **Choose commands from** combo box at the top of the window, select **All Commands**
6. Scroll down and highlight **Switchboard Manager**.
7. Click **Add** to add the **Switchboard Manager** to the new group you created under the **Database Tools** tab.
8. Click **Ok** to close the **Access** Options
9. You should now see the **Switchboard Manager** under the **Database Tools** tab.

> [!NOTE]
> If you use Method 3, you will see both the **Switchboard** group and the **Administer** group on the **Database Tools** tab in a *.mdb* file in Microsoft Access.
