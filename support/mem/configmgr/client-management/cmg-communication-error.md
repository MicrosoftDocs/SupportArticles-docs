---
title: Configuration Manager Clients Can't Communicate with CMG
description: Provides details about log files and solutions to common issues when Configuration Manager clients can't communicate with CMG.
ms.date: 02/28/2025
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
ms.reviewer: kaushika, bmoran
---
# Configuration Manager clients fail to communicate with CMG

This article provides solutions to common issues when Configuration Manager clients fail to communicate with a Cloud Management Gateway (CMG).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4503442, 4495265

## Error code 403 (CMGConnector_Clientcertificaterequired)

In the following log files, error messages that resemble the following entries are logged:

**LocationServices.log**

```output
[CCMHTTP] ERROR: URL=https://cmgsccm.contoso.com/CCM_PROXY_MUTUALAUTH/3456/SMS_MP/.sms_aut?SITESIGNCERT, Port=443, Options=31, Code=0, Text=CCM_E_BAD_HTTP_STATUS_CODE  
[CCMHTTP] ERROR INFO: StatusCode= 403 StatusText= CMGConnector_Clientcertificaterequired
```

**SMS_Cloud_ProxyConnector.log**

```output
Forwarding proxy message \<message ID> to URL: `https://InternalMP.contoso.com/SMS_MP/.sms_aut?SITESIGNCERT`  
Web exception for message \<message ID>: System.Net.WebException: **The remote server returned an error: (403) Forbidden**.~~  at System.Net.HttpWebRequest.EndGetResponse(IAsyncResult asyncResult)~~  at Microsoft.ConfigurationManager.CloudConnection.ProxyConnector.ConnectionBase.InternalResponseCallBack(IAsyncResult asynchronousResult)  
Received response `https://InternalMP.contoso.com/SMS_MP/.sms_aut?MPLIST2&CM1` for message \<message ID>: HTTP/1.1 403 CMGConnector_Clientcertificaterequired
```

### Cause

The CMG connection point requires a [server authentication certificate](/mem/configmgr/core/clients/manage/cmg/certificates-for-cloud-management-gateway#bkmk_clientauth) to securely forward client requests to an HTTPS management point. If the server authentication certificate is missing, misconfigured, or invalid, status code 403 is returned. In scenarios where the Management Point (MP) operates in enhanced HTTP mode with token-based authentication, the certificate isn't required but is always recommended.

### Resolution

To resolve this issue, generate a [server authentication certificate](/mem/configmgr/core/clients/manage/cmg/certificates-for-cloud-management-gateway#bkmk_clientauth) for the CMG connection point.

> [!NOTE]
> In the certificate, computers must have a unique value in the **Subject Name** or **Subject Alternative Name** field.

### How to verify the CMG has a server certificate

After you enable verbose logging, the **SMS_Cloud_ProxyConnector.log** file will show the list of available certificates on the server. To verify if a valid server authentication certificate to establish communication between the CMG connection point and the management point exists, check the number of certificates in the **Filtered cert count with client auth:** line. See the following log for an example:

**SMS_Cloud_ProxyConnector.log**

```output
Filtered cert count with digital signature: 7
Not allowed cert: <certificate>
Not allowed cert: <certificate>
No private key cert: <certificate>
Not allowed cert: <certificate>
Filtered cert count with allowed root CA: 3
Filtered cert count with private key: 3
Not client auth cert: <certificate>
Not client auth cert: <certificate>
Not client auth cert: <certificate>
Filtered cert count with client auth: 0
Maintaining connections...
```

## Error code 403 (CMGConnector_Forbidden)

In the following log file, error messages that resemble the following entries are logged:

**LocationServices.log**

```output
[CCMHTTP] ERROR: URL=https://cmgsccm.contoso.com/CCM_PROXY_MUTUALAUTH/3456/SMS_MP/.sms_aut?SITESIGNCERT, Port=443, Options=31, Code=0, Text=CCM_E_BAD_HTTP_STATUS_CODE  \
[CCMHTTP] ERROR INFO: StatusCode= 403 StatusText= CMGConnector_Forbidden
```

### Cause

There's a mismatch between the Internet Information Services (IIS) bindings and the management point in HTTP mode. If the management point is moved from HTTPS mode to enhanced HTTP mode without cleaning the bindings, the Configuration Management client might be unable to configure an **SMS Role SSL certificate** used in enhanced HTTP mode. In other situations, an incorrect certificate (expired or revoked) exists in the IIS bindings and needs to be cleaned.

### Resolution

1. Open IIS Manager (`inetmgr`).

1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.

1. In the right pane, select **Bindings**.

1. In the **Site Bindings** dialog, select the 443 port binding, and then select **Edit**.

1. In the **Edit Site Binding** dialog, select the certificate accordingly:

    - Enhanced HTTP: **SMS Role SSL certificate**

    - HTTPS: A valid public key infrastructure (PKI) server authentication certificate

## Error code 0x2f8f (ERROR_WINHTTP_SECURE_FAILURE)

In the following log file, an error message that resembles the following entry is logged:

**LocationServices.log**

```output
[CCMHTTP] ERROR: URL=https://CMG.CONTOSO.COM/CCM_Proxy_ServerAuth/72057594037928017/CCM_STS, Port=443, Options=63, Code=12175, Text=ERROR_WINHTTP_SECURE_FAILURE
```

Before the error message, other events might also be logged:

```output
[CCMHTTP] AsyncCallback():

