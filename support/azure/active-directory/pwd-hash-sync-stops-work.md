---
title: Password hash synchronization for Azure AD stops working and event ID 611 is logged
description: Describes an issue in which password hash synchronization for Microsoft Azure Active Directory stops working. Provides a resolution.
ms.date: 07/06/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# Password hash synchronization for Azure AD stops working and event ID 611 is logged

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2867278

## Symptoms

Password hash synchronization for Microsoft Azure Active Directory stops working after several days. Additionally, in Event Viewer, the following event ID 611 error is logged in the Application log:

> Password synchronization failed for domain: `Contoso.com`.

## Resolution

Install the latest version of the Azure Active Directory Synchronization tool. For more information, see [Install or upgrade the Directory Sync tool](/azure/active-directory/hybrid/how-to-dirsync-upgrade-get-started).

## More information

You may see one or more of the following error details for Event ID 611.

| Event ID| Description| Cause| More information |
|---|---|---|---|
|<br/><br/> 611 <br/><br/>| Microsoft.Online.PasswordSynchronization.SynchronizationManagerException: Recovery task failed. ---> Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8439: The distinguished name specified for this replication operation is invalid. There was an error calling `_IDL_DRSGetNCChanges`.|Windows Server 2003 domain controllers handle certain scenarios unexpectedly.|Update to the latest version of Azure AD Connect to resolve this issue.|
|<br/><br/> 611 <br/><br/>| Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8593: The directory service cannot perform the requested operation because the servers involved are of different replication epochs (which is related to a domain rename that is in progress).| It's a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|Update to the latest version of Azure AD Connect to resolve this issue.|
|<br/><br/> 611 <br/><br/>| System.ArgumentOutOfRangeException: Not a valid Win32 FileTime.| It's a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|Update to the latest version of Azure AD Connect to resolve this issue.|
|<br/><br/>  611  <br/><br/>| System.ArgumentException: An item with the same key has already been added.| It's a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|Update to the latest version of Azure AD tool to resolve this issue.|
|<br/><br/> 611 <br/><br/>|Password synchronization failed for domain: `Contoso.com`. Details:<br/>Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8453: Replication access was denied. There was an error calling `_IDL_DRSGetNCChanges`.<br/><br/>at Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsRpcConnection.OnGetChanges(ReplicationState syncState)<br/><br/>at Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsConnection.GetChanges(ReplicationState replicationState)<br/><br/>at Microsoft.Online.PasswordSynchronization.RetryUtility.ExecuteWithRetry[T](Func`1 operation, Func`1 shouldAbort, RetryPolicyHandler retryPolicy)<br/><br/>at Microsoft.Online.PasswordSynchronization.DeltaSynchronizationTask.SynchronizeCredentialsToCloud()<br/><br/>at Microsoft.Online.PasswordSynchronization.PasswordSynchronizationTask.SynchronizeSecrets()<br/><br/>at Microsoft.Online.PasswordSynchronization.SynchronizationExecutionContext.SynchronizeDomain()<br/><br/>at Microsoft.Online.PasswordSynchronization.SynchronizationManager.SynchronizeDomain(SynchronizationExecutionContext syncExecutionContext).|AD DS Connector Account is missing the following extended permissions on AD:<br/> <br/>Replicating Directory Changes<br/>Replicating Directory Changes All<br/>| Update to the latest version of Azure AD Connect, and follow the article "[Azure AD Connect: Configure AD DS Connector Account Permissions](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-configure-ad-ds-connector-account)" on how to add the correct Active Directory permissions.<br/>|
|||||

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
