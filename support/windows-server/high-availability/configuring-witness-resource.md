---
title: Configuring Witness Resource Troubleshooting Guide
description: Resolves issues that affect Witness resources for Windows Server and Azure Stack HCI clusters.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: clustering and high availability\configuring witness resource
- pcy: High availability\setup and configuration of clustered services and applications
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Configuring Witness resource troubleshooting guide

## Summary

Failover cluster quorum and Witness resources (File Share Witness, Disk Witness, Cloud Witness) are foundational for Windows Server and Azure Stack HCI clusters. They provide critical vote count to maintain high availability. Failures in Witness configuration or operation can jeopardize production workloads and trigger loss of quorum, unplanned failovers, or node shutdowns. 

Witness resources depend on correct permissions, resilient networking, proper registration, and accurate configuration. Each potential failure scenario requires a tailored resolution. This guide provides a thorough checklist, diagnoses the most common issues, lists data collection requirements, and provides a solution matrix for quick field troubleshooting.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Permissions and share validation**
    - Is the Cluster Name Object (CNO) or computer account granted Full Control on both share and NTFS permissions?
    - Was the share created on a Windows server or compatible NAS (by having SMB 2.0+/Kerberos support)?
    - If you use a cloud witness, are storage account name, key, and endpoint correct?
- **Network and connectivity**
    - Can all cluster nodes reach the witness (file share/disk/cloud witness) over the expected port (TCP 445 for file, 443 for cloud)?
    - Are there any proxy settings that might block internet connectivity (for cloud witness)?
    - Do DNS/route tables resolve the file share/cloud witness endpoint correctly from each node?
- **Cluster Configuration**
    - Is only one witness resource configured for the cluster?
    - Is the witness assigned to the cluster core resources and not to a non-cluster-related role?
    - Are there any duplicate or obsolete witness resources visible in Failover Cluster Manager?
- **Storage health**
    - Are quorum disks healthy, online, and not in use by antivirus scans or backup jobs?
    - Does chkdsk/Repair-Volume report any issues?
- **Cluster node/OS health**
    - Are all cluster nodes running supported operating systems and up to date drivers?
    - Have any recent migrations or domain moves been fully completed (CNO/CreatingDC registry updated)?
- **Log review**
    - Are there Access Denied (error 5, 1326), Network Path Not Found (53), or Password Expired (1330) errors in the logs?
    - Are there recurring failover, resource offline/failed events, or authentication errors involving the witness?

## Common issues and solutions

### Issue 1: File share witness doesn't come online

#### Symptoms

Resource state is "Failed" or "Offline." Errors:
- "File share witness resource... failed to arbitrate for the file share."
- "Failed to open or create file... Witness.log, error 5."
- Event ID 1069, 1564, 1205.

#### Root cause and resolution

- Incorrect permissions:
    - Resolution: Assign Full Control permissions on the share and NTFS to the CNO/computer account.
    - On the file share **Security** tab, add "Cluster_Name$" (or cluster computer account), and grant Full Control.
        - Make sure that the share permission and NTFS permission both reflect this change.
- Network issues and blocked SMB:
    - Resolution: Open TCP 445 between all nodes and the FSW host.
    - Use Test-NetConnection \<FileShare> -Port 445 from each node.
- Share Hosted on Unsupported Device/Platform:
    - Resolution: Host FSW on only a Windows server or supported NAS that has SMB/Kerberos integration.
    - Avoid DFS, replicated storage, or cloud witness share that's used as a file share witness.

### Issue 2: Disk Witness or Witness Disk intermittently offline

#### Symptoms

Cluster logs:
- "Cluster Disk X... failed. Error code was 0x5 (Access is denied)"
- Event IDs: 1558, 1069, 1792, 1795
- Physical disk moves between nodes or enters failed state intermittently

#### Root cause and resolution

- Antivirus interference:
    - Resolution: Exclude cluster disks (and their underlying volumes/paths) from antivirus scans.
    - Check running minifilters: fltmc
    - Apply AV exclusion, then restart all nodes.
- Disk and storage health or corruption:
    - Resolution: Run CHKDSK/Repair-Volume on the disk. Reformat and restore if corrupted.
    - Remove disk from cluster, run chkdsk /f, reformat as NTFS, restore as quorum disk.
- Persistent reservations and controllers:
    - Resolution: Make sure that storage controllers and drivers are up to date and that single, unique reservations are held per disk.
    - Use vendor-specific tools to check SCSI-3 persistent reservation status.

### Issue 3: Cloud witness can't be configured or brought online

#### Symptoms

Resource can't be added or brought online.

Error messages:
- "An error occurred while validating access."
- "Cloud Witness failed to come online. Error: The client and server cannot communicate because they don't possess a common algorithm."
- "The version of the connection isn't permitted on this storage account."

