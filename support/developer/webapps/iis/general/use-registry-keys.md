---
title: Use registry keys
description: This article describes the registry keys that are used by Microsoft Internet Information Services (IIS) on Windows.
ms.date: 02/16/2023
ms.reviewer: finbarr
ms.subservice: general
---
# Description of the registry keys that are used by Internet Information Services

This article describes the registry keys that are used by Microsoft Internet Information Services (IIS) on Windows.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 954864

## Introduction

This article also contains information about how to modify the registry. This list of registry keys does not include the FTP-specific registry keys that are a part of the new FTP server release for IIS or for ASP.NET.

> [!IMPORTANT]
>
> - Make sure that you back up the registry before you modify it and you know how to restore the registry if a problem occurs. For more information about how to back up, restore, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).
> - When you modify these registry keys, the behavior of IIS may change.

## Common registry keys that are used by many parts of IIS

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp\Configuration\MaxWebConfigFileSizeInKB (REG_DWORD)`  

  > [!NOTE]
  > If you configure IIS 7.0 and IIS 7.5 to run in 32-bit mode on Windows Server 2008 x64 or on Windows Server 2008 R2 x64, the registry key is instead the following:  
  > `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\InetStp\Configuration\MaxWebConfigFileSizeInKB (REG_DWORD)`  

  The *Nativerd.dll* file uses the value of this registry key to determine the maximum allowed size, in KB, of the *Web.config* files.

  If you change the value of this key, you must restart the process.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\LastPriorityUPNLogon (REG_DWORD)`

  This registry key switches the order in which IIS processes try to sign in a user. The default value is 0 (false).

  - If this value is 0, the User Principal Name (UPN) sign-in is not the last priority. IIS uses the UPN format first, and then the domain field and the username field.

  - If you set this key to a nonzero value, it switches the order so that IIS uses the domain field and the username field first and then the UPN sign-in.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\UserTokenTTL (REG_DWORD)`

  This registry key controls the length of time that IIS caches a user token before IIS releases the cache and re-creates it. The default value for the cache time is 900 seconds. This key is used by the token cache module in the worker process and by the Windows Process Activation Service (WAS).

## Registry keys that apply to the WAS

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\WAS\Parameters\ConfigIsolationPath (REG_SZ)`  

  This registry key specifies the folder path for temporary application pool configuration files that the WAS creates. The default value for this registry key is `%systemdrive%\inetput\temp\apppools`.

  - If you change the location, you must make sure that the local computer has full access to the folder.

  - The configuration isolation feature is not available in the release version of Windows Vista. This registry key is not valid in the release version of Windows Vista.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\WAS\Parameters\AlwaysLogEvents (REG_DWORD)`  

  If the WAS detects an invalid object for some reason, it does not log events. This registry switch enables you to see these events that are not logged. By default, this value is set to 0, and the WAS does not log any events. Any nonzero value enables you to view the event logs.

## Registry keys that apply to the IISADMIN service

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\IISADMIN\Parameters\EnableABOMapperLog (REG_DWORD)`  

  This registry key enables the Admin Base Objects (ABO) Mapper to log events. When you set this key to a default value of 0, the ABO Mapper may not log any information. When the registry value is set to a nonzero value, a log file is created in the location `%windir%\system32\abomapper.log`.

  Additionally, the ABO Mapper writes debug information in the *Abomapper.log* file. You must restart the IISAdmin service when you change the value of this registry key.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\IISADMIN\Parameters\LazyWriteTime (REG_DWORD)`

  This registry key helps the ABO Mapper to buffer the configuration changes for a short time before the ABO Mapper saves the changes to the hard disk.

  - The default value of this registry key is 0. The default value indicates that the lazy writer is switched off.

  - If you set this value to a value that is greater than 0, the lazy writer is switched on. The lazy write time, in milliseconds, is equal to the time that is set in the registry.

## Registry keys that apply to IIS Worker Process (W3WP)

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\ConfigPollMilliSeconds (REG_DWORD)`  

  The default value for this registry key is 0.
  - When this value is set to 0, the `ConfigPollMilliSeconds` parameter is disabled. The configuration system relies on change notifications to track changes to configuration files.

  - A positive value for this key indicates that the configuration system checks the last modified time of the configuration file for every *N* millisecond. The configuration system does not use the directory monitors.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ObjectCacheTTL (REG_DWORD)`  

  The user mode file cache and the kernel mode output cache use this registry key. Both the caches run a scavenger operation for every `ObjectCacheTTL` second.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\DisableMemoryCache (REG_DWORD)`  

  When this registry key is set to a nonzero value, the file cache is disabled. The default value for this key is 0. When the default value is set, the file cache is enabled.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MaxCachedFileSize (REG_DWORD)`  

  This registry key is used by the file cache to determine the maximum size of a file that can be cached. The file size is in bytes. The default value of this key is 256 KB. If the file size is greater than 256 KB, the file cannot be cached.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MaxCachedFileSizeInMB (REG_DWORD)`  

  The value of the `MaxCachedFileSize` registry key is the maximum file cache size in bytes.

  - This registry key value cannot be set to more than 4 GB. You can use `MaxCachedFileSizeInMB` to set the maximum file size to cache more than 4 GB.

  - If both `MaxCachedFileSizeInMB` and `MaxCachedFileSize` are defined, the effective maximum cached file size is the sum of both values.

  - The default value of `MaxCachedFileSize` is 256 KB. If you define only the value of `MaxCachedFileSize`, the effective maximum size increases by 256 KB.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MemCacheSize (REG_DWORD)`

  This registry key specifies the maximum amount of memory that a file cache in a worker process uses.

  - The default value for this registry key is 0. The default value specifies that the cache size is determined dynamically. This registry key tries to estimate the available physical memory and the total virtual memory.

  - If you set the value for this registry key to 0, the length of time in seconds that objects are held in cached memory is adjusted to the value in the `ObjectCacheTTL` registry key.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MaxOpenFiles (REG_DWORD)`

  The default value for this registry key is 0. A value of 0 specifies an unlimited number. The file cache uses the value in the `MaxOpenFiles` registry key to determine how many files to cache.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\DoDirMonitoringForUnc (REG_DWORD)`

  If you set the registry key value to 1, it enables directory monitoring for Universal Naming Convention (UNC) paths. By default, the file cache does not use change notifications for UNC files.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\FileAttributeCheckThreshold (REG_DWORD)`

  The file cache checks the last modified time of UNC files every `FileAttributeCheckThreshold` second to detect file changes. The default value for this registry key is 5 seconds. The user mode cache and the kernel mode output cache use this key to determine the length of time that the files that have the virtual file-mapping handler must stay in the response cache. The **resourceType** value for the files that have the virtual mapping handler is set to **Unspecified**.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\FlushTokenCache (REG_DWORD)`  

  If you set this registry key value to 1, the token cache module registers for a change notification. A value of 1 flushes the token cache. You must reset the value to 0.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\HttpResponseCacheTTL (REG_DWORD)`

  This registry key defines the `Http.sys` response cache Time to Live (TTL). The default value is 900 seconds.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\OutputCacheTTL (REG_DWORD)`

  The user mode output cache uses the value of this registry key as the TTL setting. A scavenger is run every `TTL` second to remove content from the cache.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\EnableTraceMethod (REG_DWORD)`

  The protocol support module (*Protsup.dll*) reads this registry key. Requests that use the `Trace` verb will be replied to only if this registry key is set to a nonzero value. If this key is not set or is set to 0, trace requests are returned as 404.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\DigestPartialContextCacheTTL (REG_DWORD)`

  The first time that a client connects to a website that requires digest authentication, it receives an initial challenge. This initial challenge is based on the partial security context that must be kept for the client to finish the digest authentication handshake.

  The `DigestPartialContextCacheTTL` registry key enables you to set the time-out value that controls the length of time that IIS must keep partial contexts.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\DigestContextCacheTTL (REG_DWORD)`

  After a successful digest authentication handshake, the full security context is kept. If the digest authentication handshake is inactive, full security contexts are flushed. The `DigestContextCacheTTL` registry key controls the length of time that full security contexts must be stored.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\DontFlushCachedIsapiResponses (REG_DWORD)`

  The default value of this registry key is false. If you set this value to a nonzero value, the `ISAPI` module calls the `SetKernelInvalidatorSet` field.  

  For more information about this registry key, see [Create a log file to troubleshoot ABO Mapper errors in IIS](https://support.microsoft.com/help/931208).

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\ForwardServerEnvironmentBlock (REG_DWORD)`

  The Common Gateway Interface (CGI) handler uses this registry key to determine whether the handler must forward all the environment variables that are defined on the worker process to the CGI process.
  
  The default value for this registry key is true. If you set this registry key value to 0, the CGI handler does not forward the environment block to the CGI process.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\MaxConcurrentCgisExecuting (REG_DWORD)`

  The default value for this registry key is 256. The CGI handler uses this registry key to determine the maximum number of CGI applications that can run at the same time.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\W3SVC\Parameters\DoNotKillCgiOnRequestEnd (REG_DWORD)`

  The default value for the registry key is false. You can set the value to true. A value of true tells the CGI handler not to kill the processes when the request ends.

