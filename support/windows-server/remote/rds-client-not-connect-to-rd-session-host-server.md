---
title: RDS client can't connect to RD Session Host server
description: Solves an issue where a Remote Desktop Services (RDS) client can't connect to a session collection. It occurs if the IP addresses of Remote Desktop (RD) Session Host servers in the collection are changed.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# RDS client can't connect to RD Session Host server after the server IP address is changed

This article provides a solution to an issue where Remote Desktop Services (RDS) client can't connect to Remote Desktop (RD) Session Host server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2844958

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

## Symptoms

Considering the following scenario:

- You set up a standard deployment of RDS in Windows Server 2012. The deployment contains RD Session Host servers, an RD Connection Broker server, and an RD Web Access server.
- You create a session collection that can be accessed by RDS clients through the RD Web Access website.
- The IP addresses of all RD Session Host servers in the session collection are changed.

In this scenario, the RDS clients can't connect to the session collection, and you receive the following error message during the connection:

> Your credentials did not work.

## Cause

This problem occurs because of an obsolete registry entry in the following subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\ClusterSettings`

The **`SessionDirectoryRedirectionIP`** registry entry stores the IP address of an RD Session Host server that was assigned when the RDS deployment was created. Although the IP address of the RD Session Host server is changed, the IP address in the RD Connection Broker setting isn't updated. So RDS clients can't connect to the session collection.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this problem, delete the **`SessionDirectoryRedirectionIP`** registry entry of the following registry subkey from each RD Session Host server in the session collection:  

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\ClusterSettings`  

Or, you can run the following PowerShell script. This script deletes the registry entry from every RD Session Host server in the deployment.

```powershell
Import-Module RemoteDesktop

# Delete the Registry Key for all machine name specified in $RemoteMachine
Function DeleteRegistryKey($RemoteMachine)
{
 $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $RemoteMachine)

# connect to the needed key :  
 $regKey= $reg.OpenSubKey("System\\CurrentControlSet\\Control\\Terminal Server\\ClusterSettings", $true )

# and delete the SessionDirectoryRedirectionIP subkey, if it exists
 foreach ($key in $regKey.GetValueNames())
 { 
 if ($key -eq "SessionDirectoryRedirectionIP")
 {
 $regKey.DeleteValue($key)  
 Write-Host "Machine : "$RemoteMachine
 }
 }
}

# Get the list of collections on the machine
$RdSessionCollections = Get-RDSessionCollection  

if ($RdSessioncollections -eq $null)
{
 Write-Host "No RDSH Session Collections"
 return
}

foreach ($SessionCollection in $RdSessionCollections)
{
 Write-Host "Collection Name : " $SessionCollection.CollectionName

# get list of RDSH Servers in the collection
 $RdSessionHosts = Get-SessionHost -CollectionName $SessionCollection.CollectionName
 foreach ($SessionHost in $RdSessionHosts)
 {
 Write-Host "SessionHost : "$SessionHost.SessionHost

# Delete the regkey on this server
 DeleteRegistryKey($SessionHost.SessionHost)
 }
}
```
