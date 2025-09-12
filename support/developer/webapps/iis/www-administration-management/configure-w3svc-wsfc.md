---
title: Configuring IIS World Wide Web Publishing Service
description: This article describes how to configure IIS World Wide Web Publishing Service in a Windows Server failover cluster.
ms.date: 03/31/2020
ms.custom: sap:WWW Administration and Management\Cluster Services
ms.reviewer: bretb, ahmedb, ctimon, mlaing
---
# Configuring IIS World Wide Web Publishing Service in a Windows Server failover cluster

This article describes how to configure Microsoft Internet Information Services (IIS) World Wide Web Publishing Service (W3SVC) in a Windows Server failover cluster (WSFC).

_Original product version:_ &nbsp; Windows Server 2008 and later versions, Internet Information Services 8.0 and later versions  
_Original KB number:_ &nbsp; 970759

## Introduction

The procedures in this article apply only to the World Wide Web Publishing Service. For instructions on how to configure the FTP Publishing service in a failover cluster, see [How to configure FTP for IIS in a Windows Server failover cluster](https://support.microsoft.com/help/974603).

## More information

In earlier versions of Internet Information Services, Microsoft provided generic resource monitor components to support high availability Web server instances using the Microsoft Clustering infrastructure. However, custom code was needed to fully realize the potential of such a solution. Also, the generic scripts that Microsoft provided didn't satisfy customer needs. To configure IIS 7.0 or a later version in a clustered environment that uses Windows Server failover clustering, you have to use a custom (scripting) code to enable such a high availability scenario. When you do it, users can customize the setup to meet their requirements. which gives them full control over the high availability integration of Web applications. Additionally, the script interfaces for administration and monitoring that were introduced in IIS 7.0 provide a richer environment than the scripts that were provided previously.

> [!NOTE]
> The IIS 7.0 installation files incorrectly include the *Clusweb.vbs* and *Clusftp.vbs* script files that are used in IIS 6.0 for IIS cluster administrative tasks. Do not use these scripts with IIS 7.0 or a later version.

We recommend that administrators carefully evaluate the use of Network Load Balancing (NLB) as the primary and preferred method for improving the scalability and availability of Web applications with multiple servers running IIS 7.0 or a later version, as opposed to using failover clustering. One of the benefits of NLB is that all servers can actively participate in the simultaneous handling of incoming HyperText Transfer Protocol (HTTP) requests. Another benefit is that in an NLB IIS environment, it can be much easier to support rolling updates and rollbacks while still providing high availability of Web applications. For more information about using IIS 7.0 or a later version in an NLB environment, see the following articles:

- [Install and configure Network Load Balancing](/iis/web-hosting/configuring-servers-in-the-windows-web-platform/network-load-balancing)
- [Network Load Balancing](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770558(v=ws.11))

It's important to consider that clustering IIS by means of clustering the IIS services doesn't always guarantee a high availability solution for Web applications. While the IIS services (specifically the WWW service) might be up and running, a specific application pool's hosting process could have terminated, or the application might be throwing internal server HTTP errors. Clustering the Web applications and monitoring their health by using a custom script is the correct and recommended way to achieve a high availability IIS cluster using failover clustering. Below is a sample script that monitors the state of an application pool to determine if it's started or not.

To configure high availability for IIS 7.0 or a later version Web server using failover clustering, follow these steps. Steps 3 to 7 are described in more detail below. The sample script later in this article can be used as an example for IIS 7.0 or a later version.

1. Install the Web Server role on all cluster nodes. For details, see [IIS 7 Deployment Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771752(v=ws.10)).
2. Install the failover clustering feature on all cluster nodes and create the cluster. For details, see [Failover Cluster Deployment Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197477(v=ws.10)).
3. Set up a file share that will be used for the IIS shared configuration.
4. Configure the IIS shared configuration on all cluster nodes.
5. Configure IIS Offline Files for shared configuration on all cluster nodes.
6. Configure the website (including the associated application pool), and specify the location of its content on one cluster node.
7. Configure high availability for your website by creating a generic script in failover clustering.

## Set up a file share that will be used for IIS shared configuration

1. Create a user that will access the share that will be used for the IIS shared configuration.
2. Create the file share. This share will be used to store the IIS shared configuration that will be shared between IIS on all cluster nodes. There are multiple options:
   - On a standalone server that isn't part of any failover cluster, create a file share.
   - On another Windows Server failover cluster, create a high availability file share. For details, visit [Failover Cluster Step-by-Step Guide: Configuring a Two-Node File Server Failover Cluster](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731844(v=ws.10)).
   - On the same failover cluster that will host the high availability website, create a high availability file share. For details, see [Failover Cluster Step-by-Step Guide: Configuring a Two-Node File Server Failover Cluster](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731844(v=ws.10)).
3. Set the permissions on the share that you created in step 2. Give the user that you created in step 1 Full Control permissions to the file share and NTFS permissions.
4. Confirm that all cluster nodes can browse to the file share. The path to the file share is `\\<fileserver>\<share>`.

## Configure the IIS shared configuration on all cluster nodes

> [!NOTE]
> There is a problem with IIS shared configuration on Windows 2008 Server due to missing privileges for the `Application Host Helper Service`. For shared configuration to work, you must follow these steps when you set up IIS shared configuration on Windows 2008 Server.

1. Open an administrative command prompt.
2. Run the following command:

    ```console  
    net stop apphostsvc
    ```

3. Run the following command:

    ```console
    sc privs apphostsvc SeChangeNotifyPrivilege/SeTcbPrivilege/SeImpersonatePrivilege
    ```

4. Run the following command:

    ```console
    net start apphostsvc
    ```

After you complete these steps on each Windows 2008 Server in the cluster, continue setting up IIS shared configuration as described in this section.

On one of the cluster nodes, export the shared configuration to the file share:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the left pane, select the **server name** node.
3. Double-click the **Shared Configuration** icon.
4. On the **Shared Configuration** page, select **Export Configuration** in the **Actions** pane (the right pane) to export the configuration files from the local computer to another location.
5. In the **Export Configuration** dialog box, type the path of the file share (`\\<fileserver>\<share>`) in the **Physical path** box.
6. Select **Connect As**, and then type the user name and the password for the user account that has access to the share in which the shared configuration is stored, and then select **OK**. This account will be used to access the share. You should use a restricted Active Directory account that isn't the domain administrator.
7. In the **Export Configuration** dialog box, type a password that will be used to protect the encryption keys, and then select **OK**.
8. On the **Shared Configuration** page, select the **Enable shared configuration** check box.
9. Type the physical path, the user account, and the password that you entered previously, and then select **Apply** in the **Actions** pane.
10. In the **Encryption Keys Password** dialog box, type the encryption key password that you set earlier, and then select **OK**.
11. In the **Shared Configuration** dialog box, select **OK**.
12. Select **OK**.

On each of the other cluster nodes, use the shared configuration that you just exported to the file share:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. Select the **server name** node.
3. Double-click the **Shared Configuration** icon.
4. On the **Shared Configuration** page, select the **Enable shared configuration** check box.
5. Type the physical path of the file share (`\\<fileserver>\<share>`), the user account, and the password that you entered previously, and then select **Apply** in the **Actions** pane.
6. In the **Encryption Keys Password** dialog box, type the encryption key password that you set earlier, and then select **OK**.
7. In the **Shared Configuration** dialog box, select **OK**.
8. Select **OK**.

> [!NOTE]
> For more information about how to set up shared configurations in IIS, visit [Shared Configuration](/iis/manage/managing-your-configuration-settings/shared-configuration_264).

## Configure IIS Offline Files for shared configuration on all cluster nodes

On each cluster node, enable Offline Files:

1. Install the Desktop Experience

    1. Navigate to **Administrative Tools**, and then select **Server Manager**.
    2. In the left pane, select **Features**.
    3. Select **Add Features** in the right pane.
    4. Do one of the following, as appropriate for your Windows version:
         - For Windows Server 2016, visit [Install Server with Desktop Experience](/windows-server/get-started/getting-started-with-server-with-desktop-experience).
         - For Windows Server 2012 and 2012 R2, choose **Desktop Experience** under **User Interfaces and Infrastructures** in the features list.
         - For Windows Server 2008 and 2008 R2, choose **Desktop Experience**.
    5. Select **Install** to install Desktop Experience.
    6. Restart the computer.

2. Do one of the following:

    - For Windows Server 2012, 2012 R2 and 2016, select **Sync Center** in Control Panel, and then select **Manage offline files**.
    - For Windows Server 2008 and 2008 R2, select **Offline Files** in Control Panel.

3. Select **Enable Offline Files**. Don't restart the computer at this time.

4. Ensure that the cache is set to read-only. To do it, run the following command at an elevated cmd prompt:

    ```console
    REG ADD "HKLM\System\CurrentControlSet\Services\CSC\Parameters" /v ReadOnlyCache /t REG_DWORD /d 1 /f
    ```

5. Restart the computer.

6. Browse to the file server from the computer. Right-click the share that contains the IIS shared configuration, and then select **Always Available Offline**.

    > [!NOTE]
    > If you set up the file share to be highly available on the same failover cluster that hosts IIS nodes, the **Always Available Offline** option will not appear when you right-click the share if the cluster node that you are on is hosting the highly available file server. You will need to move the high available file server application to another node.

7. In Control Panel, open **Offline Files**. Select **Open Sync Center**, and then select **Schedule**.

8. Schedule an offline file sync for every day or according to your requirements. You can also configure the offline sync to run every few minutes. Even if you don't set up a scheduler, when you change something in the *Applicationhost.config* file, the change is reflected on the Web server.

> [!NOTE]
> For more information about how to configure offline files for a shared configuration in IIS, see [Offline Files for Shared Configuration](/iis/web-hosting/configuring-servers-in-the-windows-web-platform/offline-files-for-shared-configuration).

## Configure the website, and specify the location of its content on one cluster node

Find the cluster node that owns the cluster disk resource where the website content files will stay:

1. Navigate to **Administrative Tools**, and then select **Failover Cluster Manager**.
2. Connect to the cluster. If you are on one of the cluster nodes, the cluster will appear on the list automatically.
3. Under **Storage**, find the disk resource on which the Web page content will reside. To do it, expand the storage tree for the disk resource. Make sure that the storage is not used by any other high availability application on the cluster. You'll find the storage under **Available Storage**.
4. The cluster node on which this resource is online. You will configure IIS on that cluster node.
5. The cluster disk resource name.

You'll use this for the content files. On the cluster node on which the resource is online, configure the Web server to use the shared disk for website content:

1. Navigate to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the left pane, expand the server name node.
3. Expand **Sites**, and then under **Sites**, select the site that you're configuring.
4. In the right pane, select **Advanced Settings** under **Manage Web Site**.
5. Locate the **Physical Path** property under **General** settings, and then type the location where the website content files are located. It is the location of the cluster disk resource that you noted in step 5 of the previous procedure.
6. Select **OK**.

## Configure high availability for your website by creating a generic script in Failover Cluster Manager

For the last step to configure high availability for IIS Web servers, set up the generic script resource that will be used to monitor the website and application pool for the website:

1. On each cluster node, copy the script that is provided at the end of this article to `Windows\System32\inetsrv\Clusweb7.vbs`.

2. By default, the script monitors a website that is named *Default Web Site* and an application pool that is named *DefaultAppPool*. If these aren't the correct website and application pool, change the `SITE_NAME and APP_POOL_NAME` variables. Make sure that the same website and application pool in the script exist on all cluster nodes.

    > [!NOTE]
    > The names are case-sensitive.

3. Navigate to **Administrative Tools**, and then select **Failover Cluster Manager**.

4. Connect to the cluster. If you are on one of the cluster nodes, the cluster will appear on the list automatically.

5. Do one of the following:
   - For Windows Server 2012, 2012 R2 and 2016, right-click **Roles** and then select **Configure Role** to create it.
   - For Windows Server 2008 and 2008 R2, right-click the cluster, and then select **Configure a Service or Application**. A wizard creates the high availability workload.

6. Select **Generic Script**.

7. Select the script file from `%systemroot%\System32\Inetsrv\clusweb7.vbs`.

8. Set the Client Access Point (CAP) name to the website name that clients will use to connect to the high availability website. Specify the static IPs to use for the website CAP. If you're using Dynamic Host Configuration Protocol (DHCP), this option won't be displayed.

9. In the **Select Storage** step, select the cluster shared disk on which the website content files are. The storage should be unused by any other high availability application on the cluster.

    > [!NOTE]
    > If the file share that is used for the IIS shared configuration is hosted on the same cluster, a different disk resource should be used here.

10. After you confirm the settings, the wizard will create the cluster group, cluster resources, and the dependencies between the resources, and then bring the resources online.

    > [!NOTE]
    > To host multiple high availability websites on the same failover cluster, follow the same steps as above. However, use a different script file for each website and different clustered shared storage. For example, in `%systemroot%\System32\Inetsrv`, use *clusweb7.vbs* for the first website, *clweb7-2.vbs* for the second, *clweb7-3.vbs* for the third, and so on. Each script file monitors a different website and application pool.

The following script is for sample purposes only and is not explicitly supported by Microsoft. Use of this script in an IIS 7.0 or a later version clustered environment is at your own risk.

```vbs
'<begin script sample>
'This script provides high availability for IIS websites
'By default, it monitors the "Default Web Site" and "DefaultAppPool"
'To monitor another website, change the SITE_NAME below
'To monitor another application pool, change the APP_POOL_NAME below
'More thorough and application-specific health monitoring logic can be added to the script if needed

Option Explicit

DIM SITE_NAME
DIM APP_POOL_NAME
Dim START_WEB_SITE
Dim START_APP_POOL
Dim SITES_SECTION_NAME
Dim APPLICATION_POOLS_SECTION_NAME
Dim CONFIG_APPHOST_ROOT
Dim STOP_WEB_SITE

'Note:
'Replace this with the site and application pool you want to configure high availability for
'Make sure that the same website and application pool in the script exist on all cluster nodes. Note that the names are case-sensitive.
SITE_NAME = "Default Web Site"
APP_POOL_NAME = "DefaultAppPool"

START_WEB_SITE = 0
START_APP_POOL = 0
STOP_WEB_SITE  = 1
SITES_SECTION_NAME = "system.applicationHost/sites"
APPLICATION_POOLS_SECTION_NAME = "system.applicationHost/applicationPools"
CONFIG_APPHOST_ROOT = "MACHINE/WEBROOT/APPHOST"

'Helper script functions
'Find the index of the website on this node
Function FindSiteIndex(collection, siteName)
    Dim i
    FindSiteIndex = -1

    For i = 0 To (CInt(collection.Count) - 1)
        If collection.Item(i).GetPropertyByName("name").Value = siteName Then
            FindSiteIndex = i
            Exit For
        End If
    Next
End Function

'Find the index of the application pool on this node
Function FindAppPoolIndex(collection, appPoolName)
    Dim i
    FindAppPoolIndex = -1

    For i = 0 To (CInt(collection.Count) - 1)
        If collection.Item(i).GetPropertyByName("name").Value = appPoolName Then
            FindAppPoolIndex = i
            Exit For
        End If
    Next
End Function

'Get the state of the website
Function GetWebSiteState(adminManager, siteName)

    Dim sitesSection, sitesSectionCollection, siteSection, index, siteMethods, startMethod, executeMethod
    Set sitesSection = adminManager.GetAdminSection(SITES_SECTION_NAME, CONFIG_APPHOST_ROOT)
    Set sitesSectionCollection = sitesSection.Collection

    index = FindSiteIndex(sitesSectionCollection, siteName)
    If index = -1 Then
        GetWebSiteState = -1
    End If

    Set siteSection = sitesSectionCollection(index)
    GetWebSiteState = siteSection.GetPropertyByName("state").Value
End Function

'Get the state of the ApplicationPool
Function GetAppPoolState(adminManager, appPool)
    Dim configSection, index, appPoolState

    set configSection = adminManager.GetAdminSection(APPLICATION_POOLS_SECTION_NAME, CONFIG_APPHOST_ROOT)
    index = FindAppPoolIndex(configSection.Collection, appPool)

    If index = -1 Then
        GetAppPoolState = -1
    End If

    GetAppPoolState = configSection.Collection.Item(index).GetPropertyByName("state").Value
End Function

'Start the w3svc service on this node
Function StartW3SVC()
    Dim objWmiProvider
    Dim objService
    Dim strServiceState
    Dim response

    'Check to see if the service is running
    set objWmiProvider = GetObject("winmgmts:/root/cimv2")
    set objService = objWmiProvider.get("win32_service='w3svc'")
    strServiceState = objService.state

    If ucase(strServiceState) = "RUNNING" Then
        StartW3SVC = True
    Else
        'If the service is not running, try to start it
        response = objService.StartService()

        'response = 0  or 10 indicates that the request to start was accepted
        If ( response <> 0 ) and ( response <> 10 ) Then
            StartW3SVC = False
        Else
            StartW3SVC = True
        End If
    End If
End Function

'Start the application pool for the website
Function StartAppPool()
    Dim ahwriter, appPoolsSection, appPoolsCollection, index, appPool, appPoolMethods, startMethod, callStartMethod
    Set ahwriter = CreateObject("Microsoft.ApplicationHost.WritableAdminManager")

    Set appPoolsSection = ahwriter.GetAdminSection(APPLICATION_POOLS_SECTION_NAME, CONFIG_APPHOST_ROOT)
    Set appPoolsCollection = appPoolsSection.Collection
    index = FindAppPoolIndex(appPoolsCollection, APP_POOL_NAME)
    Set appPool = appPoolsCollection.Item(index)

    'See if it is already started
    If appPool.GetPropertyByName("state").Value = 1 Then
        StartAppPool = True
        Exit Function
    End If

    'Try To start the application pool
    Set appPoolMethods = appPool.Methods
    Set startMethod = appPoolMethods.Item(START_APP_POOL)
    Set callStartMethod = startMethod.CreateInstance()
    callStartMethod.Execute()

    'If started return true, otherwise return false
    If appPool.GetPropertyByName("state").Value = 1 Then
        StartAppPool = True
    Else
        StartAppPool = False
    End If
End Function

'Start the website
Function StartWebSite()
    Dim ahwriter, sitesSection, sitesSectionCollection, siteSection, index, siteMethods, startMethod, executeMethod
    Set ahwriter = CreateObject("Microsoft.ApplicationHost.WritableAdminManager")
    Set sitesSection = ahwriter.GetAdminSection(SITES_SECTION_NAME, CONFIG_APPHOST_ROOT)
    Set sitesSectionCollection = sitesSection.Collection
    index = FindSiteIndex(sitesSectionCollection, SITE_NAME)
    Set siteSection = sitesSectionCollection(index)

    if siteSection.GetPropertyByName("state").Value = 1 Then
        'Site is already started
        StartWebSite = True
        Exit Function
    End If

    'Try to start site
    Set siteMethods = siteSection.Methods
    Set startMethod = siteMethods.Item(START_WEB_SITE)
    Set executeMethod = startMethod.CreateInstance()
    executeMethod.Execute()

    'Check to see if the site started, if not return false
    If siteSection.GetPropertyByName("state").Value = 1 Then
        StartWebSite = True
    Else
        StartWebSite = False
    End If
End Function

'Stop the website
Function StopWebSite()
    Dim ahwriter, sitesSection, sitesSectionCollection, siteSection, index, siteMethods, startMethod, executeMethod, autoStartProperty
    Set ahwriter = CreateObject("Microsoft.ApplicationHost.WritableAdminManager")
    Set sitesSection = ahwriter.GetAdminSection(SITES_SECTION_NAME, CONFIG_APPHOST_ROOT)
    Set sitesSectionCollection = sitesSection.Collection
    index = FindSiteIndex(sitesSectionCollection, SITE_NAME)
    Set siteSection = sitesSectionCollection(index)

    'Stop the site
    Set siteMethods = siteSection.Methods
    Set startMethod = siteMethods.Item(STOP_WEB_SITE)
    Set executeMethod = startMethod.CreateInstance()
    executeMethod.Execute()
End Function

'Cluster resource entry points. More details here:
'http://msdn.microsoft.com/en-us/library/aa372846(VS.85).aspx
'Cluster resource Online entry point
'Make sure the website and the application pool are started
Function Online( )
    Dim bOnline
    'Make sure w3svc is started
    bOnline = StartW3SVC()

    If bOnline <> True Then
        Resource.LogInformation "The resource failed to come online because w3svc could not be started."
        Online = False
        Exit Function
    End If

    'Make sure the application pool is started
    bOnline = StartAppPool()
    If bOnline <> True Then
        Resource.LogInformation "The resource failed to come online because the application pool could not be started."
        Online = False
        Exit Function
    End If

    'Make sure the website is started
    bOnline = StartWebSite()
    If bOnline <> True Then
        Resource.LogInformation "The resource failed to come online because the web site could not be started."
        Online = False
        Exit Function
    End If

    Online = true
End Function

'Cluster resource offline entry point
'Stop the website
Function Offline( )
    StopWebSite()
    Offline = true
End Function

'Cluster resource LooksAlive entry point
'Check for the health of the website and the application pool
Function LooksAlive( )
    Dim adminManager, appPoolState, configSection, i, appPoolName, appPool, index
    i = 0
    Set adminManager  = CreateObject("Microsoft.ApplicationHost.AdminManager")
    appPoolState = -1

    'Get the state of the website
    if GetWebSiteState(adminManager, SITE_NAME) <> 1 Then
        Resource.LogInformation "The resource failed because the " & SITE_NAME & " web site is not started."
        LooksAlive = false
        Exit Function
    End If

    'Get the state of the Application Pool
    if GetAppPoolState(adminManager, APP_POOL_NAME) <> 1 Then
         Resource.LogInformation "The resource failed because Application Pool " & APP_POOL_NAME & " is not started."
         LooksAlive = false  
         Exit Function
    End if

    'Web site and Application Pool state are valid return true
    LooksAlive = true
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
'<end script sample>
```
