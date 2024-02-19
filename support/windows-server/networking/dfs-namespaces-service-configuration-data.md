---
title: DFS Namespaces service and configuration
description: Provides information about the Distributed File System (DFS) Namespaces service to help you create a new namespace.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davfish, clandis
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# About the DFS Namespaces service and its configuration data

This article provides some information about the DFS Namespaces service and its configuration data.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 977511

## Summary

The Distributed File System (DFS) Namespaces service stores configuration data in several locations. If some of this data is missing or inaccessible, you may experience failures and be unable to create a namespace.

## Introduction

This article discusses the following topics to help you create a namespace:  

- Storage locations for configuration data.
- Examples of how data becomes inconsistent.
- Methods that you can use to remove orphaned configuration data.
- Symptoms and error messages that you may receive.

## More information

### DFS Namespaces configuration storage locations

The following locations store different configuration data for the Distributed File System (DFS) Namespaces:  

- Active Directory Domain Services (AD DS) stores domain-based namespace configuration data in one or more objects that contain namespace server names, folder targets, and various other configuration data.
- The namespace servers maintain shares for each namespace hosted.
- The registry keys on the domain-based namespace servers store namespace memberships.

    > [!NOTE]
    > On the stand-alone namespace servers, registry keys store all the namespace configuration data.  

If any subset of the configuration data is missing or invalid, you may be unable to manage the namespace. Additionally, you may receive many different error messages when you manage DFS Namespaces by using the DFS Namespaces Microsoft Management Console (MMC) snap-in, the Dfsutil.exe tool, or the Dfscmd.exe tool or when a client accesses the namespace. See the Symptoms and error messages section for a list of possible error messages.

### Examples of how DFS Namespaces configuration data may become inconsistent

- The dfsutil/clean command is performed on a domain-based namespace server. This command removes the namespace registry data. The configuration data that is stored in the AD DS remains and is enumerated by the DFS Namespaces MMC snap-in.
- An authoritative restoration of AD DS is performed to recover a DFS namespace that was deleted by using a DFS management tool such as the DFS Namespaces MMC snap-in or the Dfsutil.exe tool. Although the restoration of AD DS may be successful, the namespace is not operational unless other DFS Namespaces configuration data is also restored or recovered.
- Restoration of the system state for a namespace server by using a backup that was created before the server became a namespace server.
- Active Directory replication failures prevent namespace servers from locating the DFS Namespaces configuration data.
- Incorrect modification or incorrect removal of the share for the namespace on a namespace server.
- Manual manipulation of the registry or of the AD DS namespace configuration data.

### DFS Namespaces configuration cleanup and removal

DFS Namespaces configuration data is managed and maintained by management tools that use DFS APIs. The DFS APIs notify the Active Directory domain controllers and the DFS Namespaces servers about configuration changes. This behavior prevents the configuration data from becoming orphaned and guarantees consistency in the configuration data. If the notification process is inhibited, or if the data is otherwise deleted or lost, follow the cleanup steps that are listed here to remove the configuration data. These changes are not recoverable unless you make a backup of the system state for the domain controller or for the namespace server.

For more information about how to back up the system state of a server that is running Windows Server 2003, visit the following Microsoft Web site:

