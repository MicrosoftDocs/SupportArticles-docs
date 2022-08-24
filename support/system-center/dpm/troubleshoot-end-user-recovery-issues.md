---
title: Troubleshoot end-user recovery issues
description: Troubleshoots end-user recovery issues in System Center 2012 Data Protection Manager or System Center 2012 R2 Data Protection Manager.
ms.date: 08/22/2020
---
# Troubleshoot end-user recovery issues in Data Protection Manager 2012

This guide helps you troubleshoot end-user recovery (EUR) issues in System Center 2012 Data Protection Manager (DPM) or System Center 2012 R2 Data Protection Manager.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager, System Center 2012 R2 Data Protection Manager  
_Original KB number:_ &nbsp; 10107

## Check for unsupported scenarios

Before you start troubleshooting, it's important to note that there are certain scenarios where EUR will not work. Check the following scenarios and make sure your issue doesn't fall within one of these categories:

- The entire volume has been shared. Sharing out an entire volume doesn't work with EUR. You must share folders within a volume.
- DPM protection isn't configured to disk. For EUR to work, the DPM protection has to be configured to disk (D-D or D-D-T).
- Shares are mountpoints or folders within mountpoints.
- Clients are Windows Server 2008 Terminal Server clients.
- The client contains an unsupported share including:
  - FAT volume
  - CD-ROM drive
  - USB drive
  - Mount point located inside another mount point
  - Special folders: System Volume Information folder, RECYCLER folder.
  - Unsupported reparse point (that is, any reparse point other than a mount point).
  - On a case-sensitive system, a folder that has the same name as another folder inside that folder's parent, differing only in case (for example, *F:\MarketingDocs* and *F:\marketingdocs*).

On a computer containing a share from the list of unsupported shares, Microsoft recommends that you protect only volumes and folders for auto discovery to work correctly.

## The previous versions displayed by the clients don't match the list on the DPM server

In this case, check whether shadow copies are enabled on the file server locally. If so, clients will display the previous versions based on local shadow copies only. EUR will not work if local shadow copies are enabled on the protected server in question.

## The previous versions list is empty or is a subset of what is expected

In this case, check whether valid recovery points are available in DPM. If no recovery points are seen in DPM, wait for one to be created or create one manually and check again.

If valid recovery points are available on DPM, first verify that the DPM shares are in order. To do this, use the `net share` command on the DPM server and verify that every folder or share protected by DPM has a corresponding share on DPM pointing to its replica volume.

For each protected share, DPM creates a corresponding share on the DPM server as **\\\\\<DPM Server FQDN>\\\<File server FQDN>.\<share_name>**.

If the DPM shares aren't available, check for proper EUR configuration on the DPM server. To do this, open SQL Server Management Studio, expand **Databases**, right-click **DPMDB** and then click **New Query**. Type the following query and click **Execute**:

```sql
select * from tbl_DLS_GlobalSetting where PropertyName = 'EnableEndUserRecovery'
```

Note that EUR can be enabled and re-enable to reconfigure it.

If only some shares are missing, run a synchronization for the particular data sources. This will also create entries in Active Directory in the `ms-sharemapconfiguration` container.

## Check Active Directory for incorrect redirections

Another common issue with the previous versions list is invalid redirections within Active Directory. This is typically caused by protecting a share with one DPM server and then migrating the protection to a new one. When this is done, the entries in Active Directory may not be updated. So the redirections still point to the old DPM server, causing the previous versions list to be empty.

To check the redirections in Active Directory, sign in to a domain controller in the domain and run the following command:

```console
dsquery * CN=MS-ShareMapConfiguration,cn=system,dc=domain,dc=local -attr ms-backupSrvShare ms-productionSrvShare cn
```

> [!NOTE]
> Replace `dc=domain,dc=local` with the correct domain information for your environment.

This command returns a list of all EUR-enabled shares, the corresponding DPM share and the object name in Active Directory.

1. If no entries are found inside the `MS-ShareMapConfiguration` container, check the permissions for the DPM machine account.

    The DPM machine account requires create and delete permissions on the `ms-srvShareMapping` objects. Set the permissions if not set. The DPM server will then start populating the entries when the next synchronization happens. The entry for the share will appear only when sync is run for that protection.

2. If partial entries are found inside the `MS-ShareMapConfiguration` container, check the permissions for the DPM machine account and run synchronization jobs for any missing shares.
3. If the DPM shares are incorrect (that is, point to the wrong DPM server), delete the corresponding object(s) in the `cn=ms-sharemapconfiguration` container. Be careful not to delete objects in any other container. Then rerun a synchronization job (or wait for the scheduled job to run) which will recreate the object and then check for the previous versions again.

## Check if previous versions is working locally on the DPM server

When you browse to the share **\\\SERVER\SHARE** and see the message **There are no previous versions available** in the properties of a folder, check and see if the same thing happens when you browse the share directly on the DPM server.

For example, from the DPM server you would browse to **\\\DPM\server.domain.local_share**. If browsing the share directly from the DPM server works, verify the following:

1. EUR will not work if local shadow copies are enabled on the protected server in question. Disable shadow copies and try again.
2. The schema needs to be extended and the checkbox enabled on each DPM server you want EUR enabled on.
3. DPM shares need to be created by DPM on the DPM server (net shares).
4. The System account needs at least read and list permission on the root of volumes being protected.
5. EUR across a domain or forest is not supported.
