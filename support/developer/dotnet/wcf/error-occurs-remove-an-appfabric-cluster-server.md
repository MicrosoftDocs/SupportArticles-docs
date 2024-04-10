---
title: Error occurs when you remove a server
description: This article provides resolutions for the problem that triggers an error when you try to remove an unreachable server from a Windows Server AppFabric cluster.
ms.date: 08/24/2020
---
# Error occurs when you try to remove a server from an AppFabric cluster

This article helps you resolve the problem that triggers an error when you try to remove an unreachable server from a Windows Server AppFabric cluster.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 3049610

## Symptoms

When you have an AppFabric cluster, and you remove a computer from the cluster, or you or rename a computer without first removing it from the AppFabric cluster, the following error is triggered:

> PS C:\Windows\system32> get-cachehost
Get-AFCacheHostStatus : ErrorCode\<ERRCAdmin039>:SubStatus\<ES0001>:Cache host Cache1.domain.corp.contoso.com is not reachable.
At line:1 char:14  
\+ get-cachehost <<<<  
\+ CategoryInfo : NotSpecified: (:) [Get-AFCacheHostStatus], DataC
acheException  
\+ FullyQualifiedErrorId : ERRCAdmin039,Microsoft.ApplicationServer.Caching  
.Commands.GetAFCacheHostStatusCommand

This behavior occurs when you run certain AppFabric PowerShell cmdlets.

## Cause

This issue occurs because the AppFabric cluster contacts all the individual hosts in the cluster when certain commands are run. This may also cause issues with intra-host operations.

## Resolution

If the computer is no longer available, use the following command to remove the host:

```console
Export-CacheClusterConfig <file_location\config.xml>
```

Find the missing host in the \<hosts> section, and then delete it. Save the *config.xml* file, and import it by running the following command:

```console
Import-CacheClusterConfig <file_location\config.xml>
```

> [!NOTE]
> The cluster must be shut down before you run these commands.

## More information

If the host is reachable, it's best to use the `Unregister-CacheHost` command way to remove it from the cluster. Because this command is in the `DistributedCacheConfiguration` module, you will have to import it into the AppFabric PowerShell environment.

To rename a host, run the `Unregister-CacheHost` command, rename the computer, and then run Register-CacheHost.

If there are two entries for a single computer, with one showing as NetBIOS and the other showing as a fully qualified domain name (FQDN), use the Config method, and then remove the `NetBIOS` name from the configuration.
