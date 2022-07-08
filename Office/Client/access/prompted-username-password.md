---
title: You're prompted for a username and password
description: Describes a problem where you're prompted for a username and a password without setting up security in Access. Also describes how to reset the workgroup information.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: ritan
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# You're prompted for username and password though you don't set up security in Access

_Original KB number:_ &nbsp; 888734

## Symptoms

When you run Microsoft Access 2000 or a later version, you are prompted for a username and for a password. This behavior occurs even though you do not turn on security or set up security. You are prompted for a username and for a password for every database. This includes even a brand new database.

## Cause

This behavior occurs if you install "Typing Tutor Deluxe" by Global Software Publishing.

## Resolution

To resolve this behavior, use the Workgroup Administrator tool to rejoin the original default workgroup information file. To do this, you can use one of the following methods. The method that you use depends on your version of Access.

### Office Access 2007

To use the Workgroup Administrator tool in Microsoft Office Access 2007, use Microsoft Visual Basic code. To do this, use one of the following methods.

#### Method 1: Run the Visual Basic code in the Immediate window

1. In Access 2007, open a trusted database, or enable macros in the existing database.
2. Press CTRL+G to open the Immediate window.
3. Type the following line of code, and then press ENTER.

   ```vb
   DoCmd.RunCommand acCmdWorkgroupAdministrator
   ```
   
4. In the **Workgroup Administrator** dialog box, click **Join**, and then click **Browse**.
5. Locate and then click the following file, and then click **Open**:

   `C:\Program Files\Common Files\system\System.mdw`

6. In the **Workgroup Administrator** dialog box, click **OK**, and then click **Exit**.

#### Method 2: Create a module that contains the Visual Basic code

1. In Access 2007, open a trusted database, or enable macros in the existing database.
2. On the **Create** tab, click **Macro** in the **Other** group, and then click **Module**.
3. Create a subroutine, and then paste the following Visual Basic code in the subroutine.

   ```vb
   DoCmd.RunCommand acCmdWorkgroupAdministrator
   ```

4. Press F5 to run the code.
5. In the **Workgroup Administrator** dialog box, click **Join**, and then click **Browse**.
6. Locate and then click the following file, and then click **Open**:

   `C:\Program Files\Common Files\system\System.mdw`

7. In the **Workgroup Administrator** dialog box, click **OK**, and then click **Exit**.

### Office Access 2003

1. Start Office Access 2003.
2. Click **Tools**, point to **Security**, and then click **Workgroup Administrator**.
3. Click **Join**, click **Browse**, browse to `C:\Documents and Settings\<your user name>\Application Data\Microsoft\Access\System.mdw`, and then click **OK**.
4. In the **Workgroup Administrator** dialog box, click **OK**.
5. In the **Workgroup Administrator** dialog box, click **OK**.

   > [!NOTE]
   > The **Workgroup Administrator** dialog box in step 5 is a different dialog box than the dialog box in step 4. Both dialog boxes have the same name.

### Access 2002

1. Start Access.
2. Click **Tools**, point to **Security**, and then click **Workgroup Administrator**.
3. In the **Workgroup Administrator** dialog box, click **Join**, click **Browse**, browse to `C:\Documents and Settings\<your user name>\Application Data\Microsoft\Access\System.mdw`, and then click **OK**.
4. In the **Workgroup Administrator** dialog box, click **OK**, and then click **Exit**.

### Access 2000

1. Click **Start**, and then click **Search**.
2. In the **Search Results** dialog box, click **All files and folders** under **What do you want to search for**.
3. Type Wrkgadm.exe under **All or part of the file name**, and then click **Search**.
4. In the **Search Results** dialog box, double-click **WRKGADM**.
5. In the **Workgroup Administrator** dialog box, click **Join**, click **Browse**, browse to `C:\Program Files\Common Files\system\System.mdw`, and then click **OK**.
6. In the **Workgroup Administrator** dialog box, click **OK**, and then click **Exit**.

## More Information

When you install "Typing Tutor Deluxe," your workgroup security for Access is reset to point to a workgroup information file that is created for "Typing Tutor Deluxe."
