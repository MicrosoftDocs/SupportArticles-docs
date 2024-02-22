---
title: Error 403 when Configuration Manager communicates with CMG
description: Describes an issue in which Configuration Manager clients can't communicate with CMG, and they return a 403 error.
ms.date: 12/05/2023
ms.custom: sap:Cloud Management Gateway (CMG)
ms.reviewer: kaushika
---
# Error 403 when the Configuration Manager clients try to communicate with CMG

This article provides the resolution to solve the 403 error that occurs when the Configuration Manager clients try to communicate with cloud management gateway (CMG).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4503442

## Symptoms

Configuration Manager clients can't communicate together with the CMG. An error message that resembles one of the following is logged in the LocationServices.log file:

> [CCMHTTP] ERROR: URL=https://cmgsccm.contoso.com/CCM_PROXY_MUTUALAUTH/3456/SMS_MP/.sms_aut?SITESIGNCERT, Port=443, Options=31, Code=0, Text=CCM_E_BAD_HTTP_STATUS_CODE  
> [CCMHTTP] ERROR INFO: StatusCode= **403** StatusText= **CMGConnector_Clientcertificaterequired**  

or

> [CCMHTTP] ERROR: URL=https://cmgsccm.contoso.com/CCM_PROXY_MUTUALAUTH/3456/SMS_MP/.sms_aut?SITESIGNCERT, Port=443, Options=31, Code=0, Text=CCM_E_BAD_HTTP_STATUS_CODE  \
> [CCMHTTP] ERROR INFO: StatusCode= **403** StatusText= **CMGConnector_Forbidden**  

Error messages that resemble the following are logged in the SMS_Cloud_ProxyConnector.log file:

> Forwarding proxy message \<message ID> to URL: `https://InternalMP.contoso.com/SMS_MP/.sms_aut?SITESIGNCERT`  
> Web exception for message \<message ID>: System.Net.WebException: **The remote server returned an error: (403) Forbidden**.~~  at System.Net.HttpWebRequest.EndGetResponse(IAsyncResult asyncResult)~~  at Microsoft.ConfigurationManager.CloudConnection.ProxyConnector.ConnectionBase.InternalResponseCallBack(IAsyncResult asynchronousResult)  
> Received response `https://InternalMP.contoso.com/SMS_MP/.sms_aut?MPLIST2&CM1` for message \<message ID>: HTTP/1.1 **403 CMGConnector_Clientcertificaterequired**

## Cause

The CMG connection point requires a [client authentication certificate](/mem/configmgr/core/clients/manage/cmg/certificates-for-cloud-management-gateway#bkmk_clientauth) to securely forward client requests to an HTTPS management point. If the client authentication certificate is missing, configured incorrectly, or invalid, status code 403 is returned.

## Resolution

To fix this issue, generate a [client authentication certificate](/mem/configmgr/core/clients/manage/cmg/certificates-for-cloud-management-gateway#bkmk_clientauth) for the CMG connection point.

> [!NOTE]
> In the certificate, computers must have a unique value in the **Subject Name** or **Subject Alternative Name** field.

## More information

For better troubleshooting, do the following:

- Check the Internet Information Services (IIS) logs on the management point for more information about the error.

    In the following sample log, the **403 7** response means that the client certificate can't be found:

    > \<Date> \<Time> \<IP_address_of_MP> GET /SMS_MP/.sms_aut SITESIGNCERT 443 - \<IP_address_of_CMG_connectionpoint> SMS+CCM+5.0 - **403 7** 0 5573 11

- Enable verbose logging for `SMS_CLOUD_PROXYCONNECTOR` by setting the `VerboseLogging` registry value under `HKLM\SOFTWARE\MICROSOFT\SMS\SMS_CLOUD_PROXYCONNECTOR` to **1**, and then restart the SMS_EXECUTIVE service.

  The following is an example of SMS_Cloud_ProxyConnector.log content. It indicates that there isn't a valid client authentication certificate to establish communication between the CMG connection point and the management point.

  > Filtered cert count with digital signature: 7  
  > Not allowed cert: \<certificate>  
  > Not allowed cert: \<certificate>  
  > No private key cert: \<certificate>  
  > Not allowed cert: \<certificate>  \
  > Filtered cert count with allowed root CA: 3  
  > Filtered cert count with private key: 3  
  > Not client auth cert: \<certificate>  
  > Not client auth cert: \<certificate>  
  > Not client auth cert: \<certificate>  
  > Filtered cert count with client auth: 0  
  > Maintaining connections...
