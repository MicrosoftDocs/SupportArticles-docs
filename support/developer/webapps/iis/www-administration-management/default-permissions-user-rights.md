---
title: Default permissions and user rights in IIS
description: This article describes the default permissions and user rights that are set on certain folders and files. These folders and files are installed in IIS.
ms.date: 01/08/2025
ms.custom: sap:WWW Administration and Management\General configuration settings
ms.reviewer: mlaing, paulboc
ms.topic: concept-article
---
# Default permissions and user rights for IIS versions that ship with Windows Server 2016 or later versions

This article describes the default permissions and user rights that are set on certain folders and files. These folders and files are installed with Microsoft Internet Information Services (IIS) on Windows Server 2016 or later operating system versions or their Windows client equivalents (Windows 10 or later versions).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 981949

## Permission changes in IIS on Windows Server 2016 or later versions

In IIS on Windows Server 2016 and later versions, a built-in account named `IUSR` is used as the default identity that is used by the web server when Anonymous Authentication is enabled. This account replaces the `IUSR_MachineName` account from earlier versions of IIS that ship with Windows Server 2003. Additionally, a group that is named `IIS_IUSRS` is used as a container for all [application pool identities](/iis/manage/configuring-security/application-pool-identities). The `IIS_IUSRS` group replaces the `IIS_WPG` group from earlier versions of IIS. Because the IUSR account is a built-in account, the IUSR account no longer requires a password. The IUSR account resembles a network or local service account. 

Beginning in IIS on Windows Server 2012, a new security feature [application pool identities](/iis/manage/configuring-security/application-pool-identities) is added. This feature allows you to run Application Pools under a unique account without creating and managing domain or local accounts. The name of the Application Pool account corresponds to the name of the Application Pool.

For more information about IIS accounts and groups, visit [Understanding built-in user and group accounts in IIS](/iis/get-started/planning-for-security/understanding-built-in-user-and-group-accounts-in-iis).

## Default NTFS file system permissions

The tables in this section list the default New Technology File System (NTFS) permissions that are assigned to certain folders and files. These folders and files are installed together with IIS versions that ship with Windows Server 2016, Windows 10, or later versions.

### \inetpub

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read & execute</br> List folder contents</br> Read||
|TrustedInstaller|Full control||
  
### \inetpub\AdminScripts

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read & execute</br> List folder contents</br> Read</br>||
|TrustedInstaller|Full control||
  
