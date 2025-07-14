---
title: A federated user is repeatedly prompted for credentials during sign-in
description: Describes an issue in which a federated user is repeatedly prompted for credentials when the user tries to log on to the AD FS service endpoint during sign-in to Microsoft 365, Azure, or Microsoft Intune. When the user cancels, the user gets an Access Denied error message. Provides a resolution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft 365
  - Microsoft Intune
  - CRM Online via Office 365 E Plans
  - Azure Backup
ms.date: 03/31/2022
---

# A federated user is repeatedly prompted for credentials during sign-in to Microsoft 365, Azure or Intune

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect the computer.

## Problem

A federated user is repeatedly prompted for credentials when the user tries to authenticate to the Active Directory Federation Services (AD FS) service endpoint during sign-in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune. When the user cancels, the user receives the **Access Denied** error message.

## Cause

The symptom indicates an issue with Windows Integrated authentication with AD FS. This issue can occur if one or more of the following conditions are true:

- An incorrect user name or password was used.
- Internet Information Services (IIS) authentication settings are set up incorrectly in AD FS.
- The service principal name (SPN) that's associated with the service account that's used to run the AD FS federation server farm is lost or corrupted.

  > [!NOTE]
  > This occurs only when AD FS is implemented as a federation server farm and not implemented in a stand-alone configuration.
