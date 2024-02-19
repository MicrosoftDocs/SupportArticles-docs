---
title: DNS zone transfer options are unexpectedly reset
description: Address an issue in which DNS zone transfer options are reset after you change the zone replication scope.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits, kardiva, davusa, gopkr, ajayps
ms.custom: sap:dns, csstroubleshoot
---
# DNS zone transfer options are reset after you change zone replication scope in Windows Server 2008 R2

This article provides help to solve an issue where DNS zone transfer options are reset after you change the zone replication scope.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4050194

## Symptoms

Consider the following scenario:  

- A domain that is named **contoso.com**  contains two domain controllers, **DC1.contoso.com** and **DC2.contoso.com**.
- Both domain controllers are Domain Name System (DNS) servers that host the `Contoso.com` zone.
- The zone replication scope is set to the following value:

    To all domain controllers in the domain (for Windows 2000 compatibility): `contoso.com`

- The **contoso.com** zone on **DC1** and **DC2** is configured to **Allow Zone transfers** to secondary servers.
- You set the zone replication scope to the following value:

    To all DNS servers running on domain controllers in this domain: `contoso.com`

    :::image type="content" source="media/dns-zone-transfer-options-reset/set-zone-replication-scope.png" alt-text="Screenshot of setting the zone replication scope.":::

- This change is replicated to **DC2**, and then the **contoso.com** zone is reloaded by the DNS service on **DC2**.

In this scenario, the zone transfer settings on **DC2**  are removed. The following changes occur:  

- The **Allow zone transfers**  check box is cleared.
- The list of servers to which zone transfer was previously allowed is removed. The server values are also removed from the registry.

    :::image type="content" source="media/dns-zone-transfer-options-reset/allow-zone-transfers-server-removed.png" alt-text="Screenshot of the properties window which shows the Allow zone transfers check box is cleared.":::

    > [!Note]
    > When this issue occurs, the zone transfers settings on **DC1**  are not affected.

## Cause

This issue occurs because the existing zone object is deleted from the partition, and a new object is created in the corresponding partition when the replication scope is changed. This change is replicated across all domain controllers.  
  
When the polling thread on **DC2** pulls the change from the new partition, the registry settings for  are reset. Zone transfer is disabled because the value of **SecureSecondaries**  is set to **3**. Also, any configured servers in the zone transfer list are removed because the **SecondaryServers** value is removed. From a DNS perspective, this process resembles creating a new zone in a different partition.  

## Resolution

Before you change the replication scope, note the zone transfer settings. Reconfigure the zone transfer settings after the replication scope is changed.  
You can also use the following scripts to back up and restore the settings.  
> [!Note]
> These scripts are provided on an as-is basis. We recommend that you thoroughly test these scripts before you use them in a production environment.  

### Backup script

Save the following code as a file that is named BackupZoneTransferSettings.ps1.  

```powershell
# Begin Script  
param([string]$ZoneName = "test2.com")  
#Build the vars  
$TargetRoot = "HKCU:\DNSZoneConfigMigration\"  
$TargetKeyPath = $TargetRoot  
$SourceRoot = "HKLM:\Software\Microsoft\Windows Nt\CurrentVersion\DNS Server\Zones\"  
$SourceKeyPath = $SourceRoot + $ZoneName  
#Copy the Item  
#Check for the presence of the item  
Get-Item HKCU:\DNSZoneConfigMigration -ErrorAction SilentlyContinue >$null  
if($?)  
{  
"DNSZoneConfigMigration key present already!"  
}  
else  
{  
New-Item -Path HKCU:\DNSZoneConfigMigration -ErrorAction SilentlyContinue >$null  
}  
if($?)  
{  
Copy-Item -Path $SourceKeyPath -Destination $TargetKeyPath -ErrorAction SilentlyContinue >$null  
if($?)  
  {  
"Key backed up in registry (Current User Hive) successfully!"  
  }
 else  
  {  
"Key Backup Failed.Error Code is " + $Error[0].Exception.Message  
  }  
}  
else  
{ "Unable to Create Backup Key.Error code is " + + $Error[0].Exception.Message + ".Exiting"  
}  
# End Script
```

#### Restore script

Save the following code as a file that is named RestoreZoneTransferSettings.ps1.  

