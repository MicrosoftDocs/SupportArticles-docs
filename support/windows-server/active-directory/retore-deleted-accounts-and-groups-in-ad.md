---
title: Restore user accounts and groups in AD
description: Discusses how to recover from the accidental deletion of users and their group memberships in Active Directory.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, v-jomcc
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
---
# How to restore deleted user accounts and their group memberships in Active Directory

This article provides information on how to restore deleted user accounts and group memberships in Active Directory.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 840001

## Introduction

You can use several methods to restore deleted user accounts, computer accounts, and security groups. These objects are known collectively as security principals.

The most common method is to enable the AD Recycle Bin feature supported on domain controllers based on Windows Server 2008 R2 and later. For more information on this feature including how to enable it and restore objects, see [Active Directory Recycle Bin Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10)).

If this method isn't available to you, the following three methods can be used. In all three methods, you authoritatively restore the deleted objects, and then you restore group membership information for the deleted security principals. When you restore a deleted object, you must restore the former values of the `member` and `memberOf` attributes in the affected security principal.

> [!NOTE]
> Recovering deleted objects in Active directory can be simplified by enabling the AD Recycle Bin feature supported on domain controllers based on Windows Server 2008 R2 and later. For more information on this feature including how to enable it and restore objects, see [Active Directory Recycle Bin Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10)).

## More information

Methods 1 and 2 provide a better experience for domain users and administrators. These methods preserve the additions to security groups that were made between the time of the last system state backup and the time the deletion occurred. In method 3, you don't make individual adjustments to security principals. Instead, you roll back security group memberships to their state at the time of the last backup.

Most large-scale deletions are accidental. Microsoft recommends that you take several steps to prevent others from deleting objects in bulk.

> [!NOTE]
> To prevent the accidental deletion or movement of objects (especially organizational units), two Deny access control entries (ACEs) can be added to the security descriptor of each object (DENY **DELETE** & **DELETE TREE**) and one Deny access control entries (ACEs) can be added to the security descriptor of the PARENT of each object (DENY **DELETE CHILD**). To do it, use Active Directory Users and Computers, ADSIEdit, LDP, or the DSACLS command-line tool. You can also change the default permissions in the AD schema for organizational units so that these ACEs are included by default.

For example, to protect the organization unit that is called. Users in the AD domain that is called `CONTOSO.COM` from accidentally being moved or deleted out of its parent organizational unit that is called _MyCompany_, make the following configuration:

For the _MyCompany_ organizational unit, add DENY ACE for **Everyone** to **DELETE CHILD** with **This object only** scope:

```console
DSACLS "OU=MyCompany,DC=CONTOSO,DC=COM" /D "EVERYONE:DC"/
```

For the Users organizational unit, add DENY ACE for **Everyone** to **DELETE and DELETE TREE** with **This object only** scope:

```console
DSACLS "OU=Users,OU=MyCompany,DC=CONTOSO,DC=COM" /D "EVERYONE:SDDT"
```

The Active Directory Users and Computers snap-in in Windows Server 2008 includes a **Protect object from accidental deletion** check box on the **Object** tab.

> [!NOTE]
> The **Advanced Features** check box must be enabled to view that tab.

When you create an organizational unit by using Active Directory Users and Computers in Windows Server 2008, the **Protect container from accidental deletion** check box appears. By default, the check box is selected and can be deselected.

Although you can configure every object in Active Directory by using these ACEs, it's best suited for organizational units. Deletion or movements of all leaf objects can have a major effect. This configuration prevents such deletions or movements. To really delete or move an object by using such a configuration, the Deny ACEs must be removed first.

This article discusses how to restore user accounts, computer accounts, and their group memberships after they have been deleted from Active Directory. In variations of this scenario, user accounts, computer accounts, or security groups may have been deleted individually or in some combination. In all these cases, the same initial steps apply. You authoritatively restore, or auth restore, those objects that were inadvertently deleted. Some deleted objects require more work to be restored. These objects include objects such as user accounts that contain attributes that are back links of the attributes of other objects. Two of these attributes are `managedBy` and `memberOf`.

When you add security principals, such as a user account, a security group, or a computer account to a security group, you make the following changes in Active Directory:

1. The name of the security principal is added to the member attribute of each security group.
2. For each security group that the user, the computer, or the security group is a member of, a back link is added to the security principal's `memberOf` attribute.

Similarly, when a user, a computer, or a group is deleted from Active Directory, the following actions occur:

1. The deleted security principal is moved into the deleted objects container.
2. A few attribute values, including the `memberOf` attribute, are stripped from the deleted security principal.
3. Deleted security principals are removed from any security groups that they were a member of. In other words, the deleted security principals are removed from each security group's member attribute.

When you recover deleted security principals and restore their group memberships, each security principal must exist in Active Directory before you restore its group membership. The member may be a user, a computer, or another security group. To restate this rule more broadly, an object that contains attributes whose values are back links must exist in Active Directory before the object that contains that forward link can be restored or modified.

This article focuses on how to recover deleted user accounts and their memberships in security groups. Its concepts apply equally to other object deletions. This article's concepts apply equally to deleted objects whose attribute values use forward links and back links to other objects in Active Directory.

You can use either of the three methods to recover security principals. When you use method 1, you leave in place all security principals that were added to any security group across the forest. And you add only security principals that were deleted from their respective domains back to their security groups. For example, you make a system state backup, add a user to a security group, and then restore the system state backup. When you use methods 1 or 2, you preserve any users who were added to security groups that contain deleted users between the dates that the system state backup was created and the date that the backup was restored. When you use method 3, you roll back security group memberships for all the security groups that contain deleted users to their state at the time of the system state backup.

## Method 1 - Restore the deleted user accounts, and then add the restored users back to their groups by using the Ntdsutil.exe command-line tool

The Ntdsutil.exe command-line tool allows you to restore the backlinks of deleted objects. Two files are generated for each authoritative restore operation. One file contains a list of authoritatively restored objects. The other file is a .ldf file that is used with the Ldifde.exe utility. This file is used to restore the backlinks for the objects that are authoritatively restored. An authoritative restoration of a user object also generates LDAP Data Interchange Format (LDIF) files with the group membership. This method avoids a double restoration.

When you use this method, you perform the following high-level steps:

1. Check if a global catalog in the user's domain hasn't replicated in the deletion. And then prevent that global catalog from replicating. If there's no latent global catalog, locate the most current system state backup of a global catalog domain controller in the deleted user's home domain.
2. Auth restore all the deleted user accounts, and then permit end-to-end replication of those user accounts.
3. Add all the restored users back to all the groups in all the domains that the user accounts were a member of before they were deleted.

To use method 1, follow this procedure:

1. Check whether there's a global catalog domain controller in the deleted user's home domain that hasn't replicated any part of the deletion.

    > [!NOTE]
    > Focus on the global catalogs that have the least frequent replication schedules.

    If one or more of these global catalogs exist, use the Repadmin.exe command-line tool to immediately disable inbound replication by following these steps:

    1. Select **Start**, and then select **Run**.
    2. Type _cmd_ in the **Open** box, and then select **OK**.
    3. Type the following command at the command prompt, and then press ENTER:

        ```console
        repadmin /options <recovery dc name> +DISABLE_INBOUND_REPL
        ```

        > [!NOTE]
        > If you can't issue the `Repadmin` command immediately, remove all network connectivity from the latent global catalog until you can use `Repadmin` to disable inbound replication, and then immediately return network connectivity.

    This domain controller will be referred to as the recovery domain controller. If there is no such global catalog, go to step 2.