- One or more of the following are identified by Extended Protection for Authentication as a source of a man-in-the-middle attack:
  - Some third-party Internet browsers
  - The corporate network firewall, network load balancer, or other networking device is publishing the AD FS Federation Service to the Internet in such a way that IP payload data may potentially be rewritten. This possibly includes the following kinds of data:
    - Secure Sockets Layer (SSL) bridging
    - SSL offloading
    - Stateful packet filtering

      For more information, see the following Microsoft Knowledge Base article:

      [2510193](https://support.microsoft.com/help/2510193) Supported scenarios for using AD FS to set up single sign-on in Microsoft 365, Azure, or Intune
  - A monitoring or SSL decryption application is installed or is active on the client computer

- Domain Name System (DNS) resolution of the AD FS service endpoint was performed through CNAME record lookup instead of through an A record lookup.
- Windows Internet Explorer isn't configured to pass Windows Integrated authentication to the AD FS server.

### Before you start troubleshooting

Check that the user name and password are not the cause of the issue.

- Make sure that the correct user name is used and is in user principal name (UPN) format. For example, johnsmith@contoso.com.
- Make sure that the correct password is used. To double-check that the correct password is used, you may have to reset the user password. For more information, see the following Microsoft TechNet article:

  [Reset a User Password](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754395(v=ws.11))
- Make sure that the account isn't locked out, expired, or used outside designated logon hours. For more information, see the following Microsoft TechNet article:
  [Managing Users](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754661(v=ws.11))

### Verify the cause

To check that Kerberos problems are causing the issue, temporarily bypass Kerberos authentication by enabling forms-based authentication on the AD FS federation server farm. To do this, follow these steps:

#### Step 1: Edit the web.config file on each server in the AD FS federation server farm

1. In Windows Explorer, locate the C:\inetpub\adfs\ls\ folder, and then make a backup copy of the web.config file.
1. Click **Start**, click **All Programs**, click **Accessories**, right-click **Notepad**, and then click **Run as administrator**.
1. On the **File** menu, click **Open**. In the **File Name** box, type C:\inetpub\adfs\ls\web.config, and then click **Open**.
1. In the web.config file, follow these steps:
   1. Locate the line that contains **\<authentication mode>**, and then change it to \<**authentication mode="Forms"/**>.
   1. Locate the section that begins with \<**localAuthenticationTypes**>, and then change the section so that the <**add name="Forms"**> entry is listed first, as follows:

      ```asciidoc
      <localAuthenticationTypes>
      <add name="Forms" page="FormsSignIn.aspx" />
      <add name="Integrated" page="auth/integrated/" />
      <add name="TlsClient" page="auth/sslclient/" />
      <add name="Basic" page="auth/basic/" />
      ```

1. On the **File** menu, click **Save**.
1. At an elevated command prompt, restart IIS by using the iisresetcommand.

### Step 2: Test AD FS functionality

1. On a client computer that's connected and authenticated to the on-premises AD DS environment, sign in to the cloud service portal.

   Instead of a seamless authentication experience, a forms-based sign-in should be experienced. If sign-in is successful by using forms-based authentication, this confirms that a problem with Kerberos exists in the AD FS Federation Service.
2. Revert the configuration of each server in the AD FS federation server farm to the previous authentication settings before you follow the steps in the "Resolution" section. To revert the configuration of each server in the AD FS federation server farm, follow these steps:
   1. In Windows Explorer, locate the C:\inetpub\adfs\ls\ folder, and then delete the web.config file.
   1. Move the backup of the web.config file that you created in the "Step 1: Edit the web.config file on each server in the AD FS federation server farm" section to the C:\inetpub\adfs\ls\ folder.

3. At an elevated command prompt, restart IIS by using the iisresetcommand.
4. Check that the AD FS authentication behavior reverts to the original issue.

## Solution

To resolve the Kerberos issue that limits AD FS authentication, use one or more of the following methods, as appropriate for the situation.

### Resolution 1: Reset AD FS authentication settings to the default values

If AD FS IIS authentication settings are incorrect, or IIS authentication settings for AD FS Federation Services and Proxy Services don't match, one solution is to reset all IIS authentication settings to the default AD FS settings.

The default authentication settings are listed in the following table.

|Virtual application |Authentication level(s)|
|--------------------|-----------------------|
|Default Web Site/adfs|Anonymous authentication|
|Default Web Site/adfs/ls|Anonymous authentication, Windows authentication|

On each AD FS federation server and on each AD FS federation server proxy, use the information in the following Microsoft TechNet article to reset the AD FS IIS virtual applications to the default authentication settings:

[Configuring Authentication in IIS 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733010(v=ws.10))

### Resolution 2: Correct the AD FS federation server farm SPN

>[!NOTE]
>Try this resolution only when AD FS is implemented as a federation server farm. Do not try this resolution in an AD FS stand-alone configuration.

To resolve the issue if the SPN for the AD FS service is lost or corrupted on the AD FS service account, follow these steps on one server in the AD FS federation server farm:

1. Open the Services management snap-in. To do this, click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Services**.
2. Double-click **AD FS (2.0) Windows Service**.
3. On the **Log On** tab, note the service account that's displayed in **This Account**.
4. Click **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.
5. Type the following command, and then press Enter.

   ```powershell
   SetSPN –f –q host/<AD FS service name>
   ```

   > [!NOTE]
   > In this command, \<AD FS service name> represents the fully qualified domain name (FQDN) service name of the AD FS service endpoint. It does not represent the Windows host name of the AD FS server.

    - If more than one entry is returned for the command, and the result is associated with a user account other than the one that was noted in step 3, remove that association. To do this, run the following command:

       ```powershell
       SetSPN –d host/<AD FS service name><bad_username>
       ```

    - If more than one entry is returned for the command, and the SPN uses the same name as the computer name of the AD FS server in Windows, the federation endpoint name for AD FS is incorrect. AD FS has to be implemented again. The FQDN of the AD FS federation server farm must not be identical to the Windows host name of an existing server.
    - If the SPN does not already exist, run the following command:

      ```powershell
      SetSPN –a host/<AD FS service name><username of service account>  
      ```

      > [!NOTE]
      > In this command, \<username of service account> represents the user name that was noted in step 3.

6. After these steps are performed on all servers in the AD FS federation server farm, right-click **AD FS (2.0) Windows Service** in the Services management snap-in, and then click **Restart**.

### Resolution 3: Resolve Extended Protection for Authentication concerns

To resolve the issue if Extended Protection for Authentication prevents successful authentication, use one of the following recommended methods:

- Method 1: Use Windows Internet Explorer 8 (or a later version of the program) to sign in.
- Method 2: Publish AD FS services to the Internet in such a way that SSL bridging, SSL offloading, or stateful packet filtering don't rewrite IP payload data. The best-practice recommendation for this purpose is to use an AD FS Proxy Server.
- Method 3: Close or disable monitoring or SSL-decrypting applications.

If you can't use any of these methods, to work around this issue, Extended Protection for Authentication can be disabled for passive and active clients.

### Workaround: Disable Extended Protection for Authentication

> [!WARNING]
> We do not recommend that you use this procedure as a long-term solution. Disabling Extended Protection for Authentication weakens the AD FS service security profile by not detecting certain man-in-the-middle attacks on Integrated Windows Authentication endpoints.

> [!NOTE]
> When this workaround is applied for third-party application functionality, you should also uninstall hotfixes on the client operating system for Extended Protection for Authentication.

#### For passive clients

To disable Extended Protection for Authentication for passive clients, perform the following procedure for the following IIS virtual applications on all servers in the AD FS federation server farm:

- Default Web Site/adfs
- Default Web Site/adfs/ls

To do this, follow these steps:

1. Open IIS Manager and navigate to the level that you want to manage. For information about opening IIS Manager, see [Open IIS Manager (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. In Features View, double-click **Authentication**.
3. On the Authentication page, select **Windows Authentication**.
4. In the **Actions** pane, click **Advanced Settings**.
5. When the **Advanced Settings** dialog box appears, select **Off** from the **Extended Protection** drop-down menu.

#### For active clients

To disable Extended Protection for Authentication for active clients, perform the following procedure on the primary AD FS server:

1. Open Windows PowerShell.
2. Run the following command to load the Windows PowerShell for AD FS snap-in:

   ```powershell
   Add-PsSnapIn Microsoft.Adfs.Powershell
   ```

3. Run the following command to disable Extended Protection for Authentication:

   ```powershell
   Set-ADFSProperties –ExtendedProtectionTokenCheck "None"
   ```

### Re-enable Extended Protection for Authentication

#### For passive clients

To re-enable Extended Protection for Authentication for passive clients, perform the following procedure for the following IIS virtual applications on all servers in the AD FS federation server farm:

- Default Web Site/adfs
- Default Web Site/adfs/ls

To do this, follow these steps:

1. Open IIS Manager and navigate to the level that you want to manage. For information about opening IIS Manager, see [Open IIS Manager (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. In Features View, double-click **Authentication**.
3. On the Authentication page, select **Windows Authentication**.
4. In the **Actions** pane, click **Advanced Settings**.
5. When the **Advanced Settings** dialog box appears, select **Accept** from the **Extended Protection** drop-down menu.  

#### For active clients

To re-enable Extended Protection for Authentication for active clients, perform the following procedure on the primary AD FS server:

1. Open Windows PowerShell.
2. Run the following command to load the Windows PowerShell for AD FS snap-in:

   ```powershell
   Add-PsSnapIn Microsoft.Adfs.Powershell
   ```

3. Run the following command to enable Extended Protection for Authentication:

   ```powershell
   Set-ADFSProperties –ExtendedProtectionTokenCheck "Allow"
   ```

### Resolution 4: Replace CNAME records with A records for AD FS

Use DNS management tools to replace each DNS Alias (CNAME) record that's used for the federation service with a DNS address (A) record. Also, check or consider corporate DNS settings when a split-brain DNS configuration is implemented. For more information about how to manage DNS records, see
[Managing DNS Records](/previous-versions/windows/it-pro/windows-2000-server/bb727018(v=technet.10)).

### Resolution 5: Set up Internet Explorer as an AD FS client for single sign-on (SSO)

For more information about how to set up Internet Explorer for AD FS access, see [A federated user is prompted unexpectedly to enter work or school account credentials](https://support.microsoft.com/help/2535227).

## More information

To help protect a network, AD FS uses Extended Protection for Authentication. Extended Protection for Authentication can help prevent man-in-the-middle attacks in which an attacker intercepts a client's credentials and forwards them to a server. Protection against such attacks is made possible by using Channel Binding Works (CBT). CBT can be required, allowed, or not required by the server when communications are established with clients.

The **ExtendedProtectionTokenCheck** AD FS setting specifies the level of extended protection for authentication that's supported by the federation server. These are the available values for this setting:

- **Require**: The server is fully hardened. Extended protection is enforced.
- **Allow**: This is the default setting. The server is partly hardened. Extended protection is enforced for involved systems that are changed to support this feature.
- **None**: The server is vulnerable. Extended protection isn't enforced.

The following tables describe how authentication operates for three operating systems and browsers, depending on the different Extended Protection options that are available on AD FS with IIS.

> [!NOTE]
> Windows client operating systems must have specific updates that are installed to effectively use Extended Protection features. By default, the features are enabled in AD FS.

By default, Windows 7 includes the appropriate binaries to use Extended Protection.

Windows 7 (or appropriately updated versions of Windows Vista or of Windows XP)

|Setting|Require|Allow (the default)|None|
|-------|--------|------------------|----|
|Windows Communication Foundation (WCF) Client (All endpoints)|Works|Works|Works|
|Internet Explorer 8 and later versions|Works|Works|Works|
|Firefox 3.6|Fails|Fails|Works|
|Safari 4.0.4|Fails|Fails|Works|

Windows Vista without appropriate updates

|Setting|Require|Allow (the default)|None|
|-------|-------|-------------------|----|
|WCF Client (All endpoints)|Fails|Works|Works|
|Internet Explorer 8 and later versions|Works|Works|Works|
|Firefox 3.6|Fails|Works|Works|
|Safari 4.0.4|Fails|Works|Works|

Windows XP without appropriate updates

|Setting|Require|Allow (the default)|None|
|-------|-------|-------------------|----|
|Internet Explorer 8 and later versions|Works|Works|Works|
|Firefox 3.6|Fails|Works|Works|
|Safari 4.0.4|Fails|Works|Works|

For more information about Extended Protection for Authentication, see the following Microsoft resource:

[Configuring Advanced Options for AD FS 2.0](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh237448(v=ws.10))

For more information about the Set-ADFSProperties cmdlet, go to the following Microsoft website:

[Set-ADFSProperties](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee892317(v=technet.10))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
