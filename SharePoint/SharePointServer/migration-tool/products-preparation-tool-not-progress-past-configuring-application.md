---
title: The Products Preparation Tool in SharePoint Server 2013 may not progress past "Configuring Application Server Role, Web Server (IIS) Role"
description: Describes a problem in which the Products Preparation Tool in SharePoint Server 2013 may not progress past "Configuring Application Server Role, Web Server (IIS) Role." A workaround is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: sharepoint-powershell
ms.topic: article
ms.author: luche
appliesto:
- SharePoint Server 2013
---

# Products Preparation Tool may not progress past "Configuring Application Server Role, Web Server (IIS) Role"  

## Symptoms  

When you try to install Microsoft SharePoint Server 2013 on some Windows Server 2012 configurations, the Products Preparation Tool may be unable to correctly configure and install the required Windows Features for SharePoint. If this occurs, the tool will continuously try to configure and install the required features and then restart.  

Note  By default, the Products Preparation Tool restarts several times during a typical configuration operation.  

When this problem occurs, the Products Preparation Tool does not progress past the "Configuring Application Server Role, Web Server (IIS) Role" stage.  

## Workaround  

To work around this issue, use one of the following methods.

### Method 1  
Install the hotfix that is described in Microsoft Knowledge Base (KB) article 2771431. For more information about hotfix 2771431, click the following article number to view the article in the Microsoft Knowledge Base:  