[https://technet.microsoft.com/library/cc759141.aspx](https://technet.microsoft.com/library/cc759141.aspx)  
For more information about how to back up the system state of a server that is running Windows Server 2008, visit the following Microsoft Web site:

[https://technet.microsoft.com/library/cc770266.aspx](https://technet.microsoft.com/library/cc770266.aspx)  

> [!NOTE]
> The following steps should only be used if recovery of the configuration data is not possible or is not desired.

For more information about the recovery process for a DFS namespace, click the following article number to view the article in the Microsoft Knowledge Base:

[969382](https://support.microsoft.com/help/969382) Recovery process of a DFS Namespace in Windows 2003 and 2008 Server  

  1. For a domain-based DFS namespace, verify the removal of the AD DS namespace configuration data. Before the removal process, you must accurately identify the object that is associated with the malfunctioning or inconsistent namespace. To remove the AD DS namespace configuration data, follow these steps:  

      1. Open the Adsiedit.msc tool. This tool is included in Windows Server 2008 and requires that the AD DS role or tools are installed. This tool is available in Windows Server 2003 Support Tools.

          For more information about the Adsiedit.msc tool, visit the following Microsoft Web site:

          [https://technet.microsoft.com/library/cc773354(WS.10).aspx](https://technet.microsoft.com/library/cc773354%28ws.10%29.aspx)  

      2. Locate the domain partition of the domain hosting the domain-based namespace. Move to the following location:  
            CN=Dfs-Configuration,CN=System,DC= **\<domain DN>**  
            > [!NOTE]
            > The **\<domain DN>** placeholder is the distinguished name of the domain.

            DFS Namespaces store the configuration objects in this location. "Windows 2000 Server mode" namespaces have an "fTDfs" class object that is named identically to the namespace. "Windows Server 2008 mode" namespaces have a "msDFS-NamespaceAnchor" class object that is named identically to the associated namespace and that may contain additional child objects for any configured folders.  
      3. Select the appropriate object such as the "fTDfs" or "msDFS-NamespaceAnchor" object, and then delete it together with any child objects.

            > [!NOTE]
            > Active Directory replication latencies may delay this change operation from propagating to the remote domain controllers.  

  2. On any namespace servers that are hosting the namespace, verify the removal of the DFS namespace registry configuration data. If other functioning namespaces are hosted on the server, make sure that the registry key of only the inconsistent namespace is removed. To remove the DFS namespace registry configuration data, follow these steps:  

      1. In Registry Editor, locate the configuration registry key of the namespace at the appropriate path by using one of the following paths:

          Domain-based DFSN in "Windows Server 2008 mode"  
            **HKEY_LOCAL_MACHINE \Software\Microsoft\Dfs\Roots\domainV2**  
          Stand-alone DFSN  
            **HKEY_LOCAL_MACHINE \Software\Microsoft\Dfs\Roots\Standalone**  
          Domain-based DFSN in "Windows 2000 Server mode"  
            **HKEY_LOCAL_MACHINE\Software\Microsoft\Dfs\Roots\Domain**  

      2. If a registry key that is named identically to the inconsistent namespace is found, use the Dfsutil.exe tool to remove the registry key. For example, run the following command:  
         ```console
         dfsutil /clean /server:<servername> /share:<sharename> /verbose
         ```  

            > [!NOTE]
            > The **servername** placeholder is the name of the server hosting the namespace and the **sharename** placeholder is the name of the root share.
            Or, delete the key manually.
      3. On the namespace server, restart the DFS service in Windows Server 2003 or the DFS Namespaces service in Windows Server 2008 to register the change on the service.  

  3. Remove the file share that was associated with the namespace from the namespace servers. Failure to follow this step may cause the recreation of the namespace to fail because DFS Namespaces may block the namespace creation.

      Windows Server 2003  
      1. Open the Computer Management MMC snap-in. To do it, run the Compmgmt.msc tool.  
      2. Expand **System Tools**, expand **Shared Folders**, and then click **Shares**.  
      3. Right-click the DFS namespace share, and then click **Stop Sharing**. If you receive the following error message, you must restart the server and then try again to remove the share by using Computer Management MMC snap-in:  
          >"The system cannot stop sharing **<\\server\share>** because the shared folder is a Distributed File System (DFS) namespace root"  

      Windows Server 2008  
      1. Open the "Share and Storage Management" MMC snap-in. To do it, run the StorageMgmt.msc tool.  
      2. Right-click the share of the namespace, and then click **Stop Sharing**. If you receive the following error message, you must restart the server and then remove the share by using Computer Management MMC snap-in:  
          >The system cannot stop sharing **<\\server\share>** because the shared folder is a Distributed File System (DFS) namespace root

Changing the DFS namespace configuration data should only be considered after you evaluate all other recovery options. We recommend that you regularly obtain backups of the system state for the DFS namespace servers and for the domain controllers of domain-based DFS namespaces. These backups may be used to restore the namespace configuration to full operation without the risk of having inconsistent DFS namespace configuration data.

### Symptoms and error messages

#### DFS Management MMC (Dfsmgmt.msc)

In the Dfsmgmt.msc tool, you may receive the following error messages:  

- >\\\\`domain.com`\namespace: The Namespace cannot be queried. Element not found.

- >The server you specified already hosts a namespace with this name. Please select another namespace name or another server to host the namespace.

- >A shared folder name "namespace" already exists on the server **\<servername>**. If the existing shared folder is used, the security setting specified within the Edit Settings dialog box will not apply. To have a shared folder created with those settings, you must first remove the existing shared folder.

- >The namespace is not unique in the domain in which the namespace server was created. You must go back to choose a new namespace name, or change the namespace type to stand-alone.

- >\\\ **`domain.com`** \ **namespace1** : The namespace server \\ **servername** \ **namespace1** cannot be added. Cannot create a file when that file already exists.

- >\\\\`domain.com`\namespace: The namespace cannot be queried. The system cannot find the file specified.

- >\\\\`domain.com`\namespace: The namespace cannot be queried. The device is not ready for use.

- >An error occurred while trying to delete share **\<namespacefolder>**. The share must be removed from the Distributed File System before it can be deleted.

#### Distributed File System MMC (Dfsgui.msc)

In the Dfsgui.msc tool, you may receive the following error messages:  

- >The specified DFS root does not exist.

- >The DFS root "namespace1" already exists. Please give a different name for the new DFS root.

- >The following error occurred while creating DFS root on server servername: Cannot create a file when that file already exists.

- >The specified DFS root does not exist.

- >The system cannot find the file specified.

#### Dfsutil.exe

In the Dfsutil.exe tool, you may receive the following error message:  

- >System error 1168 has occurred. Element not found.

#### Dfscmd.exe

In the Dfscmd.exe tool, you may receive the following error messages:  

- >System error 1168 has occurred. Element not found.

- >System error 80 has occurred. The file exists.

- >System error 2 has occurred. The system cannot find the file specified.

#### DFS clients

On a computer that is running the DFS client, you may receive the following error messages:  

- >Windows cannot find '\\\\`domain.com`\namespace\folder'. Make sure you typed the name correctly, and then try again.

- >File not found.

- >Windows cannot access '\\\\`domain.com`\namespace\folder'. Check the spelling of the name. Otherwise, there might be a problem with your network.  
Additional details:  
Error code: 0x80070002 The system cannot find the file specified.

- >Windows cannot access \\\\`domain.com`\namespace1. Error code 0x80070035 The network path was not found.

- >\\\\`domain.com`\namespace\folder is not accessible. You might not have permission to use this network resource. . The network path was not found.

- >Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied.

- >Windows cannot access \\\\`domain.com`\namespace. Check the spelling of the name. Otherwise, there might be a problem with your network.
Additional details:  
Error code: 0x80070035 The network path was not found.

- >The system cannot find the path specified.
