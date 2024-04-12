---
title: Can't connect to alternate host headers
description: An HTTP error when you alternate host headers on SharePoint 2010 from BizTalk Server 2010 with the BizTalk SharePoint Adapter.
ms.date: 03/18/2020
ms.custom: sap:Adapters
---
# HTTP 404 error when you connect to alternate host headers on SharePoint 2010 from BizTalk Server 2010 with the BizTalk SharePoint Adapter

This article provides information about resolving an HyperText Transfer Protocol (HTTP) 404 error when you connect to alternate host headers on SharePoint 2010 from BizTalk Server 2010 with the BizTalk SharePoint Adapter.

_Original product version:_ &nbsp; BizTalk Server 2010  
_Original KB number:_ &nbsp; 2674591

## Summary

In Microsoft BizTalk Server 2010, the SharePoint adapter Web service can be installed on any SharePoint installation that it is needed upon.

However each installation on a SharePoint server can only be used from within one SharePoint virtual directory. As such if alternative access mappings are used to access the same SharePoint installation and BizTalk is then used to integrate with these mappings all queries will fail with an HTTP 404 error.

## Cause

This problem occurs because the web service doesn't exist in the alternate access mapping configuration with Internet Information Services (IIS).

## Resolution

After you configure this fix, this problem doesn't occur for that alternate access mapping. This fix needs to be configured on each Alternate Access Mapping that is added to the SharePoint installation.

Install the BizTalk SharePoint Adapter Web Service to the first Web Site as normal. These instructions are available in
[Setting Up and Deploying the Windows SharePoint Services Adapter](/biztalk/core/setting-up-and-deploying-the-windows-sharepoint-services-adapter).

Once the installation is finished, complete the procedure below for all alternate access mappings that are configured within SharePoint that you would like to integrate with.

## Configure BizTalk SharePoint Adapter for alternate access mappings in IIS

1. Start IIS Manager or open the IIS snap-in.
2. Expand **Server_name**, where **Server_name** is the name of the server, and then expand **Web Sites**.
3. In the console tree, right-click the Web site, virtual directory, or file for which you want to configure the BizTalk SharePoint Adapter, and then click **Add Application**.
4. Configure the **Alias** to be **BTSharePointAdapterWS**.
5. Click **Select** next to the **Application Pool** box.
6. Select **BTSharePointAdapterWSAppPool** as the **Application Pool** from the drop-down box.
7. Click **OK**.
8. Within the **Physical path**, provide the full path of the installation directory of the SharePoint adapter Web Service. The default for this is `C:\Program Files (x86)\Microsoft BizTalk Server 2010\BusIness Activity Services\BTSharePointV4AdapterWS`.

    > [!NOTE]
    > Only use the **V4** adapter with BizTalk 2010 and SharePoint 2010.

9. Click **OK** to add the application and then quit IIS Manager or close the IIS snap-in.

## More information

For more information on SharePoint integration with BizTalk 2010, visit [Windows SharePoint Services Adapter](/biztalk/core/windows-sharepoint-services-adapter).

For more information on creating IIS applications, visit [Create a Web Application (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772042(v=ws.10)).
