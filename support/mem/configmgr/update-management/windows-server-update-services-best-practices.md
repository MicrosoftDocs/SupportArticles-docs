---
title: Windows Server Update Services (WSUS) best practices
description: Describes best practices for WSUS to avoid configurations that experience poor performance.
ms.date: 12/05/2023
ms.reviewer: kaushika, sccmcsscontent, erice
---
# Windows Server Update Services best practices

This article provides tips for avoiding configurations that experience poor performance because of design or configuration limitations in WSUS.

_Original product version:_ &nbsp; Configuration Manager (current branch), Windows Server Update Services  
_Original KB number:_ &nbsp; 4490414

## Capacity limits

Although WSUS can support [100,000 clients](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939839(v=ws.10)) per server ([150,000 clients](/mem/configmgr/core/plan-design/configs/size-and-scale-numbers#software-update-point) when you use Configuration Manager), we don't recommend approaching this limit.

Instead, consider using a configuration of 2-4 servers sharing the same SQL Server database. This way you have safety in numbers. If one server goes down, it won't immediately spoil your weekend because no client can update while you must be updated against the latest zero-day exploit.

The shared database scenario also prevents a scan storm.

A scan storm can occur when many clients change WSUS servers and the servers don't share a database. WSUS tracks activity in the database, so that both know what has changed since a client last scanned and will only send metadata that's updated since then.

If clients change to a different WSUS server that uses a different database, they must do a full scan. A full scan can cause large metadata transfers. Transfers of greater than 1 GB per client may occur in these scenarios, especially if the WSUS server isn't maintained correctly. It can generate enough load to cause errors when clients communicate with a WSUS instance. And clients retry repeatedly in this case.

Sharing a database means when a client switches to another WSUS instance that uses the same DB, the scan penalty isn't incurred. The load increases aren't the large penalty you pay for switching databases.

Configuration Manager client scans put more demand on WSUS than the stand-alone Automatic Updates. Configuration Manager, because it includes compliance checking, requests scans with criteria that will return all updates that are in any status except declined.

When the Automatic Updates Agent scans, or you select **Check for Updates** in Control Panel, the agent sends criteria to retrieve only those updates Approved for Install. The metadata returned will usually be less than when the scan is initiated by Configuration Manager. The Update Agent does cache the data, and the next scan requests will return the data from the client cache.

## Disable recycling and configure memory limits

WSUS implements an internal cache that retrieves the update metadata from the database. This operation is expensive and very memory intensive. It can cause the IIS application pool that hosts WSUS (known as WSUSPool) to recycle when WSUSPool overruns the default private and virtual memory limits.

When the pool recycles, the cache is removed and must be rebuilt. It isn't a large problem when clients are undergoing delta scans. But if you end up in a scan storm scenario, the pool will recycle constantly. And clients will receive errors when you make scan requests, such as **HTTP 503** errors.

We recommend that you increase the default **Queue Length**, and disable both the Virtual and Private Memory Limit by setting them to **0**. IIS implements an automatic recycling of the application pool every 29 hours, Ping, and Idle Time-outs, all which should be disabled. These settings are found in **IIS Manager** > **Application Pools** > choose **WsusPool** and then click the **Advanced Settings** link in the right side pane of IIS manager.

Here's a summary of recommended changes, and a related screenshot. For more information, see [Plan for software updates in Configuration Manager](/mem/configmgr/sum/plan-design/plan-for-software-updates).

|Setting name|Value|
|---|---|
|Queue Length|**2000** (up from default of 1000)|
|Idle Time-out (minutes)|**0** (down from the default of 20)|
|Ping Enabled|**False** (from default of True)|
|Private Memory Limit (KB)|**0** (unlimited, up from the default of 1,843,200 KB)|
|Regular Time Interval (minutes)|**0** (to prevent a recycle, and modified from the default of 1740)|
  
:::image type="content" source="media/windows-server-update-services-best-practices/advanced-settings.png" alt-text="Screenshot of the settings in the Advanced Settings window.":::

In an environment that has around 17,000 updates cached, more than 24 GB of memory may be needed as the cache is built until it stabilizes (at around 14 GB).

## Check whether compression is enabled (if you want to conserve bandwidth)

WSUS uses a compression type calls Xpress encoding. It implements compression on update metadata, and can result in significant bandwidth savings.

Xpress encoding is enabled in IIS ApplicationHost.config with this line under the `<httpCompression>` element and a registry setting:

- **ApplicationHost.Config**

    > \<scheme name="xpress" doStaticCompression="false" doDynamicCompression="true" dll="C:\Program Files\Update Services\WebServices\suscomp.dll" staticCompressionLevel="10" dynamicCompressionLevel="0" />

- **Registry key**

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Update Services\Server\Setup\IIsDynamicCompression`

If both aren't present, it can be enabled by running this command and then restarting the WsusPool application pool in IIS.

```console
cscript "%programfiles%\update services\setup\DynamicCompression.vbs" /enable "%programfiles%\Update Services\WebServices\suscomp.dll"
```

Xpress encoding will add some CPU overhead, and can be disabled if bandwidth isn't a concern, but CPU usage is. The following command will turn it off.

```console
cscript "%programfiles%\update services\setup\DynamicCompression.vbs" /disable
```

## Configure products and categories

When you configure WSUS, choose only the products and categories that you plan to deploy. You can always synchronize categories and products that you must have later. Adding them when you don't plan to deploy them increases metadata size and overhead on the WSUS servers.

## Disable Itanium updates and other unnecessary updates

It shouldn't be an issue for much longer, because Windows Server 2008 R2 was the last version to support Itanium. But it bears mentioning.

Customize and use [this](https://www.powershellgallery.com/packages/decline-WSUSUpdatesTypes) script in your environment to decline Itanium architecture updates. The script can also decline updates that contain **Preview** or **Beta** in the update title.

It leads to the WSUS console being more responsive, but doesn't affect the client scan.

## Decline superseded updates and run maintenance

One of the most important things that you can do to help WSUS run better. Keeping updates around that are superseded longer than needed (for example, after you're no longer deploying them) is the leading cause of WSUS performance problems. It's ok to keep them around if you're still deploying them. Remove them after you're done with them.

For information about declining superseded updates and other WSUS maintenance items, see the [Complete guide to Microsoft WSUS and Configuration Manager SUP maintenance](https://support.microsoft.com/help/4490644) article.

## WSUS with SSL setup

By default, WSUS isn't configured to use SSL for client communication. The first post-install step should be to configured SSL on WSUS to make sure security between server-client communications.

You must take one the following actions:

- Create a self-signed certificate. It isn't ideal because every client would have to trust this certificate.
- Obtain one from a third-party certificate provider.
- Obtain one from your internal certificate infrastructure.

Your certificate must have the short server name, FQDN, and SAN names (aliases) that it goes by.

After you have the certificate installed, upgrade the Group Policy (or Client Configuration settings for software updates in Configuration Manager) to use the address and SSL port of the WSUS server. The port is typically 8531 or 443.

For example, configure GPO **Specify intranet Microsoft update service location** to <`https://wsus.contoso.com:8531`>.

To get started, see [Secure WSUS with the Secure Sockets Layer Protocol](/windows-server/administration/windows-server-update-services/deploy/2-configure-wsus#25-secure-wsus-with-the-secure-sockets-layer-protocol).

## Configure Antivirus Exclusions

- [Antivirus scans](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939908(v=ws.10)#antivirus-scans)
- [Microsoft Anti-Virus Exclusion List](https://social.technet.microsoft.com/wiki/contents/articles/953.microsoft-anti-virus-exclusion-list.aspx)

## About Cumulative Updates and Monthly Rollups

You may see the terms **Monthly Rollups** and **Cumulative Update** used for Windows OS updates. They may be used interchangeably. Rollups refer to the updates published for Windows 7, Windows 8.1, Windows Server 2008 R2, and Windows Server 2012 R2 that are only partly cumulative.

For more information, see the following blog posts:

- [Simplified servicing for Windows 7 and Windows 8.1: the latest improvements](https://techcommunity.microsoft.com/t5/Windows-Blog-Archive/Simplified-servicing-for-Windows-7-and-Windows-8-1-the-latest/ba-p/166798)
- [More on Windows 7 and Windows 8.1 servicing changes](https://techcommunity.microsoft.com/t5/Windows-Blog-Archive/More-on-Windows-7-and-Windows-8-1-servicing-changes/ba-p/166783)

With Windows 10 and Windows Server 2016, the updates were cumulative from the beginning:

- [Windows 10 update servicing cadence](https://techcommunity.microsoft.com/t5/Windows-IT-Pro-Blog/Windows-10-update-servicing-cadence/ba-p/222376)

Cumulative means that: you install the release version of the OS, and only have to apply the latest Cumulative Update to be fully patched. For the older operating systems, we don't have such updates yet, although it's the direction we're heading in.

For Windows 7 and Windows 8.1, it means that after you install the latest monthly rollup, more updates will still be needed. Here's an example for [Windows 7 and Windows Server 2008 R2](https://social.technet.microsoft.com/wiki/contents/articles/52047.windows-7-refreshed-media-creation.aspx) on what it takes to have an almost fully patched system.

The following table contains the list of Windows Monthly Rollups and Cumulative Updates. You can also find them by searching for **Windows \<version> update History**.

| Windows version | Update |
|---|---|
|Windows 7 SP1 and Windows Server 2008 R2 SP1|[Windows 7 SP1 and Windows Server 2008 R2 SP1 update history](https://support.microsoft.com/help/4009469/windows-7-sp1-windows-server-2008-r2-sp1-update-history)|
|Windows 8.1 and Windows Server 2012 R2|[Windows 8.1 and Windows Server 2012 R2 update history](https://support.microsoft.com/help/4009470/windows-8-1-windows-server-2012-r2-update-history)|
|Windows 10 and Windows Server 2016|[Windows 10 and Windows Server update history](https://support.microsoft.com/help/4043454/windows-10-windows-server-update-history)|
|Windows Server 2019|[Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/help/4464619)|
  
Another point to consider is that not all updates are published so that they sync automatically to WSUS. For example, _C_ and _D_ week Cumulative Updates are preview updates and won't synchronize to WSUS, but must be manually imported instead. See the **Monthly quality updates** section of [Windows 10 update servicing cadence](https://techcommunity.microsoft.com/t5/Windows-IT-Pro-Blog/Windows-10-update-servicing-cadence/ba-p/222376).

## Using PowerShell to connect to a WSUS server

Here's just a code example to get you started with PowerShell and the WSUS API. It can be executed where the WSUS Administration Console is installed.

```powershell
[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$WSUSServer = 'WSUS'
# This is your WSUS Server Name
$Port = 8530
# This is 8531 when SSL is enabled
$UseSSL = $False
#This is $True when SSL is enabled
Try
{
    $Wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($WSUSServer,$UseSSL,$Port)
}
Catch
{
    Write-Warning "$($WSUSServer)<$($Port)>: $($_)"
    Break
}
```

## References

- [SUS Blog](/archive/blogs/sus/)

- [WSUS Product Team Blog](/archive/blogs/wsus/)

- [The complete guide to Microsoft WSUS and Configuration Manager SUP maintenance](https://support.microsoft.com/help/4490644)

- [How does Windows Update work?](/windows/deployment/update/how-windows-update-works)

- [Introduction to WSUS and PowerShell](https://devblogs.microsoft.com/scripting/introduction-to-wsus-and-powershell/)

- [Use PowerShell to Perform Basic Administrative Tasks on WSUS](https://devblogs.microsoft.com/scripting/use-powershell-to-perform-basic-administrative-tasks-on-wsus/)

- [Approve or Decline WSUS Updates by Using PowerShell](https://devblogs.microsoft.com/scripting/approve-or-decline-wsus-updates-by-using-powershell/)

- [Use PowerShell to Find Missing Updates on WSUS Client Computers](https://devblogs.microsoft.com/scripting/use-powershell-to-find-missing-updates-on-wsus-client-computers/)

- [Get Windows Update Status Information by Using PowerShell](https://devblogs.microsoft.com/scripting/get-windows-update-status-information-by-using-powershell/)

- [Introduction to PoshWSUS, a Free PowerShell Module to Manage WSUS](https://devblogs.microsoft.com/scripting/introduction-to-poshwsus-a-free-powershell-module-to-manage-wsus/)

- [Use the Free PoshWSUS PowerShell Module for WSUS Administrative Work](https://devblogs.microsoft.com/scripting/use-the-free-poshwsus-powershell-module-for-wsus-administrative-work/)

- [Download resources and applications for Windows, SharePoint, Office, and other products](https://gallery.technet.microsoft.com/)

- [PowerShell UI used for auditing and installing updates from WSUS to local and remote systems](https://github.com/proxb/PoshPAIG)

- [PowerShell module to manage Windows Server Update Services (WSUS)](https://github.com/proxb/PoshWSUS)
