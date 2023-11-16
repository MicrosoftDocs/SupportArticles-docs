---
title: Recovering missing FRS objects
description: Provides some information about recovering missing FRS objects and FRS attributes in Active Directory.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:frs, csstroubleshoot
ms.technology: networking
---
# Recovering missing FRS objects and FRS attributes in Active Directory

This article provides some information about recovering missing FRS objects and FRS attributes in Active Directory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 312862

## Summary

File Replication service (FRS) is a multi-threaded, multi-master replication engine that replaces the LMREPL service in Microsoft Windows NT 3. **x** and in Microsoft Windows NT 4.0. Windows 2000-based and Windows Server 2003-based domain controllers and servers use FRS to replicate system policy and logon scripts for clients that run Windows Server 2003 and earlier. You can also use FRS to replicate files and folders between Windows 2000-based and Windows Server 2003-based servers that host the same fault-tolerant Distributed File System (DFS) root or child replicas.

This article describes:

- How the deletion of FRS objects and FRS attributes occurs.
- How to detect missing Server-Reference attributes and member objects in `SYSVOL` replica sets.
- How to repair missing attributes by using null Server-Reference attributes as an example.
- How to repair missing objects by using missing member objects as an example.
- How to repair missing connection objects by using existing connection objects as an example.

## More information

To function correctly, FRS relies on containers, objects, and attributes that are stored in Active Directory and that are replicated among domain controllers in a given domain. Critical objects include FRS member and subscriber objects. Required attributes (by schema class definition) and optional attributes include the Schedule attribute, the FRS-File-Filter attribute, the FRS-Folder-Filter attribute, and the FRS database location. Schema definitions define the containers or the location in which FRS objects reside.

FRS supports two replica set types: DFS and `SYSVOL`. Dcpromo.exe indirectly creates containers, objects, and attributes for `SYSVOL` replica sets. The DFS snap-in (Dfsgui.msc) creates objects when you enable replication between two or more targets in a DFS Root or a DFS Link, or when you add new members to an existing FRS replica set.

