---
title: How to configure Kerberos Constrained Delegation for Web Enrollment proxy pages
description: Discusses how to implement S4U2Proxy and Constrained Delegation on a custom service account or the NetworkServices account for Web Enrollment proxy pages.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jarrettr, wincicadsec, jitha, v-tappelgate
ms.custom: sap:Active Directory\Domain or forest functional level updates, failures and Advisory, csstroubleshoot
keywords: KCD, Kerberos constrained delegation, s4u2proxy, s4u2self, service account, computer account, machine account
---
# How to configure Kerberos Constrained Delegation for Web Enrollment proxy pages

The article provides step-by-step instructions to implement Service for User to Proxy (S4U2Proxy) or Kerberos Only Constrained Delegation on a custom service account for Web Enrollment proxy pages.

_Applies to:_ &nbsp; Window Server 2016, Window Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4494313

## Summary

This article provides step-by-step instructions to implement Service for User to Proxy (S4U2Proxy) or Kerberos-only constrained delegation for Web Enrollment proxy pages. This article describes the following configuration scenarios:

- Configuring delegation for a custom service account
- Configuring delegation to the NetworkService account

> [!NOTE]  
> The workflows that are described in this article are specific to a particular environment. The same workflows may not work for a different situation. However, the principles remain the same. The following figure summarizes this environment.  
> :::image type="content" source="media/configure-kerberos-constrained-delegation/constrained-delegation-environment.png" alt-text="Types of servers in the example environment.":::

## Scenario 1: Configure constrained delegation for a custom service account

This section describes how to implement Service for User to Proxy (S4U2Proxy) or Kerberos-only constrained delegation when you use a custom service account for the Web Enrollment proxy pages.

### 1. Add an SPN to the service account

Associate the service account with a Service Principal Name (SPN). To do this, follow these steps:

1. In **Active Directory Users and Computers**, connect to the domain, and then select **PKI** > **PKI Users**.  

2. Right-click the service account (for example, web_svc), and then select **Properties**.
3. Select **Attribute Editor** > **servicePrincipalName**.
4. Type the new SPN string, select **Add** (as shown in the following figure), and then select **OK**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/active-directory-users-computers.png" alt-text="Guidance to add and configure the H T T P SPNs.":::
  
   You can also use Windows PowerShell to configure the SPN. To do this, open an elevated PowerShell window, and then run `setspn -s SPN Accountname`. For example, run the following command:

   ```console
   setspn -s HTTP/webenroll2016.contoso.com web_svc
   ```

### 2. Configure the delegation

1. Configure S4U2proxy (Kerberos only) constrained delegation on the service account. To do this, in the **Properties** dialog box of the service account (as described in the previous procedure), select **Delegation** > **Trust this user for delegation to specified services only**. Make sure that **Use Kerberos only** is selected.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/web-svc-settings.png" alt-text="Configure web_svc properties under the Delegation tab in the Properties dialog box.":::  
2. Close the dialog box.
3. In the console tree, select **Computers**, and then select the computer account of the Web Enrollment front-end server.  
   > [!NOTE]  
   > This account is also known as the "machine account."
4. Configure S4U2self (Protocol Transition) constrained delegation on the computer account. To do this, right-click the computer account, and then select **Properties** > **Delegation** > **Trust this computer for delegation to specified services only**. Select **Use any authentication protocol**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/set-s4u2self-contained-delegation.png" alt-text="Select Use any authentication protocol under the Trust this computer for delegation to specified services only option.":::

### 3. Create and bind the SSL certificate for web enrollment

To enable the web enrollment pages, create a domain certificate for the website, and then bind it to the Default Web Site. To do this, follow these steps:

1. Open Internet Information Services (IIS) Manager.
2. In the console tree, select \<***HostName***>, and then select **Server Certificates**.  

   > [!NOTE]  
   > \<*HostName*> is the name of the front-end web server.  
   :::image type="content" source="media/configure-kerberos-constrained-delegation/select-server-certificate.png" alt-text="Add a domain certificate for the website.":::
3. In the **Actions** menu, select **Create a Domain Certificate**.
4. After the certificate is created, select **Default Web Site** in the console tree, and then select **Bindings**.
5. Make sure that **Port** is set to **443**. Then under **SSL certificate**, select the certificate that you created in step 3.  

    :::image type="content" source="media/configure-kerberos-constrained-delegation/add-site-binding.png" alt-text="Add certificate and bind it to port 443 for scenario 1.":::  
6. Select **OK** to bind the certificate to port 443.  

### 4. Configure the Web Enrollment front-end server to use the service account

> [!IMPORTANT]  
> Make sure that the service account is part of either the **local administrators** or **IIS_Users** group on the web server.  
> :::image type="content" source="media/configure-kerberos-constrained-delegation/local-users-groups.png" alt-text="Groups for the service account on the web server.":::

1. Right-click **DefaultAppPool**, and then select **Advanced Settings**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/advanced-settings.png" alt-text="Configure Application pools Advanced Settings.":::
2. Select **Process Model** > **Identity**, select **Custom account**, and then select **Set**. Specify the name and password of the service account.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/add-custom-account.png" alt-text="Configure the Application Pool Identity as the custom service account.":::
3. Select **OK** in the **Set Credentials** and **Application Pool Identity** dialog boxes.
4. In **Advanced Settings**, locate **Load User Profile**, and make sure that it's set to **True**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/load-user-profile.png" alt-text="Set the Load User Profile setting to True.":::  
5. Restart the computer.

