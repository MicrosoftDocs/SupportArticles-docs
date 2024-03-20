---
title: A user who is not an administrator experiences VBA permission problems in Dynamics GP
description: Describes a problem that occurs when Microsoft Dynamics GP does not link to VBA Editor, does not copy windows or fields, or does not run existing VBA code. Provides a resolution.
ms.topic: troubleshooting
ms.reviewer: theley, dclauson
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# A user who is not an administrator experiences VBA permission problems in Microsoft Dynamics GP

This article provides help to solve Microsoft Visual Basic for Applications (VBA) permission problems that a user who is not an administrator experiences.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929612

## Symptoms

In Microsoft Dynamics GP, a user experiences one or more of the following problems:

- Microsoft Dynamics GP does not link to Microsoft Visual Basic for Applications (VBA) Editor.
- Microsoft Dynamics GP does not copy windows or fields from Microsoft Dynamics GP to the Microsoft Dynamics GP project in VBA.
- Microsoft Dynamics GP does not run existing VBA code. In addition, Microsoft Dynamics GP does not run the code in Terminal Server or in Citrix.

Additionally, there are no error messages during the Microsoft Dynamics GP installation.

> [!NOTE]
> VBA is installed during the Microsoft Dynamics GP installation.

## Cause

This problem occurs because the user does not have administrative credentials to the computer or to the domain.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this problem, use one of the following methods.

### Method 1

For the computer on which you are trying to use VBA, you should be logged on as a user who is a member of the Administrators local group or of the Power Users local group. You may be able to edit the registry on the computer to enable VBA access to other users. However, the recommended solution is to include the users in at least one of the two local groups. The suggested modifications to enable VBA access to other users are as follows.

> [!NOTE]
> In this procedure, you will modify the following registry keys:
>
> - `HKEY_CLASSES_ROOT\Clsid`
> - `HKEY_CLASSES_ROOT\Typelib`
> - `HKEY_CLASSES_ROOT\Interface`
> - `HKEY_LOCAL_MACHINE\Software\Classes\CLSID`

To grant permissions to the registry keys, follow these steps:

1. Log on as an administrator.
2. Start Registry Editor. To do this, click **Start**, click **Run**, type regedt32.exe, and then click **OK**.
3. Locate the following registry key: `HKEY_CLASSES_ROOT\Clsid`
4. On the **Security** menu, click **Permissions**.

    > [!NOTE]
    > The Registry Key Permissions window appears.
5. Click **Add**, add the users or the groups, and then click to select the **Full Control** check box to specify the type of access.
6. Click **OK** to close the Registry Key Permissions window.
7. Repeat steps 3 through 6 for the remaining registry keys.
8. Exit Registry Editor.

> [!NOTE]
> When you exit Registry Editor, the other users for whom you changed permissions can register type libraries, Component Object Model (COM) objects, and other objects.

### Method 2

> [!NOTE]
> The following steps have not been extensively tested. We were able to successfully run Microsoft Dynamics GP with VBA as a non-administrative user. As of Microsoft Dynamics GP 9.0 Service Pack 1 (SP1), you can have VBA function for all users without exposing any registry keys.

To have VBA function for all users without exposing any registry keys, follow these steps:

1. Log on as an administrator.
2. Start Microsoft Dynamics GP, start VBA Editor, and then exit Microsoft Dynamics GP.
3. Search for the Controls.exd file that is located in the following location:

    \\Documents and Settings\\**username**\\Local Settings\\Temp\\Dynamics9.0

    Copy this file to a location that all users can access. For example, copy the file to the following location:

    \\Documents and Settings\\All Users\\DynamicsVBA  

4. Click **Start**, click **Run**, type the following, and then click **OK**:

    ```console
    regtlib.exe "C:\Documents and Settings\All Users\DynamicsVBA\Controls.exd
    ```

5. Repeat steps 3 and 4 by using the RptControls.exd file.

    > [!NOTE]
    > This file will only exist if the VBA file contains report modifications.
6. Search for the MSForms.exd file in the following location:

    \\Documents and Settings\\**username**\\Local Settings\\Temp\\VBE

    If this file exists, repeat step 4 by using the RptControls.exd file.

    > [!NOTE]
    > This file will only exist if the VBA file contains a user form.

At this point, non-administrative users should be able to run the VBA code without granting access to any registry keys. However, you may first have to delete the Controls.exd file, the RptControls.exd file, and the MSForms.exd file.

> [!NOTE]
> These steps must be repeated every time that the VBA project is changed whether it is by using VBA Editor, by using an imported package file, or by putting a different VBA file into the code folder.
