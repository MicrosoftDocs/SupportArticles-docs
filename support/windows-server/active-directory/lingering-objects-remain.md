---
title: Lingering objects still remain
description: Describes procedures for cleaning up objects that are reintroduced to AD after you bring an offline DC back online.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Lingering objects may remain after you bring an out-of-date global catalog server back online

This article describes procedures for cleaning up objects that are reintroduced to AD after you bring an offline DC back online.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 314282

## Symptoms

You bring a domain controller (DC) or global catalog server online after it has been offline for a long time. After it comes online, you observer one or more of the following issues:

- E-mail messages are not delivered to a user whose user object was moved between domains. After you bring the outdated DC or global catalog server back online, both instances of the user object appear in the global catalog. Both objects have the same e-mail address, so e-mail messages cannot be delivered.
- A user account that no longer exists still appears in the global address list.
- A universal group that no longer exists still appears in a user's access token.
- Other DCs or global catalog servers log events such as EventID 1084, **There is no such object on the server**. Further replication is blocked on the affected DCs or global catalog servers.

## Cause

These problems may occur if the DC or global catalog server has been offline for longer than the value of the **Tombstone-Lifetime** attribute of user objects.

For more information about the **Tombstone-Lifetime** attribute, see [Tombstone-Lifetime attribute](/windows/desktop/adschema/a-tombstonelifetime#windows-server-2012).

The **Tombstone-Lifetime** attribute defines the number of days before a deleted object is removed from the directory services. This assists in removing objects from replicated servers and preventing restores from reintroducing a deleted object. The default value is 180 days. After that time, Active Directory no longer needs to remember the change.

If a DC or a global catalog server is offline for longer than the value of the **Tombstone-Lifetime** attribute, its copy of Active Directory (or the global catalog) may contain objects that have been deleted on the other DCs. However, the other DCs no longer remember that the objects have been deleted. When you bring the offline DC online, it synchronizes its copy of Active Directory  with the rest of the domain. Because the information about the deletions has been discarded, the DC replicates the affected objects (referred to as lingering objects) back to the rest of the domain.

In general, AD DS uses a [loose-consistency replication model](/windows/desktop/ad/features-of-the-replication-model-for-active-directory-domain-services), in which some naming contexts (also known as directory partitions) are read/write and others are read-only. When a DC that receives a replicated object that belongs to a read/write naming context and that object does not already exist in the local copy of the Directory Information Tree (DIT), the DC creates the object. As the replication process continues, the object reappears on all DCs in the domain.

DCs and global catalog servers can also use a strict replication consistency model. Under this model, when the DC receives a replicated object that does not already exist in the local DIT, the DC stops receiving or sending replicated data and logs events such as Event ID 1084, "There is no such object on the server." For more information about strict replication consistency, including the circumstances under which DCs may use this model by default, see [KB 910205, Information about lingering objects in a Windows Server Active Directory forest](https://support.microsoft.com/help/910205/information-about-lingering-objects-in-a-windows-server-active-directo).
For more information about tombstone issues, see [KB216993 Useful shelf life of a system-state backup of Active Directory](https://support.microsoft.com/help/216993).

## Resolution 1: Determine whether Active Directory has lingering objects, and avoid future lingering objects

[KB 910205](https://support.microsoft.com/help/910205), explains several ways in which to determine whether your Active Directory system has accumulated lingering objects. KB 910205 also describes steps you can take to prevent lingering objects from accumulating.

## Resolution 2: Delete lingering objects

If the object should not exist in Active Directory at all (for example, if the object was reintroduced by an outdated domain controller), you can delete the objects with the standard tools (such as ADSIEdit or the Active Directory Users and Computers snap-in).

It is easy to remove lingering objects for read/write naming contexts. In Windows Server 2003 and later versions, you can remove lingering objects by using the command `repadmin /removelingeringobjects`. For information about how to use RepAdmin, see [Active Directory Replication Event ID 1388 or 1988: A lingering object is detected](https://support.microsoft.com/help/4469619).

This article describes how to remove lingering objects that have already appeared in read-only naming contexts such as directory partitions on global catalog servers or Read-Only Domain Controllers (RODCs). The functionality discussed in the [More information](#more-information) section still exists in newer operating systems and might still be useful to troubleshoot unexpected RepAdmin behavior.

## More information

This procedure requires the **objectGUID** of a DC that has a read/write copy of the object, and the **objectGUID** of the object itself. If you must remove more than one object, determine whether any of the objects are in a parent/child relationship (you can determine this from the objects' distinguished names). If this is the case, order the deletions so that all of the child objects are deleted before their parent objects.

This procedure has three mains steps, which you have to perform on a computer that has access to the forest (and you have to use a user account that has administrative permissions on the forest):

1. Obtain the distinguished name and ObjectGUID of the lingering object.
2. Identify a DC in the object domain.
3. Delete the lingering objects. Select one of the following methods:
   - Delete a few lingering objects.
   - Delete a large number of lingering objects.

> [!IMPORTANT]
> Each global catalog server on which you intend to run the delete operations (step 3) must have network connectivity to the domain controller that you identified (step 2).

For troubleshooting information, see the following sections:

- Error message when running Walkservers.cmd to modify many lingering objects in the environment.
- Error message 87 when removing lingering objects in the environment.

### Obtain the distinguished name and ObjectGUID of the lingering object

The best way to identify the domain in which an object is located (and from that to determine the name of a DC that has a read/write copy of the object) is to retrieve the distinguished name of the object. You can search for the name (or parts of the name) of the object by using the Ldp.exe tool. To do this, follow these steps:

1. Start Ldp.exe.

    In most versions of Windows, select **Start** > **Run** and enter **ldp.exe**. In older versions of Windows (such as Windows Server 2003 SP1) this tool is available as one of the Support Tools.

2. Select **Connection** > **Connect**. In the **Server** box, type the name of a global catalog server. In the **Port** box, type **3268**, and then select **OK**.

3. Select **Connection** > **Bind**. Type valid credentials if your current credentials are not sufficient to query all of the global catalog contents. Select **OK**.

4. Select **View** > **Tree**. Enter the distinguished name of the forest root and then select **OK**.

5. In the tree list, right-click the forest root and then select **Search**.

6. In the **Filter** box, type a filter that uses the **\<attribute> = \<value>** format.

    In the filter text, **\<attribute>** represents the object attribute to be searched, and **\<value>** represents the criteria for which you are searching. You can use ***** as a wildcard character in the value, and you can use an expression.

    For information about Lightweight Directory Access Protocol (LDAP) filter syntax, see [Search Filter Syntax](/windows/desktop/ADSI/search-filter-syntax).

    For example, to find objects for which the **sAMAccountName** attribute has a value of **testuser**, type *(sAMAccountName = testuser)* in the **Filter** box. To search for a user object, the following attributes are most useful:

    - **cn**  
    - **userPrincipalName**  
    - **sAMAccountName**  
    - **name**  
    - **mail**  
    - **sn**

    To search for a group object, the following attributes are most useful:

    - **cn**  
    - **sAMAccountName**  
    - **name**

7. Under **Scope**, select **Subtree**.

8. Select the **Attributes** box and then select the end of the attribute string. Type *;objectGUID* at the end of the string.

    :::image type="content" source="media/lingering-objects-remain/type-value-in-attributes-box.png" alt-text="Screenshot of the Search window with ;objectGUID typed at the end of the string in the Attribute box.":::

    In some versions of Ldp, you have to select **Options** to see the **Attributes** box.

9. To run the query, select **Run**.

    The results appear in the main Ldp window.

10. Determine which, if any, of the objects that are listed in the results should be removed from the global catalog. One indication that you have found a bad object is that the object does not exist on a read/write copy of the naming context.

11. If the objects that you are looking for are not included in the query results, rephrase the filter and run the search again.

12. If you have identified a lingering object, note the values of its **DN** and **objectGUID** attributes. You will need those values later.

### Identify a DC in the object domain

The value of the object's **DN** attribute includes the domain of the object. When you know the domain, you can identify a DC or global catalog server within the domain. To do this, follow these steps.

1. Check the **dc=** portions of the **DN** value. Combine the **dc=** portions to obtain the domain name.

    For example, if an object has the **DN** value of **cn=FirstName LastName,cn=Users,dc=name1,dc=name2,dc=com**, the object is in the `name1.name2.com` domain.

2. To locate a DC (or a global catalog server) in this domain, open Active Directory Users and Computers, open the domain container, and then open the Domain Controllers container.

3. Open an elevated Command Prompt window and enter `repadmin /showreps dc-name`.

    > [!NOTE]
    > In this command, **dc-name** represents the computer name of the DC that you identified in step 2.
    >
    > In older versions of Windows (such as Windows Server 2003 SP1), RepAdmin is available as one of the Support Tools.

    Repadmin produces results that resemble the following:

    > Default-First-Site-Name\WS2016-DC-01 DSA Options: IS_GC Site Options: (none) DSA object GUID: \<GUID> DSA invocationID: \<invocationID>

4. Note the value of the **DSA object GUID**. This is the **objectGUID** value of the DC.

### Delete lingering objects

Use the following methods to delete lingering objects.

#### Delete a few lingering objects from a few global catalog servers

If you have only a few objects and global catalogs, follow these steps to delete the objects by using Ldp.exe:

1. Use Enterprise Administrator credentials to sign in to each global catalog server that contains a copy of the lingering object.

2. Start Ldp.exe and connect to port 389 on the local domain controller (leave the **Server** box empty).

3. Select **Connection** > **Bind**. Leave all of the boxes empty (you are already signed in as an Enterprise Administrator).

4. Select **Browse** > **Modify**.

    :::image type="content" source="media/lingering-objects-remain/modify-dialog-configure-entries.png" alt-text="Screenshot of the Modify window with some entries can be configured.":::

5. Configure the following entries in the **Modify** dialog box:

    1. Leave the **Dn** box empty.
    2. In the **Attribute** box, type **RemoveLingeringObject**.
    3. In the **Values** box, type a value that uses the following format:

        \<GUID=dcGUID>: \<GUID=objectGUID>  

        In this value, **dcGUID** represents the GUID of the DC that you identified in step 2 of this section, and **objectGUID** represents the GUID of the lingering object that you identified in step 1 of this section.

        The value should resemble the following:

        \<GUID=*\<GUID>*>: \<GUID=*\<GUID>*>

        > [!IMPORTANT]
        > In the value, do not omit the spaces before and after the colon.

    4. Select **Operation** > **Replace**, and then select **Enter**.

        The **Entry List** box shows the full command.

    5. Select **Run**.

        The results appear in the main Ldp window, and should resemble the following.

        > ***Call Modify... ldap_modify_s(ld, '(null)',[1] attrs); Modified "".

#### Delete a large number of lingering objects from several global catalog servers

If you have to delete a large number of lingering objects, you can delete more efficiently by using scripts than by deleting them manually. To build such scripts, use the following steps:

1. Create a new folder, and in that folder create new files that have the following names:
   - Walkservers.cmd
   - Walkobjects.cmd
   - Modifyrootdse.vbs
   - Server-list.txt
   - Object-list.txt file

2. Paste the following text into Walkservers.cmd:

    ```console
    for /f %%j in (server-list.txt) do walkobjects %%j
    ```

3. Paste the following text into Walkobjects.cmd:

    ```console
    for /f "delims=@" %%i in (object-list.txt) do cscript //NoLogo MODIFYROOTDSE.VBS %1 "%%i" >>update-%1.log
    ```

4. Paste the following text into Modifyrootdse.vbs:

    ```vbs
    '********************************************************************
    '*
    '* File: MODIFYROOTDSE.VBS
    '* Created: January 2002
    '* Version: 1.0
    '*
    '* Main Function: Writes Active Directory information to clean up
    '* objects as per: Q314282.
    '* Usage: Modifyrootdse.vbs <TargetServer> <GUID PAIR>
    '* Parameter are fed into the script using a pair of batch files.
    '*
    '* Copyright (C) 2002 Microsoft Corporation '*
    '********************************************************************
    OPTION EXPLICIT
    ON ERROR RESUME NEXT

    Dim objDomain
    Dim ObjValue, strServerName, adsLdapPath
    Dim i

    'Get the command-line arguments

    if Wscript.arguments.count <> 2 Then
        Print "Invalid Number of Parameters. Use with WalkServers.CMD and WalkObjects.CMD"
        WScript.quit
    End If

    strServerName = Wscript.arguments.item(0)
    ObjValue = Wscript.arguments.item(1)

    adsLdapPath = "LDAP://" & strServerName & "/RootDSE"

    Set objDomain = GetObject(adsLdapPath)
        If Err.Number <> 0 Then
        WScript.Echo "Error opening ROOTDSE. Error number is: " & Err.Number & ". Error description is: " & Err.Description & "."
        Set objDomain = Nothing
        WScript.quit
    End If

    objDomain.Put "RemoveLingeringObject", ObjValue
    objDomain.Setinfo

    If Err.Number = 0 Then
        WScript.Echo "Object " & ObjValue & " was removed."
    Else
        WScript.Echo "Object " & ObjValue & " could not be removed. Error number is: " & Err.Number & ". Error description is: " & Err.Description & "."
    End If

    WScript.Quit
    ```

    > [!NOTE]
    > If you start Modifyrootdse.vbs manually, make sure to enclose in quotation marks any parameters that contain spaces.

5. Create a list of all of the fully qualified domain names of the global catalog servers and DCs that contain the lingering objects, and then paste the list into Server-list.txt. Use the fully qualified domain names to avoid DNS suffix searches.

6. For each lingering object, identify a DC in the object domain that does not have a copy of the lingering object. Usually this is a DC that has a read/write naming context in which you manually deleted the lingering object. As described elsewhere in this article, use RepAdmin to obtain the **objectGUID** value of each DC.

7. In Object-list.txt, create a list of GUID pairs, using the following format:

    **<GUID=dcGUID>: <GUID=objectGUID>**  

    > [!NOTE]
    > In this value, **dcGUID**  represents the GUID of the DC that does not have a copy of the lingering object, and **objectGUID** represents the GUID of the lingering object.

    Each pair should resemble the following:

    **\<GUID=*\<GUID>*>: \<GUID=*\<GUID>*>**  

    > [!IMPORTANT]
    > In the value, do not omit the spaces before and after the colon.

8. Run the Walk-servers.cmd file.

For each DC or global catalog server that is listed in Server-list.txt, the scripts generate a log file that is named Update-server-name.log. Each log file contains a line for each object that is to be deleted.

Because the lingering objects may not exist on every listed server, errors in the log files do not necessarily indicate a problem. However, error messages of the form *operation refused* or *operation error* indicate that there is a problem with the GUIDs or with the syntax of the value. If these errors occur, verify the following:

- Make sure that the DC GUIDs are the correct GUIDs for domain controllers that contain a read/write naming context of the domain that contains the object.

- Make sure that the object GUIDs identify lingering objects in read-only naming contexts (global catalog servers or RODCs).

#### Error when running Walkservers.cmd to modify many lingering objects in the environment

> Object \<GUID=*\<GUID>*> : \<GUID=*\<GUID>*> could not be removed. Error number is: -2147016672. Error description is: .

##### Cause for this error

This error occurs when the script runs against the GUID of a DC that does not contain a read/write naming context that corresponds to the naming context that contains the lingering object. Verify the location of lingering object by the Ldp.exe tool.

##### Example

In the following example, the lingering object to be removed is located in the corp.company.local domain. However, the <GUID=*\<GUID>*> entry in the Objects-list.txt file is associated with a DC that resides in the company.local domain. This DC does not have a read/write naming context for the corp.company.local domain.

The following search produces multiple objects that represent the same user (Joe), and lists their **objectGUID** values.

> ldap_search_s(ld, "DC=company,DC=local", 2, "(cn=User*)", attrList, 0, &msg) Result <0>: (null)  
Matched DNs:  
Getting 4 entries:  
\>> Dn: CN=User\, Joe,OU=Exec,OU=Corporate Users,DC=corp,DC=company,DC=local  
1> canonicalName: corp.company.local/Corporate Users/Exec/User, Joe;  
1> cn: User, Joe; 1> description: CEO;  
1> displayName: User, Joe; 1> distinguishedName: CN=User\, Joe,OU=Exec,OU=Corporate Users,DC=corp,DC=company,DC=local;   4> objectClass: top; person; organizationalPerson; user;  
1> objectGUID: *\<GUID>*; 1> name: User, Joe;  
\>> Dn: CN=User\, Joe,OU=Migration,DC=corp,DC=company,DC=local 1> canonicalName: corp.company.local/Migration/User, Joe;  
1> cn: User, Joe;  
1> description: Disabled Account; 1> displayName: User, Joe;  1> distinguishedName: CN=User\, Joe,OU=Migration,DC=corp,DC=company,DC=local;  
4> objectClass: top; person; organizationalPerson; user;  
1> objectGUID: *\<GUID>*;  
1> name: User, Joe;

In this example, presume that there is a DC in the corp.company.local domain that is named CORP-DC-01. Running the command `repadmin /showreps CORP-DC-01` produces the **objectGUID** value *\<GUID>*. This GUID replaces the previous GUID in the Objects-list.txt file. The entry for this lingering object now appears as follows:

\<GUID=*\<GUID>*> : \<GUID=*\<GUID>*>

The first GUID is the GUID of the domain controller in the corp.company.local domain. The second GUID is the GUID of the lingering object. After this change, the Walk-servers.cmd script runs successfully.

#### Error message 87 when removing lingering objects in the environment

This error might occur when you find objects are in fact not appearing on all DCs that host the naming context, but `repadmin /removelingeringobjects` does not remove them. This can be a situation when a hub DC replicates new objects it created with global catalog servers, but not with read/write replica DCs in its own domain.

This error is returned only in two cases:

- The object exists on the reference DC.
- The object is too young (compared to the current TSL value) to be lingering.

For an example of the second case, consider a global catalog server that has the following metadata:

> Loc.USN      Originating DC   Org.USN  Org.Time/Date        Ver Attribute  
=======       =============== ========= =============        === =========  
143543261     d20f71f3-6147-4f80-a0c2-470541ef09e6 104742409 *\<DateTime>* objectClass  
Up-To-Dateness Vector of a RW-replica:  d20f71f3-6147-4f80-a0c2-470541ef09e6 @ USN 104583382 @ Time *\<DateTime>*  
Up-To-Dateness Vector of a GC:  d20f71f3-6147-4f80-a0c2-470541ef09e6 @ USN 104762881 @ Time *\<DateTime>*

In this case the DC created the object after replication with the DCs in its own domain started failing, but it still replicated with global catalog servers in other domains.

To resolve this issue, let these objects become real lingering objects (aged beyond TSL) and then remove them using the script in this article. To make sure that the data continues to replicate, set **Allow Replication With Divergent and Corrupt Partner**  on all DCs in the forest.

If you cannot resolve the errors in the log files by using these methods, you may be experiencing a different problem. Contact Microsoft Product Support Services for additional assistance.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
