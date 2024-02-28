---
title: Software update point installation and configuration
description: Describes how to tack the software update point installation and how to configure Software update point. 
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Software update point installation and configuration

_Applies to:_ &nbsp; Configuration Manager

The software update point is required on the central administration site and on the primary sites to enable software updates compliance assessment and to deploy software updates to clients.

## Track software update point installation

When software update point site system role is installed, an instance of the `SMS_SCI_SysResUse` class is created, and entries that resemble the following are logged in SMSProv.log:

> PutInstanceAsync SMS_SCI_SysResUse   SMS Provider  
> CExtProviderClassObject::DoPutInstanceInstance    SMS Provider  
> INFO: 'PR1SITE.CONTOSO.COM' is a valid FQDN.    SMS Provider  

Site Component Manager then detects the change in site control information and initiates the installation of the software update point site system role. Entries that resemble the following are logged in SiteComp.log:

> Parsed the master site control file, serial number 3559422579.    SMS_SITE_COMPONENT_MANAGER  
> Synchronizing server table and polling servers as needed...      SMS_SITE_COMPONENT_MANAGER  
> Synchronizing component server PR1SITE.CONTOSO.COM...    SMS_SITE_COMPONENT_MANAGER  
> Installing component SMS_WSUS_CONTROL_MANAGER...       SMS_SITE_COMPONENT_MANAGER  
> NFO: 'PR1SITE.CONTOSO.COM' is a valid FQDN.      SMS_SITE_COMPONENT_MANAGER  
> Creating registry keys Operations Management\SMS Server Role\SMS Software Update Point on server PR1SITE.CONTOSO.COM.    SMS_SITE_COMPONENT_MANAGER  
> Updated WSUS Configuration for PR1SITE.CONTOSO.COM.    SMS_SITE_COMPONENT_MANAGER  
> The component is being installed on the site server, no files need to be installed in the "E:\ConfigMgr" directory because the files are already there.    SMS_SITE_COMPONENT_MANAGER  
> All files installed.   SMS_SITE_COMPONENT_MANAGER  
> Starting bootstrap operations...        SMS_SITE_COMPONENT_MANAGER  
> Installed service SMS_SERVER_BOOTSTRAP_PR1SITE.    SMS_SITE_COMPONENT_MANAGER  
> Starting service SMS_SERVER_BOOTSTRAP_PR1SITE with command-line arguments "PR1 E:\ConfigMgr /install E:\ConfigMgr\bin\x64\rolesetup.exe SMSWSUS "...    SMS_SITE_COMPONENT_MANAGER

When the role installation is started by Site Component Manager, SUPSetup.log is created and the following are logged:

> \<02/09/14 22:53:28> ====================================================================  
> \<02/09/14 22:53:28> SMSWSUS Setup Started....  
> \<02/09/14 22:53:28> Parameters: E:\ConfigMgr\bin\x64\rolesetup.exe /install /siteserver:PR1SITE SMSWSUS 0  
> \<02/09/14 22:53:28> Installing Pre Reqs for SMSWSUS  
> <02/09/14 22:53:28>    ======== Installing Pre Reqs for Role SMSWSUS ========  
> <02/09/14 22:53:28> Found 1 Pre Reqs for Role SMSWSUS  
> <02/09/14 22:53:28> Pre Req SqlNativeClient found.  
> <02/09/14 22:53:28> SqlNativeClient already installed (Product Code: {D411E9C9-CE62-4DBF-9D92-4CB22B750ED5}). Would not install again.  
> <02/09/14 22:53:28> Pre Req SqlNativeClient is already installed. Skipping it.  
> <02/09/14 22:53:28>    ======== Completed Installation of Pre Reqs for Role SMSWSUS ========  
> <02/09/14 22:53:28> Installing the SMSWSUS  
> <02/09/14 22:53:28> Checking for supported version of WSUS (min WSUS 3.0 SP2 + KB2720211 + KB2734608)  
> <02/09/14 22:53:28> Checking runtime v2.0.50727...  
> <02/09/14 22:53:28> Did not find supported version of assembly Microsoft.UpdateServices.Administration.  
> <02/09/14 22:53:28> Checking runtime v4.0.30319...  
> <02/09/14 22:53:28> Found supported assembly Microsoft.UpdateServices.Administration version 4.0.0.0, file version 6.2.9200.16384  
> <02/09/14 22:53:28> Found supported assembly Microsoft.UpdateServices.BaseApi version 4.0.0.0, file version 6.2.9200.16384  
> <02/09/14 22:53:28> Supported WSUS version found  
> <02/09/14 22:53:28> Supported WSUS Server version (6.2.9200.16384) is installed.  
> <02/09/14 22:53:28> CTool::RegisterManagedBinary: run command line: "C:\Windows\Microsoft.NET\Framework64\v2.0.50727\RegAsm.exe" "E:\ConfigMgr\bin\x64\wsusmsp.dll"  
> <02/09/14 22:53:44> CTool::RegisterManagedBinary: Registered E:\ConfigMgr\bin\x64\wsusmsp.dll successfully  
> <02/09/14 22:53:44> Registered DLL E:\ConfigMgr\bin\x64\wsusmsp.dll  
> <02/09/14 22:53:44> Installation was successful.  
> <02/09/14 22:53:44> ~RoleSetup().