## Registry keys that apply to ASP pages

The following registry keys apply to the Active Server Pages (ASP) Internet Server API (ISAPI).

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\F5AttackDetectionEnabled (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\HangDetRequestThreshold (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\HangDetThreadHungThreshold (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\HangDetConsecIllStatesThreshold (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\HangDetEnabled (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\EnableChangeNotificationForUNC (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\FileMonitoringEnabled (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\FileMonitoringTimeoutSeconds (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\MaxCSR (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\MaxCPU (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\DisableOOMRecycle (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\DisableLazyContentPropagation (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\ThreadMax (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\DisableComPlusCpuMetric (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\AspMaxResponseHeaderLength (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\AspMaxPropertyStringLength (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\DisableCachedResponseOnUNCAccessFailure (REG_DWORD)`  
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ASP\Parameters\DisableCertificateBlobAsArray (REG_DWORD)`  

  The Certificates binary large object (BLOB) is returned as an array. If you have programs that cannot handle an array, you can change this behavior. This key applies to IIS Manager and the Web Management Service (WMSVC).

## Registry keys that apply to IIS Manager and the WMSVC

- `HKEY_LOCAL_MACHINE\Software\Microsoft\Inetmgr\Parameters\IncrementalSiteIDCreation (REG_DWORD)`

  The default value for this registry key is 0. A value of 0 indicates that incremental site identifiers are not enabled. The Inetmgr.exe program reads this key every time that a website is created. You do not have to restart the Inetmgr.exe program after you change this key.

The following registry keys are used to store the settings that are required by the WMSVC for remote management.

> [!NOTE]
> If you make any changes to the keys, you must restart the WMSVC. You must use IIS Manager to change the values of the keys.

For more information about Remote Administration for IIS Manager, see [Remote Administration for IIS Manager](/iis/manage/remote-administration/remote-administration-for-iis-manager)

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\IPAddress (REG_SZ)`  

  The default value for this registry key is `*`. This value indicates all unassigned IP addresses.

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\Port (REG_DWORD)`

  If you do not specify a value for this key, the port number is 8172.

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\RequiresWindowsCredentials (REG_DWORD)`  

  The default value of this registry key is 0. The default value indicates that both Windows users and IIS Manager users can be used. If you set the key value to 1, only Windows users are enabled.

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\EnableLogging (REG_DWORD)`

  The default value for this registry key is 1. The default value indicates that WMSVC logging is enabled. If you set the key value to 0, WMSVC logging is disabled.

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\LoggingDirectory (REG_SZ)`

  The value for this registry key is the log file location. The default location is `%systemdrive%\inetpub\logs\wmsvc`

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\EnableRemoteManagement (REG_DWORD)`

  The default value for this registry key is 0. The default value indicates that the remote management feature is disabled. You must set this key value to 1 to enable the remote management feature.

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\RemoteRestrictions (REG_SZ)`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\SslCertificateHash (REG_BINARY)`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WebManagement\Server\SelfSignedSslCertificateHash (REG_BINARY)`

## Registry keys that apply to W3TP

> [!NOTE]
> These keys affect the thread pool manager that the WAS and the worker process use. The *W3tp.dll* is a file that is used by the IIS Thread Pool Library.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MaxPoolThreads (REG_DWORD)`

  This registry key value specifies the maximum number of threads that can be adjusted dynamically. The default value is 20 * number of processors.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\PoolThreadLimit (REG_DWORD)`

  This registry key specifies the absolute maximum thread count. The minimum value is 64, and the maximum value is 256. The default value is calculated based on available physical memory.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadTimeout (REG_DWORD)`

  The default value for this key is 1,800 seconds.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolStartupThreadCount (REG_DWORD)`

  The default value of this key is 4 if the number of processes is less than four. If the number of processes is more than four, the value of this key is equal to the number of processes. This value specifies the number of threads that must start when the computer starts. A value that is less than 1 is interpreted as 1.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolMaxCPU (REG_DWORD)`

  The default value of this key is 95. If CPU usage is more than 95, you cannot create new threads.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolStartDelay (REG_DWORD)`

  The default value is 1 second.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolExactThreadCount (REG_DWORD)`

  The default value of this key is 0. The default value specifies that the exact thread count value is not set. If the initial thread count value is set to 0, you cannot change the thread count dynamically.

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\MaxConcurrency (REG_DWORD)`

  This key specifies the number of threads that can process I/O at the same time. The default value is 0. A value of 0 enables the same number of running threads as the number of processors in the system.

## New registry keys in IIS

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\IIS\CentralCertProvider`

  This registry key controls the *new* `Central Certificate Store` parameters that are new to IIS. For more information about the new Central Certificate Store feature in IIS, see [IIS 8.0 Centralized SSL Certificate Support: SSL Scalability and Manageability](/iis/get-started/whats-new-in-iis-8/iis-80-centralized-ssl-certificate-support-ssl-scalability-and-manageability).

## References

For more information about how to create a log file in IIS, see [Create a log file to troubleshoot ABO Mapper errors in IIS](https://support.microsoft.com/help/931208).
