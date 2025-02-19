---
title: Manually Remove Lingering Objects on Outdated Replication Partners
description: Helps with manual removal of lingering objects after you bring an outdated domain controller (DC) or global catalog server back online.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Manually remove lingering objects on outdated replication partners

This article helps manually remove [lingering objects](information-lingering-objects.md#summary) after you bring an outdated domain controller (DC) or global catalog server back online. In many cases, you can clean up lingering objects using the `repadmin /removelingeringobjects` command or tools like [Lingering Object Liquidator](lingering-object-liquidator-tool.md). However, these facilities don't work if you have [abandoned objects](https://support.microsoft.com/topic/attributes-that-contain-stale-or-bad-data-cause-exchange-offline-address-book-oab-generation-failures-and-event-ids-9126-9330-and-9339-together-with-stop-error-code-8004010e-occur-d505154b-f51f-6604-436b-e30fe4e486d9).

_Original KB number:_ &nbsp; 314282

When you bring a domain controller or global catalog server back online after it has been offline for a long time, any of the following issues might occur:

- Email messages aren't delivered to a user whose user object was moved between domains. After you bring the outdated domain controller or global catalog server back online, both instances of the user object appear in the global catalog content. Both objects have the same email address, so email messages can't be delivered.
- A user account that no longer exists still appears in the global address list.
- A universal group that no longer exists still appears in a user's access token.

## The offline duration is longer than the value of the tombstone lifetime setting

A domain controller or global catalog server that has been offline for longer than the value of the [tombstone lifetime](information-lingering-objects.md#how-object-deletions-replicate-through-a-forest) setting (the default value is 60 or 180 days) might contain objects that have been deleted on other domain controllers or global catalog servers. Additionally, tombstones for these objects may no longer exist. When you bring the outdated domain controller back online, it can't be notified of the object deletions. If any of the objects are modified, they're reactivated in the rest of the domain.

For lingering objects that are replicated into read/write naming contexts, the standard behavior (Loose Replication Consistency) is that the receiving domain controller re-creates the objects that aren't already present in the local database Directory Information Tree (DIT). These objects are then replicated back to the originating domain controller, effectively re-creating the deleted objects. If the object shouldn't exist in Active Directory (for example, if the object was reintroduced by an outdated domain controller), you can delete the objects with standard tools (such as ADSIEdit or the Active Directory Users and Computers snap-in).

It's straightforward to remove lingering objects for read/write naming contexts. This article describes how to remove lingering objects that have already appeared in global catalog (read-only) naming contexts.

## Obtain the distinguished name and identify the domain

The best way to identify in which domain an object is located (and therefore the name of a domain controller that has a read/write copy of the object) is to establish the distinguished name of the object. You can do this by searching for the name (or part of the name) of the duplicate user, group, or distribution list by using the **Ldp.exe** tool:

1. Start **Ldp.exe**.
2. On the **Connection** menu, select **Connect**.
3. Enter the name of a global catalog server. Enter **3268** as the port to connect to. Select **OK**.
4. On the **Connection** menu, select **Bind**. If your current credentials aren't sufficient to query all of the global catalog contents, enter valid credentials. Select **OK**.
5. On the **View** menu, select **Tree**. Enter the distinguished name of the forest root. Select **OK**.
6. Right-click the forest root in the tree list, and then select **Search**.
7. Create a filter of the following form:

    **(attribute=value)**

    Substitute *attribute* and *value* with the appropriate data. For example, to create a filter to return results where the **sAMAccountName** attribute has a value set to a user account named **testuser**, enter **(sAMAccountName=testuser)** in the **Filter** box. The **cn**, **userPrincipalName**, **sAMAccountName**, **name**, **mail**, and **sn** attributes are useful candidates for finding a user object. For group objects, use the **cn**, **sAMAccountName**, or **name** attributes. You can use asterisks (*) in the *value* field if necessary.

    For more information on Lightweight Directory Access Protocol (LDAP) filter syntax, see [Search Filter Syntax](/windows/win32/adsi/search-filter-syntax).

8. Select **Subtree** as the search scope.
9. Select **Options**. In the **Search Options** dialog, move to the end of the **Attributes** control.
10. Append **objectGUID;** to the list. Select **OK**.
11. Select **Run** to run the query.
12. View the results. You must identify which of the displayed objects should be removed from the global catalog server. One indication that you have found a problematic object is that the object doesn't exist on a read/write copy of the naming context.
13. Rephrase the query and rerun it if necessary.
14. If you have identified the lingering object, note its distinguished name and **objectGUID**.

After you obtain the object's distinguished name, identify the domain in which it was located by looking at the **dc=** part of the distinguished name. For example, the domain of **cn=FirstName LastName,cn=Users,dc=contoso,dc=com** is **contoso.com**. Next, locate a domain controller for the domain (it can also be a global catalog server).

Run the `repadmin /showreps <dcname>` command (where `<dcname>` is the name of the domain controller you located). From the output, note the domain controller's `objectGuid`:

```console
C:\>repadmin /showreps some-DC
Your-Site\some-DC
DSA Options : (none)
objectGuid : <GUID>
```

## Delete lingering objects if you have only a few objects and global catalog servers

If you have only a few objects and global catalog servers, follow these steps to delete the objects by using **Ldp.exe**:

1. Sign in to each global catalog server that contains a copy of the lingering object by using Enterprise Administrator credentials.
2. Start **Ldp.exe** and connect to port 389 on the local domain controller (leave the **Server** box empty).
3. On the **Connection** menu, select **Bind**. Leave all of the boxes empty (you're already signed in as an Enterprise Administrator).
4. On the **Browse** menu, select **Modify**.
5. Leave the **Dn** box empty.
6. In the **Attribute** box, enter **RemoveLingeringObject**.
7. Enter **<GUID=** as the value.
8. Append the GUID of the domain controller that you obtained earlier from the command `repadmin /showreps <dcname>`.

    > [!NOTE]
    > In this example, `<dcname>` is a domain controller that hosts the writable naming context of the lingering object.

9. Append **> : <GUID=**. Don't omit the spaces.
10. Append the GUID of the lingering object.
11. Append **>**.
12. The complete value should look like:
    **<GUID=*GUID*> : <GUID=*GUID*>**
13. Select the **Replace** operation, and then select **Enter** on the interface. Now the command appears in the **Entry List**.
14. Select **Run** to run the request. The right side of the **Ldp.exe** window contains the request result. It should look similar to this example:

    ```output
    ***Call Modify...
    ldap_modify_s(ld, '(null)',[1] attrs);
    Modified "".
    ```

## Delete lingering objects if you have many objects and global catalog servers

If you have many objects to delete and many global catalog servers, it might be more convenient to use the following scripts:

1. Paste the following text into a new file named **Walkservers.cmd** in a new folder:

    ```console
    for /f %%j in (server-list.txt) do walkobjects %%j
    ```

2. Paste the following text into a file named **Walkobjects.cmd**:

    ```console
    for /f "delims=@" %%i in (object-list.txt) do cscript //NoLogo MODIFYROOTDSE.VBS %1 "%%i" >>update-%1.log
    ```

    > [!NOTE]
    > This is a single command line. Line breaks are inserted here for readability.

3. Paste the following text into a file named **Modifyrootdse.vbs**:

    ```vbscript
    '********************************************************************
    '*
    '* File:        MODIFYROOTDSE.VBS
    '* Created:     January 2002
    '* Version:     1.0
    '*
    '* Main Function: Writes Active Directory information to clean up 
    '* objects as per: Q314282.
    '* Usage: Modifyrootdse.vbs <TargetServer> <GUID PAIR>
    '* Parameter are fed into the script using a pair of batch files.
    '*
    '* Copyright (C) 2002 Microsoft Corporation
    '*
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
    > If you start **Modifyrootdse.vbs** manually, make sure to enclose any parameters that contain spaces in quotation marks.

4. Create a list of all global catalog servers that contain the lingering objects. Place the server names in a **Server-list.txt** file in the same folder. Use the fully qualified domain names to avoid DNS suffix searches.
5. Add the GUID pairs that you obtained earlier in this procedure to an **Object-list.txt** file. Add one pair per line. Use the following syntax:

    `<GUID = <DC GUID>> : <GUID = <object GUID>>`

    Here, the first value is the GUID of the writable domain controller that is used to confirm that the original object no longer exists. The second value is the GUID of the lingering object to be removed.

6. Run the **Walk-servers.cmd** file. The scripts generate a log file named **Update-server-name.log** for each global catalog server listed in the **Server-list.txt** file. The log files contain a line for each object that is to be deleted.

> [!NOTE]
> Errors in the log files don't necessarily indicate a problem because the lingering objects might not exist on all global catalog servers. However, error messages of the form "operation refused" or "operation error" indicate a problem with the GUIDs or the value syntax. If these errors occur, verify the following items:
>
> - Make sure that the domain controller GUIDs are the correct GUIDs for domain controllers that contain a writable copy of the domain that contains the object.
> - Make sure that the object GUIDs identify lingering objects in global catalog (read-only) naming contexts.

### Error message when running Walkservers.cmd to modify many lingering objects in the environment

> Object <GUID=GUID> : <GUID=GUID> could not be removed. Error number is: -2147016672. Error description is: .

This error occurs because the script runs against the GUID of a domain controller that doesn't contain a writeable partition that contains the lingering object. Use the **Ldp.exe** tool to verify the location of the lingering object.

#### Example

In the following example, the lingering object that causes the error message to be removed is located in the `corp.company.local` domain. However, the `<GUID=<GUID>>` from the **objects-list.txt** file is associated with a domain controller in the `company.local` domain that doesn't have a writeable partition for `corp.company.local`.

```output
ldap_search_s(ld, "DC=company,DC=local", 2, "(cn=User*)", attrList,  0, &msg)
Result <0>: (null)
Matched DNs: 
Getting 4 entries:
>> Dn: CN=User\, Joe,OU=Exec,OU=Corporate Users,DC=corp,DC=company,DC=local
    1> canonicalName: corp.company.local/Corporate Users/Exec/User, Joe; 
    1> cn: User, Joe; 
    1> description: CEO; 
    1> displayName: User, Joe; 
    1> distinguishedName: CN=User\, Joe,OU=Exec,OU=Corporate Users,DC=corp,DC=company,DC=local; 
    4> objectClass: top; person; organizationalPerson; user; 
    1> objectGUID: <GUID>; 
    1> name: User, Joe; 
>> Dn: CN=User\, Joe,OU=Migration,DC=corp,DC=company,DC=local
    1> canonicalName: corp.company.local/Migration/User, Joe; 
    1> cn: User, Joe; 
    1> description: Disabled Account; 
    1> displayName: User, Joe; 
    1> distinguishedName: CN=User\, Joe,OU=Migration,DC=corp,DC=company,DC=local; 
    4> objectClass: top; person; organizationalPerson; user; 
    1> objectGUID: <GUID>; 
    1> name: User, Joe; 
```

Obtain the GUID of a server in the `corp.company.local` domain by running the following command:

```console
repadmin /showreps <dcname>
```

In this command, `<dcname>` is a placeholder for the name of a domain controller in the `corp.company.local` domain. Change the GUID in the **Objects-list.txt** file to match the GUID of the domain controller in the `corp.company.local` domain. In this example, the **Objects-list.txt** file will appear as:

`<GUID=<GUID>> : <GUID=<GUID>>`

The first `<GUID>` is the GUID of the domain controller in the `corp.company.local` domain. The second `<GUID>` is the GUID of the lingering object from the LDAP search.

When you run **Walk-servers.cmd**, the command now completes successfully without the "-2147016672" error.

If you can't resolve the errors in the log files by using these methods, you might be experiencing a different problem. Contact Microsoft Product Support Services for additional assistance.