After the role is installed, Site Component Manager removes the bootstrap service that's created to perform the installation, the following are logged in SiteComp.log:

> "E:\ConfigMgr\bin\x64\rolesetup.exe /install /siteserver:PR1SITE.CONTOSO.COM" executed successfully on server PR1SITE.CONTOSO.COM.         SMS_SITE_COMPONENT_MANAGER  
> Bootstrap operation successful.       SMS_SITE_COMPONENT_MANAGER  
> Deinstalled service SMS_SERVER_BOOTSTRAP_PR1SITE.     SMS_SITE_COMPONENT_MANAGER  
> Bootstrap operations completed.      SMS_SITE_COMPONENT_MANAGER

## Configure proxy setting for the software update point

When there is a proxy server between the WSUS server and the upstream update source, the proxy settings must be configured for the site system as well as the software update point role. The proxy server settings are site system specific, which means that all site system roles use the proxy server settings that you specify. For more information, see [Accounts used in Configuration Manager](/mem/configmgr/core/plan-design/hierarchy/accounts).

### Check proxy configuration on a computer

- To review the proxy configuration for the logged-on user, run the following command:

    ```console
    netsh winhttp show proxy
    ```

- To review the proxy configuration for the SYSTEM account, open a command prompt by running the following command:

    ```console
    psexec -s -i cmd
    ```

    In the Command Prompt window, run `whoami` to confirm that the command window is running under the System account.

    Run the `netsh winhttp show proxy` command and review the proxy configuration for the System account.

    You can also start Internet Explorer from this command window, and review the proxy configured in Internet Explorer. In some cases you may have to clear the **Automatically Detect Settings** check box, and set the correct proxy.

To force WinHTTP to use proxy configuration from Internet Explorer, run the following command:

```console
netsh winhttp import proxy source =ie
```

For more information about Netsh commands, see [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10)).

### Configure the proxy settings for the Site System

1. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, select the *\<SiteSystemName>* on the right pane.
2. In the bottom pane, right-click **Site System**, and then click **Properties**.
3. Select the **Proxy** tab, specify the proxy server name, port, and credentials (if required).

### Configure the proxy settings for the software update point

1. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, select *\<SiteSystemName>* on the right pane.
2. In the bottom pane, right-click **Software Update Point**, and then click **Properties**.
3. Select the **Proxy and Account Settings** tab, and select **Use a proxy server when synchronizing software updates**.
4. (Optional) To configure automatic deployment rules (ADRs) to use a proxy server, select the **Proxy And Account Settings** tab, and then select **Use a proxy server when downloading content by using automatic deployment rules**.

### Verify proxy settings in the WSUS console

1. Open the WSUS console.
2. Select **Options** in the tree pane, and then select **Update Source and Proxy Server** in the display pane.
3. Select the **Proxy Server** tab. Verify that the proxy settings match the settings configured for the software update point in Configuration Manager. If the settings don't match, check WCM.log on the site server.

For more information, see [Proxy server settings](/mem/configmgr/sum/get-started/install-a-software-update-point#proxy-server-settings).

## Configure the WSUS Server Connection Account for the software update point

If the software update point is remote from the site server, and if the site server computer account doesn't have permissions to connect to the WSUS server, you must specify a WSUS Server Connection Account that Configuration Manager can use to connect to the WSUS server.

This account is used by WCM and WSyncMgr. It must be a local administrator on the computer where WSUS is installed. Additionally, the account must be part of the local WSUS Administrators group. For more information, see [Accounts used in Configuration Manager](/mem/configmgr/core/plan-design/hierarchy/accounts).

To configure the WSUS Server Connection Account for the software update point:

1. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, select *\<SiteSystemName>* on the right pane.
2. In the bottom pane, right-click **Software Update Point**, and then click **Properties**.
3. On the **Proxy And Account Settings** tab, specify the connection account under **WSUS Server Connection Account**.

## References

- [Install and configure a software update point](/mem/configmgr/sum/get-started/install-a-software-update-point)
- [Synchronize software updates](/mem/configmgr/sum/get-started/synchronize-software-updates)
- [Configure classifications and products to synchronize](/mem/configmgr/sum/get-started/configure-classifications-and-products)