```powershell
# Begin Script  
param([string]$ZoneName = "test2.com")  
#Build the vars
$SourceRoot = "HKCU:\DNSZoneConfigMigration\"  
$SourceKeyPath = $SourceRoot + $ZoneName  
$DestinationRoot = "HKLM:\Software\Microsoft\Windows Nt\CurrentVersion\DNS Server\Zones\"  
$DestinationKeyPath = $DestinationRoot + $ZoneName  
#Copy the ItemProperty Values  
Copy-ItemProperty -Path $SourceKeyPath -Destination $DestinationKeyPath -Name "SecureSecondaries" -ErrorAction SilentlyContinue >$null  
if($?)
{  
    "SecureSecondaries Value Successfully Restored for " + $ZoneName  
    Copy-ItemProperty -Path $SourceKeyPath -Destination $DestinationKeyPath -Name "SecondaryServers" -ErrorAction SilentlyContinue >$null  
    if($?)  
    {  
       "SecondaryServers Value Successfully Restored for " + $ZoneName "Restore Successful! Deleting the backup" Remove-Item -Path $SourceKeyPath  
if(-Not $?)  
    {  
    "Unable to Delete Backup Key. Delete Manually. Error :" + $Error[0].Exception.Message  
}  
    }  
    else
    {
     "Failed to restore SecondaryServers value. " + $Error[0].Exception.Message  
    }  
}  
else  
{  
    "Failed to restore SecureSecondaries value. " + $Error[0].Exception.Message  
}
# End Script
```

The backup script backs up the zone transfer settings for a particular zone. (For convenience, the backup is stored in the registry under the `HKEY_CURRENT_USER` hive.)  
> [!Note]
> You can run the **Set-ExecutionPolicy** PowerShell cmdlet to allow unsigned scripts.  

The second command (highlighted) in the following screenshot takes a backup of the zone transfer settings for the zone that is named "test3.com."

:::image type="content" source="media/dns-zone-transfer-options-reset/command-to-backup-zone-transfer-setting.png" alt-text="Screenshot of the command to take a backup of the zone transfer settings.":::

##### Where the settings are backed up to in the registry

:::image type="content" source="media/dns-zone-transfer-options-reset/settings-backed-up-in-resgitry.png" alt-text="Screenshot of the Registry Editor window where the settings are backed up.":::

##### Running the script to restore the zone transfer settings (the restore script restores these two values only)

:::image type="content" source="media/dns-zone-transfer-options-reset/script-to-restore-zone-transfer-setting.png" alt-text="Screenshot of Windows PowerShell window which runs the restore script.":::

##### Zone transfer settings in the registry before the restore operation  

:::image type="content" source="media/dns-zone-transfer-options-reset/settings-in-registry-before-restore.png" alt-text="Screenshot of the Registry Editor window with zone transfer settings before the restore operation.":::

##### Zone transfer settings in registry after the restore operation  

:::image type="content" source="media/dns-zone-transfer-options-reset/settings-in-registry-after-restore.png" alt-text="Screenshot of the Registry Editor window with zone transfer settings after the restore operation.":::

> [!Note]
> After you run the restore script, you must restart the DNS service to apply the changes.

## More information

### Zone transfer settings storage

The zone transfer settings are stored in the registry on the DNS server in the following path:

`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones\<domain name>`

 When zone transfer is set to specific servers or IP addresses, the following values are populated:  

- **SecureSecondaries** is set to **0x2**. This corresponds to the **Only to the following servers** option.  
- A multi-string value that is named **SecondaryServers** is created by using the IP addresses of the servers.  

#### Settings

:::image type="content" source="media/dns-zone-transfer-options-reset/zone-transfer-setting-storage.png" alt-text="Screenshot of the properties window with zone transfer settings.":::

#### Registry

:::image type="content" source="media/dns-zone-transfer-options-reset/zone-transfer-setting-storage-in-registry.png" alt-text="Screenshot of the Registry Editor window with zone transfer settings.":::

> [!Note]
> The zone transfer settings are not stored in Active Directory. Therefore, the settings don't replicate as part of Active Directory replication.  

### DS polling thread

The DNS service maintains a DS polling thread that periodically polls partitions and retrieves the list of all zones. For more information, see [How Often Does the DNS Server Service Check AD for New or Modified Data?](https://blogs.technet.microsoft.com/askpfeplat/2013/03/22/mailbag-how-often-does-the-dns-server-service-check-ad-for-new-or-modified-data/)  
By default, the DNS service polls Active Directory for changes every 180 seconds (3 minutes). You can control this process by using the **DsPollingInterval**  registry key or the **dnscmd /dspollinginterval**  switch.  
> [!Note]
> The switch accepts values from 0 to 3,600 seconds. However, values from 1 to 29 are not allowed. The minimum acceptable value is 30 seconds.  

For more information, see [Dnscmd config](https://technet.microsoft.com/library/cc756116%28v=WS.10%29.aspx#BKMK_3).
