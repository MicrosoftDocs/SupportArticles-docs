---
title: How to upgrade Windows 2000 domain controllers to Windows Server 2003
description: Discusses how to upgrade Microsoft Windows 2000 domain controllers to Windows Server 2003 and how to add new Windows Server 2003 domain controllers to Windows 2000 domains.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: arrenc, kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# How to upgrade Windows 2000 domain controllers to Windows Server 2003

This article discusses how to upgrade Microsoft Windows 2000 domain controllers to Windows Server 2003 and how to add new Windows Server 2003 domain controllers to Windows 2000 domains.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 325379

## Summary

This article discusses how to upgrade Microsoft Windows 2000 domain controllers to Windows Server 2003 and how to add new Windows Server 2003 domain controllers to Windows 2000 domains. For more information about how to upgrade domain controllers to Windows Server 2008 or Windows Server 2008 R2, visit the following Microsoft Web site:

[Upgrade Domain Controllers: Microsoft Support Quick Start for Adding Windows Server 2008 or Windows Server 2008 R2 Domain Controllers to Existing Domains](https://technet.microsoft.com/library/ee522994%28ws.10%29.aspx#)

## Domain and forest inventory

Before you upgrade Windows 2000 domain controllers to Windows Server 2003 or before you add new Windows Server 2003 domain controllers to a Windows 2000 domain, follow these steps:

1. Inventory the clients that access resources in the domain that host Windows Server 2003 domain controllers for compatibility with SMB signing:

    Each Windows Server 2003 domain controller enables SMB signing in its local security policy. Make sure that all network clients that use the SMB/CIFS protocol to access shared files and printers in domains that host Windows Server 2003 domain controllers can be configured or upgraded to support SMB signing. If they can't, temporarily disable SMB signing until updates can be installed or until the clients can be upgraded to newer operating systems that support SMB signing. For information about how to disable SMB signing, see the **To disable SMB signing** section at the end of this step.

    Action plans

    The following list shows the action plans for popular SMB clients:
      - Microsoft Windows Server 2003, Microsoft Windows XP Professional, Microsoft Windows 2000 Server, Microsoft Windows 2000 Professional, and Microsoft Windows 98

          No action is required.
      - Microsoft Windows NT 4.0
        Install Service Pack 3 or later (Service Pack 6A is recommended) on all Windows NT 4.0-based computers that access domains that contain Windows Server 2003-based computers. Instead, temporarily disable SMB signing on Windows Server 2003 domain controllers. For information about how to disable SMB signing, see the **To disable SMB signing** section at the end of this step.
      - Microsoft Windows 95

        Install the Windows 9 *x* directory service client on the Windows 95-based computers or temporarily disable SMB signing on Windows Server 2003 domain controllers. The original Win9 *x* directory service client is available on the Windows 2000 Server CD-ROM. However, that client add-on has been replaced by an improved Win9 *x* directory service client. For information about how to disable SMB signing, see the **To disable SMB signing** section at the end of this step.
      - Microsoft Network Client for MS-DOS and Microsoft LAN Manager clients

        The Microsoft Network Client for MS-DOS and the Microsoft LAN Manager 2.x network client may be used to provide access to network resources, or they may be combined with a bootable floppy disk to copy operating system files and other files from a shared directory on a file server as part of a software installation routine. These clients don't support SMB signing. Use an alternative installation method, or disable SMB signing. For information about how to disable SMB signing, see the **To disable SMB signing** section at the end of this step.
      - Macintosh clients

        Some Macintosh clients aren't SMB signing compatible and will receive the following error message when they try to connect to a network resource:
        > \- Error -36 I/O

        Install updated software if it's available. Otherwise, disable SMB signing on Windows Server 2003 domain controllers. For information about how to disable SMB signing, see the **To disable SMB signing** section at the end of this step.
      - Other third-party SMB clients

        Some third-party SMB clients don't support SMB signing. Consult your SMB provider to see if an updated version exists. Otherwise, disable SMB signing on Windows Server 2003 domain controllers.

    To disable SMB signing

    If software updates can't be installed on affected domain controllers that are running Windows 95, Windows NT 4.0, or other clients that were installed before the introduction of Windows Server 2003, temporarily disable the SMB service signing requirements in Group Policy until you can deploy updated client software.

    You can disable SMB service signing in the following node of Default Domain Controllers policy on the domain controllers organizational unit: Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options\\Microsoft Network Server:

    Digitally sign communications (always)

    If domain controllers aren't located in the domain controller's organizational unit, you must link the default domain controller's Group Policy object (GPO) to all organizational units that host Windows 2000 or Windows Server 2003 domain controllers. Or, you can configure SMB service signing in a GPO that is linked to those organizational units.

2. Inventory the domain controllers that are in the domain and in the forest:
    1. Make sure that all the Windows 2000 domain controllers in the forest have installed all the appropriate hotfixes and service packs.

        Microsoft recommends that all the Windows 2000 domain controllers run the Windows 2000 Service Pack 4 (SP4) or later operating systems. If you can't fully deploy Windows 2000 SP4 or later, all the Windows 2000 domain controllers *must* have an Ntdsa.dll file whose date stamp and version are later than June 4, 2001 and 5.0.2195.3673.

        By default, Active Directory administrative tools on Windows 2000 SP4, Windows XP, and Windows Server 2003 client computers use Lightweight Directory Access Protocol (LDAP) signing. If such computers use (or fall back to) NTLM authentication when they remotely administer Windows 2000 domain controllers, the connection won't work. To resolve this behavior, remotely administered domain controllers should have a minimum of Windows 2000 SP3 installed. Otherwise you should turn off LDAP signing on the clients that run the administration tools.

        The following scenarios use NTLM authentication:
          - You administer Windows 2000 domain controllers that are located in an external forest connected by an NTLM (non-Kerberos) trust.
          - You focus Microsoft Management Console (MMC) snap-ins against a specific domain controller that is referenced by its IP address. For example, you click **Start**, click **Run**, and then type the following command: `dsa.msc /server=ipaddress`

        To determine the operating system and the service pack revision level of Active Directory domain controllers in an Active Directory domain, install the Windows Server 2003 version of Repadmin.exe on a Windows XP Professional or Windows Server 2003 member computer in the forest, and then run the following `repadmin` command against a domain controller in each domain in the forest:

        ```console
        >repadmin /showattr <name of the domain controller that is in the target domain> ncobj:domain: /filter:"(&(objectCategory=computer)(primaryGroupID=516))" /subtree /atts:operatingSystem,operatingSystemVersion,operatingSystemServicePack

        DN: CN=NA-DC-01,organizational unit=Domain Controllers,DC=company,DC=com
         1> operatingSystem: Windows Server 2003
         1> operatingSystemVersion: 5.2 (3718)
        DN: CN=NA-DC-02,organizational unit=Domain Controllers,DC=company,DC=com
         1> operatingSystem: Windows 2000 Server
         1> operatingSystemVersion: 5.0 (2195)
         1> operatingSystemServicePack: Service Pack 1
        ```

        > [!NOTE]
        > The domain controller's attributes do not track the installation of individual hotfixes.
    2. Verify the end-to-end Active Directory replication throughout the forest.

        Verify that each domain controller in the upgraded forest replicates all its locally held naming contexts with its partners consistently with the schedule that site links or connection objects define. Use the Windows Server 2003 version of Repadmin.exe on a Windows XP- or Windows Server 2003-based member computer in the forest with the following arguments: All the domain controllers in the forest must replicate Active Directory without error, and the values in the "Largest Delta" column of the repadmin output shouldn't be significantly greater than the replication frequency on the corresponding site links or connection objects that are used by a given destination domain controller.

        Resolve all replication errors between domain controllers that have failed to inbound replicate in less than Tombstone Lifetime (TSL) number of days (by default, 60 days). If replication can't be made to function, you may have to forcibly demote the domain controllers and remove them from the forest by using the Ntdsutil metadata cleanup command, and then promote them back into the forest. You can use a forceful demotion to save both the operating system installation and the programs that are on an orphaned domain controller. For more information about how to remove orphaned Windows 2000 domain controllers from their domain, click the following article number to view the article in the Microsoft Knowledge Base:

        [216498](https://support.microsoft.com/help/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion  

        Take this action only as a last resort to recover the installation of the operating system and the installed programs. You'll lose unreplicated objects and attributes on orphaned domain controllers including users, computers, trust relationships, their passwords, groups, and group memberships.

        Be careful when you try to resolve replication errors on domain controllers that haven't replicated inbound changes for a particular Active Directory partition for greater than **tombstonelifetime** number of days. When you do so, you may reanimate objects that were deleted on one domain controller but for which direct or transitive replication partners never received the deletion in the previous 60 days.

        Consider removing any lingering objects that reside on domain controllers that haven't performed inbound replication in the last 60 days. Alternatively, you can forcefully demote domain controllers that have not performed any inbound replication on a given partition in tombstone lifetime number of days and remove their remaining metadata from the Active Directory forest by using Ntdsutil and other utilities. Contact your support provider or Microsoft PSS for additional help.
    3. Verify that the contents of the Sysvol share are consistent.

        Verify that the file system portion of group policy is consistent. You can use Gpotool.exe from the Resource Kit to determine whether there are inconsistencies in policies across a domain. Use Healthcheck from the Windows Server 2003 support tools to determine whether the Sysvol share replica sets function correctly in each domain.

        If the contents of the Sysvol share are inconsistent, resolve all the inconsistencies.
    4. Use Dcdiag.exe from the support tools to verify that all the domain controllers have shared Netlogon and Sysvol shares. To do so, type the following command at a command prompt:

        ```console
        DCDIAG.EXE /e /test:frssysvol
        ```

    5. Inventory the operations roles.

        The schema and infrastructure operations masters are used to introduce forest and domain-wide schema changes to the forest and its domains that are made by the Windows Server 2003 adprep utility. Verify that the domain controller that hosts the schema role and infrastructure role for each domain in the forest reside on live domain controllers and that each role owner has performed inbound replication over all partitions since they were last restarted.

        The `DCDIAG /test:FSMOCHECK` command can be used to view forest-wide and domain-wide operational roles. Operations master roles that reside on non-existent domain controllers should be seized to a healthy domain controller by using NTDSUTIL. Roles that reside on unhealthy domain controllers should be transferred if possible. Otherwise, they should be seized. The `NETDOM QUERY FSMO` command doesn't identify FSMO roles that reside on deleted domain controllers.

        Verify that the have performed inbound replication of Active Directory since last booted. Inbound replication can be verified by using the `REPADMIN /SHOWREPS DCNAME` command, where **DCNAME** is the NetBIOS computer name or the fully qualified computer name of a domain controller. For more information about operations masters and their placement, click the following article numbers to view the articles in the Microsoft Knowledge Base:

        [197132](https://support.microsoft.com/help/197132) Windows 2000 Active Directory FSMO roles  

        [223346](https://support.microsoft.com/help/223346) FSMO placement and optimization on Active Directory domain controllers  

    6. EventLog Review

        Examine the event logs on all the domain controllers for problematic events. The event logs must not contain serious event messages that indicate a problem with any of the following processes and components:

        physical connectivity  
        network connectivity  
        name registration  
        name resolution  
        authentication  
        Group Policy  
        security policy  
        disk subsystem  
        schema  
        topology  
        replication engine  

    7. Disk Space Inventory

        The volume that hosts the Active Directory database file, Ntds.dit, must have free space equal to at least 15-20% of the Ntds.dit file size. The volume that hosts the Active Directory log file must also have free space equal to at least 15-20% of the Ntds.dit file size. For more information about how to free up additional disk space, see the "Domain Controllers Without Sufficient Disk Space" section of this article.
    8. DNS Scavenging (Optional)

        Enable DNS Scavenging at 7-day intervals for all DNS servers in the forest. For best results, perform this operation 61 or more days before you upgrade the operating system. This provides the DNS scavenging daemon sufficient time to garbage-collect the aged DNS objects when an offline defragmentation is performed on the Ntds.dit file.
    9. Disable the DLT Server Service (Optional)

        The DLT Server service is disabled on new and upgraded installations of Windows Server 2003 domain controllers. If distributed link tracking isn't used, you can disable the DLT Server service on your Windows 2000 domain controllers and begin deleting DLT objects from each domain in the forest. For more information, see the "Microsoft Recommendations for distributed link tracking" section of the following article in the Microsoft Knowledge Base: [312403](https://support.microsoft.com/help/312403) Distributed Link Tracking on Windows-based domain controllers  

    10. System State Backup

        Make a system state backup of at least two domain controllers in every domain in the forest. You can use the backup to recover all the domains in the forest if the upgrade doesn't work.

## Microsoft Exchange 2000 in Windows 2000 forests

> [!Note]
>
> - If Exchange 2000 Server is installed, or will be installed, in a Windows 2000 forest, read this section before you run the Windows Server 2003 `adprep /forestprep` command.
> - If Microsoft Exchange Server 2003 schema changes will be installed, go to the "[Overview: Upgrading Windows 2000 domain controllers to Windows Server 2003](#overview-upgrading-windows-2000-domain-controllers-to-windows-server-2003)" section before you run the Windows Server 2003 `adprep` commands.

The Exchange 2000 schema defines three inetOrgPerson attributes with non-Request for Comment (RFC)-compliant LDAPDisplayNames: houseIdentifier, secretary, and labeledURI.

The Windows 2000 inetOrgPerson Kit and the Windows Server 2003 `adprep` command define RFC-complaint versions of the same three attributes with identical LDAPDisplayNames as the non-RFC-compliant versions.

When the Windows Server 2003 `adprep /forestprep` command is run without corrective scripts in a forest that contains Windows 2000 and Exchange 2000 schema changes, the LDAPDisplayNames for the houseIdentifier, labeledURI, and secretary attributes become mangled. An attribute becomes "mangled" if "Dup" or other unique characters are added to the beginning of the conflicted attribute name so that objects and attributes in the directory have unique names.

Active Directory forests aren't vulnerable to mangled LDAPDisplayNames for these attributes in the following cases:

- If you run the Windows Server 2003 `adprep /forestprep` command in a forest that contains the Windows 2000 schema before you add the Exchange 2000 schema.
- If you install the Exchange 2000 schema in forest that was created where a Windows Server 2003 domain controller was the first domain controller in the forest.
- If you add Windows 2000 inetOrgPerson Kit to a forest that contains the Windows 2000 schema, and then you install Exchange 2000 schema changes, and then you run the Windows Server 2003 `adprep /forestprep` command.
- If you add Exchange 2000 schema to an existing Windows 2000 forest, then run Exchange 2003 /forestprep before you run the Windows Server 2003 `adprep /forestprep` command.

Mangled attributes will occur in Windows 2000 in the following cases:

- If you add the Exchange 2000 versions of the labeledURI, the houseIdentifier, and the secretary attributes to a Windows 2000 forest before you install the Windows 2000 inetOrgPerson Kit.
- You add the Exchange 2000 versions of the labeledURI, the houseIdentifier, and the secretary attributes to a Windows 2000 forest before you run the Windows Server 2003 `adprep /forestprep` command without first running the cleanup scripts. Action plans for each scenario follow:

### Scenario 1: Exchange 2000 schema changes are added after you run the Windows Server 2003 adprep /forestprep command

If Exchange 2000 schema changes will be introduced to your Windows 2000 forest after the Windows Server 2003 `adprep /forestprep` command is run, no cleanup is required. Go to the "[Overview: Upgrading Windows 2000 domain controllers to Windows Server 2003](#overview-upgrading-windows-2000-domain-controllers-to-windows-server-2003)" section.

### Scenario 2: Exchange 2000 schema changes will be installed before the Windows Server 2003 adprep /forestprep command

If Exchange 2000 schema changes have already been installed but you have NOT run the Windows Server 2003 `adprep /forestprep` command, consider the following action plan:

1. Log on to the console of the schema operations master by using an account that is a member of the Schema Admins security group.
2. Click **Start**, click **Run**, type *notepad.exe* in the **Open** box, and then click **OK**.
3. Copy the following text including the trailing hyphen after "schemaUpdateNow: 1" to Notepad.

    > dn: CN=ms-Exch-Assistant-Name,CN=Schema,CN=Configuration,DC=X  
    changetype: Modify  
    replace:LDAPDisplayName  
    LDAPDisplayName: msExchAssistantName  
    \-  
    >
    > dn: CN=ms-Exch-LabeledURI,CN=Schema,CN=Configuration,DC=X  
    changetype: Modify  
    replace: LDAPDisplayName  
    LDAPDisplayName: msExchLabeledURI  
    \-
    >
    > dn: CN=ms-Exch-House-Identifier,CN=Schema,CN=Configuration,DC=X  
    changetype: Modify  
    replace: LDAPDisplayName  
    LDAPDisplayName: msExchHouseIdentifier  
    \-  
    >
    > dn:  
    changetype: Modify  
    add: schemaUpdateNow  
    schemaUpdateNow: 1  
    \-  

4. Confirm that there is no space at the end of each line.
5. On the **File** menu, click **Save**. In the **Save As** dialog box, follow these steps:
    1. In the **File name** box, type the following:
        *\\%userprofile%\\InetOrgPersonPrevent.ldf*
    2. In the **Save as type** box, click **All Files**.
    3. In the **Encoding** box, click **Unicode**.
    4. Click **Save**.
    5. Quit Notepad.
6. Run the InetOrgPersonPrevent.ldf script.
    1. Click **Start**, click **Run**, type *cmd* in the **Open** box, and then click **OK**.
    2. At a command prompt, type the following, and then press ENTER: `cd %userprofile%`

    3. Type the following command

    ```console  
    c:\documents and settings\%username%>ldifde -i -f inetorgpersonprevent.ldf -v -c DC=X "domain name path for forest root domain"
    ```

    Syntax notes:

    - DC=X is a case-sensitive constant.
    - The domain name path for the root domain must be enclosed in quotation marks.

    For example, the command syntax for an Active Directory forest whose forest root domain is `TAILSPINTOYS.COM` would be:

    c:\\documents and settings\\administrator>ldifde -i -f inetorgpersonprevent.ldf -v -c DC=X "dc=tailspintoys,dc=com"
    > [!NOTE]
    > You may need to change the **Schema Update Allowed** registry subkey if you receive the following error message:
    > Schema update is not allowed on this DC because the registry key is not set or the DC is not the schema FSMO Role Owner.

7. Verify that the LDAPDisplayNames for the CN=ms-Exch-Assistant-Name, CN=ms-Exch-LabeledURI, and CN=ms-Exch-House-Identifier attributes in the schema naming context now appear as msExchAssistantName, msExchLabeledURI, and msExchHouseIdentifier before you run the Windows Server 2003 `adprep /forestprep` commands.
8. Go to the "[Overview: Upgrading Windows 2000 domain controllers to Windows Server 2003](#overview-upgrading-windows-2000-domain-controllers-to-windows-server-2003)" section to run the `adprep /forestprep` and `/domainprep` commands.

### Scenario 3: The Windows Server 2003 forestprep command was run without first running inetOrgPersonFix

If you run the Windows Server 2003 `adprep /forestprep` command in a Windows 2000 forest that contains the Exchange 2000 schema changes, the LDAPDisplayName attributes for houseIdentifier, secretary, and labeledURI will become mangled. To identify mangled names, use Ldp.exe to locate the affected attributes:

1. Install Ldp.exe from the Support\\Tools folder of the Microsoft Windows 2000 or Windows Server 2003 media.
2. Start Ldp.exe from a domain controller or member computer in the forest.
      1. On the **Connection** menu, click **Connect**, leave the **Server** box empty, type *389* in the **Port** box, and then click **OK**.
      2. On the **Connection** menu, click **Bind**, leave all the boxes empty, and then click **OK**.
3. Record the distinguished name path for the SchemaNamingContext attribute. For example, for a domain controller in the CORP.ADATUM.COM forest, the distinguished name path might be CN=Schema,CN=Configuration,DC=corp,DC=company,DC=com.
4. On the **Browse** menu, click **Search**.
5. Use the following settings to configure the **Search** dialog box:
   - **Base DN**: The distinguished name path for the schema naming context that is identified in step 3.
   - **Filter**: (ldapdisplayname=dup*)
   - **Scope**: Subtree
6. Mangled houseIdentifier, secretary, and labeledURI attributes have LDAPDisplayName attributes that are similar to the following format:

    LDAPDisplayName: DUP-labeledURI-9591bbd3-d2a6-4669-afda-48af7c35507d;  
    LDAPDisplayName: DUP-secretary-c5a1240d-70c0-455c-9906-a4070602f85f  
    LDAPDisplayName: DUP-houseIdentifier-354b0ca8-9b6c-4722-aae7-e66906cc9eef  

7. If the LDAPDisplayNames for labeledURI, secretary, and houseIdentifier were mangled in step 6, run the Windows Server 2003 InetOrgPersonFix.ldf script to recover, and then go to the "Upgrading Windows 2000 domain controllers with Winnt32.exe" section.
      1. Create a folder named %Systemdrive%\\IOP, and then extract the InetOrgPersonFix.ldf file to this folder.
      2. At a command prompt, type `cd %systemdrive%\iop`.
      3. Extract the InetOrgPersonFix.ldf file from the Support.cab file that is located in the Support\\Tools folder of the Windows Server 2003 installation media.
      4. From the console of the schema operations master, load the InetOrgPersonFix.ldf file by using Ldifde.exe to correct the LdapDisplayName attribute of the houseIdentifier, secretary, and labeledURI attributes. To do so, type the following command, where \<X> is a case-sensitive constant and \<dn path for forest root domain> is the domain name path for the root domain of the forest:

          ```console  
         C:\IOP>ldifde -i -f inetorgpersonfix.ldf -v -c DC=X "domain name path for forest root domain"
          ```

         Syntax notes:

            - DC=X is a case-sensitive constant.
            - The domain name path for the forest root domain must be enclosed in quotation marks.
8. Verify that the houseIdentifier, secretary, and labeledURI attributes in the schema naming context are not "mangled" before you install Exchange 2000.

## Overview: Upgrading Windows 2000 domain controllers to Windows Server 2003

The Windows Server 2003 `adprep` command that you run from the \\I386 folder of the Windows Server 2003 media prepares a Windows 2000 forest and its domains for the addition of Windows Server 2003 domain controllers. The Windows Server 2003 `adprep /forestprep` command adds the following features:

- Improved default security descriptors for object classes

- New user and group attributes
- New Schema objects and attributes like inetOrgPersonThe adprep utility supports two command-line arguments:

  - `adprep /forestprep`: Runs forest upgrade operations.  
  - `dprep /domainprep`: Runs domain upgrade operations.

The `adprep /forestprep` command is a one-time operation performed on the schema operation master (FSMO) of the forest. The forestprep operation must complete and replicate to the infrastructure master of each domain before you can run `adprep /domainprep` in that domain.

The `adprep /domainprep` command is a one-time operation that you run on the infrastructure operations master domain controller of each domain in the forest that will host new or upgraded Windows Server 2003 domain controllers. The `adprep /domainprep` command verifies that the changes from forestprep have replicated in the domain partition and then makes its own changes to the domain partition and group policies in the Sysvol share.

You can't perform either of the following actions unless the /forestprep and the /domainprep operations have completed and replicated to all the domain controllers in that domain:

- Upgrade the Windows 2000 domain controllers to Windows Server 2003 domain controllers by using Winnt32.exe.

> [!NOTE]
> You can upgrade the Windows 2000 member servers and computers to Windows Server 2003 member computers whenever you want.
> Promote new Windows Server 2003 domain controllers into the domain by using Dcpromo.exe.The domain that hosts the schema operations master is the only domain where you must run both `adprep /forestprep` and `adprep /domainprep`. In all other domains, you only have to run `adprep /domainprep`.

The `adprep /forestprep` and the `adprep /domainprep` commands don't add attributes to the global catalog partial attribute set or cause a full synchronization of the global catalog. The RTM version of `adprep /domainprep` does cause a full sync of the \\Policies folder in the Sysvol tree. Even if you run forestprep and domainprep several times, completed operations are performed only one time.

After the changes from `adprep /forestprep` and `adprep /domainprep` completely replicate, you can upgrade the Windows 2000 domain controllers to Windows Server 2003 by running Winnt32.exe from the \I386 folder of the Windows Server 2003 media. Also, you can add new Windows Server 2003 domain controllers to the domain by using Dcpromo.exe.

### Upgrading the forest with the adprep /forestprep command

To prepare a Windows 2000 forest and domains to accept Windows Server 2003 domain controllers, follow these steps first in a lab environment, then in a production environment:

1. Make sure that you've completed all the operations in the "Forest Inventory" phase with special attention to the following items:
      1. You have created system state backups.
      2. All the Windows 2000 domain controllers in the forest have installed all the appropriate hotfixes and service packs.
      3. End-to-end replication of Active Directory is occurring throughout the forest
      4. FRS replicates the file system policy correctly throughout each domain.
2. Log on to the console of the schema operations master with an account that is a member of the Schema Admins security group.
3. Verify that the schema FSMO has performed inbound replication of the schema partition by typing the following at a Windows NT command prompt:
    `repadmin /showreps`

    ( repadmin is installed by the Support\\Tools folder of Active Directory.)
4. Early Microsoft documentation recommends that you isolate the schema operations master on a private network before you run `adprep /forestprep`. Real-world experience suggests that this step isn't necessary and may cause a schema operations master to reject schema changes when it's restarted on a private network.

5. Run `adprep` on the schema operations master. To do so, click **Start**, click **Run**, type *cmd*, and then click **OK**. On the schema operations master, type the following command:

    ```console
     X:\I386\adprep /forestprep
    ```

    where **X:\\I386\\** is the path of the Windows Server 2003 installation media. This command runs the forest-wide schema upgrade.

    > [!NOTE]
    > Events with event ID 1153 that are logged in the Directory Service event log, such as the sample that follows, can be ignored:
6. Verify that the `adprep /forestprep` command successfully ran on the schema operations master. To do so, from the console of the schema operations master, verify the following items:
       - The `adprep /forestprep` command completed without error.
       - The CN=Windows2003Update object is written under CN=ForestUpdates,CN=Configuration,DC= **forest_root_domain**. Record the value of the Revision attribute.
       - (Optional) The schema version incremented to version 30. To do so, see the ObjectVersion attribute under CN=Schema,CN=Configuration,DC= **forest_root_domain**.If `adprep /forestprep` doesn't run, verify the following items:
      - The fully qualified path for Adprep.exe located in the \\I386 folder of the installation media was specified when `adprep` ran. To do so, type the following command:

        ```console
        x:\i386\adprep /forestprep
        ```

        where **x** is the drive that hosts the installation media.
      - The logged on user who runs adprep has membership to the Schema Admins security group. To verify this, use the `whoami /all` command.
      - If `adprep` still doesn't work, view the Adprep.log file in the %systemroot%\\System32\\Debug\\Adprep\\Logs\\**Latest_log** folder.
7. If you disabled outbound replication on the schema operations master in step 4, enable replication so that the schema changes that were made by `adprep /forestprep` can propagate. To do this, following these steps:
      1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
      2. Type the following, and then press ENTER: repadmin /options -DISABLE_OUTBOUND_REPL

8. Verify that the `adprep /forestprep` changes have replicated on all the domain controllers in the forest. It's useful to monitor the following attributes:
      1. Incrementing the schema version
      2. The CN=Windows2003Update, CN=ForestUpdates,CN=Configuration,DC= **forest_root_domain** or CN=Operations,CN=DomainUpdates,CN=System,DC= **forest_root_domain** and the operations GUIDs under it have replicated in.
      3. Search for new schema classes, objects, attributes, or other changes that `adprep /forestprep` adds, such as inetOrgPerson. View the Sch **XX**.ldf files (where **XX** is a number between 14 and 30) in the %systemroot%\System32 folder to determine what objects and attributes there should be. For example, inetOrgPerson is defined in Sch18.ldf.
9. Look for mangled LDAPDisplayNames.
    If you find mangled names, go to Scenario 3 of the same article.
10. Log on to the console of the schema operations master with an account that is a member of the Schema Admins group security group of the forest that hosts the schema operations master.

### Upgrading the domain with the adprep /domainprep command

Run `adprep /domainprep` after the /forestprep changes fully replicate to the infrastructure master domain controller in each domain that will host Windows Server 2003 domain controllers. To do so, follow these steps:

1. Identify the infrastructure master domain controller in the domain you're upgrading, and then log on with an account that is a member of the Domain Admins security group in the domain you're upgrading.

    > [!NOTE]
    > The enterprise administrator may not be a member of the Domain Admins security group in child domains of the forest.
2. Run `adprep /domainprep` on the Infrastructure master. To do so, click Start, click Run, type *cmd*, and then on the Infrastructure master type the following command: `X:\I386\adprep /domainprep`
where X:\\I386\\ is the path of the Windows Server 2003 installation media. This command runs domain-wide changes in the target domain.

    > [!NOTE]
    > The `adprep /domainprep` command modifies files permissions in the Sysvol share. These modifications cause a full synchronization of files in that directory tree.
3. Verify that domainprep completed successfully. To do so, verify the following items:
      - The `adprep /domainprep` command completed without error.
      - The CN=Windows2003Update,CN=DomainUpdates,CN=System,DC= **dn path of domain you are upgrading** existsIf `adprep /domainprep` doesn't run, verify the following items:
      - The logged on user who runs `adprep` has membership to the Domain Admins security group in the domain being you're upgrading. To do so, use the `whoami /all` command.
      - The fully qualified path for Adprep.exe located in the \\I386 directory of the installation media was specified when you ran `adprep`. To do so, at a command prompt type the following command: `x :\i386\adprep /forestprep`
    where **x** is the drive that hosts the installation media.
      - If `adprep` still doesn't work, view the Adprep.log file in the %systemroot%\\System32\\Debug\\Adprep\\Logs\\ **Latest_log** folder.
4. Verify that the `adprep /domainprep` changes have replicated. To do so, for the remaining domain controllers in the domain, verify the following items:
       - The CN=Windows2003Update,CN=DomainUpdates,CN=System,DC= **dn path of domain you are upgrading** object exists and the value for the Revision attribute matches the value of the same attribute on the infrastructure master of the domain.
       - (Optional) Look for objects, attributes, or access control list (ACL) changes that `adprep /domainprep` added. Repeat steps 1-4 on the infrastructure master of the remaining domains in bulk or as you add or upgrade DCs in those domains to Windows Server 2003. Now you can promote new Windows Server 2003 computers into the forest by using DCPROMO. Or, you can upgrade existing Windows 2000 domain controllers to Windows Server 2003 by using WINNT32.EXE.

## Upgrading Windows 2000 domain controllers by using Winnt32.exe

After the changes from /forestprep and /domainprep completely replicate and you have made a decision about security interoperability with earlier-version clients, you can upgrade Windows 2000 domain controllers to Windows Server 2003 and add new Windows Server 2003 domain controllers to the domain.

The following computers must be among the first domain controllers that run Windows Server 2003 in the forest in each domain:

- The domain naming master in the forest so that you can create default DNS program partitions.
- The primary domain controller of the forest root domain so that the enterprise-wide security principals that Windows Server 2003's forestprep adds become visible in the ACL editor.
- The primary domain controller in each non-root domain so that you can create new domain-specific Windows 2003 security principals. To do so, use WINNT32 to upgrade existing domain controllers that host the operational role you want. Or, transfer the role to a newly promoted Windows Server 2003 domain controller. Perform the following steps for each Windows 2000 domain controller that you upgrade to Windows Server 2003 with WINNT32 and for each Windows Server 2003 workgroup or member computer that you promote:

1. Before you use WINNT32 to upgrade Windows 2000 member computers and domain controllers, remove Windows 2000 Administration Tools. To do so, use the Add/Remove Programs tool in Control Panel. (Windows 2000 upgrades only.)
2. Install any hotfix files or other fixes that either Microsoft or the administrator determines is important.
3. Check each domain controller for possible upgrade issues. To do so, run the following command from the \\I386 folder of the installation media: `winnt32.exe /checkupgradeonly`
Resolve any issues that the compatibility check identifies.
4. Run WINNT32.EXE from the \\I386 folder of the installation media, and the restart the upgraded 2003 domain controller.
5. Lower the security settings for earlier-version clients as required.

    If Windows NT 4.0 clients don't have NT 4.0 SP6 or Windows 95 clients don't have the directory service client installed, disable SMB Service signing on the Default Domain Controllers policy on the Domain Controllers organizational unit, and then link this policy to all organizational units that host domain controllers. Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options\\Microsoft Network Server: Digitally sign communications (always)

6. Verify the health of the upgrade using the following data points:
   - The upgrade completed successfully.
   - The hotfixes that you added to the installation successfully replaced the original binaries.
   - Inbound and outbound replication of Active Directory is occurring for all naming contexts held by the domain controller.
   - The Netlogon and Sysvol shares exist.
   - The event log indicates that the domain controller and its services are healthy.

    > [!NOTE]
    > You may receive the following event message after you upgrade:
    You can safely ignore this event message.
7. Install the Windows Server 2003 Administration Tools (Windows 2000 upgrades and Windows Server 2003 non-domain controllers only). Adminpak.msi is in the \\I386 folder of the Windows Server 2003 CD-ROM. Windows Server 2003 media contains updated support tools in the Support\\Tools\\Suptools.msi file. Make sure that you reinstall this file.
8. Make new backups of at least the first two Windows 2000 domain controllers that you upgraded to Windows Server 2003 in each domain in the forest. Locate the backups of the Windows 2000 computers that you upgraded to Windows Server 2003 in locked storage so you don't accidentally use them to restore a domain controller that now runs Windows Server 2003.
9. (Optional) Perform an offline defragmentation of the Active Directory database on the domain controllers that you upgraded to Windows Server 2003 after the single instance store (SIS) has completed (Windows 2000 upgrades only).

    The SIS reviews existing permissions on objects stored in Active Directory, and then applies a more efficient security descriptor on those objects. The SIS starts automatically (identified by event 1953 in the directory service event log) when upgraded domain controllers first start the Windows Server 2003 operating system. You benefit from the improved security descriptor store only when you log an event ID 1966 event message in the directory service event log: This event message indicates that the single instance store operation has completed and serves as a queue the administrator to perform of offline defragmentation of the Ntds.dit using NTDSUTIL.EXE.

    The offline defragmentation can reduce the size of a Windows 2000 Ntds.dit file by up to 40%, improves Active Directory performance, and updates the pages in the database for more efficient storage of Link Valued attributes. For more information about how to defragment the Active Directory database, click the following article number to view the article in the Microsoft Knowledge Base:

    [232122](https://support.microsoft.com/help/232122) Performing offline defragmentation of the Active Directory database  

10. Investigate the DLT Server Service. Windows Server 2003 domain controllers disable the DLT Server service on fresh and upgrade installs. If Windows 2000 or Windows XP clients in your organization use the DLT Server service, use Group Policy to enable the DLT Server service on new or upgraded Windows Server 2003 domain controllers. Otherwise, incrementally delete distributed link tracking objects from Active Directory. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

    [312403](https://support.microsoft.com/help/312403) Distributed Link Tracking on Windows-based domain controllers  

    If you bulk delete thousands of DLT objects or other objects, you may block replication because of a lack of version store. Wait **tombstonelifetime** number of days (by default, 60 days) after you delete the last DLT object and for garbage collection to complete, then use NTDSUTIL.EXE to perform an offline defragmentation of the Ntds.dit file.

11. Configure the best practice organizational unit structure. Microsoft recommends that administrators actively deploy the best practice organizational unit structure in all the Active Directory domains, and after they upgrade or deploy Windows Server 2003 domain controllers in Windows Domain mode, redirect the default containers that earlier-version APIs use to create users, computers, and groups to an organizational unit container that the administrator specifies.

    For additional information about the best practice organizational unit structure, view the "Creating an Organizational Unit Design" section of the "Best Practice Active Directory Design for Managing Windows Networks" white paper. To view the white paper, visit the following Microsoft Web site: [https://technet.microsoft.com/library/bb727085.aspx](https://technet.microsoft.com/library/bb727085.aspx)
     For more information about changing the default container where users, computers, and groups that earlier-version APIs create are located, click the following article number to view the article in the Microsoft Knowledge Base:

    [324949](https://support.microsoft.com/help/324949) Redirecting the users and computers containers in Windows Server 2003 domains  

12. Repeat steps 1 through 10 as required for each new or upgraded Windows Server 2003 domain controller in the forest and step 11 (Best Practice organizational unit structure) for each Active Directory domain.

    In Summary:
       - Upgrade Windows 2000 Domain controllers with WINNT32 (from the slipstreamed installation media if used)
       - Verify the hotfixes files have been installed on the upgraded computers
       - Install any required hotfixes not contained on installation media
       - Verify the health on new or upgraded servers (AD, FRS, Policy, and so on)
       - Wait 24 hours after OS upgrade then offline defrag (optional)
       - Start the DLT Service if you must, otherwise delete DLT objects using q312403 / q315229 post forest-wide domainpreps
       - Perform offline defrag 60+ days (tombstone lifetime and garbage collection # of days) after deleting DLT objects

## Dry-run upgrades in a lab environment

Before you upgrade Windows domain controllers to a production Windows 2000 domain, validate and refine your upgrade process in the lab. If the upgrade of a lab environment that accurately mirrors the production forest performs smoothly, you can expect similar results in production environments. For complex environments, the lab environment must mirror the production environment in the following areas:

- Hardware: computer type, memory size, page file placement, disk size, performance and raid configuration, BIOS and firmware revision levels
- Software: client and server operating system versions, client and server applications, service pack versions, hotfixes, schema changes, security groups, group memberships, permissions, policy settings, object count type, and location, version interoperability
- Network infrastructure: WINS, DHCP, link speeds, available bandwidth
- Load: Load simulators can simulate password changes, object creation, Active Directory replication, logon authentication and other events. The goal isn't to reproduce the scale of the production environment. Instead, the goals are to discover the costs and frequency of common operations and to interpolate their effects (name queries, replication traffic, network bandwidth, and processor consumption) on the production environment based on your current and future requirements.
- Administration: tasks performed, tools used, operating systems used
- Operation: capacity, interoperability
- Disk Space: Note the starting, peak, and ending size of the operating system, Ntds.dit, and Active Directory log files on global catalog and non-global catalog domain controllers in each domain after each of the following operations:
  1. `adprep /forestprep`
  2. `adprep /domainprep`
  3. Upgrading Windows 2000 domain controllers to Windows Server 2003
  4. Performing offline defragmentation after version upgrades
  
An understanding of the upgrade process and complexity of the environment combined with detailed observation determines the pace and degree of care that you apply to upgrading production environments. Environments with a small number of domain controllers and Active Directory objects connected over high availability wide area network (WAN) links might upgrade in only a few hours. You may have to take more care with enterprise deployments that have hundreds of domain controllers or hundreds of thousands of Active Directory objects. In such cases, you may want to perform the upgrade over the course of several weeks or months.

Use "Dry-run" upgrades in the lab to perform the following tasks:

- Understand the inner workings of the upgrade process and the associated risks.
- Expose potential problem areas for the deployment process in your environment.
- Test and develop fall-back plans in case the upgrade doesn't succeed.
- Define the appropriate level of detail to apply to the upgrade process for the production domain.

## Domain controllers without sufficient disk space

On domain controllers with insufficient disk space, use the following steps to free up additional disk space on the volume that hosts the Ntds.dit and Log files:

1. Delete the unused files including *.tmp files or cached files that internet browsers use. To do so, type the following commands (press ENTER after each command):

    ```console
    cd /d drive\  
    del *.tmp /s  
    ```

2. Delete any user or memory dump files. To do so, type the following commands (press ENTER after each command):

     ```console
    cd /d drive\  
    del *.dmp /s  
    ```

3. Temporarily remove or relocate files that you can access from other servers or easily reinstall. Files that you can remove and easily replace include ADMINPAK, Support Tools, and all the files in the %systemroot%\\System32\\Dllcache folder.
4. Delete old or unused user profiles. To do so, click **Start**, right-click **My Computer**, click **Properties**, click the **User Profiles** tab, and then delete all the profiles that are for old and unused accounts. Don't delete any profiles that may be for service accounts.
5. Delete the symbols at %systemroot%\\Symbols. To do so, type the following command: `rd /s %systemroot%\symbols`
Depending on whether the servers have a full or small symbol set, this may gain approximately 70 MB to 600 MB.
6. Perform an offline defragmentation. An offline defragmentation of the Ntds.dit file may free up space but temporarily requires double the space of the current DIT file. Perform the offline defrag by using other local volumes if one is available. Or, use space on a best connected network server to perform the offline defragmentation. If the disk space is still not sufficient, incrementally delete unnecessary user accounts, computer accounts, DNS records, and DLT objects from Active Directory.

> [!NOTE]
> Active Directory does not delete objects from the database until **tombstonelifetime** number of days (by default, 60 days) have passed and the garbage collection completes. If you reduce **tombstonelifetime** to a value lower than end-to-end replication in the forest, you may cause inconsistencies in Active Directory.
