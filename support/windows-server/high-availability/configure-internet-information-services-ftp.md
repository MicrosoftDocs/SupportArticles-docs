---
title: Configure FTP for IIS in a Windows Server failover cluster
description: Describes how to configure FTP for IIS in a Windows Server failover cluster.
ms.date: 08/31/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# How to configure FTP for IIS in a Windows Server failover cluster

This article describes how to configure FTP for Internet Information Services (IIS) 8.0 or a later version in a Windows Server failover cluster. The procedures in this article apply only to the FTP service.  

> [!NOTE]
> For more information about how to configure Web services in a failover cluster, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [970759](https://support.microsoft.com/help/970759) Configuring IIS World Wide Web Publishing Service in a Windows Server failover cluster

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974603

## Configure high availability for IIS FTP servers using Failover Clustering

1. Install the Web Server role on all cluster nodes. If you're installing on Windows Server 2012, don't include the "FTP Server" role. If you're installing on Windows Server 2012 R2 or a later version, include the in-box "FTP Server" role. For more information about IIS 8 deployment guide, visit the following website: [Open IIS Manager (IIS 8)](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj635847%28v=ws.11%29)

2. Install the Failover Clustering feature on all cluster nodes and create the cluster. For more information, visit the following website: [Failover Cluster Deployment Guide](https://technet.microsoft.com/library/dd197477%28ws.10%29.aspx)

3. Set up a file share that will be used for IIS Shared Configuration.
4. Configure IIS Shared Configuration on all cluster nodes.
5. Configure Offline Files for IIS Shared Configuration on all cluster nodes.
6. Configure the FTP site and specify the location of its content on one cluster node.
7. Configure highly availability for your FTP site by creating a generic script in Failover Clustering.

## Set up a file share that will be used for IIS shared configuration

1. Create a user who will access the share that will be used for the IIS shared configuration.
2. Create the file share. This share will be used to store the IIS shared configuration that will be shared between IIS on all cluster nodes. There are multiple options:

    - On a stand-alone server that's not part of any failover cluster, create a file share.
    - On another Windows Server failover cluster, create a high availability file share. For more information, visit the following Microsoft website: [Failover Cluster Step-by-Step Guide: Configuring a Two-Node File Server Failover Cluster](https://technet.microsoft.com/library/cc731844.aspx)

    - On the same failover cluster that will host the high availability FTP site, create a high availability file share. For more information, visit the following Microsoft website: [Failover Cluster Step-by-Step Guide: Configuring a Two-Node File Server Failover Cluster](https://technet.microsoft.com/library/cc731844.aspx)

3. Set the permissions on the share that you created in step 2. Give the user whom you created in step 1 Full Control permissions to the file share and NTFS permissions.
4. Confirm that all cluster nodes can browse to the file share. The path of the file share is `\\<fileservername>\<sharename>`.

## Configure the IIS shared configuration on all cluster nodes

On one of the cluster nodes, export the shared configuration to the file share:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the left pane, select the server name node.
3. Double-click the **Shared Configuration** icon.
4. On the Shared Configuration page, select **Export Configuration** in the **Actions** pane (the right pane) to export the configuration files from the local computer to another location.
5. In the **Export Configuration** dialog box, type the path of the file share (`\\<fileservername>\<sharename>`) in the **Physical path** box.
6. Select **Connect As**, and then type the user name and the password for the user account that has access to the share in which the shared configuration is stored, and then select **OK**. This account will be used to access the share. You should use a restricted Active Directory account that's not the domain administrator.
7. In the **Export Configuration** dialog box, type a password that will be used to protect the encryption keys, and then select **OK**.
8. On the **Shared Configuration** page, select the **Enable shared configuration** check box.
9. Type the physical path, the user account, and the password that you entered previously, and then select **Apply** in the **Actions** pane.
10. In the **Encryption Keys Password** dialog box, type the encryption key password that you set earlier, and then select **OK**.
11. In the Shared Configuration dialog box, select **OK**.
12. Select **OK**.

On each of the other cluster nodes, use the shared configuration that you just exported to the file share:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. Select the server name node.
3. Double-click the **Shared Configuration** icon.
4. On the **Shared Configuration** page, select the **Enable shared configuration** check box.
5. Type the physical path of the file share (`\\<fileservername>\<sharename>`), the user account, and the password that you entered previously, and then select **Apply** in the **Actions** pane.
6. In the **Encryption Keys Password** dialog box, type the encryption key password that you set earlier, and then select **OK**.
7. In the Shared Configuration dialog box, select **OK**.
8. Select **OK**.

> [!NOTE]
> For more information about how to set up shared configurations in IIS, visit the following Microsoft website: [Shared Configuration](https://learn.iis.net/page.aspx/264/shared-configuration)

## Configure Offline Files for IIS Shared Configuration on all cluster nodes

On each cluster node, enable Offline Files:

1. Install the Desktop Experience feature. To do this, follow these steps:

    1. Navigate to **Administrative Tools**, and then select **Server Manager**.
    2. In the left pane, select **Features**.
    3. Select **Add Features** in the right pane.
    4. Do one of the following, as appropriate for your Windows version:
       - For Windows Server 2016, review [Install Server with Desktop Experience](/windows-server/get-started/getting-started-with-server-with-desktop-experience).
       - For Windows Server 2102 and 2012 R2, choose **Desktop Experience** under **User Interfaces and Infrastructures** in the features list
2. Do the following:  
   For Windows Server 2012, 2012 R2 and 2016, select **Sync Center** in Control Panel, and then select **Manage offline files.**
3. Select **Enable Offline Files**. Don't restart the computer at this point.
4. Ensure that the cache is set to read-only. To do this, run the following command at an elevated cmd prompt:

    ```console
    REG ADD "HKLM\System\CurrentControlSet\Services\CSC\Parameters" /v ReadOnlyCache /t REG_DWORD /d 1 /f
    ```

5. Restart the computer.
6. Browse to the file server from the computer. Right-click the share that contains the IIS shared configuration, and then select **Always Available Offline**.

    > [!NOTE]
    > If you set up the file share to be highly available on the same failover cluster that hosts IIS nodes, the **Always Available Offline** option will not appear when you right-click the share if the cluster node that you are on is hosting the highly available file server. You will have to move the high available file server application to another node.
7. In Control Panel, open **Offline Files**. Select **Open Sync Center**, and then select **Schedule**.
8. Schedule an offline file sync for every day or according to your requirements. You can also configure the offline sync to run every few minutes. Even if you don't set up a scheduler, when you change something in the Applicationhost.config file, the change is reflected on the Web server.

> [!NOTE]
> For more information about how to configure offline files for a shared configuration in IIS, see [Offline Files for Shared Configuration](/iis/web-hosting/configuring-servers-in-the-windows-web-platform/offline-files-for-shared-configuration).

## Configure the FTP site and specify the location of its content on one cluster node

Find the cluster node that owns the cluster disk resource where the FTP site content files will reside:

1. Navigate to **Administrative Tools**, and then select **Failover Cluster Manager**.
2. Connect to the cluster. If you are on one of the cluster nodes, the cluster will appear on the list automatically.
3. Under "Storage," find the disk resource on which the FTP site content will reside. To do this, expand the storage tree for the disk resource. Make sure that the storage isn't used by any other high availability application on the cluster. You'll find the storage under "Available Storage."
4. Note the cluster node on which this resource is online. You'll configure IIS on that cluster node.
5. Note the cluster disk resource name. You'll use this for the content files.

On the cluster node on which the resource is online, configure the FTP server to use the shared disk for FTP site content:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the left pane, expand the server name node.
3. Expand **Sites**, right-click **Sites**, and then select **Add FTP Site**.
4. In the **Add FTP Site** dialog box, type the site name. For the content directory, type the location where the FTP site content files are located. This is the location of the cluster disk resource that you noted in step 5 of the previous procedure.
5. Configure remaining FTP site settings.
6. Select **Finish**.

## Configure high availability for your FTP site by creating a generic script in Failover Cluster Manager

For the last step to configure high availability for FTP site, set up the generic script resource that will be used to monitor the FTP service:

1. On each cluster node, copy the script at the end of this article to `Windows\System32\inetsrv\Clusftp7.vbs`.
2. Navigate to **Administrative Tools**, and then select **Failover Cluster Manager**.
3. Connect to the cluster. If you are on one of the cluster nodes, the cluster will appear on the list automatically.
4. Do the following:  
For Windows Server 2012, 2012 R2 and 2016, right-click **Roles** and then select **Configure Role** to create it.
5. Click **Generic Script**.
6. Select the script file from the following path:  
`%systemroot%\System32\Inetsrv\Clusftp7.vbs`
7. Set the Client Access Point (CAP) name to the FTP site name that clients will use to connect to the high availability FTP site. Specify the static IPs to use for the FTP site CAP. If you're using Dynamic Host Configuration Protocol (DHCP), this option won't be displayed.
8. In the **Select Storage** step, select the cluster shared disk on which the FTP site content files reside. The storage should be unused by any other high availability application on the cluster. If the file share that is used for the IIS shared configuration is hosted on the same cluster, a different disk resource should be used here.
9. After you confirm the settings, the wizard will create the cluster group, cluster resources, and the dependencies between the resources, and then bring the resources online.

> [!NOTE]
> To host multiple high availability FTP sites on the same failover cluster, follow the same steps that are mentioned earlier. You can point to the same script file for all FTP sites on the cluster if you did not customize the script. However, if you make changes that are specific to the individual FTP sites, use a different script file for each FTP site and different clustered shared storage. For example, in `%systemroot%\System32\Inetsrv, useClusftp7.vbs` for the first FTP site,Clftp7-2.vbsfor the second,Clftp7-3.vbsfor the third, and so on. Each script file monitors a different FTP site.

> [!IMPORTANT]
> The following script is for sample purposes only and is not explicitly supported by Microsoft. Use of this script in an IIS 8.0 FTP clustered environment is done at your own risk.

```vbscript

'<begin script sample>

'This script provides high availability for IIS FTP websites
'The script is applicable to:
'   - Windows Server 2012: Microsoft FTP Service 7.5 for IIS 8.0 (available for download from microsoft.com)
'   - Windows Server 2012 R2 or a later version: FTP Service in the box

'More thorough and application-specific health monitoring logic can be added to the script if needed


Option Explicit



'Helper script functions


'Start the FTP service on this node
Function StartFTPSVC()

    Dim objWmiProvider
    Dim objService
    Dim strServiceState
    Dim response

    'Check to see if the service is running
    set objWmiProvider = GetObject("winmgmts:/root/cimv2")
    set objService = objWmiProvider.get("win32_service='ftpsvc'")
    strServiceState = objService.state

    If ucase(strServiceState) = "RUNNING" Then
        StartFTPSVC = True
    Else
        'If the service is not running, try to start it
        response = objService.StartService()

        'response = 0  or 10 indicates that the request to start was accepted
        If ( response <> 0 ) and ( response <> 10 ) Then
            StartFTPSVC = False
        Else
            StartFTPSVC = True
        End If
    End If

End Function

'Cluster resource entry points. More details here:
'http://msdn.microsoft.com/en-us/library/aa372846(VS.85).aspx

'Cluster resource Online entry point
'Make sure the FTP service is started
Function Online( )

    Dim bOnline
    'Make sure FTP service is started
    bOnline = StartFTPSVC()

    If bOnline <> True Then
        Resource.LogInformation "The resource failed to come online because ftpsvc could not be started."
        Online = False
        Exit Function
    End If

    Online = true

End Function

'Cluster resource offline entry point
'On offline, do nothing.
Function Offline( )

    Offline = true

End Function


'Cluster resource LooksAlive entry point
'Check for the state of the FTP service
Function LooksAlive( )

    Dim objWmiProvider
    Dim objService
    Dim strServiceState

    set objWmiProvider = GetObject("winmgmts:/root/cimv2")
    set objService = objWmiProvider.get("win32_service='ftpsvc'")
    strServiceState = objService.state

    if ucase(strServiceState) = "RUNNING" Then
LooksAlive = True
    Else
LooksAlive = False
    End If

End Function


'Cluster resource IsAlive entry point
'Do the same health checks as LooksAlive
'If a more thorough than what we do in LooksAlive is required, this should be performed here
Function IsAlive()

    IsAlive = LooksAlive

End Function


'Cluster resource Open entry point
Function Open()

    Open = true

End Function


'Cluster resource Close entry point
Function Close()

    Close = true

End Function


'Cluster resource Terminate entry point
Function Terminate()

    Terminate = true

End Function
```
