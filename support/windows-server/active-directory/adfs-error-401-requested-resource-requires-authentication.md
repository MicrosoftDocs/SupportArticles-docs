---
title: ADFS 2.0 error 401
description: Discusses that you can't authenticate an account in AD FS 2.0, that you're prompted for credentials, and that event 111 is logged. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# ADFS 2.0 error: 401 The requested resource requires user authentication

This article discusses an issue where you're prompted for credentials and event 111 is logged when you authenticate an account in Active Directory Federation Services (AD FS) 2.0.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044976

## Summary

Most Active Directory Federated Services (AD FS) 2.0 problems belong to one of the following main categories. This article contains step-by-step instructions to troubleshoot authentication problems.

- [Connectivity problems (KB 3044971)](https://support.microsoft.com/help/3044971)
- [ADFS service problems (KB 3044973)](https://support.microsoft.com/help/3044973)
- [Certificate problems (KB 3044974)](https://support.microsoft.com/help/3044974)
- Authentication problems (KB 3044976)
- [Claim rules problems (KB 3044977)](https://support.microsoft.com/help/3044977)

## Symptoms

When you try to authenticate an account in Active Directory Federation Services (AD FS) 2.0, the following errors occur:

- The AD FS server returns the following error message:

    > Not Authorized-HTTP error 401. The requested resource requires user authentication.

- On a form-based login screen, the server returns the following error message:

    > The user name or password is incorrect.

- You're continually prompted for credentials.
- Event 111 is logged in the AD FS Admin log, as follows:

    > Log Name:  AD FS 2.0/Admin  
    Event ID: 111  
    Level: Error  
    Keywords: AD FS  
    Description:  
    The Federation Service encountered an error while processing the WS-Trust request.  
    Request type: `http://schemas.xmlsoap.org/ws/2005/02/trust/RST/Issue`  
    Exception details:  
    Microsoft.IdentityModel.SecurityTokenService.FailedAuthenticationException: MSIS3019: Authentication failed. ---> System.IdentityModel.Tokens.SecurityTokenValidationException: ID4063: LogonUser failed for the 'user1' user. Ensure that the user has a valid Windows account. ---> System.ComponentModel.Win32Exception: Logon failure: unknown user name or bad password

## Resolution

To resolve this problem, follow these steps, in the order given. These steps will help you determine the cause of the problem.

### Step 1: Assign the correct AD FS Federation service name record

Make sure that the DNS has a HOST (A) record for the AD FS Federation service name, and avoid using a CNAME record. For more information, see [Internet Explorer behaviors with Kerberos Authentication](https://blogs.technet.com/b/askds/archive/2009/06/22/internet-explorer-behaviors-with-kerberos-authentication.aspx).

### Step 2: Check Federation Service name registration

Locate the Federation Service Name, and check whether the name is registered under the AD FS service account. To do this, follow these steps:

1. Locate the HOST/**\<Federation Service Name>** name:
    1. Open AD FS 2.0 Manager.
    2. Right-click **ADFS 2.0**, and then select **Edit Federation Service Properties**.
    3. On the **General** tab, locate the Federation Service name field to see the name.

        :::image type="content" source="media/adfs-error-401-requested-resource-requires-authentication/edit-federation-service-name.png" alt-text="Screenshot of the Federation Service Properties window where you can check the Federation Service name.":::

2. Check whether HOST/**\<Federation Service Name>**  name is registered under the AD FS service account:
    1. Open the Management snap-in. To do this, click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Services**.
    2. Double-click **AD FS (2.0) Windows Service**.
    3. On the **Log On** tab, note the service account that's displayed in the **This account** field.
  
        :::image type="content" source="media/adfs-error-401-requested-resource-requires-authentication/service-account-name.png" alt-text="Screenshot of the AD FS 2.0 Windows Service Properties (Local Computer) window, in which the service account is displayed in the This account field.":::
  
    4. Click **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.
    5. Run the following command:
  
        ```console
        SETSPN -L domain\<ADFS Service Account>
        ```  

        :::image type="content" source="media/adfs-error-401-requested-resource-requires-authentication/setspn-result.png" alt-text="Screenshot for the result of the setspn command.":::

If the Federation Service name doesn't already exist, run the following command to add the service principal name (SPN) to the AD FS account:

```console
SetSPN -a host/<Federation service name> <username of service account>
```  

:::image type="content" source="media/adfs-error-401-requested-resource-requires-authentication/setspn-command.png" alt-text="Screenshot for the result of the setspn command, which is to add the service principal name.":::

### Step 3: Check for duplicate SPNs

Verify that there are no duplicate SPNs for the AD FS account name. To do this, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.
2. Run the following command to make sure that there are no duplicate SPNs for the AD FS account name:

    ```console
    SETSPN -X -F
    ```  

### Step 4: Check whether the browser uses Windows Integrated Authentication

Make sure that the Internet Explorer browser that you're using is configured to use Windows Integrated Authentication. To do this, start Internet Explorer, click **Settings**, click **Internet Options**, click **Advanced**, and then click **Enable IntegratedWindows Authentication**.

### Step 5: Check the authentication type

Make sure that the default authentication type on the AD FS server is configured correctly. To do this, follow these steps:

1. In Windows Explorer, navigate to C:\inetpub\adfs\ls (this assumes that inetpub is located on drive C).
2. Locate **Web.config**, and then open the file in Notepad.
3. In the file, locate **(Ctrl+F) \<localAuthenticationTypes>**.
4. Under **\<localAuthenticationTypes>**, locate the four lines that represent the local authentication types.
5. Select and delete your preferred local authentication type (the whole line). Then, paste the line at the top of the list (under **\<localAuthenticationTypes>**).
6. Save and close the Web.config file.

For more information about the Local Authentication Type, see the following TechNet topic:

[AD FS 2.0: How to Change the Local Authentication Type](https://social.technet.microsoft.com/wiki/contents/articles/1600.ad-fs-2-0-how-to-change-the-local-authentication-type.aspx)

### Step 6: Check authentication settings

Make sure that the AD FS virtual directories are configured correctly for authentication in Internet Information Services (IIS).

- In the **Default Web Site/adfs** node, open the **Authentication** setting, and then make sure the **Anonymous Authentication** is enabled.
- In the **Default Web Site/adfs/ls** node, open the **Authentication** setting, and then make sure that both **Anonymous** and **Windows Authentication** are enabled.

### Step 7: Check proxy trust settings

If you have an AD FS proxy server configured, check whether proxy trust is renewed during the connection intervals between the AD FS and AD FS Proxy servers.

The Proxy server automatically renews trust with AD FS Federation Service. If this process fails, event 394 is logged in Event Viewer and you receive the following error message:

> The federation server proxy could not renew its trust with the Federation Service.

To resolve this problem, try to run the AD FS proxy configuration wizard again. As the wizard runs, make sure that valid domain user name and passwords are used. These credentials aren't stored on the AD FS Proxy server. When entering credentials for the proxy trust configuration wizard, you have two choices.

- Use domain credentials that have local administrative rights on the AD FS servers.
- Use the AD FS service account credentials

### Step 8: Check IIS extended protection settings

Certain browsers can't authenticate if extended protection (that is, Windows Authentication) is enabled in IIS as shown in Step 5. Try to disable Windows Authentication to determine whether this resolves the problem.

You would also see Extended protection not allowing Windows Authentication when SSL proxy is being done by tools like Fiddler or some intelligent load balancers.

For example: You may see repeated authentication prompts if you have Fiddler Web Debugger running on the client.

To disable extended protection for authentication, follow the appropriate method, depending on the client type.

#### For passive clients

Use this method for the "Default Web Site/adfs/ls" virtual applications on all servers in the AD FS federation server farm. To do this, follow these steps:

1. Open IIS Manager, and then locate the level that you want to manage.

    For more information about how to open IIS Manager, see [Open IIS Manager (IIS 7)](https://technet.microsoft.com/library/cc770472%28v=ws.10%29.aspx).
2. In **Features View**, double-click **Authentication**.
3. On the **Authentication** page, select **Windows Authentication**.
4. In the **Actions** pane, click **Advanced Settings**.
5. When the **Advanced Settings** dialog box appears, click **Off** on the **Extended Protection** menu.

#### For active clients

Use this method for the primary AD FS server:

1. Start Windows PowerShell.
2. To load the Windows PowerShell for AD FS snap-in, run the following command:

    ```powershell
    Add-PsSnapIn Microsoft.Adfs.Powershell
    ```  

3. To disable extended protection for authentication, run the following command:

    ```powershell
    Set-ADFSProperties -ExtendedProtectionTokenCheck "None"
    ```  

### Step 9: Check the secure channel status between ADFS server and DCs

Make sure that the secure channel between AD FS and the DCs is good. To do this, run the following command:

```console
Nltest /dsgetdc:domainname
```  

If the response is anything other than "success," you must troubleshoot the netlogon secure channel. To do this, make sure that the following conditions are true:

- The domain controller (DC) is reachable
- DC names can be resolved
- Passwords on the computer and its account on the Active Directory site are in sync.

### Step 10: Check for bottlenecks

Check whether you're experiencing authentication-related bottlenecks per the **MaxconcurrentAPI** setting on the AD FS server or on the DCs. For more information about how to check this setting, see the following Knowledge Base article:

[How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](https://support.microsoft.com/help/2688798)

### Step 11: Check whether the ADFS proxy server is experiencing congestion

Check whether the ADFS proxy server is throttling connections because it has received many requests or delayed response from the AD FS server. For more information, see the following TechNet topic:

[AD FS 2.x: Troubleshooting Proxy Server Event ID 230 (Congestion Avoidance Algorithm)](https://social.technet.microsoft.com/wiki/contents/articles/19057.ad-fs-2-x-troubleshooting-proxy-server-event-id-230-congestion-avoidance-algorithm.aspx)

In this scenario, you may note intermittent login failures on ADFS.

### Step 12: Check proxy trust settings

If you have an ADFS proxy server configured, check whether proxy trust is renewed during the connection intervals between the AD FS and AD FS Proxy servers.

The Proxy server automatically renews trust with AD FS Federation Service. If this process fails, event 394 is logged in Event Viewer and you receive the following error message:

> The federation server proxy could not renew its trust with the Federation Service.

To resolve this problem, try to run the AD FS proxy configuration wizard again. As the wizard runs, make sure that valid domain user name and passwords are used. These credentials aren't stored on the AD FS Proxy server.

### Step 13: Enable ADFS auditing together with Audit logon events - success and failure

For more information, see [Configuring ADFS Servers for Troubleshooting](https://technet.microsoft.com/library/cc738766%28v=ws.10%29.aspx).
