---
title: Recovery process of a DFS namespace
description: Describes the methods to recover a Distributed File System Namespace (DFSN)
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Recovery process of a DFS Namespace in Windows 2003 and 2008 Server

This article describes the methods by which to recover a Distributed File System Namespace (DFSN) in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969382

## Rapid publishing

Rapid publishing articles provide information directly from within the Microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.

## More information

The recovery process of a DFS Namespace depends on how the namespace configuration data was lost, the type of Namespace (domain or standalone), and what types of backups exist of the data. The data may have been inappropriately modified through the DFS management tools, deleted directly within Active Directory or the registry, or corrupted. Backups types of the configuration data include System-state backups of a domain controller, backups of DFS Roots/Namespace servers, exported data via the dfsutil.exe utility, and DFS service registry keys.

Background:

Before beginning the recovery process, determine if the loss of the DFS Namespace was due to accidental administrative deletion of the namespace contents or by loss/corruption of the DFS configuration data.  

> DFSN Recovery options:  
Standalone DFSN  
Registry data deleted?  
Use system-state backup of Namespace server, see recovery option 1 of Standalone DFS Root and Links  
Use exported copy of the DFSN namespace using DFSUTIL, see recovery option 2 of Standalone DFS Root and Links  
Recreate the DFS Namespace  
Root or Link share deleted?  
Use system-state backup of namespace server, see recovery option 1 of Shared folders  
Use saved share configuration registry data, see recovery option 2 of Shared fodlers
>
> Domain DFSN  
Active Directory configuration data is deleted?  
Restore the Active Directory DFS configuration data from backup, see recovery option 1 of Domain DFS Root and Links  
Use exported copy of the DFSN domain namespace using DFSUTIL, see recovery option 2 of DFS Root and Links  
Recreate the namespace, see recovery option 3 of DFS Root and Links  
Registry data deleted?  
Use system-state backup of Namespace server to recover the registry  
Recreate the namespace, see recovery option 3 of DFS Root and Links
>
> Root or Link share deleted?  
Use system-state backup of namespace server, see recovery option 1 of Shared folders  
Use saved share configuration registry data, see recovery option 2 of Shared fodlers  

The following chart details how the data (Active Directory or registry of a DFS namespace server) is impacted by various operations against a DFS namespace:

|<br/><br/>Namespace type<br/>|<br/><br/>Modification type<br/>|<br/><br/>Resulting configuration changes<br/>|
|---|---|---|
|<br/><br/>Domain <br/>|<br/><br/>Domain DFS Root or Links<br/>|<br/><br/>Active Directory, Registry<br/>|
|<br/><br/>Standalone<br/>|<br/><br/>Standalone Root/Link<br/>|<br/><br/>Registry<br/>|
|<br/><br/>Domain/Standalone<br/>|<br/><br/>Shared folders<br/>|<br/><br/>File System, Registry<br/>|
  
Utilize the dfsutil.exe utility to view the contents of the DFS configuration. Dfsutil is available within the Windows Server 2003 and the Windows XP Support Tools package, and it is included with Windows Server 2008 once the Distributed File System Role Service is installed via Server Manager. The following data lists the configuration for the DFS namespace/root named "DATA" after running the commands `dfsutil /root:\\contoso.com\DATA /view` (on 2003) or `dfsutil root \\contoso.com\DATA` (on 2008):

> DFS Utility Version 5.2 (built on 5.2.3790.3959)
>
> Copyright (c) Microsoft Corporation. All rights reserved.
>
> Domain Root with 1 Links [Blob Size: 704 bytes]
>
> SiteCosting:ENABLED
>
> Root Name="\\CONTOSO\DATA" State="1" Timeout="300" Attributes="64"
>
> Target Server="2003SERVER1" Folder="DATA" State="2"[Site: Default-First-Site-Name]
>
> Link Name="documentation" State="1" Timeout="1800"
>
> Target Server="2003server1" Folder="documentation" State="2"[Site: Default-First-Site-Name]
>
> Target Server="2003server2" Folder="documentation" State="2"[Site: Default-First-Site-Name]
>
> Root with 1 Links [Blob Size: 704 bytes]

This DFS namespace contains a single folder/link called "Documentation" and contains two folder/link targets, \\\\2003server1\documentation and \\\\2003server2\documentation.

The DFS configuration Data queried by DFSUtil is stored within the following location within Active Directory:  

> CN=Dfs-Configuration,CN=System,DC=\<domain DN>