> [!NOTE]
> Starting in Windows Server 2008 R2, `SYSVOL` replication can be performed by the Distributed File System Replication (DFS-R) engine. A similar procedure exists to repair DFS-R objects and attributes. For more information, see [https://technet.microsoft.com/library/cc794759(WS.10).aspx](https://technet.microsoft.com/library/cc794759%28ws.10%29.aspx)  

### The deletion or removal of FRS objects and FRS attributes

FRS objects and attributes are removed from Active Directory when you gracefully remove servers from the replica set.

For example:

- `SYSVOL`: When you use Dcpromo.exe to demote a server to a member server.
- Replicated DFS Roots, DFS Links, and DFS connections: When you use Dfsgui.msc to remove the DFS Link or the DFS Root or some of the connections.  

It is possible for an administrator to delete objects or containers without understanding their importance, which can have a negative impact on FRS.

In general, never manually delete FRS member or FRS subscriber objects or their parent containers from Active Directory unless you are reinstalling the operating system to which these objects refer.

For example:

- In Active Directory Sites and Services, do not delete an NTDS Settings object on a domain controller (regardless of whether it is orphaned or offline). If you make the deletion, the Server-References attributes on the FRS member object become null; null Server-Reference attributes halt inbound and outbound replication of `SYSVOL` on the domain controller. This type of deletion is a common scenario.
- Do not delete Machine Account objects for member servers or domain controllers in FRS replica sets or in their child objects.
- Do not delete one or more member objects of a replica set.
- Do not delete the `SYSVOL` NtFrsReplica container that contains (with) member objects for each of the domain controllers in the domain.

### Detecting null Server-Reference attributes

When FRS replicates the contents of the `SYSVOL` folder, FRS uses connection objects that are located in the configuration partition of Active Directory. You can manually create these connection objects; however, KCC automatically generates the connection objects by default. An NTDS Settings object is one of two critical objects that distinguish domain controllers from other computer accounts in Active Directory. Among other things, the NTDS Settings object is the parent container for inbound connections from other domain controllers in the domain and in the forest.

The domain name path of the Server-Reference attribute on FRS member objects becomes null (empty) if you delete NTDS Settings objects from the Configuration partition in Active Directory. This behavior is detected or recorded by the following tools or logs:

1. The output of the ntfrsutl ds command:
2. Event 13562 in the FRS event log on computers that are running Service Pack 2 (SP2) or later:  

    >Event Type: Warning  
    Event Source: NtFrs  
    Event Category: None  
    Event ID: 13562  
    Date: **mm/dd/yyyy**  
    Time:  
     **hh:mm:ss AM|PM**  
    User: N/A  
    Computer:  
     **computername**  
    Description:  
    Following is the summary of warnings and errors encountered by File Replication service while polling the Domain Controller `dc1.a.com` for FRS replica set configuration information.
    >
    >The nTFRSMember object cn=dc1,cn=domain system volume (sysvol share),cn=file replication service,cn=system,dc=a,dc=com has a invalid value for the attribute ServerReference.

3. Errors in the FRS debug logs:  

    >NtFrs_000X.log: **FrsNewDsGetSysvolCxtions: S0: HH:MM:SS** :DS: WARN - Member (cn=DC1,cn=domain system volume (sysvol share),cn=file replication service,cn=system,dc=a,dc=com) of sysvol replica set lacks server reference; skipping

4. The output of the ntfrsutl ds command parsed with the PERL script TOPCHK (which is available from Microsoft Product Support Services):  

    >S E R V E R S M I S S I N G I N B O U N D C O N N E C T I O N S
    >
    >The following FRS Member servers have outbound replication partners but no inbound connection objects. There could be several reasons for this:
    >
    >1. There are no connection objects under the NTDS Settings object for this server. This is an error.  
    >2. The ServerReference Attribute for this server is null. This is an error.
    >3. This server could be in a different domain so there will be no FRS member object for it.
    >4. The FRS member object may be missing. This is an error.
    >
    >DEFAULT-FIRST-SITE-NAME\DC1

### Repairing the null Server-Reference attributes

You can use LDP.exe or ADSIedit.msc to repair missing Server-Reference attributes. These tools allow you to repair the attributes by resetting them to match the distinguished name (DN) of the server's NTDS settings object. To repair null Server-Reference attributes, follow these steps:

1. Use one of the following methods to locate the DN path of the NTDS Settings object for the computer that has the missing (null) Server-Reference attribute:

    - In LDP or ADSIedit, copy the DN path of the NTDS Settings object from the Configuration container in the root domain of the forest to Clipboard.

       -or-
    - From the domain partition of Active Directory, copy the value of the Server-Reference attribute from a healthy domain controller to Clipboard. This domain controller needs to be in the same Active Directory domain and site as the broken computer, otherwise you have to edit the DN path.  

2. Locate the member object that has the null Server-Reference attribute:

    1. Start ADSIedit. In the Domain partition of Active Directory, locate the member object (nTFRSMember) that lacks the settings reference. The DN path is:
    2. Right-click the member object that has the null Server-Reference attribute, and then click Properties.
3. Edit the value for the Server-Reference attribute:

   1. Configure the Attributes tab in ADSIedit:

      - Select which properties to view: Set it to OPTIONAL.
      - Select a property to view: Click the Server-Reference property.  

   2. Under Edit Attribute, paste the DN path of the NTDS Settings object from Clipboard. The DN path for an NTDS Setting should have the following format  
     CN=NTDS Settings, CN= **Computer name**,CN= **Site name**, CN=Sites, CN=Configuration, DC= **Root domain of forest**,DC=COM  
     where **Computer name** is the name of the domain controller with the null Server-Reference attribute and where  
     **Site name** is the name of the Active Directory site where that server's NTDS Settings object lives.  
   3. Click SET, and then confirm the value that is written to Active Directory.  

4. Wait or force FRS to poll Active Directory:

    FRS polls Active Directory at regular intervals to discover configuration changes. You can use either of the following methods to have polling occur:

    1. Use the net stop ntfrs command to stop FRS, and then use the net start ntfrs command to restart FRS.
    -or-
    2. Use the ntfrsutl poll /now command line to force FRS to poll:

        1. Wait until the short or long polling interval expires. It is a five-minute default on domain controllers.
        2. FRS registers the change during its next DS polling cycle. Monitor the FRS event log for replication by using the output from the ntfrsutl sets command.  

Fixing or Modifying Other Attributes:

You can use the same techniques that are described in the "Fixing Null Server-Reference Attributes" section with any configuration objects or attributes that are used by FRS.

Regarding the particular attributes that you want to modify or repair which you will paste into LDP or ADSIedit during the LDAP modification procedure, Microsoft recommends that you use attributes from a healthy domain controller or member server.

### Recovering from deleted FRS objects

Bulk deletions of FRS member or subscriber objects are rare; however, to recover from a bulk deletion, you need to use an authoritative restore in the appropriate container. To avoid the damage that bulk deletions cause, you need to protect critical objects by having the appropriate permissions, by training administrators in the domain, and by making regular system state backups. Consider the following action plan if a restore is required:

1. Perform frequent system state backups so that you can return to the current state if necessary.
2. Restore objects as deep in the Active Directory tree as possible.
3. Test bulk restores in test domains that mirror your production domain.
4. Test bulk restores on test production domain controllers on a private network before you introduce it back on the corporate network.  

You can use LDP and ADSIedit to recover individual objects by using the same procedure that is described in the "Fixing Null Server-Reference Attributes" section; however, in this scenario, the procedure occurs on a larger scale.

#### Detecting missing FRS member objects

You can detect missing FRS member objects with the following tools:

1. Use the ntfrsutl sets command-line output, and then parse it with the PERL script TOPCHK:  

    >S E R V E R S M I S S I N G I N B O U N D C O N N E C T I O N S  
    The following FRS member servers have outbound replication partners but no inbound connection objects. There could be several reasons for this:
    >
    >1. There are no connection objects under the NTDS Settings object for this server. This is an error.
    >2. The ServerReference Attribute for this server is null. This is an error.
    >3. This server could be in a different domain so there will be no FRS member object for it.
    >4. The FRS member object may be missing. This is an error.
    >
    >DEFAULT-FIRST-SITE-NAME\DC1

2. The output of the ntfrsutl sets command:  

    > [!NOTE]
    > There are no outbound connections in the following output.

#### Recovering deleted FRS replica sets

You can recover deleted FRS replica sets by re-creating them or by restoring the system state.

To re-create the `SYSVOL` replica by using ADSIEDIT, follow these steps:

> [!NOTE]
> Pay extra attention to avoid typos as you add object and attribute names and values into ADSIedit. If there is a DC in your Active Directory environment that did not replicate the accidental deletion of the Replica Set (for example, the DC was offline, was not connected to the network, or the replication schedule was not opened) you can use LDP.exe or ADSIedit to copy the values from that DC and paste them into ADSIedit on the "recovery" DC where you want to re-create the Replica Set objects. You can also string names and values from another domain or an online copy of this article if you modify the DN path to match the target domain. For example, see **DC=A,DC=COM** in the below example.  

1. Start ADSIedit. Connect to the domain partition on a domain controller that is member of the domain that is hosting the missing `SYSVOL` object.

2. Re-create the `SYSVOL` replica set. To do it, right-click **Container CN=File Replication Service,CN=System,DC=A,DC=COM**, click **New** and then click **Object**.

3. Select the **nTFRSReplicaSet** object class, and then click **Next**.

4. Type Domain System Volume (`SYSVOL` share) in the **Value** box, and then click **Next**.

5. Click **More Attributes**, and then click **BOTH** in the **Select which properties to view** list.

6. Under **Edit Attribute**, configure the following attributes. Click **SET** after each entry.

    - instanceType: - Expected value: 4
    - fRSReplicaSetType: - Expected value: 2
    - fRSFileFilter: - Expected value: \*.tmp, \*.bak, ~*  

If you have to recover the replica set by restoring the system state, follow these steps:  

1. Start the domain controller where you have a valid system state backup in the Directory Services Restore Mode.

    For more information, visit the following Microsoft Web site:  
    [Performing an Authoritative Restore of Active Directory objects](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816878(v=ws.10)?redirectedfrom=MSDN)

2. After restoring the system state backup in the Directory Restore Mode, *do not* restart the DC. At a command prompt, use NTDSUTIL to perform an authoritative restore on the deleted `SYSVOL` replica set by using the following ndtsutil syntax:  

    ntdsutil "authoritative restore" "restore subtree \"CN=Domain System Volume (`SYSVOL` Share),CN=File Replication Service,CN=System, **DC=A,DC=COM**\\"" q q  

    > [!NOTE]
    > Change the DN path **DC=A,DC=COM** to match the DN path of your Active Directory domain.

#### Recovering deleted FRS member objects

All objects in Active Directory contain required attributes such as `objectclass`, ObjectCategory, CN, and so forth. Class definitions in the schema may define additional required attributes as well as optional attributes. Required attributes and optional attributes for FRS member objects include Server-Reference and Frs-Computer-Reference.

In the following procedure, you are using ADSIedit to re-create a deleted member object for the domain controller \\DC1 in the `SYSVOL` replica set of the A.COM domain where **\\DC1** is the name of the domain controller and **A.COM** is the domain name.

> [!NOTE]
> ADSIedit the preferred tool for creating missing objects and attributes because it has a drop-down list of attributes and objects that you can use to help avoid syntax errors.

To recover a deleted FRS member object:

1. Start ADSIedit. Connect to the domain partition on a domain controller that is a member of the domain that is hosting the missing FRS member object.
2. Review the required attributes and the optional attributes for a healthy member object in the same replica set.

    For a `SYSVOL` replica set in the A.COM domain, the DN path is:  
    > [!NOTE]
    > LDP is the preferred tool in this step because you can look at all of the attributes in a single screen. ADSIedit works better for small attribute sets.
3. In ADSIedit, in the console tree, right-click the name of the FRS replica set to which you want to add the missing member, \\DC1, click New, and then click Object:  
(CN=Domain System Volume (`SYSVOL` share),CN=File Replication Service...)
4. In the Create Object Wizard, click nTFRSMember, and then click Next.
5. Type the host name of the computer (DC1 in this example) in the Value box, and then click Next.
6. Click More Attributes, and then click BOTH in the Select which properties to view list.
7. Under Edit Attribute, configure the following attributes. Click SET after each entry:

    - Frs-Computer-Reference:

        - Expected Value: DN path of computer account in domain NC
        - Example: CN=DC1,OU=Domain Controllers,DC=a,DC=com
    - InstanceType:

        - Expected Value: 4 for `SYSVOL`, 2 for DFS replica sets
        - Example: 4
    - Server-Reference:

        - Expected Value: DN path of NTDS Settings object from Configuration partition
        - Example: CN=NTDS Settings,CN=DC1,CN=Servers,CN=USA-CORP,CN=Sites,CN=Configuration,DC=a,DC=com  

8. Update the FrsMemberReference attribute on the NtFrsSubscriber object:

    1. In ADSIedit, in the console tree, navigate to the NtFrsSubscriber object for same replica set that you used in step 2:CN=NTFRS Subscriptions,CN=ARRENC1,OU=Domain Controllers,DC=a,DC=com

    2. Right-click NtFrsSubscriber, and then click Properties. You can view the properties in the detail pane:CN=Domain System Volume (`SYSVOL` share),CN=NTFRS Subscriptions

    3. On the Attributes tab, set Select which properties to view to OPTIONAL.  

9. Under Edit Attribute, configure the following attributes. Click SET after each entry:

    - FrsMemberReference:

        - Expected Value: The DN path of the FRS member object for the matching replica set, which is `SYSVOL` in this example.
        - Example: CN=DC1,CN=Domain System Volume (`SYSVOL` share),CN=File Replication Service,CN=System,DC=a,DC=com
        - Result: Populates the fRSMemberReferenceBL attribute on the member object in:CN=Domain System Volume (`SYSVOL` share),CN=File Replication Service,CN=System,DC=a,DC=com

#### Recovering deleted nTFRSSubscriptions object

You can recover deleted nTFRSSubscription objects by re-creating the object using an LDAP editor or by restoring the system state.

To re-create nTFRSSubscription objects by using ADSIEDIT, follow these steps:  

1. Start ADSIedit. Connect to the domain partition on a domain controller that is member of the domain that is hosting the missing `SYSVOL` object.

2. Locate the required computer object, right-click the computer object, click **New**, select **nTFRSSubscriptions**, and then click **Next**.
3. Type **NTFRS Subscriptions** in the **Value** box, and then click **Next**.

4. Click **More Attributes**, and then click **BOTH** in the **Select which properties to view** list.
5. Under **Edit Attribute**, configure the following attributes. Click **SET** after each entry.

    - instanceType: oExpected value: 4

    - fRSWorkingPath: oExpected value: c:\windows\ntfrs

    > [!NOTE]
    > The working path may vary because the SYSVOL can be stored on a different volume or you might want to configure the working path in another folder. Typically, the working path will be located as is mentioned here.  

To restore nTFRSSubscription objects by restoring a system state backup, follow these steps:  

1. Start the Domain Controller where you have a recent, valid system state backup in the Directory Services Restore Mode.

    For more information, visit the following Microsoft Web site:  
    [Performing an Authoritative Restore of Active Directory objects](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816878(v=ws.10)?redirectedfrom=MSDN)  

2. After you restore the system state backup in the Directory Restore Mode, *do not* restart the DC. Open a command prompt to restore the deleted subscription object. If DC the where you restored the object is running Windows Server 2003 with SP1 or later versions, you can use the following ndtsutil syntax:  
ntdsutil "authoritative restore" "restore object \"CN=DC1,CN=Domain System Volume (`SYSVOL` Share),CN=File Replication Service,CN=System, **DC=A,DC=COM**\\"" q q  

    > [!NOTE]
    > Change the DN path **DC=A,DC=COM** to reflect the DN path of the Active Directory domain that is being modified.  

Another option to recover is to use the Active Directory Installation Wizard (DCPROMO) to forcefully remove Active Directory from the affected DC. Then, run metadata cleanup for this DC. After that you can run DCPROMO again to promote the DC back into the domain. The nTFRSSubscription object will be recreated with all required subscription objects for `SYSVOL` during the promotion. Notice that any unique objects in either AD or in the file system portion of policy would be lost with this option.

### Recovering deleted FRS subscriber objects

When FRS subscriber objects are missing, FRS can't perform replication for the replica set. You will see evidence in the following places:  

- The NtFrs_*.log report contains the message:

- When you run the Ntfrsutl ds command, the following message appears at the end of the text output:  
    SUBSCRIPTION: NTFRS SUBSCRIPTIONS DN: cn=ntfrs subscriptions,cn=win2k-pdc,ou=domain controllers,dc=crbc-win2k,dc=d... Guid: 5c44b60b-8f01-48c6-8604c630a695dcdd Working: f:\winnt\ntfrs Actual Working: f:\winnt\ntfrs WIN2K-PDC IS NOT A MEMBER OF ANY SET!  
    This message may look differently for DFS replica sets.  

Collect the following information:

- Where is the DFS volume/replica set on the hard disk?
- Where is the staging area for this replica set?
- Where is the member object for this member? For `SYSVOL`, the name of the object is:  
    CN= **computer name**,CN=Domain System Volume (`SYSVOL` share),CN=File Replication Service,CN=System,dc= **your domain name**  
    For DFS volumes, the name of the object is:  
    CN= **server name**,CN= **DFS volume name**,CN= **DFS volume name**,CN=DFS Volumes,CN=File Replication Service,CN=System,DC= **your domain**  
    Locate this object in **Active Directory Users and Computers**. (Turn on **Advanced Features** in the View menu to see the System container.) Put the domain name that you get in a text file.

- What is the GUID of the domain root object? To get the objectGUID of the domain root object, follow these steps:

    1. From a command prompt, type LDP.EXE.
    2. Click **Connection\Connect**, and then enter the name of a domain controller in your domain.
    3. Click **Connection\Bind**. You only need to read from the Active Directory, so any valid credentials work. If you are logged on with a domain account, leave all text fields blank.
    4. Click **View\Tree**. Make sure that the text field is empty, and then press ENTER.
    5. On the right side of the LDP window, you see the attributes of the domain root object. Locate the objectGUID attribute, and then copy the GUID that is the attribute's value to a text file.  

To resolve the problem of missing FRS subscriber objects, follow these steps.
> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Windows Server 2003, Microsoft Exchange 2000 Server, Microsoft Exchange Server 2003, or both Windows and Exchange. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.  

1. Stop the NTFRS service on the computer where the object is missing.
2. Run the ADSIedit.msc tool. (This tool comes with the Windows Support Tools). Locate the empty CN=NTFRS Subscriptions object under the computer account.
3. Go to step 4 to repair DFS objects. For `SYSVOL` objects, follow these steps:
    1. Right-click the subscription object, and then click **New\Object**.
    2. Click **nTFRSSubscriber object**. For the name, type Domain System Volume (`SYSVOL` share).
    3. For the **Attribute values** that are required for the object type the following values, where Use the actual paths of the directories on your computer:
    >fRSStagingPath = F:\WINNT\SYSVOL\staging\domain  
    fRSRootPath = F:\WINNT\SYSVOL\domain  
    fRSMemberReference = CN= computer name ,CN=Domain System Volume (SYSVOL share),CN=File Replication Service,CN=System,dc= your domain name

4. If no DFS objects need repairs, go to step 5. To repair DFS objects, follow these steps:  

      1. If the object "DFS Volumes" is missing, create two nTFRSSubscriptions objects. To create the first object, right-click the subscription object, and then click **New\Object**. Click the nTFRSSubscriptions object. For the name, type DFS Volumes. Click **OK**.
      2. If the nTFRSSubscriptions object with the GUID-name (the GUID is the objectGUID of the domain root object) is missing, create that object.
      3. Create the last nTFRSSubscriptions object. Switch to the ADSIEdit snap-in, and then locate the CN=DFS Volumes that you created in step 4a.
      4. Right-click the object, and then click **New\Object - Select nTFRSSubscriptions**. For a name, type `The GUID that you copied to the text file`. Press ENTER.
      5. Click the nTFRSSubscriptions object that you created in 4d. Right-click the new subscription object, and click New\Object - Attribute values for the object.
      6. Click the nTFRSSubscriber object. For the name, type **name of the DFS volume**. Enter the following Attribute values for the object, where you use the actual paths of the directories on your computer:  

     >fRSStagingPath = D:\DFS-Volumes\App-Install  
     fRSRootPath = D:\FRS-Staging
     fRSMemberReference = CN= Server name ,CN= DFS volume name ,CN= DFS volume name ,CN=DFS Volumes,CN=File Replication Service,CN=System,DC= your domain

5. Restart the NTFRS service. Check that FRS replication is working.

### Recovering deleted DFS connection objects

1. Use Adsiedit.msc (which ships with the Windows 2000 and Windows Server 2003 Support Tools) to locate the server that is missing the inbound connection. To do so:

    1. Start Adsiedit.msc.
    2. Locate the following object:cn=DFS Volumes,cn=File Replication Service, cn= **system**,dc= **domain**  

    3. Under this object, there is an entry for each DFS volume (and a second level, also). These DFS volume entries list an nTFRSMember object for each DFS member server. The name of the nTFRSMember object is a GUID, so you must view each object to determine which server it corresponds to. Right-click each nTFRSMember object, click Properties, and then click frsComputerReference.
    4. Record the mapping. To do so, copy and paste the Path string at the top of the dialog box, and then copy and paste the data from the Value(s) box to the same text file.  

2. Right-click the member object, click New, click Object, and then click nTDSConnection.
3. Click Next, and then type the required attributes.
4. For the cn value, use the name of the source server (it is just a suggestion), and then click Next.
5. In the Value: field for the Options attribute, type 0, and then click Next.
6. In the Value: box for the fromServer attribute, type the DN path of the NTFRS member computer (objectclass=nTFRSMember) from which this connection object will replicate changes. Or from the Windows clipboard, copy the DN path of the NTFRS member computer from which this connection object will replicate changes, paste that DN path into the Value: box for the fromServer attribute, and then click Next.

    For example, you may have three domain controllers, \\DC1, \\DC2, and \\DC3 in the `CORP.COM` domain. All three domain controllers participate in the `\\CORP.COM\DFSFT\APPS` domain DFS link with the following topology:

    - \\DC1 replicates inbound changes from \\DC2
    - \\DC2 replicates inbound changes from \\DC1
    - \\DC3 replicates inbound changes from \\DC2  
    >[!NOTE]
    > The following table lists the DN path strings, followed by a corresponding list of ObjectClass values. The paths and ObjectClass values that have the same number correspond. Also note that the DN path strings are truncated with ellipses ("...") for formatting and readability. To create a second inbound connection so that \\DC3 (destination) replicates changes from \\DC1 (source), copy the full DN path of the NTFRSmember object for \\DC1  
    CN={06f7572e-4e49-4a6e-9ce5-d3b229b591c5},CN=dfsft|apps,CN=dfsft,CN=DFS Volumes,CN=...  
    into the clipboard, and then paste it into the Value: box for the fromServer attribute.  

7. In the Value: box for the enabledConnection attribute, type TRUE, and then click Next.
8. Click Finish.  
FRS picks up the connection the next time it reads its configuration from the Active Directory.
