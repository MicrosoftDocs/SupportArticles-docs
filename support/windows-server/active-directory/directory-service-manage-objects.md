---
title: Use Directory Service to manage AD objects
description: Describes how to use the Directory Service command-line tools to perform administrative tasks for Active Directory in Windows Server 2003.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Use the Directory Service command-line tools to manage Active Directory objects in Windows Server 2003  

This article describes how to use the Directory Service command-line tools to perform administrative tasks for Active Directory in Windows Server 2003. The following tasks are broken down into task groups.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 322684

## How to manage users

The following sections provide detailed steps to manage groups.

### Create a New User Account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsadd user <user_dn> -samid <sam_name>
    ```

    The following values are used in this command:

    - **user_dn** specifies the distinguished name (also known as the DN) of the user object that you want to add.
    - **sam_name** specifies the security account manager (SAM) name used as the unique SAM account name for this user (for example, Linda).

4. To specify the user account password, type the following command, where **password** is the password that is to be used for the user account:

    ```console
    dsadd user <user_dn> -pwd password
    ```

> [!NOTE]
> To view the complete syntax for this command, and to obtain more information about entering more user account information, at a command prompt, type `dsadd user /?`.

### Reset a user password

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod user <user_dn> -pwd <new_password>
    ```

    This command uses the following values:

    - **user_dn** specifies the distinguished name of the user for which the password will be reset.
    - **new_password** specifies the password that will replace the current user password

4. If you want to require the user to change this password at the next logon process, type the following command:

    ```console
    dsmod user <user_dn> -mustchpwd {yes|no}
    ```

If a password is not assigned, the first time the user tries to log on (by using a blank password), the following logon message is displayed:

> You are required to change your password at first logon

After the user has changed the password, the logon process continues.

You must reset the services that are authenticated with a user account if the password for the service's user account is changed.

> [!NOTE]
> To view the complete syntax for this command, and to obtain more information about entering more user account information, at a command prompt, type `dsmod user /?`.

### Disable or enable a user account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod user <user_dn> -disabled {yes|no}
    ```

    This command uses the following values:

    - **user_dn** specifies the distinguished name of the user object to be disabled or enabled.
    - **{yes|no}** specifies whether the user account is disabled for logon (yes) or not (no).

> [!NOTE]
> As a security measure, instead of deleting that user's account, you can disable user accounts to prevent a particular user from logging on. If you disable user accounts that have common group memberships, you can use disabled user accounts as account templates to simplify user account creation.

### Delete a user account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the `dsrm <user_dn>` command, where **user_dn** specifies the distinguished name of the user object to be deleted.  

After you delete a user account, all of the permissions and memberships that are associated with that user account are permanently deleted. Because the security identifier (SID) for each account is unique, if you create a new user account that has the same name as a previously deleted user account, the new account does not automatically assume the permissions and memberships of the previously deleted account. To duplicate a deleted user account, you must manually re-create all permissions and memberships.

> [!NOTE]
> To view the complete syntax for this command, and to obtain more information about entering more user account information, at a command prompt, type `dsrm /?`.

## How to manage groups

The following sections provide detailed steps to manage groups.

### Create a new group

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsadd group <group_dn> -samid <sam_name> -secgrp {yes|no} -scope {l|g|u}
    ```

    This command uses the following values:

    - **group_dn** specifies the distinguished name of the group object that you want to add.
    - **sam_name** specifies the SAM name that is the unique SAM account name for this group (for example, operators).
    - **{yes|no}** specifies whether the group you want to add is a security group (yes) or a distribution group (no).
    - **{l|g|u}** specifies the scope of the group you want to add (domain local [l], global [g], or universal [u]).

If the domain in which you are creating the group is set to the domain functional level of Windows 2000 mixed, you can select only security groups with domain local scopes or global scopes.

To view the complete syntax for this command, and to obtain more information about entering more group information, at a command prompt, type `dsadd group /?`.

### Add a member to a group

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod group <group_dn> -addmbr <member_dn>
    ```

    This command uses the following values:

    - **group_dn** specifies the distinguished name of the group object that you want to add.
    - **member_dn** specifies the distinguished name of the object that you want to add to the group.

In addition to users and computers, a group can contain contacts and other groups.

To view the complete syntax for this command, and to obtain more information about entering more user account and group information, at a command prompt, type `dsmod group /?`.

### Convert a group to another group type

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod group <group_dn> -secgrp {yes|no}
    ```

    This command uses the following values:

    - **group_dn** specifies the distinguished name of the group object for which you want to change the group type.
    - **{yes|no}** specifies that the group type is set to security group (yes) or distribution group (no).

To convert a group, the domain functionality must be set to Windows 2000 Native or higher. You cannot convert groups when the domain functionality is set to Windows 2000 Mixed.

To view the complete syntax for this command, at a command prompt, type `dsmod group /?`.

### Change group scope

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod group <group_dn> -scope {l|g|u}
    ```

    This command uses the following values:

    - **group_dn** specifies the distinguished names of the group object to which the scope will be changed.
    - **{l|g|u}** specifies the scope that the group is to be set to (local, global, or universal). If the domain is still set to Windows 2000 mixed, the universal scope is not supported. Also, it is not possible to convert a domain local group to global group or vice versa.

> [!NOTE]
> You can only change group scopes when the domain functional level is set to Windows 2000 native or higher.

### Delete a group

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsrm <group_dn>`.

    The **group_dn** specifies the distinguished name of the group object to be deleted.

