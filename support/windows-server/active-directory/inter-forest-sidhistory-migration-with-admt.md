---
title: Troubleshoot sIDHistory migration with ADMTv2
description: Describes how to troubleshoot inter-forest sIDHistory migration by using Active Directory Migration Tool version 2 (ADMTv2).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
---
# How to troubleshoot inter-forest sIDHistory migration with ADMTv2

This article describes how to troubleshoot inter-forest sIDHistory migration with Active Directory Migration Tool version 2 (ADMTv2).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 322970

## More information

When you are using ADMTv2 to migrate sIDHistory as part of an inter-forest user or group migration, configuration is required with the base migration requirements.

By default, sIDHistory, password, and objectGUID are all preserved during intra-forest migrations, but this is not true for inter-forest cloning.

Because there is no built-in security context for inter-forest operations, you must take steps to protect the security of operations across forest boundaries.

### Configuration

The basic requirements for inter-forest migration operations are:

#### Wizard-based basic user and group account migration without sIDHistory

- The source domain must trust the target domain.
- The user account that is running ADMTv2 must have Administrator rights in the source domain.
- The ADMT user account must have delegated permissions to create user or group objects in the target container.
- DNS (hostname) and NetBIOS name resolution between the domains must exist.

#### sIDHistory migration requires the following additional dependencies

- Success and failure auditing of account management for both source and target domains.
- Source domains call this user and group management auditing.
- An empty local group in the source domain that is named *{SourceNetBIOSDom}$$$*.
- The `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\TcpipClientSupport`registry key must be set to 1 on the source domain primary domain controller.
- You must restart the source domain primary domain controller after the registry configuration.
- Windows security requires user credentials with the delegated MigratesIDHistory extended right or administrator rights in the target domain. You add these credentials in the wizard when sIDHistory migration is turned on.

To delegate the MigrateSidHistory extended right on a domain controller or on a computer that has the Windows Server Administration Tools pack installed, follow these steps:

1. Click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Right-click the name of the domain that you want to delegate the MigrateSidHistory extended right from, and then click **Delegate Control** to open the **Delegation of Control Wizard** window.
3. Click **Next**, click **Add**, enter the name of the user or group that you wish to add in the **Select Users, Computers, or Groups** dialog box, click **OK**, and then click **Next**.
4. Click to select the **Create a custom task to delegate** option, and then click **Next**.
5. Make sure that the **This folder, existing objects in this folder, and creation of new objects in this folder** option is selected, and then click **Next**.
6. Make sure that the **General** option is selected, click **Migrate SID History** in the
**Permissions** list, and then click **Next**.
7. Verify that the information is correct, and then click **Finish**.
    - No sID to be migrated may exist in the target forest, either as a primary sID or as an sIDHistory attribute of another object.

#### Additional requirements for migrating sIDHistory with the command line or scripting interfaces

- When you start a user or group migration with sIDHistory migration from the command line or from a script, the command or script must be run on the domain controller in the target domain.
- The user account that is running the migration must have administrator rights in both the source and the target domains.

#### Special requirements for group mapping and merging wizard

- If sIDHistory is to be migrated during group mapping and merging, the scope of the source groups must match the scope of the target group.

## Troubleshooting

The most basic step you can use to troubleshoot inter-forest sIDHistory migration is to use the User Account Migration Wizard or the Group Account Migration Wizard to run a test-mode migration.

During the test-mode migration, ADMTv2 validates the following dependencies:

- The {SourceNetBIOSDom}$$$ local group is created.
- TcpipClientSupport on the source primary domain controller or primary domain controller emulator is turned on.
- Auditing in both domains is turned on.

Optionally, ADMT can repair any of these dependencies that are not set. To repair or configure these settings, the account that is used to run ADMT must have enough permissions in each respective domain to carry out the tasks.

Only the wizard performs these checks and corrections. The command line and scripting interfaces do not perform these checks, and do not work without correct configuration.

### Common error messages with inter-forest sIDHistory migration

> "The handle is invalid (Error code = 6)."

This error indicates an RPC problem where the migration tool cannot bind to an RPC endpoint on the source primary domain controller. Possible causes include:

- TcpipClientSupport on the source primary domain controller or primary domain controller emulator has not been turned on.
- The primary domain controller or primary domain controller emulator was not restarted after TcpipClientSupport was configured.
- DNS or NetBIOS name resolution is not working.

> Could not verify auditing and TcpipClientSupport on domains. Will not be able to migrate Sid's. The specified local group does not exist.

This error typically indicates that a user or a global or universal group with the {SourceNetBIOSDom}$$$ name already exists. ADMT typically creates the local group of that name, but it cannot do so if a security principal already exists with the name.

> Could not verify auditing and TcpipClientSupport on domains. Will not be able to migrate Sid's. Access is Denied.

This error typically indicates that the user account that is used to run ADMT does not have enough permissions to perform the migration in one or both of the domains.Domain name lookup failed, rc=1332. No mapping between account names and security IDs was done.
This error in the Migration.log file after a migration with sIDHistory typically indicates that the source domain has configured trusts that do not exist on the target domain. To resolve this issue, run the Trust Migration Wizard to map the trusts in the source domain, and then replicate the relationships in the target domain.

## Additional sIDHistory information

The sIDHistory is a multivalued attribute of security principals in the Active Directory that may hold up to 850 values. To provide backward-compatibility with domain controllers that are running earlier versions of Windows, the sIDHistory attribute is only available in domains that are operating at the functional level of Windows.

Some third-party vendor products make it possible to turn on sIDHistory in mixed mode domains. These claims do not represent the legitimate use of public APIs. Domain administrators that use such tools risk putting their Active Directory deployment in an unsupported state.

During intra-forest migrations, LDAP_Rename is responsible for moving objects. Because of this, migrated objects retain important identification data, including the objectGUID and password. This is not the case for inter-forest migrations, which call DSAddSidHistory to populate the attribute in the target domain. Password migration may be turned on for inter-forest cloning, but the objectGUID is always lost during this type of migration.

In both cases, migrated objects are assigned a new sID by the target domain. The original sID is added to the sIDHistory attribute of the migrated object in the new domain. After this occurs, the sIDHistory attribute may not be modified or deleted by using the standard Active Directory administration tools. This is not permitted because the sIDHistory attribute is owned by the SAM. It is possible to clear the sIDHistory by using a script or a non-public Microsoft internal tool.

Note that the sIDHistory is a transitional tool and is not meant to exist indefinitely attached to security principals. Although migrating the sIDHistory can significantly ease and simplify the domain migration process, there are important security ramifications that must be considered before you implement the sIDHistory in a production enterprise.

A Windows security token can hold a maximum of 1,023 sIDs, including sIDHistory and group sIDs. Kerberos is also limited because Windows Kerberos has a 73-sID buffer. This size can be doubled by an enterprise-wide registry change. Exceeding these limits violates the MaxTokenSize restriction and can lead to unpredictable results, including failure of Kerberos authentication and erratic or nonexistent application of policies. To prevent these issues, use Security Translation instead of sIDHistory as the long-term solution to maintaining resource access after a domain migration.