#### \inetpub\AdminScripts\0409

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only. </br>Inherited from `\inetpub\AdminScripts`.|
|SYSTEM|Full control|Inherited from `\inetpub\AdminScripts`.|
|Administrators|Full control|Inherited from `\inetpub\AdminScripts`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub\AdminScripts`.|
|TrustedInstaller|Full control|Inherited from `\inetpub\AdminScripts`.|
  
### \inetpub\custerr

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to Subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control</br> Special permissions|Full control is inherited from `\inetpub`.</br> Special Permissions are equivalent to Full control.</br> Applies to this folder only.|
|Administrators|Full control</br> Special permissions|Full control is inherited from `\inetpub`.</br> Equivalent to Full control.</br> Applies to this folder only.|
|Users|Read & execute</br> List folder contents</br> Read</br> Special permissions|Permissions are inherited from `\inetpub` except for special permissions.</br></br> Special permissions apply to this folder only, and include the following: <ul><li>Traverse folder / execute file</li><li>List folder / read data</li><li> Read attributes</li><li>Read extended attributes</li><li>Read permissions</li></ul>|
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\custerr\en-us

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control. </br>Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\ftproot

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\history and subfolders

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|SYSTEM|Full control||
|Administrators|Full control||
  
### \inetpub\logs

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|WMSvc|List folder contents||
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\logs\FailedReqLogFiles

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|IIS_IUSRS|Special permissions|Special permissions include the following: <ul><li>List folder / read data</li><li>Create files / write data</li><li>Create folders / append data</li><li>Write attributes</li><li>Write extended attributes</li><li>Delete subfolders and files</li><li>Delete</li></ul>|
|SYSTEM|Full control||
|Administrators|Full control||
  
### \inetpub\logs\wmsvc

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|WMSvc|Modify</br> Read & execute</br> List folder contents</br> Read</br> Write|List folder contents permission is inherited from `\inetpub\logs`.|
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\temp

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\temp\appPools

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Full control||
|Administrators|Full control||
|IIS_IUSRS|Read & execute|Inherited from `\inetpub`.|
  
### \inetpub\temp\ASP Compiled Templates

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|By default, no permissions are assigned to this folder.|||
  
### \inetpub\temp\IIS Temporary Compressed Files

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|SYSTEM|Full control||
|Administrators|Full control||
|IIS_IUSRS|Full control||
  
### \inetpub\wwwroot

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `\inetpub`.|
|SYSTEM|Full control|Inherited from `\inetpub`.|
|Administrators|Full control|Inherited from `\inetpub`.|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `\inetpub`.|
|IIS_IUSRS|Read & execute||
|TrustedInstaller|Full control|Inherited from `\inetpub`.|
  
### \inetpub\wwwroot\aspnet_client

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|Everyone|Read||
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read & execute</br> List folder contents</br> Read||
  
### %windir%\system32\inetsrv

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Special permissions|Special permissions allowed for the SYSTEM account for this folder only include the following: <ul><li>Traverse folder / execute file</li><li>List folder / read data</li><li>Read attributes</li><li>Read extended attributes</li><li>Create file / write data</li><li>Create folders / append data</li><li>Write attributes</li><li> Write extended attributes</li><li> Delete</li><li> Read permissions</li></ul></br> Special permission allowed for SYSTEM for subfolders and files only is equivalent to Full control.|
|Administrators|Special permissions|Special permissions allowed for the Administrators group for this folder only include the following: <ul><li>Traverse folder / execute file</li><li> List folder / read data</li><li> Read attributes</li><li> Read extended attributes</li><li> Create file / write data</li><li> Create folders / append data</li><li> Write attributes</li><li> Write extended attributes</li><li> Delete</li><li> Read permissions</li></ul></br> Special permission allowed for the Administrators group for subfolders and files only is equivalent to Full control.|
|Users|Read & execute</br> List folder contents</br> Read||
|TrustedInstaller|Special permissions|Permissions are equivalent to Full control, and apply to this folder and subfolders.|
  
### %windir%\System32\inetsrv\0409

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `%windir%\System32\inetsrv`.|
|SYSTEM|Full control|Inherited from `%windir%\System32\inetsrv`.|
|Administrators|Full control|Inherited from `%windir%\System32\inetsrv`|
|Users|Read & execute</br> List folder contents</br> Read|Inherited from `%windir%\System32\inetsrv`|
|TrustedInstaller|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.</br> Inherited from `%windir%\System32\inetsrv`|
  
### %windir%\System32\inetsrv\config

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read & execute</br> List folder contents</br> Read||
|TrustedInstaller|Full control||
|WMSvc|Read||
  
### %windir%\System32\inetsrv\config\Export

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Full control||
|Administrators|Full control||
|TrustedInstaller|Full control||
  
### %windir%\System32\inetsrv\config\schema

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Special permissions|Special permissions allowed for the SYSTEM account for this folder only include the following: <ul><li>Traverse folder / execute file</li><li> List folder / read data</li><li> Read attributes</li><li> Read extended attributes</li><li> Create file / write data</li><li> Create folders / append data</li><li> Write attributes</li><li> Write extended attributes</li><li> Delete</li><li> Read permissions</li></ul></br>Special permission allowed for SYSTEM for subfolders and files only is equivalent to Full control.|
|Administrators|Special permissions|Special permissions allowed for the Administrators group for this folder only include the following: <ul><li>Traverse folder / execute file</li><li>List folder / read data</li><li>Read attributes</li><li>Read extended attributes</li><li>Create file / write data</li><li>Create folders / append data</li><li>Write attributes</li><li>Write extended attributes</li><li>Delete</li><li>Read permissions</li></ul></br>Special permission allowed for the Administrators group for subfolders and files only is equivalent to Full control.|
|Users|Read & execute</br> List folder contents</br> Read||
|TrustedInstaller|Special permissions|Equivalent to Full control.</br> Applies to this folder and subfolders.|
  
### %windir%\System32\inetsrv\en-us

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subfolders and files only.|
|SYSTEM|Special permissions|Special permissions allowed for the SYSTEM account for this folder only include the following: <ul><li>Traverse folder / execute file</li><li> List folder / read data</li><li> Read attributes</li><li> Read extended attributes</li><li> Create file / write data</li><li> Create folders / append data</li><li> Write attributes</li><li> Write extended attributes</li><li> Delete</li><li> Read permissions</li></ul></br>Special permission allowed for SYSTEM for subfolders and files only is equivalent to Full control.|
|Administrators|Special permissions|Special permissions allowed for the Administrators group for this folder only include the following: <ul><li>Traverse folder / execute file</li><li> List folder / read data</li><li> Read attributes</li><li>Read extended attributes</li><li>Create file / write data</li><li>Create folders / append data</li><li>Write attributes</li><li>Write extended attributes</li><li>Delete</li><li>Read permissions</li></ul></br>Special permission allowed for the Administrators group for subfolders and files only is equivalent to Full control.|
|Users|Read & execute</br> List folder contents</br> Read||
|TrustedInstaller|List folder contents</br> Special permissions|Equivalent to Full control.</br> Applies to this folder and subfolders.|
  
### %windir%\System32\inetsrv\History

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|Administrators|Full control||
|SYSTEM|Full control||
  
#### %windir%\System32\inetsrv\MetaBack

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|Administrators|Full control||
|SYSTEM|Full control||
  
## Default registry permissions

The tables in this section list the default registry permissions that are assigned when IIS versions that ship with Windows Server 2016, Windows 10, or later versions. When Read permissions are listed for users, the following permissions are included:

- Query Value
- Enumerate Subkeys
- Notify
- Read Control

### HKEY_LOCAL_MACHINE\Software\Microsoft\Inetmgr

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\Software\Microsoft\InetStp

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\Software\Microsoft\W3SVC

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP.NET

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP.NET_2.0.50727

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\aspnet_state

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\IISAdmin

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\WAS

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
  > [!NOTE]
> The WAS key is for the Windows Process Activation Service. This is a required dependency and is installed together with IIS.

### HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\WMsvc

| Users / groups| Allowed permissions| Comments |
|---|---|---|
|CREATOR OWNER|Special permissions|Equivalent to Full control.</br> Applies to subkeys only.|
|SYSTEM|Full control||
|Administrators|Full control||
|Users|Read||
  
## Default Windows user rights assignments

The table in this section lists the default local security policies and the users, the groups, or the users and groups that are assigned to the policy when IIS versions that ship with Windows Server 2016, Windows 10, or later versions are installed.

### Windows user rights that are assigned by local security policy

|Allowed permissions|Users / groups |
|---|---|
|Access this computer from the network|Everyone</br> Administrators</br> Users</br> Backup operators|
|Adjust memory quotas for a process|LOCAL SERVICE</br> NETWORK SERVICE</br> Administrators</br> ApplicationPoolIdentity|
|Allow log on locally|Administrators</br> Users</br> Backup operators|
|Bypass traverse checking|Everyone</br> LOCAL SERVICE</br> NETWORK SERVICE</br> Administrators</br> Users</br> Backup operators|
|Generate security audits|ApplicationPoolIdentity|
|Impersonate a client after authentication|LOCAL SERVICE</br> NETWORK SERVICE</br> Administrators</br> `IIS_IUSRS`</br> SERVICE|
|Log on as a batch job|Administrators</br> Backup operators</br> Performance log users</br> `IIS_IUSRS`|
|Log on as a service|ApplicationPoolIdentity|
|Replace a process level token|LOCAL SERVICE</br> NETWORK SERVICE</br> ApplicationPoolIdentity|
