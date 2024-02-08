---
title: Use Group Policy to remotely install software
description: Describes how to use Group Policy to remotely install software.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:deploying-software-through-group-policy, csstroubleshoot
ms.subservice: group-policy
---
# Use Group Policy to remotely install software

This article describes how to use Group Policy to automatically distribute programs to client computers or users.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816102

## Summary

You can use Group Policy to distribute computer programs by using the following methods:

- Assigning software

    You can assign a program distribution to users or computers. If you assign the program to a user, it's installed when the user logs on to the computer. When the user first runs the program, the installation is completed. If you assign the program to a computer, it's installed when the computer starts, and it's available to all users who log on to the computer. When a user first runs the program, the installation is completed.

- Publishing software

    You can publish a program distribution to users. When the user logs on to the computer, the published program is displayed in the **Add or Remove Programs** dialog box, and it can be installed from there.

> [!NOTE]
> Windows Server 2003 Group Policy automated-program installation requires client computers that are running Microsoft Windows 2000 or a later version.

## Create a distribution point

To publish or assign a computer program, create a distribution point on the publishing server by following these steps:

1. Log on to the server as an administrator.
2. Create a shared network folder where you'll put the Windows Installer package (.msi file) that you want to distribute.
3. Set permissions on the share to allow access to the distribution package.
4. Copy or install the package to the distribution point. For example, to distribute a .msi file, run the administrative installation (`setup.exe /a`) to copy the files to the distribution point.

## Create a Group Policy Object

To create a Group Policy Object (GPO) to use to distribute the software package, follow these steps:

1. Start the Active Directory Users and Computers snap-in by clicking **Start**, pointing to **Administrative Tools**, and then clicking **Active Directory Users and Computers**.
2. In the console tree, right-click your domain, and then click **Properties**.
3. Click the **Group Policy** tab, and then click **New**.
4. Type a name for this new policy, and then press Enter.
5. Click **Properties**, and then click the **Security** tab.
6. Clear the **Apply Group Policy**  check box for the security groups that you don't want this policy to apply to.
7. Select the **Apply Group Policy** check box for the groups that you want this policy to apply to.
8. When you're finished, click **OK**.

## Assign a package

To assign a program to computers that are running Windows Server 2003, Windows 2000, or Windows XP Professional, or to users who are logging on to one of these workstations, follow these steps:

1. Start the Active Directory Users and Computers snap-in by clicking **Start**, pointing to **Administrative Tools**, and then clicking **Active Directory Users and Computers**.
2. In the console tree, right-click your domain, and then click **Properties**.
3. Click the **Group Policy** tab, select the policy that you want, and then click **Edit**.
4. Under **Computer Configuration**, expand **Software Settings**.
5. Right-click **Software installation**, point to **New**, and then click **Package**.
6. In the **Open** dialog box, type the full Universal Naming Convention (UNC) path of the shared installer package that you want. For example, `\\<file server>\<share>\<file name>.msi`.

    > [!IMPORTANT]
    > Don't use the **Browse** button to access the location. Make sure that you use the UNC path of the shared installer package.

7. Click **Open**.
8. Click **Assigned**, and then click **OK**. The package is listed in the right-pane of the **Group Policy** window.
9. Close the **Group Policy** snap-in, click **OK**, and then close the Active Directory Users and Computers snap-in.
10. When the client computer starts, the managed software package is automatically installed.

## Publish a package

To publish a package to computer users and make it available for installation from the **Add or Remove Programs** list in Control Panel, follow these steps:

1. Start the Active Directory Users and Computers snap-in by clicking **Start**, pointing to **Administrative Tools**, and then clicking **Active Directory Users and Computers**.
2. In the console tree, right-click your domain, and then click **Properties**.
3. Click the **Group Policy** tab, click the policy that you want, and then click **Edit**.
4. Under **User Configuration**, expand **Software Settings**.
5. Right-click **Software installation**, point to **New**, and then click **Package**.
6. In the **Open** dialog box, type the full UNC path of the shared installer package that you want. For example, `\\file server\share\file name.msi`.

    > [!IMPORTANT]
    > Don't use the **Browse** button to access the location. Make sure that you use the UNC path of the shared installer package.

7. Click **Open**.
8. Click **Publish**, and then click **OK**.
9. The package is listed in the right-pane of the **Group Policy** window.
10. Close the Group Policy snap-in, click **OK**, and then close the Active Directory Users and Computers snap-in.
11. Test the package.

    > [!NOTE]
    > Because there are several versions of Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

    1. Log on to a workstation that is running Windows 2000 Professional or Windows XP Professional by using an account that you published the package to.
    2. In Windows XP, click **Start**, and then click **Control Panel**.
    3. Double-click **Add or Remove Programs**, and then click **Add New Programs**.
    4. In the **Add programs from your network** list, click the program that you published, and then click **Add**. The program is installed.
    5. Click **OK**, and then click **Close**.

## Redeploy a package

In some cases, you may want to redeploy a software package (for example, if you upgrade or change the package). To redeploy a package, follow these steps:

1. Start the Active Directory Users and Computers snap-in by clicking **Start**, pointing to **Administrative Tools**, and then clicking **Active Directory Users and Computers**.
2. In the console tree, right-click your domain, and then click **Properties**.
3. Click the **Group Policy** tab, click the Group Policy Object that you used to deploy the package, and then click **Edit**.
4. Expand the **Software Settings** container that contains the software installation item that you used to deploy the package.
5. Click the software installation container that contains the package.
6. In the right-pane of the **Group Policy** window, right-click the program, point to **All Tasks**, and then click **Redeploy application**. You will receive the following message:

    > Redeploying this application will reinstall the application everywhere it is already installed. Do you want to continue?

7. Click **Yes**.
8. Quit the Group Policy snap-in, click **OK**, and then close the Active Directory Users and Computers snap-in.

## Remove a package

To remove a published or assigned package, follow these steps:

1. Start the Active Directory Users and Computers snap-in by clicking **Start**, pointing to **Administrative Tools**, and then clicking **Active Directory Users and Computers**.
2. In the console tree, right-click your domain, and then click **Properties**.
3. Click the **Group Policy** tab, click the Group Policy Object that you used to deploy the package, and then click **Edit**.
4. Expand the **Software Settings** container that contains the software installation item that you used to deploy the package.
5. Click the software installation container that contains the package.
6. In the right-pane of the **Group Policy** window, right-click the program, point to **All Tasks**, and then click **Remove**.
7. Perform one of the following actions:
   - Click **Immediately uninstall the software from users and computers**, and then click **OK**.
   - Click **Allow users to continue to use the software but prevent new installations**, and then click **OK**.
8. Close the Group Policy snap-in, click **OK**, and then closet the Active Directory Users and Computers snap-in.

## Troubleshoot

Published packages are displayed on a client computer after you use a Group Policy to remove them.

This situation can occur when a user has installed the program but hasn't used it. When the user first starts the published program, the installation is finished. Group Policy then removes the program.
