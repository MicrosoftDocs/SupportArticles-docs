---
title: Delegate DFS replication
description: Describes the Active Directory configuration objects that you can use to delegate user rights. Describes how to directly modify the permissions on the configuration objects for each replication group.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, mikelan
ms.custom: sap:dfsr, csstroubleshoot
ms.technology: networking
---
# Delegate DFS replication in Windows Server 2003 R2

This article describes how to directly modify the permissions on the configuration objects for each replication group.

_Applies to:_ &nbsp; Windows Server 2003 R2  
_Original KB number:_ &nbsp; 911604

## Introduction

Distributed File System (DFS) replication uses the Active Directory directory service to store configuration objects. When you use Active Directory, you can delegate user rights more exactly. The DFS Management feature provides high-level delegation support. This support lets you grant users the ability to create a replication group. This support also lets you grant users administrative rights on a replication group that has already been created.

## Configuration objects

It is useful to have an overview of all objects before you view each object in detail. This section describes the objects that are used to configure DFS replication. The permissions to these objects determine which users can perform specific operations on replication groups.

### Global objects

Global objects configure the replica set as a whole. For example, global objects configure the number of replicated folders. Global objects also configure the connections between each member of the replication group.

#### msDFSR-GlobalSettings

This object is created at the following times:

- When the first replication group in a domain is created
- The first time that a user is delegated rights to create replication groups in a domain

This object is created in the system container. By default, only the domain administrator can create this object.

The only security modification to this object that we recommend is to grant users the right to create msDFSR-ReplicationGroup child objects in this container. To use DFS Management for this task, perform the Delegate Management Permissions action on the Replication node.

#### msDFSR-ReplicationGroup

This object contains all the global settings that are specific to a single replication group. To modify the permissions on this container in DFS Management, perform the Delegate Management Permissions action on a replication group. You can grant a user administration rights on a replication group. You can also grant the user control of the msDFSR-ReplicationGroup object and of all the child objects for a replication group. The following attributes are stored in this object:

1. Description  
    The replication group description.
2. msDFSR-Topology  
    The default schedule.

#### msDFSR-Content

This object is created under the msDFSR-ReplicationGroup object when the replication group is created. The msDFSR-Content object contains a msDFSR-ContentSet object for each replicated folder in the replication group.

> [!NOTE]
> No important attributes are stored in this object.

#### msDFSR-ContentSet

A msDFSR-ContentSet object is created for each replicated folder in the replication group. The following attributes are stored in this object:

- Description  
    The description of the replicated folder.
- msDFSR-FileFilter  
    File filter for files is excluded from replication.
- msDFSR-DirectoryFilter  
    Directory filter for folders is excluded from replication.
- msDFSR-DfsPath  
    Path of DFS folder when the replicated folder is published to a DFS namespace.

#### msDFSR-Topology

This object is created under the msDFSR-ReplicationGroup object when the replication group is created. The msDFSR-Topology object contains a msDFSR-Member object for each member of the replication group.

> [!NOTE]
> No important attributes are stored in this object.

#### msDFSR-Member

A msDFSR-Member object is created for each member of the replication group. This object references the computer object for the member. This object contains a msDFSR-Connection object for each connection where this member is the receiving member of the connection. The following attributes are stored in this object:

- msDFSR-ComputerReference  
    A reference to the computer object for the member.

#### msDFSR-Connection

A msDFSR-Connection is created as a child of a msDFSR-Member object for each incoming replication connection to that member. The following attributes are stored in this object:

- msDFSR-Enabled  
    The enabled state of the connection.
- msDFSR-Schedule  
    The custom schedule of the connection.
- msDFSR-Keywords  
    Keywords for the connection.
- msDFSR-RdcEnabled  
    The enabled state of the rRemote Differential Compression.

### Server-local objects

Server-local objects exist in the computer account for each server that participates in a replication. These objects configure individual members of the replication group.

#### msDFSR-LocalSettings

This object is the top-level container for DFS replication objects on a computer account.

#### msDFSR-Subscriber

A msDFSR-Subscriber object is created for each replication group to which a server belongs. This object contains a msDFSR-Subscription object for each replicated folder in the replication group that is specified by the msDFSR-Subscriber object. The following attributes are stored in this object:

- msDFSR-MemberReference  
    A reference to the msDFSR-Member object.

#### msDFSR-Subscription

The msDFSR-Subscription object contains settings that are unique to each replicated folder on the server. The following attributes are stored in this object:

- msDFSR-RootPath  
    The local path of the replicated folder.
- msDFSR-StagingPath  
    The staging path of the replicated folder.
- msDFSR-StagingSizeInMb  
    The size of the staging folder.
- msDFSR-ConflictSizeInMb  
    The size of the conflict folder.
- msDFSR-Enabled  
    The enabled state of the subscription.
- msDFSR-Flags  
    A flag that controls whether deleted files are moved to the conflict folder.

### Detailed delegation

- Grant permissions to create a replication group

    This action is one of the two delegation actions that are available in DFS Management. To manually perform this action in Active Directory Users and Computers, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the Domain\System\DFSR-GlobalSettings node, and then click **Properties**.
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Create All Child objects** permission, and then select **This object only** in the **Apply onto** area.

- Delegate administrative rights to a replication group

    This is the other delegation action that is available in DFS Management. To manually perform this action in Active Directory Users and Computers, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the Domain\System\DFSR-GlobalSettings node, and then click **Properties**.
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Full Control** permission, and then select **This object and all child objects** in the **Apply onto** area.
    5. Add the users or groups to each member's local Administrators group.

- Manage local system settings without being a local administrator

    Typically, the user must be an administrator to manage local computer settings. To enable a user who is not an administrator to manage local computer settings, grant the user direct control of the required objects in Active Directory. To do this, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the computer node, and then click **Properties**.

        By default, the path of the computer node is one of the following:
          - **Member servers**  
              Domain\Computer\ComputerName\DFSR-LocalSettings
          - **Domain controllers**  
             Domain\Domain Controllers\ComputerName\DFSR-LocalSettings
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Full Control** permission, and then click to select **This object and all child objects** in the **Apply onto** area.

- Control of all replication groups

    To grant a user control of all existing and future replication groups in a domain, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the Domain\System\DFSR-GlobalSettings node, and then click **Properties**.
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Full Control** permission, and then click to select **This object and all child objects** in the **Apply onto** area.
    5. Add the users or groups to each member's local Administrators group. Or, grant the **Full Control** permission for the computer objects of each server in the replication groups.

- Add/Remove/Modify replicated folders

    To grant a user rights only to modify, to add, or to delete a replicated folder, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the Domain\System\DFSR-GlobalSettings\ReplicationGroup\Content node, and then click **Properties**.
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Full Control** permission, and then select **This object and all child objects** in the **Apply onto** area.
    5. Add the users or groups to each member's local Administrators group. Or, grant the **Full Control** permission for the computer objects of each server in the replication groups.

- Add/Remove/Modify members and connections

    To grant a user rights only to modify, to add, or to delete members and connections, follow these steps:

    1. Start Active Directory Users and Computers.
    2. Right-click the Domain\System\DFSR-GlobalSettings\ReplicationGroup\Topology node, and then click **Properties**.
    3. Click the **Security** tab, and then click **Advanced**.
    4. Grant the desired users or groups the **Full Control** permission, and then select **This object and all child objects** in the **Apply onto** area.
    5. Add the users or groups to each member's local Administrators group. Or, grant the **Full Control** permission for the computer objects of each server in the replication groups.

- Generate a report on a replication group

    To generate a diagnostic report, a user must be a local administrator of the servers that are part of the report.