2. It's best to stop making changes to security groups in the forest if all the following statements are true:

    - You're using method 1 to authoritatively restore deleted users or computer accounts by their distinguished name (dn) path.
    - The deletion has replicated to all the domain controllers in the forest except the latent recovery domain controller.
    - You're not auth restoring security groups or their parent containers.
  
    If you're auth restoring security groups or organizational unit (OU) containers that host security groups or user accounts, temporarily stop all these changes.

    Notify administrators and help desk administrators in the appropriate domains in addition to domain users in the domain where the deletion occurred about stopping these changes.

3. Create a new system state backup in the domain where the deletion occurred. You can use this backup if you have to roll back your changes.

    > [!NOTE]
    > If system state backups are current up to the point of the deletion, skip this step and go to step 4.

    If you identified a recovery domain controller in step 1, back up its system state now.

    If all the global catalogs located in the domain where the deletion occurred replicated in the deletion, back up the system state of a global catalog in the domain where the deletion occurred.

    When you create a backup, you can return the recovery domain controller back to its current state. And perform your recovery plan again if your first try isn't successful.

4. If you can't find a latent global catalog domain controller in the domain where the user deletion occurred, find the most recent system state backup of a global catalog domain controller in that domain. This system state backup should contain the deleted objects. Use this domain controller as the recovery domain controller.

    Only restorations of the global catalog domain controllers in the user's domain contain global and universal group membership information for security groups that reside in external domains. If there's no system state backup of a global catalog domain controller in the domain where users were deleted, you can't use the `memberOf` attribute on restored user accounts to determine global or universal group membership or to recover membership in external domains. Additionally, it's a good idea to find the most recent system state backup of a non-global catalog domain controller.