#### Root cause and resolution

- TLS mismatch or version error:
    - Resolution: Enforce TLS 1.2 on all nodes.
    - PowerShell:

    ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Set-ClusterQuorum -CloudWitness -AccountName <StorageAccount> -AccessKey <AccessKey>
    ```

    > [!NOTE]
    >
    > Remove any Disk Witness before you add a Cloud Witness.

- Incorrect storage account/endpoint/network:
    - Resolution:
        - Verify name, key, endpoint.
        - Make sure that TCP 443 is open and not blocked by a firewall or proxy.
        - For private endpoints, update hosts file if DNS doesn't resolve.
- Simultaneous witness types:
    - Resolution: Only one witness (disk/file/cloud) is allowed at a time.
        - Remove any existing witness:

        ```powershell
        Set-ClusterQuorum -NodeAndDiskMajority
        Set-ClusterQuorum -CloudWitness -AccountName <StorageAccount> -AccessKey <AccessKey>
        ```

### Issue 4: Other common causes and fixes

- Password synchronization failures (Error 1330, 1326):
    - Use Failover Cluster Manager or Repair-ClusterNameAccount PowerShell to resync password or reset CNO in AD.
- Multiple witness resources / configuration drift:
    - Remove all witness resources, set quorum to "none."
    - Manually delete duplicate or stale witness resources.
    - Restore witness cleanly.
- Network path not found / Access Denied (Error 53/5):
    - Verify network routes/firewall, name resolution, and DNS registration.
    - Restart cluster resource/service after correcting.
- Kerberos or disabled computer object:
    - Restore computer object from Active Directory Recycle Bin, or re-create if deleted.
    - For Active Directory object disabled, enable and reset password.
- Cluster quorum loss after node down/resource migration:
    - Migrate core cluster resources before shutting down a node (workaround for known bug in WS2025).
    - If all nodes except one are lost, and quorum isn't achieved, use forced quorum—but only as last resort (Start-ClusterNode -ForceQuorum).

## Common issues quick reference table

| Symptom | Event ID/Error code | Cause | Resolution |
| --- | --- | --- | --- |
| File share witness FSW offline/fails arbitration | 1069, 1564, 5, 53 | Permissions, network, misconfiguration| Set Full Control on share/NTFS, open TCP 445, verify CNO |
| Can't bring cloud witness online | "Not permitted," TLS | Protocol/version mismatch, endpoint | Enforce TLS1.2, verify storage account, remove disk witness |
| Disk witness intermittent offline | 1558, 1792, 1069, 5 | AV interference, disk corruption | Add AV exclusions, chkdsk/repair, reformat disk |
| "The specified network password isn't correct," password expired | 86, 1330, 1326 | CNO password unsynced, AD object issues | Repair CNO, reset password, AD User status |
| Multiple witness resources/duplicate | -- | Configuration drift | Remove all, set quorum none, re-add single witness |
| After node loss, cluster offline/quorum loss | 1177, 7024, 7031 | Quorum config, bug in WS2025 | Migrate core role, enable dynamic quorum, apply hotfix |
| "Unable to save property changes for FSW" (NAS/unsupported share) | -- | Non-Windows/non-compatible share | Host witness on Windows or supported device |
| Witness works on one cluster, not others | -- | Path/permissions mismatch, hosts lookup | Update permissions, hosts file, re-add witness |
| After domain/OS migration, FSW fails | -- | Registry (CreatingDC), AD object wrong | Update registry, check CreatingDC, restart cluster service |

## Data collection

- Cluster logs:
    - Get-ClusterLog -UseLocalTime
    - Standard logs for the time of occurrence.
- System/Event Logs:
    - Export system/application logs, filter for event IDs (1558, 1069, 1326, and so on)
- FSW/Cloud Witness Events:
    - Verify by using PowerShell:Get-ClusterResource | where {$_.ResourceType -like "\witness\" }
- Connectivity Tests:
    - Test-NetConnection \<FileShareOrCloudEndpoint> -Port 445/443
    - tracert \<FileShare>
- Permissions checks:
    - icacls \<witness_path>
    - Review share and NTFS security settings.
- Active Directory Objects:
    - Verify that status of CNO/Cluster objects in AD Users and Computers.
- If NAS/non-Windows:
    - SMB protocol supported? Kerberos enabled?

## References

- [Configure a File Share Witness](/windows-server/failover-clustering/file-share-witness?tabs=domain-joined-witness)
- [Cluster Quorum Best Practices](/windows-server/failover-clustering/manage-cluster-quorum)
- [Dynamic Quorum in Windows Server](/windows-server/storage/storage-spaces/quorum#dynamic-quorum-behavior)