[CCMHTTP] AsyncCallback(): WINHTTP_CALLBACK_STATUS_SECURE_FAILURE Encountered
[CCMHTTP] : dwStatusInformationLength is 4
[CCMHTTP] : lpvStatusInformation is 0x9
[CCMHTTP] : WINHTTP_CALLBACK_STATUS_FLAG_CERT_REV_FAILED is set
[CCMHTTP] : WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA is set
[CCMHTTP] : WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID is set
```

> [!NOTE]
>
> - `WINHTTP_CALLBACK_STATUS_FLAG_CERT_REV_FAILED` indicates that the `/NoCRLCheck` parameter is missing from the `CCMSetup` command, and the certificate revocation list (CRL) isn't published on the Internet.
>
> - `WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA` indicates that the root certificate authority (CA) certificate required to validate the server authentication certificate for a CMG is missing.
>
> - `WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID` indicates that the hostname in the certificate common name is incorrect.

### Cause

This issue occurs if one or more of the following conditions are true:

- The client doesn't have the necessary PKI Root CA to validate the server authentication certificate.
- The certificate presented to the client is incorrect.
- The CRL that contains the certificate isn't published on the Internet, and the client is forced to validate the CRL.

### Resolution

If you're using a PKI server authentication certificate, follow these steps:

1. Make sure that the certificate presented to the client has the expected CMG name. If you're using non-Microsoft services that use certificate pinning and modify the presented certificate, the clients can't validate the server certificate.

    To verify which certificate is presented, open the following URL in a web browser:

    `https://<CMGFQDN>/CCM_Proxy_MutualAuth/ServiceMetadata`

    Replace the `<CMGFQDN>` placeholder with your CMG public fully qualified domain name (FQDN).

2. Make sure that the client has the certificate in the local Trusted Root Certification Authorities certificate store. Otherwise, the client doesn't trust the CMG, even when using Microsoft Entra or token-based authentication. This modern authentication method is only available for the CMG to validate the server authentication but not for the responses sent from the CMG to the client. When you use a non-Microsoft certificate for authentication, the client can typically validate the public Root CA over the Internet.

3. If the CRL isn't published on the Internet, make sure that the site doesn't force clients to validate the CRL and disable CRL checking for clients:

    1. In the Configuration Manager console, navigate to the **Administration** workspace.

    1. Expand **Site Configuration**, and then select the **Sites** node.

    1. Select the primary site to configure.

    1. In the ribbon, select **Properties**.

    1. On the **Communication Security** tab, clear the **Clients check the certificate revocation list (CRL) for site systems** checkbox.

    > [!NOTE]
    > When installing clients from the Internet, make sure that the `/NoCRLCheck` parameter is included in the `CCMSetup` command.

## Error code 401 (CMGService_Invalid_Token)

The client hasn't communicated with the site (via the CMG or MP) for more than 30 days, or the `CCMSetup` command is attempting to use an expired token with the `/regtoken` parameter. In the following log files, error messages that resemble the following entries are logged:

**Ccmsetup.log**

```output
[CCMHTTP] ERROR: URL=https://CMGSERVER.CLOUDAPP.NET/CCM_Proxy_ServerAuth/ServiceMetadata , Port=443, Options=224, >Code=0, Text=CCM_E_BAD_HTTP_STATUS_CODE
[CCMHTTP] ERROR INFO: StatusCode=401 StatusText=CMGService_Invalid_Token
```

**CCM_STS.log**

```output
Return code: 401, Description: PreAuth token validation failed, System.IdentityModel.Tokens.SecurityTokenExpiredException:
IDX10223: Lifetime validation failed. The token is expired.
ValidTo: '10/01/2020 22:03:24'
Current time: '10/28/2020 13:05:05'.
   at System.IdentityModel.Tokens.Validators.ValidateLifetime....
```

### Cause

This issue occurs because the token has expired or wasn't properly added.

### Resolution

To renew the expired token, connect the client to the internal MP directly or reinstall the client by using a new [Bulk registration token](/mem/configmgr/core/clients/deploy/deploy-clients-cmg-token#bulk-registration-token).

## More information

For further troubleshooting, do the following actions:

- Check the IIS logs on the management point.

    In the following sample log, the `403 7` response indicates that the server certificate can't be found:

    > \<Date> \<Time> \<IP_address_of_MP> GET /SMS_MP/.sms_aut SITESIGNCERT 443 - \<IP_address_of_CMG_connectionpoint> SMS+CCM+5.0 - **403 7** 0 5573 11

- Enable verbose logging for the **SMS_Cloud_ProxyConnector.log** file by setting the `VerboseLogging` registry entry value to `1` under the following registry key, and then restart the SMS_EXECUTIVE service.

    `HKLM\SOFTWARE\MICROSOFT\SMS\SMS_CLOUD_PROXYCONNECTOR`
