---
title: Internet browser can't display AD FS sign-in webpage for federated users
description: Discusses a scenario in which a federated user may receive an error message when trying to sign in to Microsoft 365, Azure, or Microsoft Intune.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Internet browser can't display the AD FS sign-in webpage for federated users

## Problem

When a federated user tries to sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune, the Internet browser can't display the Active Directory Federation Services (AD FS) sign-in webpage. Additionally, the user may receive an error message. For example, if the user is using Internet Explorer, the user may receive the following error message:

**Internet Explorer cannot display the webpage.** 

When this error occurs, the address that's displayed in the web browser resembles the following address:

`https://sts.domain.tld/adfs/ls/auth/integrated/?wa=wsignin1.0&wtrealm=uri:WindowsLiveID&wctx=MEST%3D0%26LoginOptions%3D2%26wa%3Dwsignin1.0%26rpsnv%3D11%26ct%3D1283354771%26rver%3D6.0.5286.0%26wp%3DMCMBI%26wreply%3Dhttps:%252F%252Fportal.office.com%252Flanding.aspx%253Ftarget%253D%25252fDefault.aspx%26lc%3D1033%26id%3D271346%26bk%3D1283354772`

## Cause 

This issue may occur if the user can't contact the on-premises AD FS federation server or the Internet-facing AD FS Federation server proxy. This can occur when the AD FS Federation Service stops running or when IP connectivity is marginalized.

## Solution 

Before you begin to resolve this issue, determine the AD FS endpoint address for the on-premises federation server, and then determine which server is having problems.

### Determine the AD FS endpoint address for the on-premises federation server 

To do this, follow these steps on a domain-connected computer that has Azure Active Directory module for Windows PowerShell installed:

1. Run the Azure Active Directory module for Windows PowerShell as an elevated admin. To do this, right-click **Windows Azure Active Directory module for Windows PowerShell**, and then click **Run as administrator**.   
2. Type the following commands. Press Enter after you type each command:

    ```powershell
   $cred = get-credential
    ```
   > [!NOTE]
   > When you're prompted, enter your global admin credentials.    
   
   ```powershell
   Connect-MsolService –credential $credS  
   ```  
   ```powershell
   Set-MsolADFSContext -Computer <AD FS Server>
   ```
   > [!NOTE]
   > The \<AD FS Server> placeholder represents the computer name of your primary AD FS server.   
   
   ```powershell
   Get-MSOLFederationProperty –DomainName <Federated Domain> | FL
   ```
   > [!NOTE]
   > The \<Federated Domain> placeholder represents the domain name that's federated with the cloud service.     

In the output, examine the ActiveClientSignInUrlproperty. The domain part of the URL is the endpoint that can be used in the resolution that's described later in this article. 

### Determine the server that's having problems

Scope the issue. To do this, determine the server that's having problems. If only Internet clients are having problems, troubleshoot the AD FS Federation server proxy first. If corporate network clients are also having problems, troubleshoot the AD FS federation server first.

After you determine which server is having problems, follow these steps on the appropriate AD FS server:

#### Step 1: Make sure that the on-premises AD FS federation server is running

1. On the AD FS federation server, open Control Panel, click **Administrative Tools**, and then click **Services**.   
2. Look for the AD FS Windows Service service.    
3. Make sure that the status of the AD FS Windows Service service is **Started**. If the service is stopped, right-click the service, and then click **Start** to start the service.   

#### Step 2: Make sure that the web server is running on the appropriate AD FS server

1. On the AD FS federation server or on the AD FS federation server proxy, open Server Manager, expand **Roles**, expand **Web Server (IIS)**, and then select **Internet Information Services**.    
2. Expand your computer name, and then expand **Sites**.   
3. Make sure that **Default Web Site** is set to **Started**. If it isn't, right-click **Default Web Site**, point to **All Tasks**, and then click **Start**.   
4. Expand **Default Web Site**, and then make sure that the adfs and /adfs/ls virtual directories exist.   

#### Step 3: Make sure that DNS has a host record for the AD FS endpoint that's appropriate to the client that's having problems

For internal clients, internal DNS should resolve the AD FS endpoint name to an internal IP address (for example, sts.contoso.com A 192.168.1.104.). For Internet clients, the endpoint name should resolve to a public IP address. This can be tested on the client by using the following procedure. If the on-premises network contains a proxy server, try to add the AD FS endpoint by using Internet Options in Internet Explorer.

1. Click **Start**, click **Run**, type cmd, and then click **OK**.  
1. At the command prompt, type the following command, where the placeholder <STS.contoso.com> represents the AD FS endpoint name:   

   ```powershell
   NSlookup <STS.contoso.com>
   ```
1. If the command results in an incorrect IP address, resolve the issue by updating the A record on either the internal or external DNS server. To make sure that DNS requests for AD FS resources from on-premises computers resolve to the AD FS Federation service instead of the AD FS Proxy server, see the following Microsoft Knowledge Base article to check and update the split-brain DNS settings.

   [2715326 ](https://support.microsoft.com/help/2715326) Split-brain DNS misconfiguration prevents seamless SSO sign-in experience

   > [!NOTE]
   > Updated Internet-facing DNS settings may take as long as 48 hours to propagate to all Internet DNS servers.    

#### Step 4: Try to add the AD FS server name as an exception in the Internet proxy settings in Internet Explorer on the client computer

If the on-premises network contains a proxy, and if only internal clients are having problems with AD FS access, try to add the AD FS server name as an exception in the Internet proxy settings in Internet Explorer. To do this, follow these steps on the client computer:

1. Open Internet Explorer, and then click **Internet Options** on the **Tools** menu.   
2. Click the **Connections** tab, and then click **LAN Settings.**   
3. Under **Automatic configuration**, click to clear the check boxes, and then click to select the **Use a proxy server for your LAN** check box under **Proxy server**.   
4. Under **Proxy server**, add the proxy server address and the port that the proxy server uses, and then click **Advanced**.   
5. Under **Exceptions**, add your AD FS endpoint (for example, sts.contoso.com).   

## More information

The Windows PowerShell commands in this article require the Azure Active Directory module for Windows PowerShell.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
