---
title: Default permissions and user rights in IIS
description: This article describes the default permissions and user rights that are set on certain folders and files. These folders and files are installed in IIS 7.0 and later.
ms.date: 04/01/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: mlaing
ms.topic: article
ms.technology: www-authentication-authorization
---
# Default permissions and user rights for IIS 7.0 and later

This article describes the default permissions and user rights that are set on certain folders and files. These folders and files are installed with Microsoft Internet Information Services (IIS) 7.0 and later.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 981949

## Permission changes in IIS 6.0, IIS 7.0, and later versions

In IIS 6.0, a local account (`IUSR_MachineName`) is created when IIS is installed. The `IUSR_MachineName` account is the default identity that is used by IIS when Anonymous authentication is enabled. Anonymous authentication is used by both the File Transfer Protocol (FTP) service and the HyperText Transfer Protocol (HTTP) service. IIS 6.0 also contains a group that is named `IIS_WPG`. The `IIS_WPG` group is used as a container for all Application Pool Identities.

In IIS 7.0 and later, a built-in account (IUSR) replaces the `IUSR_MachineName` account. Additionally, a group that is named `IIS_IUSRS` replaces the `IIS_WPG` group. Because the IUSR account is a built-in account, the IUSR account no longer requires a password. The IUSR account resembles a network or local service account. The `IUSR_MachineName` account is created and used only when the FTP 6 server that is included on the Windows Server 2008 DVD is installed. If the FTP 6 server isn't installed, the account isn't created.

Beginning in IIS 7.5, a new security feature is added that is called _Application Pool Identities_. This feature lets you run Application Pools under a unique account without having to create and manage domain or local accounts. The name of the Application Pool account corresponds to the name of the Application Pool.

For more information about IIS 7.0 accounts and groups, visit [Understanding built-in user and group accounts in IIS 7](/iis/get-started/planning-for-security/understanding-built-in-user-and-group-accounts-in-iis).

For more information about Application Pool Identities, visit [Application Pool Identities](/iis/manage/configuring-security/application-pool-identities).

## Default NTFS file system permissions

The tables in this section list the default New Technology File System (NTFS) permissions that are assigned to certain folders and files. These folders and files are installed together with IIS 7.0, IIS 7.5, IIS 8.0, IIS 8.5, and IIS 10.0.

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

The tables in this section list the default registry permissions that are assigned when IIS 7.0, IIS 7.5, IIS 8.0, or IIS 8.5 is installed. When Read permissions are listed for users, the following permissions are included:

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

The table in this section lists the default local security policies and the users, the groups, or the users and groups that are assigned to the policy when IIS 7.0, IIS 7.5, IIS 8.0, or IIS 8.5 is installed.

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
