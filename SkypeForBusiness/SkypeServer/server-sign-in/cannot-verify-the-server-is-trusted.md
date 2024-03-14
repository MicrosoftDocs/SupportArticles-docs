---
title: Lync can't verify that the server is trusted during client sign-in
description: Works around an issue in which a Trust Model dialog box appears when a user tries to sign in to Lync. This issue occurs in a Lync Server 2013 environment.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync 2013
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync can't verify that the server is trusted for your sign-in address" message during client sign-in

## Symptoms

This article describes two scenarios that occur when the Microsoft Lync client can't establish a trust relationship with resources that require a secure TLS connection.

### Scenario 1

When users try to sign in to Microsoft Lync in a Lync Server 2013 environment for the first time, they receive the following message in a dialog box:

```output
Lync is attempting to connect to:
<Fully qualified domain name (FQDN) of a server>
Lync cannot verify that the server is trusted for your sign-in address. Connect anyway? 
```

For example, the following trust model dialog box is displayed:

:::image type="content" source="./media/cannot-verify-the-server-is-trusted/trust-model.png" alt-text="Screenshot that shows the Trust Model dialog box.":::

### Scenario 2

The **Lync – Sign In** dialog box that's shown in the screen shot in Scenario 1 displays the fully qualified domain name (FQDN) of the organization's Exchange Client Access server (CAS) interface. This interface is used by the Lync client to access user mailbox information through Exchange Web Services (EWS). This behavior occurs if the Lync user's SIP URI contains a domain suffix that does not match the domain suffix of the Exchange CAS interface. If the user chooses not to trust the connection to the Exchange CAS interface, the Lync client will not have access to the Exchange mailbox services that are provisioned by EWS.

To verify this behavior, follow these steps:

1. Make sure that the Lync client is signed in to on the Windows client's desktop.    
2. Hold down the CTRL key and right-click the Lync icon in the Windows client's notification area.    
3. In the shortcut menu, click **Configuration Information**. 
4. Locate the "EWS Information" line.    
5. If this line contains "EWS not fully initialized," you are experiencing the Scenario 2 behavior.    
  
## Cause

This issue occurs because the SIP domain name of the user does not match the domain names in the following properties in the certificate of Lync Web Services and Exchange Web Services:

- Subject Name   
- Common Name   

## Resolution

To prevent display of the Trust Model dialog box, use the **Trusted Domain List (TrustModelData) Group Policy**. After you set this policy, Lync will exclusively trust the domains that are specified in the policy. Supported values: 
 
- Not Configured (Default)/Disabled

   Through this setting, the following domains are trusted by default:  
    - lync.com    
    - outlook.com    
    - lync.glbdns.microsoft.com    
    - microsoftonline.com    
     
- Enabled

   This setting specifies the list of domains to be trusted—for example: contoso.com, contoso.co.in.

For more information about the Lync 2013 Trusted Domain List (TrustModelData) Group Policy setting, see [Configuring client bootstrapping policies](/skypeforbusiness/deploy/deploy-clients/configure-client-bootstrapping-policies).

For more information about the Lync 2013.admx (ADMX) and .adml (ADML) Administrative Templates, see [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization tool](https://www.microsoft.com/download/details.aspx?id=35554). 

## More Information

### Scenario 1

The Lync 2013 desktop client uses the new automatic discovery mechanism to locate the internal or external Lync Web Service, depending on the network location of the user.

The following process occurs when the Lync 2013 desktop client tries to locate the Lync Web Service:

1. The Lync 2013 desktop client sends a pair of HTTP and HTTPS requests to locate the Lync Autodiscover Service. The HTTP and HTTPS requests consist of a default set of internal or external host name values and the SIP domain name of the user.

    For example, the Lync 2013 desktop client sends the following requests:

    `http://LyncdiscoverInternal.contoso.com` and `https://LyncdiscoverInternal.contoso.com` 

    > [!NOTE]
    > `LyncdiscoverInternal.contoso.com` is resolved to the FQDN or IP address of the Internal Lync Web Service.

    `http://Lyncdiscover.contoso.com` and `https://Lyncdiscover.contoso.com` 

    > [!NOTE]
    > `Lyncdiscover.contoso.com` is resolved to the FQDN or IP address of the external interface of the Reverse Proxy.    
2. The Lync 2013 desktop client receives a response that contains the secure internal and external URLs of the Autodiscover Service from Web Services.    
3. The Lync 2013 desktop client tries to contact the Autodiscover Service by using an HTTPS connection. If the SIP domain name of the user does not match the domain name in the Subject Name or Common Name property on the certificate that is assigned to Lync Web Service, the Trust Model dialog box is displayed.    
 
### Scenario 2

The Lync client makes https requests to the Exchange CAS interface as part of its post-sign-in process. These requests include access to the Exchange Autodiscover service through URLs that include the FQDN of the Exchange CAS interface. For example:

- `https://<smtpdomain>/autodiscover/autodiscover.xml`     
- `https://autodiscover.<smtpdomain>/autodiscover/autodiscover.xml`    
 
If the FQDN of the SMTP domain does not match the FQDN of the SIP domain that the Lync client is signed in to, the Scenario 2 issue occurs.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