## Scenario 2: Configure constrained delegation on the NetworkService account

This section describes how to implement S4U2Proxy or Kerberos-only constrained delegation when your use the NetworkService account for the Web Enrollment proxy pages.

### Optional step: Configure a name to use for connections

You can assign a name to the Web Enrollment role that clients can use to connect. This configuration means that incoming requests do not have to know the computer name of the Web Enrollment front-end server, or other routing information such as the DNS canonical name (CNAME).

For example, suppose the computer name of your Web Enrollment server is WEBENROLLMAC (in the Contoso domain). You want incoming connections to use the name ContosoWebEnroll instead. In this case, the connection URL would be the following:

`https://contosowebenroll.contoso.com/certsrv`

It would not be the following:

`https://WEBENROLLMAC.contoso.com/certsrv`

To use such a configuration, follow these steps:

1. In the DNS zone file for the domain, create an alias record or a host name record that maps the new connection name to the Web Enrollment role IP address. Use the Ping tool to test the routing configuration.  

   In the example that was previously discussed, the `Contoso.com` zone file has an alias record that maps ContosoWebEnroll to the IP address of the Web Enrollment role.
2. Configure the new name as an SPN for the Web Enrollment front-end server. To do this, follow these steps:
   1. In Active Directory Users and Computers, connect to the domain, and then select **Computers**.
   2. Right-click the computer account of the Web Enrollment front-end server, and then select **Properties**.
      >[!NOTE]  
      > This account is also known as the "machine account."
   3. Select **Attribute Editor** > **servicePrincipalName**.
   4. Type **HTTP/\<*ConnectionName*>.\<*DomainName*.com**>, select **Add**, and then select **OK**.
        > [!NOTE]  
        > In this string, \<*ConnectionName*> is the new name that you have defined, and \<*DomainName*> is the name of the domain.
        > In the example, the string is **HTTP/ContosoWebEnroll.contoso.com**.
        :::image type="content" source="media/configure-kerberos-constrained-delegation/aduc-editor-add-spn.png" alt-text="Add an S P N to the front-end server computer account.":::

### 1. Configure the delegation

1. If you haven't already connected to the domain, do this now in **Active Directory Users and Computers**, and then select **Computers**.
2. Right-click the computer account of the Web Enrollment front-end server, and then select **Properties**.  
   > [!NOTE]  
   >This account is also known as the "machine account."
3. Select **Delegation**, and then select **Trust this computer for delegation to specified services only**.
   > [!NOTE]  
   > If you can guarantee that clients will always use Kerberos authentication when they connect to this server, select **Use Kerberos only**.
   > If some clients will use other authentication methods, such as NTLM or forms-based authentication, select **Use any authentication protocol**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/aduc-props-delegation.png" alt-text="Configure delegation on the web server computer account.":::  

### 2. Create and bind the SSL certificate for web enrollment

To enable the web enrollment pages, create a domain certificate for the website, and then bind it to the default first site. To do this, follow these steps:

1. Open IIS Manager.
2. In the console tree, select \<***HostName***>, and then select **Server Certificates** in the actions pane.  

   > [!NOTE]  
   > \<*HostName*> is the name of the front-end web server.
   :::image type="content" source="media/configure-kerberos-constrained-delegation/select-server-certificate.png" alt-text="Add a domain certificate for the website.":::
3. In the **Actions** menu, select **Create a Domain Certificate**.
4. After the certificate is created, select **Default Web Site**, and then select **Bindings**.
5. Make sure that **Port** is set to **443**. Then, under **SSL certificate**, select the certificate that you created in step 3. Select **OK** to bind the certificate to port 443.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/bind-server-cert.png" alt-text="Add certificate and bind it to port 443.":::

### 3. Configure the Web Enrollment front-end server to use the NetworkService account

1. Right-click **DefaultAppPool**, and then select **Advanced Settings**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/advanced-settings.png" alt-text="Select Advanced Settings of the default application pool.":::
2. Select **Process Model** > **Identity**. Make sure that **Built-in account** is selected, and then select **NetworkService**. Then, select **OK**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/iis-apppool-id-netserv.png" alt-text="Configure the Application Pool Identity as the built-in NetworkService account.":::
3. In **Advanced Properties**, locate **Load User Profile**, and then make sure that it's set to **True**.  

   :::image type="content" source="media/configure-kerberos-constrained-delegation/netserv-loaduserprf.png" alt-text="Set the Load User Profile to True in the Advances Settings.":::
4. Restart the IIS service.

## Related topics

For more information about these processes, see [Authenticating Web Application Users](/previous-versions/windows/it-pro/windows-server-2003/cc759501%28v%3dws.10%29).

For more information about the S4U2self and S4U2proxy protocol extensions, see the following articles:

- [[MS-SFU]: Kerberos Protocol Extensions: Service for User and Constrained Delegation Protocol](/openspecs/windows_protocols/ms-sfu/3bff5864-8135-400e-bdd9-33b552051d94)  
- [4.1 S4U2self Single Realm Example](/openspecs/windows_protocols/ms-sfu/6a8dfc0c-2d32-478a-929f-5f9b1b18a169)  
- [4.3 S4U2proxy Example](/openspecs/windows_protocols/ms-sfu/c920c148-8a9c-42e9-b8e9-db5755cd281b)