> [!NOTE]
> If you delete the group, the group is permanently removed.

By default, local groups that are provided automatically in domain controllers that are running Windows Server 2003, such as Administrators and Account Operators, are located in the Builtin folder. By default, common global groups, such as Domain Admins and Domain Users, are located in the Users folder. You can add or move new groups to any folder. Microsoft recommends that you keep groups in an organizational unit folder.

To view the complete syntax for this command, at a command prompt, type `dsrm /?`.

### Find groups in which a user is a member

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsget user <user_dn> -memberof
    ```

    The **user_dn** specifies the distinguished name of the user object for which you want to display group membership.

To view the complete syntax for this command, at a command prompt, type `dsget user /?`.

## How to manage computers

The following sections provide detailed steps to manage computers.

### Create a new computer account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsadd computer <computer_dn>
    ```

    The **computer_dn** specifies the distinguished name of the computer you want to add. The distinguished name indicates the folder location.

To view the complete syntax for this command, at a command prompt, type `dsadd computer /?`.

To modify the properties of a computer account, use the dsmod computer command.

### Add a computer account to a group

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod group <group_dn> -addmbr <computer_dn>
    ```

    This command uses the following values:

    - **group_dn** specifies the distinguished name of the group object to which you want to add the computer object.
    - **computer_dn** specifies the distinguished name of the computer object to be added to the group. The distinguished name indicates the folder location.

When you add a computer to a group, you can assign permissions to all of the computer accounts in that group, and then filter Group Policy settings on all accounts in that group.

To view the complete syntax for this command, at a command prompt, type `dsmod group /?`.

### Reset a computer account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod computer <computer_dn> -reset
    ```

    The **computer_dn** specifies the distinguished names of one or more computer objects that you want to reset.

    > [!NOTE]
    > When you reset a computer account, you break the computer's connection to the domain. You must rejoin computer account to the domain computer account after you reset it.

To view the complete syntax for this command, at a command prompt, type dsmod computer /? .

### Disable or enable a computer account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsmod computer <computer_dn> -disabled {yes|no}
    ```

    This command uses the following values:

    - **computer_dn** specifies the distinguished name of the computer object that you want to disable or enable.
    - **{yes|no}** specifies whether the computer is disabled for logon (yes) or not (no).

When you disable a computer account, you break the computer's connection with the domain and the computer cannot authenticate to the domain.

To view the complete syntax for this command, at a command prompt, type `dsmod computer /?`.

## How to manage organizational units

The following sections provide detailed steps to manage organizational units.

### Create a new organizational unit

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the following command:

    ```console
    dsadd ou <organizational_unit_dn>
    ```

    The **organizational_unit_dn** specifies the distinguished name of the organizational unit to be added.

To view the complete syntax for this command, at a command prompt, type `dsadd ou /?`.

> [!NOTE]
> To modify the properties of an organizational unit, use the `dsmod ou` command.

### Delete an Organizational Unit

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsrm <organizational_unit_dn>`.  

    The **organizational_unit_dn** specifies the distinguished name of the organizational unit to be deleted.

To view the complete syntax for this command, at a command prompt, type `dsrm /?`.

> [!NOTE]
> If you delete an organizational unit, all of the objects that it contains are deleted.

## How to search Active Directory

The following sections provide detailed steps to search Active Directory.

### Find a user account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery user <parameter>`.

    The **parameter** specifies the parameter to use. For the list of parameters, see the online help for the d`squery user` command.

To view the complete syntax for this command, at a command prompt, type `dsquery user /?`.

### Find a contact

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery contact <parameter>`.

    The **parameter** specifies the parameter to use. For the list of parameters, see the online help for the dsquery user command.

### Find a group

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery group <parameter>`.

    The **parameter** specifies the parameter to use. For the list of parameters, see the online help for the dsquery user command.

By default, local groups that are provided automatically in domain controllers that are running Windows Server 2003, such as Administrators and Account Operators, are located in the Builtin folder. By default, common global groups, such as Domain Admins and Domain Users, are located in the Users folder. You can add or move new groups to any folder. Microsoft recommends that you keep groups in an organizational unit folder.

### Find a computer account

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery computer -name <name>`.

    The **name** specifies the computer name that the command searches for. This command searches for computers whose name attributes (value of CN attribute) match **name**.

To view the complete syntax for this command, at a command prompt, type `dsquery computer /?`.

### Find an organizational unit

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery ou <parameter>`.

    The **parameter** specifies the parameter to use. For the list of parameters, see the online help for `dsquery ou`.

To view the complete syntax for this command, at a command prompt, type `dsquery ou /?`.

### Find a domain controller

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery server <parameter>`.  

    The **parameter** specifies the parameter to use. There are several attributes of a server that you can search by using this command. For the list of parameters, see online help for `dsquery server.`

### Perform a custom search

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*.
3. At the command prompt, type the command `dsquery * <parameter>`.

    The **parameter** specifies the parameter to use. There are several attributes that you can search by using this command. For more information about LDAP searches, see the Windows Server 2003 Resource Kit.

## References

For more information about the Directory Services command-line tools in Windows Server 2003, click **Start**, click **Help and Support Center**, and then type *directory service command-line* tools in the **Search** box.