[2771431](https://support.microsoft.com/help/2771431) A servicing stack update is available for Windows 8 and Windows Server 2012

**Note** Although KB 2771431 states that you do not have to restart your computer in order to apply the hotfix, you must restart the SharePoint Server as part of the installation process after you apply this hotfix.

### Method 2  
Use this method only if you cannot install hotfix 2771431 as described in the "Method 1" section.  

1. Make sure that the server meets the minimum hardware requirements for SharePoint Server 2013. For more information about the minimum hardware requirements for SharePoint Server 2013, go to the following Microsoft TechNet website:

   [Hardware and software requirements for SharePoint 2013](/SharePoint/install/hardware-and-software-requirements-0)

2. Manually install the Windows Server 2012 Roles and Features that are required by SharePoint 2013. To do this, use one of the following methods, depending on whether the SharePoint server is connected to the Internet or is offline.   

   **Online method: Server is connected to the Internet**  

   Open an elevated Windows PowerShell prompt on the SharePoint server (that is, Run as Administrator), and execute the following commands:

   ```
   Import-Module ServerManager   
   ```

   ```
   Add-WindowsFeature NET-WCF-HTTP-Activation45,NET-WCF-TCP-Activation45,NET-WCF-Pipe-Activation45   
   ```

   ```
   Add-WindowsFeature Net-Framework-Features,Web-Server,Web-WebServer,Web-Common-Http,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-App-Dev,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Health,Web-Http-Logging,Web-Log-Libraries,Web-Request-Monitor,Web-Http-Tracing,Web-Security,Web-Basic-Auth,Web-Windows-Auth,Web-Filtering,Web-Digest-Auth,Web-Performance,Web-Stat-Compression,Web-Dyn-Compression,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Mgmt-Compat,Web-Metabase,Application-Server,AS-Web-Support,AS-TCP-Port-Sharing,AS-WAS-Support, AS-HTTP-Activation,AS-TCP-Activation,AS-Named-Pipes,AS-Net-Framework,WAS,WAS-Process-Model,WAS-NET-Environment,WAS-Config-APIs,Web-Lgcy-Scripting,Windows-Identity-Foundation,Server-Media-Foundation,Xps-Viewer
   ```

   Your server will require a restart after you run this Windows PowerShell code.  

   When you use the PrerequisiteInstaller.exe, it will execute this Windows PowerShell code to install the necessary Roles and Features to configure Windows Server 2012 for SharePoint 2013. Part of the Windows PowerShell code for Add-WindowsFeature installation installs the Windows NET-Framework-Core feature that is the Microsoft .NET Framework 3.5. This feature installation requires binaries and other files that are not included in a default installation of Windows Server 2012. When you use this method, and for the installation to continue, these binaries and other files will be downloaded by the PrerequisiteInstaller.exe application from Windows Update through an online connection.  

   **Notes**
   - If the server does not have an Internet connection, the PrerequisiteInstaller.exe cannot continue past the "Configuring Application Server Role, Web Server (IIS Role)" phase, and you may receive the following error message:  

     **Add-WindowsFeature: The request to add or remove features on the specified server failed.
   Installation of one or more roles, role services, or features failed. The source files could not be downloaded. Use the "source" option to specify the location of the files that are required to restore the feature. For more information on specifying a source location, see [https://go.microsoft.com/fwlink/?LinkId=243077](/windows-hardware/manufacture/desktop/configure-a-windows-repair-source). Error: 0x800f0906**

     The 0x800F0906 error code indicates that the computer cannot download the required files from Windows Update.  

   - Why do we receive this error?   

     In Windows Server 2012 and Windows 8, the .NET Framework 3.5 is a Feature on Demand. The metadata for Features on Demand are included in Windows Server 2012 and in Windows 8. However, the binaries and other files that are associated with the feature are not included. When you enable this feature, Windows tries to contact Windows Update to download the missing information to install the feature.  

     The network configuration and how computers are configured to install updates in the environment can affect this process. Therefore, you may encounter errors when you first install such features.   

     For more information about error codes that may occur when you try to install the .NET Framework 3.5 in Windows 8 or in Windows Server 2012, see the following Microsoft Knowledge Base article  

     [2734782](https://support.microsoft.com/help/2734782) Error codes when you try to install the .NET Framework 3.5 in Windows 8 or in Windows Server 2012     

   **Offline method: Server is not connected to the Internet**

   To install the Roles and Features that are required by SharePoint 2013 on Windows Server 2012 in an offline environment, you must have access to the Windows Server 2012 installation media. You can then run the same Windows PowerShell commands that you used in Method 2, but you must use the -source  parameter to specify the location of the required files on the installation media.  

   For example, assume that you mounted the Windows Server 2012 installation media (ISO) to drive D of the server. Then, the path to provide for the -source  parameter is as follows:  

   ```
   D:\sources\sxs
   ```  

   **Note** Be aware that you can also copy the files locally or specify a UNC path where the installation files are stored.  

   Open an elevated Windows PowerShell prompt on the SharePoint server (that is, Run as Administrator), and execute the following commands:
 
   ```
   Import-Module ServerManager   
   ```

   ```
   Add-WindowsFeature NET-WCF-HTTP-Activation45,NET-WCF-TCP-Activation45,NET-WCF-Pipe-Activation45 -Source D:\Sources\sxs   
   ```

   ```
   Add-WindowsFeature Net-Framework-Features,Web-Server,Web-WebServer,Web-Common-Http,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-App-Dev,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Health,Web-Http-Logging,Web-Log-Libraries,Web-Request-Monitor,Web-Http-Tracing,Web-Security,Web-Basic-Auth,Web-Windows-Auth,Web-Filtering,Web-Digest-Auth,Web-Performance,Web-Stat-Compression,Web-Dyn-Compression,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Mgmt-Compat,Web-Metabase,Application-Server,AS-Web-Support,AS-TCP-Port-Sharing,AS-WAS-Support, AS-HTTP-Activation,AS-TCP-Activation,AS-Named-Pipes,AS-Net-Framework,WAS,WAS-Process-Model,WAS-NET-Environment,WAS-Config-APIs,Web-Lgcy-Scripting,Windows-Identity-Foundation,Server-Media-Foundation,Xps-Viewer **-Source D:\Sources\sxs**
   ```   

   Your server will require a restart after you run this Windows PowerShell code.

3. Install the other prerequisites that are required by SharePoint 2013.   
4. Run the Products Preparation Tool - PrerequisiteInstaller.exe again.     

### Download prerequisites for offline installation  

In certain scenarios where installing prerequisites directly from the Internet is not possible, you can download the prerequisites and then install them from a network share or a UNC path. For more information, see the following article:   
[Install prerequisites for SharePoint 2013 from a network share](/SharePoint/install/install-prerequisites-from-network-share)

Software prerequisites that are required for the installation of SharePoint Server 2013 on Windows Server 2012 are listed in the following together with their download links where appropriate. Be aware that you can enable the Web Server (IIS) role and the Application Server role in Server Manager. You can find the complete list of prerequisites [here](/SharePoint/install/hardware-and-software-requirements#section5).  

- [Microsoft .NET Framework version 4.5](https://go.microsoft.com/fwlink/p/?linkid=250950)   
- [Windows Management Framework 3.0](https://go.microsoft.com/fwlink/p/?linkid=273961)   
- Application Server Role and Web Server (IIS) Role: Enable the Web Server (IIS) role and the Application Server role in Server Manager   
- Microsoft SQL Server 2008 R2 SP1 Native Client   
- [Description of Windows Identity Foundation](/troubleshoot/windows-server/user-profiles-and-logon/windows-identity-foundation)   
- [Microsoft Sync Framework Runtime v1.0 SP1 (x64)](https://go.microsoft.com/fwlink/p/?linkid=224449)   
- [Microsoft AppFabric 1.1 for Windows Server](https://www.microsoft.com/download/details.aspx?id=27115)   
- [Windows Identity Extensions](https://go.microsoft.com/fwlink/p/?linkid=252368)   
- [Microsoft Information Protection and Control Client (MSIPC)](https://www.microsoft.com/download/details.aspx?id=38396) MSIPC.dll - Microsoft Active Directory Rights Management Services Client. See [AD RMS Client 2.0 Deployment Notes](/azure/information-protection/rms-client/client-deployment-notes) for more information.  
- [Microsoft WCF Data Services 5.0 for OData V3](https://www.microsoft.com/download/details.aspx?id=29306)   
- [Cumulative Update Package 1 for Microsoft AppFabric 1.1 for Windows Server (KB 2671763)](https://support.microsoft.com/help/2671763)     

## Status  

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## References  

[Install SharePoint 2013 Prerequisites Offline or Manually on Windows Server 2012 - A Comprehensive Guide](https://social.technet.microsoft.com/wiki/contents/articles/14582.install-sharepoint-2013-prerequisites-offline-or-manually-on-windows-server-2012-a-comprehensive-guide.aspx)  

[Download and Install SharePoint 2013 Prerequisites on Windows Server 2012 with PowerShell](https://social.technet.microsoft.com/wiki/contents/articles/14538.download-and-install-sharepoint-2013-prerequisites-on-windows-server-2012-with-powershell.aspx)  

**Note** These scripts apply only to Windows Server 2012. Do not use them on a server that is running Windows Server 2008 R2 SP1.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).