In Windows Server 2003, each Domain DFS Root/Namespace is stored within an "fTDfs" object that contains an attribute "pKT" containing the configuration data (namespace settings, namespace servers, folder targets, etc). For instance, the "DATA" namespace listed in the dfsutil.exe output above is located with an fTDfs object at this location: CN=DATA,CN=Dfs-Configuration,CN=System,DC=\<domain DN>. No parts of this object should ever be modified directly.  

> CN=Dfs-Configuration,CN=System,DC=\<domain DN>
 |_fTDfs

In Windows Server 2008, Domain DFS Roots/Namespaces may be configured in "Windows Server 2008 mode". In this mode, configuration data is stored under an msDFS-NamespaceAnchor class object. An object of class "msDFS-Namespacev2" represents each root, and each root contains an msDFS-Linkv2 object representing each hosted link.  

>CN=Dfs-Configuration,CN=System,DC=\<domain DN>  
 |_msDFS-NamespaceAnchor  
 |_msDFS-Namespacev2  
 |_msDFS-Linkv2  

Each DFS Namespace/Root server utilizes registry data to identify the root(s) it hosts. Without this information, the DFS service would not obtain the configuration data from Active Directory and would fail to host the root(s).  

For 2003/2008 domain-based DFS roots, this key stores the root associations:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\Domain`

For "Windows Server 2008 mode" roots, the following key stores the root associations:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\DomainV2`

Within this key exists a subkey for each root hosted by the server and specifies the root share via two values "LogicalShare" and "RootShare". The key for the "DATA" root would be as follows:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\Domain\DATA`

For standalone DFS roots, configuration data isn't stored within Active Directory. Configuration data is stored within the following location:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\Standalone`

Beneath the "Standalone" key exists subkeys for the specific standalone root(s) hosted by the server, and within each, subkeys containing configuration data for the hosted folders/links.

The file server shares specified by the "LogicalShare" and "RootShare" registry values must exist and be accessible for proper operation of a DFS root. Access will be denied to a root if the share is missing or is configured with inappropriate permissions. It is recommended to never directly edit these registry values.

Backup:

To back up a DFS Namespace server, a system-state backup is required. The backup will contain the registry configuration for the server's DFS service. If the domain-based namespace server is also a domain controller, the system-state will also include a backup of the Active Directory database, where domain-based DFS namespaces store the configuration data. For namespace servers not running on domain controllers, ensure at least one domain controller is backed up regularly to prevent the loss of configuration data in the event a domain controller experiences a failure. Lastly, ensure the DFS-related folders residing on the server are included within the backup.

For additional details about system-state backups and restorations, please see the following articles:

Windows Server 2003  
[How Backup Works](https://technet.microsoft.com/library/cc759141.aspx)

Windows Server 2008  
[Windows Server Backup Step-by-Step Guide for Windows Server 2008](https://technet.microsoft.com/library/cc770266.aspx)

Note the typical shelf life of a system-state backup of Active Directory is only 60 days:  
[Useful shelf life of a system-state backup of Active Directory](https://support.microsoft.com/kb/216993)

An alternate method to save the DFS configuration data is via the DFSUtil.exe utility. The output created via the "export" option may be used to recreate the missing DFS configuration information lost through accidental deletion.

_Recovery:_  

Once the scope of the modifications has been identified, the appropriate recovery process should be performed.

Domain DFS Root and Links

Option 1 - Restore the Active Directory DFS configuration data from backup

For domain-based DFS, modification of a DFS root via a management tool has the largest potential impact to the namespace. This is because whenever modifications are performed via DFS API's, all root servers are notified of the changes and they will update their registry as required. Thus, restoration of the DFS configuration within Active Directory from backups may also require the task of recovering the registry of root servers.

Authoritatively restore the DFS configuration blob. This requires the startup of a DC in DS restore mode, restoring the Active Directory database from a backup that still contains a valid copy of the DFS configuration, marking the DFS root directory object as authoritative, and replicating this throughout the domain. DFS roots, by default, obtain DFS configuration data from the PDC FSMO role owner domain controller. To prevent replication latencies from impacting the time until the roots begin hosting the restored namespace(s), consider using the PDC FSMO as the domain controller to restore.

The authoritative restoration process is detailed in the following article:

Performing an Authoritative Restore of Active Directory Objects

[Performing an Authoritative Restore of Active Directory Objects](https://technet.microsoft.com/library/cc779573.aspx)

Restoring Active Directory:  

Windows Server 2003:  
[Restore Active Directory from backup](https://technet.microsoft.com/library/cc758435.aspx)  
  
1. Start the computer in Directory Services Restore Mode.  
2. To start the Windows Server 2003 backup utility, click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup.  
3. On the Welcome to the Backup or Restore Wizard page, click Next.  
4. Click Restore files and settings, and then click Next.  
5. Select System State, and then click Next.  
6. On the Completing the Backup or Restore Wizard page, click Advanced.  
7. In Restore files to, click Original Location, and then click Next.  
8. Click Leave existing files (Recommended), and then click Next.  
9. Click Finish.  
10. When the restore process is complete, click Close, and then click No to remain in Directory Services Restore Mode.  

> [!NOTE]
> Do not reboot when prompted by the backup program. If a reboot is performed and Active Directory replication takes place, the domain controller will replicate the deletions again.

Windows Server 2008:  
[Performing a Nonauthoritative Restore of AD DS](https://technet.microsoft.com/library/cc730683.aspx)

1. At the Windows logon screen, click Switch User, and then click Other User.

2. Type .\administrator as the user name, type the DSRM password for the server, and then press ENTER.

3. Click Start, right-click Command Prompt, and then click Run as Administrator.

4. At the command prompt, type the following command, and then press ENTER:

    ```console
    wbadmin get versions -backuptarget:\<targetDrive>:

    -machine:\<BackupComputerName>
    ```

    Where:

    \<targetDrive> is the location of the backup that you want to restore.

    \<BackupComputerName> is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.

5. Identify the version that you want to restore. You must enter this version exactly in the next step.

6. At the command prompt, type the following command (wrapped for readability), and then press ENTER:

    ```console
    wbadmin start systemstaterecovery -version:<MM/DD/YYYY-HH:MM>

    -backuptarget:<targetDrive>: -machine:<BackupComputerName>

    -quiet
    ```

Marking the DFS configuration data authoritative:  

It is important to know the distinguished name of the namespace(s) to be restored so that the DFS root object(s) may be marked authoritatively. It should be in the format "CN=\<rootname>,CN=DFS-Configuration,CN=System,DC=" and may need to be enclosed in quotation marks if spaces exist within any labels.

1. In Directory Services Restore Mode, click Start, click Run, type ntdsutil, and then press ENTER.

2. At the ntdsutil: prompt, type authoritative restore, and then press ENTER.

3. To restore a subtree of objects, type the following command and then press ENTER:

    restore subtree DistinguishedName

    For example, to restore all DFS Namespace objects in the domain `contoso.com`, type:

    restore subtree "CN=Dfs-Configuration,CN=System,DC=contoso,dc=com"
    > [!Warning]
    > All DFS namespaces will be affected by this operation, returning them to the state contained in the backup.

    To restore a single DFS Namespace object for a root named "DATA" in the domain `contoso.com`, type:

    restore subtree "CN=DATA,CN=Dfs-Configuration,CN=System,DC=contoso,dc=com"

    Restoring a subtree of objects ensures the operation will complete successfully for both v1 and v2 namespaces.

4. Click Yes in the message box to confirm the command.

5. At the authoritative restore: and ntdsutil: prompts, type quit, and then press ENTER.

6. Restart the domain controller in normal operating mode.

7. Allow Active Directory replication sufficient time to replicate the objects throughout the domain.

Verify registry data on all DFS roots  

Each domain DFS namespace/root server must have proper registry data under the location `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\Domain` in order to properly host the restored DFS root(s). If the DFS namespace was deleted via a DFS management tool, you may have to manually create the keys and "LogicalShare" and "RootShare" values on each root. Once the registry data is in place, restart the DFS service on each root to reinitialize DFS and obtain the restored configuration data.  

For example, to create the "LogicalShare" and "RootShare" for a DFS Namespace named "Data" whose shared folder for the root is named "DataShare", the following steps are used:

1. Click Start, click Run, type `regedit` in the Open box, and then click OK.  
2. Locate and then click the following registry subkey:
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfs\Roots\Domain`
3. Right-click Domain, point to New, and then click Key.  
4. Type "Data" as the key name, and then press ENTER.  
5. Right-click the "Data" key, point to New, and then click "String Value".
6. Type "LogicalShare" as the value name.
7. Right-click the "LogicalShare" value, and then click Modify.
8. In the Value data box, type "DataShare", and then click OK.
9. Right-click the "Data" key, point to New, and then click "String Value".
10. Type "RootShare" as the value name.
11. Right-click the "RootShare" value, and then click Modify.
12. In the Value data box, type "DataShare", and then click OK.

Option 2 - Import the DFS configuration if an export is available  

An export of the DFS configuration consists of a text file generated via dfsutil.exe and the following command:  

Windows Server 2003:  

```console
 dfsutil /root:\\contoso.com\DATA /export:DATA-dfs-Root.txt
```  

Windows Server 2008:  

```console
 dfsutil root export \\contoso.com\DATA DATA-dfs-root.txt
```

To recover a namespace via an export file, perform the following:

1. If the root doesn't already exist, create it using DFS Management. Add all appropriate root targets. Dfsutil.exe will fail to import the configuration if the root itself doesn't already exist and will not add root targets as defined in the file. However, you may review the contents of the export file to identify which root targets should be manually added.  

2. Import the configuration file to create all of the hosted links via the commands:
Windows Server 2003:  

    ```console
    dfsutil /root:\\contoso.com\DATA /import: DATA-dfs-Root.txt
    ```

    Windows Server 2008:  

    ```console
    dfsutil root import set DATA-dfs-Root.txt \\contoso.com\DATA
    ```

    (Where the domain is `contoso.com`, "DATA" is the root's name, and `DATA-dfs-Root.txt` is the export file)

    Attempting the import before the root has been created will result in the error "Element not found."  

    Attempting to add a root target that already has registry configuration data associated with the root results in the errors "The device is not ready for use" or "Cannot create a file when that file already exists." To remove the registry data from the affected server, utilize the "clean" option within DFSUtil:

    Windows Server 2003:  

    ```console
    dfsutil /clean /server:<servername> /share:<sharename>
    ```

    Windows Server 2008:  

    ```console
    dfsutil diag clean \\<servername>\<sharename>
    ```

3. Verify the import was successful. You may have to reopen any DFS management tools to observe the imported links.

Option 3 - Recreate the Namespace(s)  

It may be easier to recreate the namespaces as required. This activity will update the configuration within Active Directory and the registry of the roots. If adding a server as a root fails to indicate the root is already hosted by the server, check the registry configuration of the server to ensure that it doesn't already have configuration data for the original root. To remove such data, run the following command:

```console
dfsutil /clean /server:servername /share:sharename
```

(Where "servername" is the server that needs to be added as a new root target and "sharename" is the name of the share to host the root)

On Windows Server 2008:

```console
dfsutil diag clean \\servername\sharename
```

Active Directory fTDfs object

If the ftDfs object within Active Directory was directly deleted, restore the object as detailed in Option 1 of the "Domain DFS Root and Links" section. There should be no need to repair missing registry data, as a direct deletion of the fTDfs object is performed without using DFS API's and no notifications sent to the DFS roots of the deletion.

If an export of the DFS configuration exists, the process will be similar to that in Option 2 of the "Domain DFS Root and Links" section.  

Lastly, you may also recreate the DFS namespace, ensuring each DFS root has been properly cleaned of the previous configuration. See Option 3 of the "Domain DFS Root and Links" section for more details.

Standalone DFS Root and Links

Option 1 - Restore the Standalone DFS configuration data from backup  

If a standalone DFS namespace/root server experiences configuration data loss, it is recommended to restore the system-state of the server from backup. This operation will automatically restore the configuration data to the proper state. Attempting to modify the registry of a standalone DFS root is not recommended.

Option 2 - Import the DFS configuration if an export is available  

If a DFSUTIL.EXE export exists for the root, it may be imported via the commands:

Windows Server 2003:  

```console
dfsutil /root:\\server-name\namespace-name /import: DATA-dfs-Root.txt
```  

Windows Server 2008:  

```console
dfsutil root import set DATA-dfs-Root.txt \\contoso.com\DATA
```

Option 3 - Recreate the Namespace(s)  

It may be easier to recreate the standalone namespace(s) as required.  

Shared folders

If a domain-based or a standalone DFS namespace server experiences loss of a DFS share and the DFS configuration remains, the shares must be recovered to restore DFS functionality.  

Option 1 - Restore the Standalone DFS configuration data from backup  

Restore the system-state from a backup made prior to the loss. The system-state includes the registry data for the server to host the shares. Ensure the folder(s) for the share(s) also are present on the server.

Option 2 - Recover the share configuration data from the registry  

If a system-state backup of a DFS Namespace server is not available but share registry information exists, this information may be used to restore the share configuration of the server. Shares and assigned share permissions are stored in the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares`

To save this registry key using the registry editor, click Export on the File menu.  

This registry key may be imported to the DFS Namespace server or used as a reference of the share names and location of shared folders for manual creation.  

To restore or import the registry key using the registry editor, click Import on the File menu.

Once the shares have been recovered, restart the Namespace server's DFS service to initialize the namespace.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied or statutory, including but not limited to representations, warranties, or conditions of title, non infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