5. If you know the password for the offline administrator account, start the recovery domain controller in Disrepair mode. If you don't know the password for the offline administrator account, reset the password using ntdsutil.exe while the recovery domain controller is still in normal Active Directory mode.

    You can use the setpwd command-line tool to reset the password on domain controllers while they are in online Active Directory mode.

    > [!NOTE]
    > Microsoft no longer supports Windows 2000.

    Administrators of Windows Server 2003 and later domain controllers can use the `set dsrm password` command in the Ntdsutil command-line tool to reset the password for the offline administrator account.

    For more information about how to reset the Directory Services Restore Mode administrator account, see [How To Reset the Directory Services Restore Mode Administrator Account Password in Windows Server](https://support.microsoft.com/help/322672).

6. Press F8 during the startup process to start the recovery domain controller in Disrepair mode. Sign in to the console of the recovery domain controller with the offline administrator account. If you reset the password in step 5, use the new password.

    If the recovery domain controller is a latent global catalog domain controller, don't restore the system state. Go to step 7.

    If you're creating the recovery domain controller by using a system state backup, restore the most current system state backup that was made on the recovery domain controller now.

7. Auth restore the deleted user accounts, the deleted computer accounts, or the deleted security groups.

    > [!NOTE]
    > The terms _auth restore_ and _authoritative restore_ refer to the process of using the authoritative restore command in the Ntdsutil command-line tool to increment the version numbers of specific objects or of specific containers and all their subordinate objects. As soon as end-to-end replication occurs, the targeted objects in the recovery domain controller's local copy of Active Directory become authoritative on all the domain controllers that share that partition. An authoritative restoration is different from a system state restoration. A system state restoration populates the restored domain controller's local copy of Active Directory with the versions of the objects at the time that the system state backup was made.

    Authoritative restorations are performed with the Ntdsutil command-line tool, and refer to the domain name (dn) path of the deleted users or of the containers that host the deleted users.

    When you auth restore, use domain name (dn) paths that are as low in the domain tree as they have to be. The purpose is to avoid reverting objects that aren't related to the deletion. These objects may include objects that were modified after the system state backup was made.

    Auth restore deleted users in the following order:
    1. Auth restore the domain name (dn) path for each deleted user account, computer account, or security group.

        Authoritative restorations of specific objects take longer but are less destructive than authoritative restorations of a whole subtree. Auth restore the lowest common parent container that holds the deleted objects.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore object <object DN path>" q q
        ```

        For example, to authoritatively restore the deleted user John Doe in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=JohnDoe,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        To authoritatively restore the deleted security group **ContosoPrintAccess** in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=ContosoPrintAccess,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        > [!IMPORTANT]
        > The use of quotes is required.

        For each user that you restore, at least two files are generated. These files have the following format:

        ar_**YYYYMMDD-HHMMSS**_objects.txt  
        This file contains a list of the authoritatively restored objects. Use this file with the ntdsutil authoritative restore `create ldif file from` command in any other domain in the forest where the user was a member of Domain Local groups.

        ar_**YYYYMMDD-HHMMSS**_links_usn.loc.ldf  
        If you perform the auth restore on a global catalog, one of these files is generated for every domain in the forest. This file contains a script that you can use with the Ldifde.exe utility. The script restores the backlinks for the restored objects. In the user's home domain, the script restores all the group memberships for the restored users. In all other domains in the forest where the user has group membership, the script restores only universal and global group memberships. The script doesn't restore any Domain Local group memberships. These memberships are not tracked by a global catalog.

    2. Auth restore only the OU or Common-Name (CN) containers that host the deleted user accounts or groups.

        Authoritative restorations of a whole subtree are valid when the OU targeted by the ntdsutil authoritative restore command contains most of the objects that you're trying to authoritatively restore. Ideally, the targeted OU contains all the objects that you're trying to authoritatively restore.

        An authoritative restoration on an OU subtree restores all the attributes and objects that reside in the container. Any changes that were made up to the time that a system state backup is restored are rolled back to their values at the time of the backup. With user accounts, computer accounts, and security groups, this rollback may mean the loss of the most recent changes to:

        - passwords
        - the home directory
        - the profile path
        - location
        - contact info
        - group membership
        - any security descriptors that are defined on those objects and attributes.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore subtree <container DN path>" q q
        ```

        For example, to authoritatively restore the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore subtree ou=Mayberry, dc=contoso,dc=com" q q
        ```

        > [!NOTE]
        > Repeat this step for each peer OU that hosts deleted users or groups.

        > [!IMPORTANT]
        > When you restore a subordinate object of an OU, all the deleted parent containers of the deleted subordinate objects must be explicitly auth restored.

        For each organizational unit that you restore, at least two files are generated. These files have the following format:

        ar_**YYYYMMDD-HHMMSS**_objects.txt  
        This file contains a list of the authoritatively restored objects. Use this file with the ntdsutil authoritative restore `create ldif file from` command in any other domain in the forest where the restored users were members of Domain Local groups.

        ar_**YYYYMMDD-HHMMSS**_links_usn.loc.ldf  
        This file contains a script that you can use with the Ldifde.exe utility. The script restores the backlinks for the restored objects. In the user's home domain, the script restores all the group memberships for the restored users.

8. If deleted objects were recovered on the recovery domain controller because of a system state restore, remove all the network cables that provide network connectivity to all the other domain controllers in the forest.

9. Restart the recovery domain controller in normal Active Directory mode.
10. Type the following command to disable inbound replication to the recovery domain controller:

    ```console
    repadmin /options <recovery dc name> +DISABLE_INBOUND_REPL
    ```

    Enable network connectivity back to the recovery domain controller whose system state was restored.

11. Outbound-replicate the auth-restored objects from the recovery domain controller to the domain controllers in the domain and in the forest.

    While inbound replication to the recovery domain controller remains disabled, type the following command to push the auth-restored objects to all the cross-site replica domain controllers in the domain and to all the global catalogs in the forest:

    ```console
    repadmin /syncall /d /e /P <recovery dc> <Naming Context>
    ```

    If all the following statements are true, group membership links are rebuilt with the restoration and the replication of the deleted user accounts. Go to step 14.

    > [!NOTE]
    > If one or more of the following statements isn't true, go to step 12.

    - Your forest is running at the Windows Server 2003 and later or later forest functional level or at the Windows Server 2003 and later or later Interim forest functional level.
    - Only user accounts or computer accounts were deleted, and not security groups.
    - The deleted users were added to security groups in all the domains in the forest after the forest was transitioned to Windows Server 2003 and later, or later forest functional level.

12. On the console of the recovery domain controller, use the Ldifde.exe utility and the ar_**YYYYMMDD-HHMMSS**_links_usn.loc.ldf file to restore the user's group memberships. To do it, follow these steps:

    - Select **Start**, select **Run**, type _cmd_ in the **Open** box, and then select **OK**.
    - At the command prompt, type the following command, and then press ENTER:

      ```console
      ldifde -i -f ar_YYYYMMDD-HHMMSS_links_usn.loc.ldf
      ```

13. Enable inbound replication to the recovery domain controller by using the following command:

    ```console
    repadmin /options <recovery dc name> -DISABLE_INBOUND_REPL
    ```

14. If deleted users were added to local groups in external domains, take one of the following actions:

    - Manually add the deleted users back to those groups.
    - Restore the system state and auth restore each of the local security groups that contains the deleted users.

15. Verify group membership in the recovery domain controller's domain, and in global catalogs in other domains.
16. Make a new system state backup of domain controllers in the recovery domain controller's domain.
17. Notify all the forest administrators, delegated administrators, help desk administrators in the forest, and users in the domain that the user restore is complete.

    Help desk administrators may have to reset the passwords of auth-restored user accounts and computer accounts whose domain password changed after the restored system was made.

    Users who changed their passwords after the system state backup was made will find that their most recent password no longer works. Have such users try to log on by using their previous passwords if they know them. Otherwise, help desk administrators must reset the password and select the **user must change password at next logon** check box. Do it preferably on a domain controller in the same Active Directory site as the user is located in.

## Method 2 - Restore the deleted user accounts, and then add the restored users back to their groups

When you use this method, you perform the following high-level steps:

1. Check if a global catalog in the user's domain hasn't replicated in the deletion. And then prevent that global catalog from replicating. If there is no latent global catalog, locate the most current system state backup of a global catalog domain controller in the deleted user's home domain.
2. Auth restore all the deleted user accounts, and then permit end-to-end replication of those user accounts.
3. Add all the restored users back to all the groups in all the domains that the user accounts were a member of before they were deleted.

To use method 2, follow this procedure:

1. Check whether there's a global catalog domain controller in the deleted user's home domain that hasn't replicated any part of the deletion.

    > [!NOTE]
    > Focus on the global catalogs that have the least frequent replication schedules.

    If one or more of these global catalogs exist, use the Repadmin.exe command-line tool to immediately disable inbound replication. To do it, follow these steps:

      1. Select **Start**, and then select **Run**.
      2. Type _cmd_ in the **Open** box, and then select **OK**.
      3. Type the following command at the command prompt, and then press ENTER:

      ```console
      repadmin /options <recovery dc name> +DISABLE_INBOUND_REPL
      ```

      > [!NOTE]
      > If you can't issue the Repadmin command immediately, remove all network connectivity from the latent global catalog until you can use Repadmin to disable inbound replication, and then immediately return network connectivity.

    This domain controller will be referred to as the recovery domain controller. If there is no such global catalog, go to step 2.

2. Decide whether additions, deletions, and changes to user accounts, computer accounts, and security groups must be temporarily stopped until all the recovery steps have been completed.

    To maintain the most flexible recovery path, temporarily stop making changes to the following items. Changes include password resets by domain users, help desk administrators, and administrators in the domain where the deletion occurred, in addition to group membership changes in the deleted users' groups. Consider halting additions, deletions, and modifications to the following items:
  
    1. User accounts and attributes on user accounts
    2. Computer accounts and attributes on computer accounts
    3. Service accounts
    4. Security groups

    It's best to stop making changes to security groups in the forest if all the following statements are true:

    - You're using method 2 to authoritatively restore deleted users or computer accounts by their domain name (dn) path.
    - The deletion has replicated to all the domain controllers in the forest except the latent recovery domain controller.
    - You're not auth restoring security groups or their parent containers.

    If you're auth restoring security groups or organizational unit (OU) containers that host security groups or user accounts, temporarily stop all these changes.

    Notify administrators and help desk administrators in the appropriate domains in addition to domain users in the domain where the deletion occurred about stopping these changes.

3. Create a new system state backup in the domain where the deletion occurred. You can use this backup if you have to roll back your changes.

    > [!NOTE]
    > If system state backups are current up to the point of the deletion, skip this step and go to step 4.

    If you identified a recovery domain controller in step 1, back up its system state now.

    If all the global catalogs located in the domain where the deletion occurred replicated in the deletion, back up the system state of a global catalog in the domain where the deletion occurred.

    When you create a backup, you can return the recovery domain controller back to its current state. And perform your recovery plan again if your first try isn't successful.

4. If you can't find a latent global catalog domain controller in the domain where the user deletion occurred, find the most recent system state backup of a global catalog domain controller in that domain. This system state backup should contain the deleted objects. Use this domain controller as the recovery domain controller.

    Only restorations of the global catalog domain controllers in the user's domain contain global and universal group membership information for security groups that reside in external domains. If there is no system state backup of a global catalog domain controller in the domain where users were deleted, you can't use the `memberOf` attribute on restored user accounts to determine global or universal group membership or to recover membership in external domains. Additionally, it's a good idea to find the most recent system state backup of a non-global catalog domain controller.

5. If you know the password for the offline administrator account, start the recovery domain controller in Disrepair mode. If you don't know the password for the offline administrator account, reset the password while the recovery domain controller is still in normal Active Directory mode.

    You can use the setpwd command-line tool to reset the password on domain controllers that are running Windows 2000 Service Pack 2 (SP2) and later while they are in online Active Directory mode.

    > [!NOTE]
    > Microsoft no longer supports Windows 2000.

    Administrators of Windows Server 2003 and later domain controllers can use the `set dsrm password` command in the Ntdsutil command-line tool to reset the password for the offline administrator account.

    For more information about how to reset the Directory Services Restore Mode administrator account, see [How To Reset the Directory Services Restore Mode Administrator Account Password in Windows Server](https://support.microsoft.com/help/322672).

6. Press F8 during the startup process to start the recovery domain controller in Disrepair mode. Sign in to the console of the recovery domain controller with the offline administrator account. If you reset the password in step 5, use the new password.

    If the recovery domain controller is a latent global catalog domain controller, don't restore the system state. Go to step 7.

    If you're creating the recovery domain controller by using a system state backup, restore the most current system state backup that was made on the recovery domain controller now.

7. Auth restore the deleted user accounts, the deleted computer accounts, or the deleted security groups.

    > [!NOTE]
    > The terms **auth restore** and **authoritative restore** refer to the process of using the authoritative restore command in the Ntdsutil command-line tool to increment the version numbers of specific objects or of specific containers and all their subordinate objects. As soon as end-to-end replication occurs, the targeted objects in the recovery domain controller's local copy of Active Directory become authoritative on all the domain controllers that share that partition. An authoritative restoration is different from a system state restoration. A system state restoration populates the restored domain controller's local copy of Active Directory with the versions of the objects at the time that the system state backup was made.

    Authoritative restorations are performed with the Ntdsutil command-line tool, and refer to the domain name (dn) path of the deleted users or of the containers that host the deleted users.

    When you auth restore, use domain name (dn) paths that are as low in the domain tree as they have to be. The purpose is to avoid reverting objects that aren't related to the deletion. These objects may include objects that were modified after the system state backup was made.

    Auth restore deleted users in the following order:
    1. Auth restore the domain name (dn) path for each deleted user account, computer account, or security group.

        Authoritative restorations of specific objects take longer but are less destructive than authoritative restorations of a whole subtree. Auth restore the lowest common parent container that holds the deleted objects.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore object <object DN path>" q q
        ```

        For example, to authoritatively restore the deleted user John Doe in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=JohnDoe,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        To authoritatively restore the deleted security group **ContosoPrintAccess** in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=ContosoPrintAccess,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        > [!IMPORTANT]
        > The use of quotes is required.

        > [!NOTE]
        > This syntax is available only in Windows Server 2003 and later. The only syntax in Windows 2000 is to use the following:

        ```console
        ntdsutil "authoritative restore" "restore subtree object DN path"
        ```

        > [!NOTE]
        > The Ntdsutil authoritative restore operation isn't successful if the distinguished name path (DN) contains extended characters or spaces. In order for the scripted restore to succeed, the `restore object <DN path>` command must be passed as one complete string.

        To work around this problem, wrap the DN that contains extended characters and spaces with backslash-double-quotation-mark escape sequences. Here is an example:

        ```console
        ntdsutil "authoritative restore" "restore object \"CN=John Doe,OU=Mayberry NC,DC=contoso,DC=com\"" q q
        ```

        > [!NOTE]
        > The command must be modified further if the DN of objects being restored contain commas. See the following example:

        ```console
        ntdsutil "authoritative restore" "restore object \"CN=Doe\, John,OU=Mayberry NC,DC=contoso,DC=com\"" q q
        ```

        > [!NOTE]
        > If the objects were restored from tape, marked authoritative and the restore did not work as expected and then the same tape is used to restore the NTDS database once again, the USN version of objects to be restored authoritatively must be increased higher than the default of 100000 or the objects will not replicate out after the second restore. The syntax below is needed to script an increased version number higher than 100000 (default):

        ```console
        ntdsutil "authoritative restore" "restore object \"CN=Doe\, John,OU=Mayberry NC,DC=contoso,DC=com\" verinc 150000\"" q q
        ```

        > [!NOTE]
        > If the script prompts for confirmation on each object being restored you can turn off the prompts. The syntax to turn off prompting is:

        ```console
        ntdsutil "popups off" "authoritative restore" "restore object \"CN=John Doe,OU=Mayberry NC,DC=contoso,DC=com\" verinc 150000\"" q q
        ```

    2. Auth restore only the OU or Common-Name (CN) containers that host the deleted user accounts or groups.

        Authoritative restorations of a whole subtree are valid when the OU targeted by the ntdsutil authoritative restore command contains most of the objects that you're trying to authoritatively restore. Ideally, the targeted OU contains all the objects that you're trying to authoritatively restore.

        An authoritative restoration on an OU subtree restores all the attributes and objects that reside in the container. Any changes that were made up to the time that a system state backup is restored are rolled back to their values at the time of the backup. With user accounts, computer accounts, and security groups, this rollback may mean the loss of the most recent changes to passwords, to the home directory, to the profile path, to location and to contact info, to group membership, and to any security descriptors that are defined on those objects and attributes.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore subtree <container DN path>" q q
        ```

        For example, to authoritatively restore the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore subtree ou=Mayberry, dc=contoso,dc=com" q q
        ```

        > [!NOTE]
        > Repeat this step for each peer OU that hosts deleted users or groups.

        > [!IMPORTANT]
        > When you restore a subordinate object of an OU, all the deleted parent containers of the deleted subordinate objects must be explicitly auth restored.

8. If deleted objects were recovered on the recovery domain controller because of a system state restore, remove all the network cables that provide network connectivity to all the other domain controllers in the forest.
9. Restart the recovery domain controller in normal Active Directory mode.
10. Type the following command to disable inbound replication to the recovery domain controller:

    ```console
    repadmin /options <recovery dc name> +DISABLE_INBOUND_REPL
    ```

    Enable network connectivity back to the recovery domain controller whose system state was restored.

11. Outbound-replicate the auth-restored objects from the recovery domain controller to the domain controllers in the domain and in the forest.

    While inbound replication to the recovery domain controller remains disabled, type the following command to push the auth-restored objects to all the cross-site replica domain controllers in the domain and to all the global catalogs in the forest:

    ```console
    repadmin /syncall /d /e /P <recovery dc> <Naming Context>
    ```
  
    If all the following statements are true, group membership links are rebuilt with the restoration and the replication of the deleted user accounts. Go to step 14.

    > [!NOTE]
    > If one or more of the following statements isn't true, go to step 12.

    - Your forest is running at the Windows Server 2003 and later forest functional level, or at the Windows Server 2003 and later Interim forest functional level.
    - Only user accounts or computer accounts were deleted, and not security groups.
    - The deleted users were added to security groups in all the domains in the forest after the forest was transitioned to Windows Server 2003 and later forest functional level.

12. Determine which security groups the deleted users were members of, and then add them to those groups.

    > [!NOTE]
    > Before you can add users to groups, the users who you auth restored in step 7 and who you outbound-replicated in step 11 must have replicated to the domain controllers in the referenced domain controller's domain and to all the global catalog domain controllers in the forest.

    If you have deployed a group-provisioning utility to repopulate membership for security groups, use that utility to restore deleted users to the security groups that they were members of before they were deleted. Do it after all the direct and transitive domain controllers in the forest's domain and global catalog servers have inbound-replicated the auth-restored users and any restored containers.

    If you don't have the utility, the `Ldifde.exe` and `Groupadd.exe` command-line tools can automate this task for you when they are run on the recovery domain controller. These tools are available from Microsoft Product Support Services. In this scenario, Ldifde.exe creates an LDAP Data Interchange Format (LDIF) information file that contains the names of the user accounts and their security groups. It starts at an OU container that the administrator specifies. Groupadd.exe then reads the `memberOf` attribute for each user account that's listed in the .ldf file. It then generates separate and unique LDIF information for each domain in the forest. This LDIF information contains the names of the security groups associated with the deleted users. Use the LDIF information to add the information back to the users so that their group memberships can be restored. Follow these steps for this phase of the recovery:

    1. Sign in to the recovery domain controller's console by using a user account that is a member of the domain administrator's security group.
    2. Use the Ldifde command to dump the names of the formerly deleted user accounts and their `memberOf` attributes, starting at the topmost OU container where the deletion occurred. The Ldifde command uses the following syntax:

        ```console
        ldifde -d <dn path of container that hosts deleted users> -r "(objectClass=user)" -l memberof -p subtree -f user_membership_after_restore.ldf
        ```

        Use the following syntax if deleted computer accounts were added to security groups:

        ```console
        ldifde -d <dn path of container that hosts deleted users> -r "(objectClass=computer)" -l memberof -p subtree -f computer_membership_after_restore.ldf
        ```

    3. Run the `Groupadd` command to build more .ldf files that contain the names of domains and the names of global and universal security groups that the deleted users were a member of. The `Groupadd` command uses the following syntax:

        ```console
        Groupadd / after_restore users_membership_after_restore.ldf
        ```

        Repeat this command if deleted computer accounts were added to security groups.

    4. Import each `Groupadd`_**fully.qualified.domain.name**.ldf file that you created in step 12c to a single global catalog domain controller that corresponds with each domain's .ldf file. Use the following Ldifde syntax:

        ```console
        Ldifde -i -k -f Groupadd_<fully.qualified.domain.name>.ldf
        ```

        Run the .ldf file for the domain that the users were deleted from on any domain controller except the recovery domain controller.

    5. On the console of each domain controller that's used to import the Groupadd_<**fully.qualified.domain.name**>.ldf file for a particular domain, outbound-replicate the group membership additions to the other domain controllers in the domain, and to the global catalog domain controllers in the forest. To do it, use the following command:

        ```console
        repadmin /syncall /d /e /P <recovery dc> <Naming Context>
        ```

13. To disable outbound replication, type the following text, and then press ENTER:

    ```console
    repadmin /options +DISABLE_OUTBOUND_REPL
    ```

    > [!NOTE]
    > To re-enable outbound replication, type the following text, and then press ENTER:

    ```console
    repadmin /options -DISABLE_OUTBOUND_REPL
    ```

14. If deleted users were added to local groups in external domains, take one of the following actions:

    - Manually add the deleted users back to those groups.
    - Restore the system state and auth restore each of the local security groups that contains the deleted users.

15. Verify group membership in the recovery domain controller's domain, and in global catalogs in other domains.
16. Make a new system state backup of domain controllers in the recovery domain controller's domain.
17. Notify all the forest administrators, delegated administrators, help desk administrators in the forest, and users in the domain that the user restore is complete.

    Help desk administrators may have to reset the passwords of auth-restored user accounts and computer accounts whose domain password changed after the restored system was made.

    Users who changed their passwords after the system state backup was made will find that their most recent password no longer works. Have such users try to log on by using their previous passwords if they know them. Otherwise, help desk administrators must reset the password and select the **user must change password at next logon** check box. Do it preferably on a domain controller in the same Active Directory site as the user is located in.

## Method 3 - Authoritatively restore the deleted users and the deleted users' security groups two times

When you use this method, you perform the following high-level steps:

1. Check if a global catalog in the user's domain hasn't replicated in the deletion. And then prevent that domain controller from inbound-replicating the deletion. If there is no latent global catalog, locate the most current system state backup of a global catalog domain controller in the deleted user's home domain.
2. Authoritatively restore all deleted user accounts and all security groups in the deleted user's domain.
3. Wait for the end-to-end replication of the restored users and the security groups to all the domain controllers in the deleted user's domain, and to the forest's global catalog domain controllers.
4. Repeat steps 2 and 3 to authoritatively restore deleted users and security groups. (You restore the system state only one time.)
5. If the deleted users were members of security groups in other domains, authoritatively restore all the security groups that the deleted users were members of in those domains. Or, if system state backups are current, authoritatively restore all the security groups in those domains. To satisfy the requirement that deleted group members must be restored before security groups to fix up group membership links, you restore both object types twice in this method. The first restoration puts all the user accounts and group accounts in place. The second restoration restores deleted groups and repairs the group membership information, including membership information for nested groups.

To use method 3, follow this procedure:

1. Check whether a global catalog domain controller exists in the deleted users home domain and hasn't replicated in any part of the deletion.

    > [!NOTE]
    > Focus on global catalogs in the domain that has the least frequent replication schedules. If these domain controllers exist, use the Repadmin.exe command-line tool to immediately disable inbound replication. To do it, follow these steps:

    1. Select **Start**, and then select **Run**.
    2. Type _cmd_ in the **Open** box, and then select **OK**.
    3. Type `repadmin /options <recovery dc name> +DISABLE_INBOUND_REPL` at the command prompt, and then press ENTER.

    > [!NOTE]
    > If you cannot issue the Repadmin command immediately, remove all network connectivity from the domain controller until you can use Repadmin to disable inbound replication, and then immediately return network connectivity.

   This domain controller will be referred to as the recovery domain controller.

2. Avoid making additions, deletions, and changes to the following items until all the recovery steps have been completed. Changes include password resets by domain users, help desk administrators, and administrators in the domain where the deletion occurred, in addition to group membership changes in the deleted users' groups.

    1. User accounts and attributes on user accounts
    2. Computer accounts and attributes on computer accounts
    3. Service accounts
    4. Security groups

        > [!NOTE]
        > Especially avoid changes to group membership for users, computers, groups, and service accounts in the forest where the deletion occurred.

    5. Notify all the forest administrators, the delegated administrators, and the help desk administrators in the forest of the temporary stand-down. This stand-down is required in method 2 because you're authoritatively restoring all the deleted users' security groups. Therefore, any changes that are made to groups after the date of system state backup are lost.

3. Create a new system state backup in the domain where the deletion occurred. You can use this backup if you have to roll back your changes.

    > [!NOTE]
    > If your system state backups are current up to the time that the deletion occurred, skip this step and go to step 4.

    If you identified a recovery domain controller in step 1, back up its system state now.

    If all the global catalogs that are located in the domain where the deletion occurred replicated the deletion, back up the system state of a global catalog in the domain where the deletion occurred.

    When you create a backup, you can return the recovery domain controller back to its current state. And perform your recovery plan again if your first try isn't successful.

4. If you can't find a latent global catalog domain controller in the domain where the user deletion occurred, find the most recent system state backup of a global catalog domain controller in that domain. This system state backup should contain the deleted objects. Use this domain controller as the recovery domain controller.

    Only databases of the global catalog domain controllers in the user's domain contain group membership information for external domains in the forest. If there's no system state backup of a global catalog domain controller in the domain where users were deleted, you can't use the `memberOf` attribute on restored user accounts to determine global or universal group membership, or to recover membership in external domains. Go to the next step. If there is an external record of group membership in external domains, add the restored users to security groups in those domains after the user accounts have been restored.

5. If you know the password for the offline administrator account, start the recovery domain controller in Disrepair mode. If you don't know the password for the offline administrator account, reset the password while the recovery domain controller is still in normal Active Directory mode.

    You can use the setpwd command-line tool to reset the password on domain controllers that are running Windows 2000 SP2 and later while they are in online Active Directory mode.

    > [!NOTE]
    > Microsoft no longer supports Windows 2000.

    Administrators of Windows Server 2003 and later domain controllers can use the `set dsrm password` command in the Ntdsutil command-line tool to reset the password for the offline administrator account.

    For more information about how to reset the Directory Services Restore Mode administrator account, see [How To Reset the Directory Services Restore Mode Administrator Account Password in Windows Server](https://support.microsoft.com/help/322672).

6. Press F8 during the startup process to start the recovery domain controller in Disrepair mode. Log on to the console of the recovery domain controller with the offline administrator account. If you reset the password in step 5, use the new password.

    If the recovery domain controller is a latent global catalog domain controller, don't restore the system state. Go directly to step 7.

    If you're creating the recovery domain controller by using a system state backup, restore the most current system state backup that was made on the recovery domain controller that contains the deleted objects now.

7. Auth restore the deleted user accounts, the deleted computer accounts, or the deleted security groups.

    > [!NOTE]
    > The terms _auth restore_ and _authoritative restore_ refer to the process of using the authoritative restore command in the Ntdsutil command-line tool to increment the version numbers of specific objects or of specific containers and all their subordinate objects. As soon as end-to-end replication occurs, the targeted objects in the recovery domain controller's local copy of Active Directory become authoritative on all the domain controllers that share that partition. An authoritative restoration is different from a system state restoration. A system state restoration populates the restored domain controller's local copy of Active Directory with the versions of the objects at the time that the system state backup was made.

    Authoritative restorations are performed with the Ntdsutil command-line tool by referencing the domain name (dn) path of the deleted users, or of the containers that host the deleted users.

    When you auth restore, use domain name paths that are as low in the domain tree as they have to be. The purpose is to avoid reverting objects that aren't related to the deletion. These objects may include objects that were modified after the system state backup was made.

    Auth restore deleted users in the following order:

    1. Auth restore the domain name (dn) path for each deleted user account, computer account, or deleted security group.

        Authoritative restorations of specific objects take longer but are less destructive than authoritative restorations of a whole subtree. Auth restore the lowest common parent container that holds the deleted objects.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore object <object DN path>" q q
        ```

        For example, to authoritatively restore the deleted user John Doe in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=JohnDoe,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        To authoritatively restore the deleted security group **ContosoPrintAccess** in the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore object cn=ContosoPrintAccess,ou=Mayberry,dc=contoso,dc=com" q q
        ```

        > [!IMPORTANT]
        > The use of quotes is required.

        By using this Ntdsutil format, you can also automate the authoritative restoration of many objects in a batch file or a script.

        > [!NOTE]
        > This syntax is available only in Windows Server 2003 and later. The only syntax in Windows 2000 is to use: `ntdsutil "authoritative restore" "restore subtree object DN path"`.

    2. Auth restore only the OU or Common-Name (CN) containers that host the deleted user accounts or groups.

        Authoritative restorations of a whole subtree are valid when the OU targeted by the Ntdsutil Authoritative restore command contains most of the objects that you're trying to authoritatively restore. Ideally, the targeted OU contains all the objects that you're trying to authoritatively restore.

        An authoritative restore on an OU subtree restores all the attributes and objects that reside in the container. Any changes that were made up to the time that a system state backup is restored are rolled back to their values at the time of the backup. With user accounts, computer accounts, and security groups, this rollback may mean the loss of the most recent changes to passwords, to the home directory, to the profile path, to location and to contact info, to group membership, and to any security descriptors that are defined on those objects and attributes.

        Ntdsutil uses the following syntax:

        ```console
        ntdsutil "authoritative restore" "restore subtree <container DN path>" q q
        ```

        For example, to authoritatively restore the **Mayberry** OU of the `Contoso.com` domain, use the following command:

        ```console
        ntdsutil "authoritative restore" "restore subtree ou=Mayberry,dc=contoso,dc=com" q q
        ```

        > [!NOTE]
        > Repeat this step for each peer OU that hosts deleted users or groups.

        > [!IMPORTANT]
        > When you restore a subordinate object of an OU, all the parent containers of the deleted subordinate objects must be explicitly auth restored.

8. Restart the recovery domain controller in normal Active Directory mode.
9. Outbound-replicate the authoritatively restored objects from the recovery domain controller to the domain controllers in the domain and in the forest.

    While inbound replication to the recovery domain controller remains disabled, type the following command to push the authoritatively restored objects to all the cross-site replica domain controllers in the domain and to global catalogs in the forest:

    ```console
    repadmin /syncall /d /e /P <recovery dc> <Naming Context>
    ```

    After all the direct and transitive domain controllers in the forest's domain and global catalog servers have replicated in the authoritatively restored users and any restored containers, go to step 11.

    If all the following statements are true, group membership links are rebuilt with the restoration of the deleted user accounts. Go to step 13.

    - Your forest is running at the Windows Server 2003 and later forest functional level, or at the Windows Server 2003 and later interim forest functional level.
    - Only security groups were not deleted.
    - All the deleted users were added to all the security groups in all the domains in the forest.

    Consider using the `Repadmin` command to accelerate the outbound replication of users from the restored domain controller.

    If groups were also deleted, or if you can't guarantee that all the deleted users were added to all the security groups after the transition to the Windows Server 2003 and later interim or forest functional level, go to step 12.

10. Repeat steps 7, 8, and 9 without restoring the system state, and then go to step 11.
11. If deleted users were added to local groups in external domains, take one of the following actions:

    - Manually add the deleted users back to those groups.
    - Restore the system state and auth restore each of the local security groups that contains the deleted users.

12. Verify group membership in the recovery domain controller's domain, and in global catalogs in other domains.
13. Use the following command to enable inbound replication to the recovery domain controller:

    ```console
    repadmin /options recovery dc name -DISABLE_INBOUND_REPL
    ```

14. Make a new system state backup of domain controllers in the recovery domain controller's domain and global catalogs in other domains in the forest.
15. Notify all the forest administrators, the delegated administrators, the help desk administrators in the forest, and the users in the domain that the user restore is complete.

    Help desk administrators may have to reset the passwords of auth restored user accounts and computer accounts whose domain password changed after the restored system was made.

    Users who changed their passwords after the system state backup was made will find that their most recent password no longer works. Have such users try to log on by using their previous passwords if they know them. Otherwise, help desk administrators must reset the password with the **user must change password at next logon** check box checked. Do it preferably on a domain controller in the same Active Directory site as the user is located in.

## How to recover deleted users on a domain controller when you do not have a valid system state backup

If you lack current system state backups in a domain where user accounts or security groups were deleted, and the deletion occurred in domains that contain Windows Server 2003 and later domain controllers, follow these steps to manually reanimate deleted objects from the deleted objects container:

1. Follow the steps in the following section to reanimate deleted users, computers, groups, or all of them:  
   [How to manually undelete objects in a deleted objects container](#how-to-manually-undelete-objects-in-a-deleted-objects-container)
1. Use Active Directory Users and Computers to change the account from disabled to enabled. (The account appears in the original OU.)
1. Use the bulk reset features in the Windows Server 2003 and later version of Active Directory Users and Computers to perform bulk resets on the **password must change at next logon policy** setting, on the home directory, on the profile path, and on group membership for the deleted account as required. You can also use a programmatic equivalent of these features.
1. If Microsoft Exchange 2000 or later was used, repair the Exchange mailbox for the deleted user.
1. If Exchange 2000 or later was used, reassociate the deleted user with the Exchange mailbox.
1. Verify that the recovered user can log on and access local directories, shared directories, and files.

You can automate some or all of these recovery steps by using the following methods:

- Write a script that automates the manual recovery steps that are listed in step 1. When you write such a script, consider scoping the deleted object by date, time, and last known parent container, and then automating the reanimation of the deleted object. To automate the reanimation, change the `isDeleted` attribute from **TRUE** to **FALSE**, and change the relative distinguished name to the value that is defined either in the `lastKnownParent` attribute or in a new OU or common name (CN) container that is specified by the administrator. (The relative distinguished name is also known as the RDN.)
- Obtain a non-Microsoft program that supports the reanimation of deleted objects on Windows Server 2003 and later domain controllers. One such utility is AdRestore. AdRestore uses the Windows Server 2003 and later undelete primitives to undelete objects individually. Aelita Software Corporation and Commvault Systems also offer products that support undelete functionality on Windows Server 2003 and later-based domain controllers.

To obtain AdRestore, see [AdRestore v1.1](/sysinternals/downloads/adrestore).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.

## How to manually undelete objects in a deleted object's container

To manually undelete objects in a deleted object's container, follow these steps:

1. Select **Start**, select **Run**, and then type _ldp.exe_.

    ldp.exe is available:

    - On computers where the Domain Controller role has been installed.
    - On computers where Remote Server Administration Tools (RSAT) has been installed.

2. Use the **Connection** menu in Ldp to perform the connect operations and the bind operations to a Windows Server 2003 and later domain controller.

    Specify domain administrator credentials during the bind operation.

3. On the **Options** menu, select **Controls**.
4. In the **Load Predefined** list, select **Return Deleted Objects**.

    > [!NOTE]
    > The 1.2.840.113556.1.4.417 control moves to the **Active Controls** window.

5. Under **Control Type**, select **Server**, and the select **OK**.
6. On the **View** menu, select **Tree**, type the distinguished name path of the deleted objects container in the domain where the deletion occurred, and then select **OK**.

    > [!NOTE]
    > The distinguished name path is also known as the DN path. For example, if the deletion occurred in the `contoso.com` domain, the DN path would be the following path:  
    > cn=deleted Objects,dc=contoso,dc=com

7. In the left pane of the window, double-click the **Deleted Object Container**.

    > [!NOTE]
    > As a search result of Idap query, only 1000 objects are returned by default. Fot example, if more than 1000 objects exist in the Deleted Objects container, not all objects appear in this container. If your target object doesn't appear, use **ntdsutil**, and then set the maximum number by using **maxpagesize** to get the search results .

8. Double-click the object that you want to undelete or reanimate.
9. Right-click the object that you want to reanimate, and then select **Modify**.

    Change the value for the `isDeleted` attribute and the DN path in a single Lightweight Directory Access Protocol (LDAP) modify operation. To configure the **Modify** dialog, follow these steps:

    1. In the **Edit Entry Attribute** box, type _isDeleted_. Leave the **Value** box blank.
    2. Select the **Delete** option button, and then select **Enter** to make the first of two entries in the **Entry List** dialog.

        > [!IMPORTANT]
        > Don't select **Run**.

    3. In the **Attribute** box, type _distinguishedName_.
    4. In the **Values** box, type the new DN path of the reanimated object.

        For example, to reanimate the _JohnDoe_ user account to the Mayberry OU, use the following DN path: cn= **JohnDoe**,ou= **Mayberry**,dc= **contoso**,dc= **com**

        > [!NOTE]
        > If you want to reanimate a deleted object to its original container, append the value of the deleted object's lastKnownParent attribute to its CN value, and then paste the full DN path in the **Values** box.

    5. In the **Operation** box, select **REPLACE**.
    6. Select **ENTER**.
    7. Select the **Synchronous** check box.
    8. Select the **Extended** check box.
    9. Select **RUN**.

10. After you reanimate the objects, select **Controls** on the **Options** menu, select the **Check Out** button to remove (1.2.840.113556.1.4.417) from the **Active Controls** box list.
11. Reset user account passwords, profiles, home directories, and group memberships for the deleted users.

    When the object was deleted, all the attribute values except `SID`, `ObjectGUID`, `LastKnownParent`, and `SAMAccountName` were stripped.

12. Enable the reanimated account in Active Directory Users and Computers.

    > [!NOTE]
    > The reanimated object has the same primary SID as it had before the deletion, but the object must be added again to the same security groups to have the same level of access to resources. The first release of Windows Server 2003 and later doesn't preserve the `sIDHistory` attribute on reanimated user accounts, computer accounts, and security groups. Windows Server 2003 and later with Service Pack 1 does preserve the `sIDHistory` attribute on deleted objects.

13. Remove Microsoft Exchange attributes and reconnect the user to the Exchange mailbox.

    > [!NOTE]
    > The reanimation of deleted objects is supported when the deletion occurs on a Windows Server 2003 and later domain controller. The reanimation of deleted objects isn't supported when the deletion occurs on a Windows 2000 domain controller that is subsequently upgraded to Windows Server 2003 and later.

    > [!NOTE]
    > If the deletion occurs on a Windows 2000 domain controller in the domain, the `lastParentOf` attribute isn't populated on Windows Server 2003 and later domain controllers.

## How to determine when and where a deletion occurred

When users are deleted because of a bulk deletion, you may want to learn where the deletion originated. To do so, follow these steps:

1. To locate deleted security principals, follow steps 1 to 7 in the [How to manually undelete objects in a deleted object's container](#how-to-manually-undelete-objects-in-a-deleted-objects-container) section. If a tree was deleted, follow these steps to locate a parent container of the deleted object.
2. Copy the value of the `objectGUID` attribute to the Windows clipboard.
You can paste this value when you enter the `Repadmin` command in step 4.
3. At the command line, run the following command:

    ```console
    repadmin /showmeta GUID=<objectGUID> <FQDN>
    ```

    For example, if the `objectGUID` of the deleted object or container is 791273b2-eba7-4285-a117-aa804ea76e95 and the fully qualified domain name (FQDN) is `dc.contoso.com`, run the following command:

    ```console
    repadmin /showmeta GUID=791273b2-eba7-4285-a117-aa804ea76e95 dc.contoso.com
    ```

    The syntax of this command must include the GUID of the deleted object or container and the FQDN of the server that you want to source from.

4. In the `Repadmin` command output, find the originating date, time, and domain controller for the `isDeleted` attribute. For example, information for the `isDeleted` attribute appears in the fifth line of the following sample output:

    |Loc.USN|Originating DC|Org.USN|Org.Time/Date|Ver|Attribute|
    |---|---|---|---|---|---|
    |134759|Default-First-Site-Name\NA-DC1|134759|DateTime|1|objectClass|
    |134760|Default-First-Site-Name\NA-DC1|134760|DateTime|2|ou|
    |134759|Default-First-Site-Name\NA-DC1|134759|DateTime|1|instanceType|
    |134759|Default-First-Site-Name\NA-DC1|134759|DateTime|1|whenCreated|
    |134760|Default-First-Site-Name\NA-DC1|134760|DateTime|1|isDeleted|
    |134759|Default-First-Site-Name\NA-DC1|134759|DateTime|1|nTSecurityDescriptor|
    |134760|Default-First-Site-Name\NA-DC1|134760|DateTime|2|name|
    |134760|Default-First-Site-Name\NA-DC1|134760|DateTime|1|lastKnownParent|
    |134760|Default-First-Site-Name\NA-DC1|134760|DateTime|2|objectCategory|

5. If the name of the originating domain controller appears as a 32-character alpha-numeric GUID, use the Ping command to resolve the GUID to the IP address and the name of the domain controller that originated the deletion. The Ping command uses the following syntax:

    ```console
    ping -a <originating DC GUID>._msdomain controllers.<fully qualified path for forest root domain>
    ```
  
    > [!NOTE]
    > The **-a** option is case sensitive. Use the fully qualified domain name of the forest root domain regardless of the domain that the originating domain controller resides in.

    For example, if the originating domain controller resided in any domain in the `Contoso.com` forest and had a GUID of 644eb7e7-1566-4f29-a778-4b487637564b, run the following command:

    ```console
    ping -a 644eb7e7-1566-4f29-a778-4b487637564b._msdomain controllers.contoso.com
    ```

    The output returned by this command is similar to the following one:

    ```console
    Pinging na-dc1.contoso.com [65.53.65.101] with 32 bytes of data:

    Reply from 65.53.65.101: bytes=32 time<1ms TTL=128
    Reply from 65.53.65.101: bytes=32 time<1ms TTL=128
    Reply from 65.53.65.101: bytes=32 time<1ms TTL=128
    Reply from 65.53.65.101: bytes=32 time<1ms TTL=128
    ```

## How to minimize the impact of bulk deletions in the future

The keys to minimize the impact of the bulk deletion of users, computers, and security groups are:

- Make sure that you have up-to-date system state backups.
- Tightly control access to privileged user accounts.
- Tightly control what those accounts can do.
- Practice recovery from bulk deletions.

System state changes occur every day. These changes may include:

- Password resets on user accounts and computer accounts
- Group membership changes
- Other attribute changes on user accounts, computer accounts, and security groups.

If your hardware or software fails, or your site experiences another disaster, you'll want to restore the backups that were made after each significant set of changes in each Active Directory domain and site in the forest. If you don't maintain current backups, you may lose data, or may have to roll back restored objects.

Microsoft recommends that you take the following steps to prevent bulk deletions:

1. Don't share the password for the built-in administrator accounts, or permit common administrative user accounts to be shared. If the password for the built-in administrator account is known, change the password, and define an internal process that discourages its use. Audit events for shared user accounts make it impossible to determine the identity of the user who is making changes in Active Directory. Therefore, the use of shared user accounts must be discouraged.
2. It's rare that user accounts, computer accounts, and security groups are intentionally deleted. It's especially true of tree deletions. Disassociate the ability of service and delegated administrators to delete these objects from the ability to create and manage user accounts, computer accounts, security groups, OU containers, and their attributes. Grant only the most privileged user accounts or security groups the right to perform tree deletes. These privileged user accounts may include enterprise administrators.
3. Grant delegated administrators access only to the class of object that those administrators are permitted to manage. For example, a help desk administrator's primary job is to modify properties on user accounts. He doesn't have permissions to create and delete computer accounts, security groups, or OU containers. This restriction also applies to delete permissions for the administrators of other specific object classes.
4. Experiment with audit settings to track delete operations in a lab domain. After you're comfortable with the results, apply your best solution to the production domain.
5. Wholesale access-control and audit changes on containers that host tens of thousands of objects can make the Active Directory database grow significantly, especially in Windows 2000 domains. Use a test domain that mirrors the production domain to evaluate potential changes to free disk space. Check the hard disk drive volumes that host the Ntds.dit files and the log files of domain controllers in the production domain for free disk space. Avoid setting access-control and audit changes on the domain network controller head. Making these changes would needlessly apply to all the objects of all the classes in all the containers in the partition. For example, avoid making changes to Domain Name System (DNS) and distributed link tracking (DLT) record registration in the CN=SYSTEM folder of the domain partition.
6. Use the best-practice OU structure to separate user accounts, computer accounts, security groups, and service accounts, in their own organizational unit. When you use this structure, you can apply discretionary access control lists (DACLs) to objects of a single class for delegated administration. And you make it possible for objects to be restored according to object class if they have to be restored. The best-practice OU structure is discussed in the **Creating an Organizational Unit Design** section of the following article:  
[Best Practice Active Directory Design for Managing Windows Networks](/previous-versions/windows/it-pro/windows-2000-server/bb727085(v=technet.10))
7. Test bulk deletions in a lab environment that mirrors your production domain. Choose the recovery method that makes sense to you, and then customize it to your organization. You may want to identify:

    - The names of the domain controllers in each domain that is regularly backed up
    - Where backup images are stored  
      Ideally, these images are stored on an extra hard disk that's local to a global catalog in each domain in the forest.
    - Which members of the help desk organization to contact
    - The best way to make that contact

8. Most of the bulk deletions of user accounts, of computer accounts, and of security groups that Microsoft sees are accidental. Discuss this scenario with your IT staff, and develop an internal action plan. Focus on early detection. And return functionality to your domain users and business as quickly as possible. You can also take steps to prevent accidental bulk deletions from occurring by editing the access control lists (ACLs) of organizational units.

    For more information about how to use Windows interface tools to prevent accidental bulk deletions, see [Guarding Against Accidental Bulk Deletions in Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc773347(v=ws.10)).

    For more information about how to prevent accidental bulk deletions by using Dsacls.exe or a script, see the following article:

    [Script to Protect Organizational Units (OUs) from Accidental Deletion](https://gallery.technet.microsoft.com/ScriptCenter/c307540f-bd91-485f-b27e-995ae5cea1e2).

## Tools and scripts that may help you recover from bulk deletions

The Groupadd.exe command-line utility reads the `memberOf` attribute on a collection of users in an OU and builds a .ldf file that adds each restored user account to the security groups in each domain in the forest.

Groupadd.exe automatically discovers the domains and security groups that deleted users were members of and adds them back to those groups. This process is explained in more detail in step 11 of method 1.

Groupadd.exe runs on Windows Server 2003 and later domain controllers.

Groupadd.exe uses the following syntax:

```console
groupadd / after_restore ldf_file [/ before_restore ldf_file ]
```

Here, `ldf_file` represents the name of the .ldf file to be used with the previous argument, `after_restore` represents the user file data source, and `before_restore` represents the user data from the production environment. (The user file data source is the good user data.)

To obtain Groupadd.exe, contact Microsoft Product Support Services.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

## References

For more information on how to use the AD Recycle Bin feature included in Windows Server 2008 R2, see [Active Directory Recycle Bin Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10)).
