---
title: Troubleshoot backend health issues in Azure Application Gateway
description: Learn how to troubleshoot Azure Application Gateway backend health issues, diagnose unhealthy or unknown status, and resolve common probe errors.
services: application-gateway
ms.date: 08/28/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-application-gateway
ms.custom: sap:backend health,sfi-image-nochange
# Customer intent: As an IT admin, I want to troubleshoot backend health issues in Application Gateway, so that I can ensure my backend servers are operational and effectively serving requests.
---

# Troubleshoot backend health issues in Application Gateway

## Summary

This article explains how to troubleshoot backend health issues in Azure Application Gateway.

By default, Azure Application Gateway probes backend servers (associated with a rule) to check their health status and ensure the incoming traffic is sent only to the servers that are running. In each case, if the backend server doesn't respond successfully, Application Gateway marks the server as Unhealthy and stops forwarding requests to the server. After the server starts responding successfully, Application Gateway resumes forwarding the requests.

You can also create [custom probes](/azure/application-gateway/application-gateway-probe-overview#custom-health-probe) to specify the host name, the path to probe, and the status codes to accept as **Healthy**.

## Tools to check backend health

To check the health of your backend pool, use these tools:

- The **Backend Health** page in the [Azure portal](/azure/application-gateway/application-gateway-diagnostics#enable-logging-through-the-azure-portal)
- [Azure PowerShell](/azure/application-gateway/application-gateway-diagnostics#enable-logging-through-powershell) (Also see [Get-AzApplicationGatewayBackendHealth](/powershell/module/az.network/get-azapplicationgatewaybackendhealth))
- [CLI](/cli/azure/network/application-gateway#az-network-application-gateway-show-backend-health)
- [REST API](/rest/api/application-gateway/applicationgateways/backendhealth)

The status retrieved by any of these methods can be any one of the following states:

- **Healthy**
- **Unhealthy**
- **Unknown**

Application Gateway forwards a request to a server from the backend pool if its status is **Healthy**. If all the servers in a backend pool are **Unhealthy** or **Unknown**, the clients might encounter problems accessing the backend application. 

> [!NOTE]
> If you don't have permission to see backend health statuses, **No results** is displayed.

## Backend health status: Unhealthy

If the backend health status is **Unhealthy**, the portal view resembles the following screenshot:

:::image type="content" source="./media/application-gateway-backend-health-troubleshooting/appgwunhealthy.png" alt-text="Screenshot of Application Gateway backend health - Unhealthy." lightbox="./media/application-gateway-backend-health-troubleshooting/appgwunhealthy.png":::

If you use Azure PowerShell, Azure CLI, or Azure REST API query, you get a response that resembles the following example:

```azurepowershell
PS C:\Users\testuser\> Get-AzApplicationGatewayBackendHealth -Name "appgw1" -ResourceGroupName "rgOne"
BackendAddressPools :
{Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayBackendHealthPool}
BackendAddressPoolsText : [
{
                              "BackendAddressPool": {
                                "Id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/rgOne/providers/Microsoft.Network/applicationGateways/appgw1/b
                          ackendAddressPools/appGatewayBackendPool"
                              },
                              "BackendHttpSettingsCollection": [
                                {
                                  "BackendHttpSettings": {
                                    "TrustedRootCertificates": [],
                                    "Id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/rgOne/providers/Microsoft.Network/applicationGateways/appg
                          w1/backendHttpSettingsCollection/appGatewayBackendHttpSettings"
                                  },
                                  "Servers": [
                                    {
                                      "Address": "10.0.0.5",
                                      "Health": "Healthy"
                                    },
                                    {
                                      "Address": "10.0.0.6",
                                      "Health": "Unhealthy"
                                    }
                                  ]
                                }
                              ]
                            }
                        ]
```

After you receive an unhealthy backend server status for all the servers in a backend pool, Application Gateway stops forwarding requests to the servers and returns a **502 Bad Gateway** error to the requesting client. To troubleshoot this issue, check the **Details** column on the **Backend Health** tab.

The message displayed in the **Details** column provides more detailed insights about the issue. Based on those details, you can start troubleshooting the issue.

> [!NOTE]
> The default probe request is sent in the format of `\<protocol\>://127.0.0.1:\<port\>`. For example, `http://127.0.0.1:80` for an HTTP probe on port 80. Only HTTP status codes of 200 through 399 are considered healthy. The protocol and destination port come from the HTTP settings. If you want Application Gateway to probe on a different protocol, host name, or path and to recognize a different status code as healthy, configure a custom probe and associate it with the HTTP settings.

## Error messages

### Backend server timeout

#### Message 

"Time taken by the backend to respond to application gateway's health probe is more than the timeout threshold in the probe setting."

#### Cause 

After Application Gateway sends an HTTP(S) probe request to the backend server, it waits for a response from the backend server for a configured period. If the backend server doesn't respond within this period (the timeout value), it's marked as **Unhealthy** until it responds within the configured timeout period again.

#### Resolution 

Check why the backend server or application isn't responding within the configured timeout period. Make sure to also check the application dependencies. For example, check whether the database has any issues that might trigger a delay in response. If you're aware of the application's behavior and it should respond only after the timeout value, increase the timeout value from the custom probe settings. You must have a custom probe to change the timeout value. For information about how to configure a custom probe, see [Create a custom probe for Application Gateway by using the portal](/azure/application-gateway/application-gateway-create-probe-portal).

To increase the timeout value, follow these steps:

1. Access the backend server directly and check the time taken for the server to respond on that page. You can use any tool to access the backend server, including a browser using developer tools.
1. After you determine the time taken for the application to respond, select the **Health Probes** tab, then select the probe associated with your HTTP settings.
1. Enter any timeout value that's greater than the application response time, in seconds.
1. Save the custom probe settings and check whether the backend health shows as **Healthy** now.

### DNS resolution error

#### Message 

"Application Gateway could not create a probe for this backend. This usually happens when the FQDN of the backend is not entered correctly."

#### Cause 

If the backend pool is an IP address, fully qualified domain name (FQDN), or Azure App Service, Application Gateway resolves to the IP address of the FQDN you enter through Domain Name Service (DNS) (custom or Azure default). The application gateway then tries to connect to the server on the Transmission Control Protocol (TCP) port you specify in the HTTP settings. This message means Application Gateway can't successfully resolve the IP address of the FQDN you entered.

#### Solution 

To resolve this issue, follow this guidance:

- Verify that the FQDN you enter in the backend pool is correct and that it's a public domain. Then try to resolve it from your local machine. If you can resolve the IP address, check the DNS configuration in the virtual network.
- Check whether the virtual network is configured with a custom DNS server. If it is, check the DNS server for why it can't resolve to the IP address of the specified FQDN.

> [!NOTE]
> If you're using the default version of Azure DNS, verify with your domain name registrar that proper `A` or `CNAME` record mapping is complete.

- If the domain is private or internal, try to resolve it from a virtual machine (VM) in the same virtual network. If you can't resolve it, restart Application Gateway and check again. To restart, you need to [stop](/powershell/module/az.network/stop-azapplicationgateway) and then [start](/powershell/module/az.network/start-azapplicationgateway) Application Gateway by using the PowerShell commands in this article.
- If you're using short names (single-label domain names like `server1` instead of a fully-qualified domain name `server1.contoso.com`), verify that your DNS server can resolve the short name. Azure's built-in DNS (168.63.129.16) only resolves short names for resources within the same virtual network. For on-premises short names, use a custom DNS server configured with the appropriate search domains.

### TCP connect error

#### Message

"Application Gateway could not connect to the backend. Check that the backend responds on the port used for the probe. Also check whether any NSG/UDR/Firewall is blocking access to the Ip and port of this backend."

#### Cause

After the DNS resolution phase, Application Gateway tries to connect to the backend server on the TCP port configured in the HTTP settings. If Application Gateway can't establish a TCP session on the port specified, the probe is marked as **Unhealthy** with this message.

#### Solution

To resolve this issue, follow these steps:

1. Check whether you can connect to the backend server on the port mentioned in the HTTP settings by using a browser or PowerShell by running this command: `Test-NetConnection -ComputerName www.bing.com -Port 443`.
1. If the port mentioned isn't the desired port, enter the correct port number for Application Gateway to connect to the backend server.
1. If you can't connect on the port from your local machine as well, do the following:
   a.  Check the network security group (NSG) settings of the backend server's network adapter and subnet and whether inbound connections to the configured port are allowed. If they aren't, create a new rule to allow the connections. To learn how to create NSG rules, see [Create security rules](/azure/virtual-network/tutorial-filter-network-traffic?tabs=portal#create-security-rules).
   b.  Check whether the NSG settings of the Application Gateway subnet allow outbound public and private traffic, so that a connection can be made. Run the following command in Azure PowerShell:

   ```azurepowershell
           $vnet = Get-AzVirtualNetwork -Name "vnetName" -ResourceGroupName "rgName"
           Get-AzVirtualNetworkSubnetConfig -Name appGwSubnet -VirtualNetwork $vnet
   ```
   > [!NOTE]
   > Check the document page that's provided in step 3a to learn more about how to create NSG rules.

   c.  Check the user-defined route (UDR) settings of Application Gateway and the backend server's subnet for any routing anomalies. Make sure the UDR isn't directing the traffic away from the backend subnet. For example, check for routes to network virtual appliances or default routes being advertised to the Application Gateway subnet using Azure ExpressRoute and a virtual private network (VPN).
   d.  To check the effective routes and rules for a network adapter, run the following command in Azure PowerShell:

   ```azurepowershell
           Get-AzEffectiveNetworkSecurityGroup -NetworkInterfaceName "nic1" -ResourceGroupName "testrg"
           Get-AzEffectiveRouteTable -NetworkInterfaceName "nic1" -ResourceGroupName "testrg"
   ```

1. If you don't find any issues with NSG or UDR, check your backend server for application-related issues that are preventing clients from establishing a TCP session on the ports configured. Do the following:
   a.  Open a command prompt (Win+R -> cmd), enter **netstat**, and select Enter.
   b.  Check whether the server is listening on the configured port. For example:

   ```
           Proto Local Address Foreign Address State PID
           TCP 0.0.0.0:80 0.0.0.0:0 LISTENING 4
   ```

   c.  If it's not listening on the configured port, check your web server settings. For example,
   site bindings in Internet Information Services (IIS), server block in NGINX, and virtual host in Apache.
   d.  Check your OS firewall settings to make sure that incoming traffic to the port is allowed.

### HTTP status code mismatch

#### Message

"Status code of the backend's HTTP response did not match the probe setting. Expected:{HTTPStatusCode0} Received:{HTTPStatusCode1}."

#### Cause

After Application Gateway establishes the TCP connection and completes the TLS handshake (if TLS is enabled), it sends the probe as an `HTTP GET` request to the backend server. As described earlier, the default probe is set to `<protocol>://127.0.0.1:<port>/`, and it considers response status codes in the range 200 through 399 as **Healthy**. If the server returns any other status code, Application Gateway marks the server as **Unhealthy** and returns this message.

#### Solution

Depending on the backend server's response code, use the appropriate guidance in the following table:

| **Error** | **Actions** |
| --- | --- |
| Probe status code mismatch: Received 401 | Check whether the backend server requires authentication. Application Gateway probes can't pass credentials for authentication. Either allow "HTTP 401" in a probe status code match or probe to a path where the server doesn't require authentication. |
| Probe status code mismatch: Received 403 | Access forbidden. Check whether access to the path is allowed on the backend server. |
| Probe status code mismatch: Received 404 | Page not found. Check whether the host name path is accessible on the backend server. Change the host name or path parameter to an accessible value. |
| Probe status code mismatch: Received 405 | The probe requests for Application Gateway use the HTTP GET method. Check whether your server allows this method. |
| Probe status code mismatch: Received 500 | Internal server error. Check the backend server's health and whether the services are running. |
| Probe status code mismatch: Received 503 | Service unavailable. Check the backend server's health and whether the services are running. |

If you think the response is legitimate and you want Application Gateway to accept other status codes as **Healthy**, create a custom probe. This approach is useful in situations where the backend website needs authentication. Because the probe requests don't carry any user credentials, they fail, and the backend server returns an `HTTP 401` status code.

To create a custom probe, see [Create a custom probe for Application Gateway by using the portal](/azure/application-gateway/application-gateway-create-probe-portal).

### HTTP response body mismatch

#### Message

"Body of the backend's HTTP response did not match the probe setting. Received response body doesn't contain {string}."

#### Cause

When you create a custom probe, you can mark a backend server as **Healthy** by matching a string from the response body. For example, you can configure Application Gateway to accept "unauthorized" as a string to match. If the backend server response for the probe request contains the string **unauthorized**, it marks the server as Healthy. Otherwise, it marks the server as **Unhealthy** with this message.

#### Solution

To resolve this issue, follow these steps:

1. Access the backend server locally or from a client machine on the probe path, and check the response body.
1. Verify that the response body in the Application Gateway custom probe configuration matches what you configured.
1. If they don't match, change the probe configuration so that it has the correct string value to accept.

For more information, see [Application Gateway probe matching](/azure/application-gateway/application-gateway-probe-overview#probe-matching).

> [!NOTE]
> For all TLS related error messages, to learn more about Server Name Indication (SNI) behavior and differences between the v1 and v2 SKUs, see [TLS overview](/azure/application-gateway/ssl-overview).

### Common Name (CN) doesn't match

#### Message

**v2**

"The Common Name of the leaf certificate presented by the backend server does not match the Probe or Backend Setting hostname of the application gateway."

**v1**

"The Common Name (CN) of the backend certificate doesn't match."

#### Cause

**v2** 

This error occurs when you select the HTTPS protocol in the backend setting, and the custom probe and backend setting hostname (in that order) don't match the common name (CN) of the backend server's certificate.

**v1**

The FQDN of the backend pool target doesn't match the CN of the backend server's certificate.

#### Solution

The hostname information is critical for backend HTTPS connection since that value is used to set the SNI during a TLS handshake. To resolve this error, use the following guidance based on your gateway's configuration.

**v2**

- If you're using a default probe, specify a hostname in the associated backend setting of your application gateway. Select either **Override with specific hostname** or **Pick hostname from backend target** in the backend settings.
- If you're using a custom probe, use the **host** field to specify the CN of the backend server certificate. Alternatively, if the backend setting is already configured with the same hostname, choose **Pick hostname from backend setting** in the probe settings.

**v1**

Verify the backend pool target's FQDN is the same as the CN.

> [!NOTE]
> For HTTPS backends, don't set the custom probe or backend setting hostname to an IP address. The SNI extension ([RFC 6066](https://www.rfc-editor.org/rfc/rfc6066)) doesn't permit literal IP addresses, so the application gateway sends no SNI and the backend can't select the matching certificate. Use the FQDN that matches the certificate's CN or system area network (SAN). 
> If a V2 gateway's backend is reachable only by IP address, use the [backend HTTPS validation settings](/azure/application-gateway/configuration-http-settings?tabs=backendhttpsettings#backend-https-validation-settings) to set a specific SNI or to skip subject name validation, or use the [hostName override](/azure/application-gateway/configuration-http-settings?tabs=backendhttpsettings#host-name-override) property to replace the forwarded host header with a value that matches the certificate's CN. 
> In the V1 SKU, the probe **Host** value serves only as the host header. SNI comes from the backend pool FQDN. For the full comparison, see [SNI differences in the v1 and v2 SKU](/azure/application-gateway/ssl-overview#sni-differences-in-the-v1-and-v2-sku).

To determine the CN of the backend server certificate, use any of following methods. Be aware that if a SAN exists the SNI verification is done only against that field (see [**RFC 6125**](https://www.rfc-editor.org/rfc/rfc6125#section-6.4.4) for more information). The common name field is matched if there's no SAN in the certificate.

**For browser or client**

Access the backend server directly and not through Application Gateway. In the **Issued To** section of the certificate details, select the certificate padlock icon in the address bar. You can then see the CN of the certificate.

:::image type="content" source="./media/application-gateway-backend-health-troubleshooting/browser-cert.png" alt-text="Screenshot of certificate details in a browser." lightbox="./media/application-gateway-backend-health-troubleshooting/browser-cert.png":::

**For backend server (Windows)**

   1. Sign in to the machine where your application is hosted.
   1. Select Win+R or right-click **Start**, and then select **Run**.
   1. Enter `certlm.msc` and select **Enter**. You can also search for **Certificate Manager** on the **Start** menu.
   1. Locate the certificate (usually in the Certificates folder at Local Computer\Personal\Certificates), and open the certificate.
   1. On the **Details** tab, check the certificate **Subject**.

**For backend server (Linux)**

Run this OpenSSL command and specify the correct certificate filename `certificate.crt` as shown in the following example:

```bash
openssl x509 -in certificate.crt -subject -noout
```

### Backend certificate expired

#### Message 

"Backend certificate is invalid. Current date isn't within the "Valid from" and "Valid to" date range on the certificate."

#### Cause

An expired certificate is unsafe. Therefore, the application gateway marks the backend server with an expired certificate as **Unhealthy**.

#### Solution

Use the following guidance based on which part of the certificate chain expired on the backend server.

**v2**

- **Expired leaf (also known as domain or server) certificate** – Renew the server certificate with the certificate provider and install the new certificate on the backend server. Ensure that you install the complete certificate chain comprised of `Leaf (topmost) > Intermediate(s) > Root`. Based on the type of Certificate Authority (CA), use the following guidance:
  - **Publicly known CA** - If the certificate issuer is a well-known CA, you don't need to take any action on the application gateway.
  - **Private CA** - If the leaf certificate is issued by a private CA, check if the signing root CA certificate changed. In this case, upload the new root CA certificate to the associated backend setting of your application gateway.

- **Expired intermediate or root certificate** – These certificates usually have extended validity periods (a decade or two). When root or intermediate certificates expire, check with your certificate provider for the renewed certificate files. Ensure you install this updated and complete certificate chain comprising `Leaf (topmost) > Intermediate(s) > Root` on the backend server. Use the following guidance based on your situation:
  - If the root certificate remains unchanged or if the issuer is a well-known CA, you don't need to take any action on the application gateway. 
  - When using a private CA, if the root CA certificate itself or the root of the renewed intermediate certificate changed, upload the new root certificate to the application gateway's backend setting.

**v1**

Renew the expired leaf certificate with your CA and upload the same leaf certificate to the associated backend setting of your application gateway. 

### The intermediate certificate wasn't found

#### Message 

"The **Intermediate certificate is missing** from the certificate chain presented by the backend server. Ensure the certificate chain is complete and correctly ordered on the backend server."

#### Cause

The backend server doesn't have the intermediate certificates installed in the certificate chain.

#### Solution

An intermediate certificate signs the leaf certificate and is needed to complete the chain. Check with your CA for the necessary intermediate certificates and install them on your backend server. This chain must start with the leaf certificate, then the intermediate certificate, and finally the root CA certificate. Install the complete chain on the backend server, including the root CA certificate. For reference, see the certificate chain example in the [Leaf must be topmost in chain](#leaf-must-be-topmost-in-chain) section.

> [!NOTE] 
> A self-signed certificate that isn't a CA can also cause this error. Application Gateway treats this self-signed certificate as a leaf certificate and looks for its signing intermediate certificate. To learn more, see [generate a self-signed certificate](/azure/application-gateway/self-signed-certificates).

The following illustration shows the difference between the self-signed certificates.

:::image type="content" source="./media/application-gateway-backend-health-troubleshooting/self-signed-types.png" alt-text="Screenshot showing difference between self-signed certificates." lightbox="./media/application-gateway-backend-health-troubleshooting/self-signed-types.png":::

### The leaf or server certificate wasn't found

#### Message

"The **Leaf certificate is missing** from the certificate chain presented by the backend server. Ensure the chain is complete and correctly ordered on the backend server."

#### Cause

The backend server's certificate chain is missing the leaf certificate.

#### Solution

Get the leaf certificate from your CA. Install this leaf certificate and all its signing certificates (intermediate and root CA certificates) on the backend server. This chain must start with the leaf certificate, then the intermediate certificate, and finally the root CA certificate. For reference, see the certificate chain example in the [Leaf must be topmost in chain](#leaf-must-be-topmost-in-chain) section.

### Server certificate isn't issued by a publicly known CA

#### Message 

"The backend **Server certificate** isn't signed by a well-known Certificate Authority (CA). To use unknown CA certificates, its Root certificate must be uploaded to the Backend Setting of the application gateway."

#### Cause

You selected the **well-known CA certificate** option in the backend settings, but the backend server presents a root certificate that isn't publicly known. 

#### Solution

When a private CA issues a leaf certificate, you must upload the signing root CA certificate to the application gateway associated backend setting. This configuration enables your application gateway to establish a trusted connection with that backend server. 

Go to the associated backend setting, choose **not a well-known CA**, and then upload the root CA certificate. To identify and download the root certificate, see [Trusted root certificate mismatch](/azure/application-gateway/application-gateway-backend-health-troubleshooting#trusted-root-certificate-mismatch-root-certificate-is-available-on-the-backend-server).

### The intermediate certificate isn't signed by a publicly known CA

#### Message

 "The **Intermediate certificate** isn't signed by a well-known Certificate Authority (CA). Ensure the certificate chain is complete and correctly ordered on the backend server."

#### Cause

You selected the **well-known CA certificate** option in the backend settings, but the intermediate certificate that the backend server presents isn't signed by any publicly known CA.

#### Solution

When a private CA issues a certificate, you must upload the signing root CA certificate to the application gateway associated backend setting. This step enables your application gateway to establish a trusted connection with that backend server. 

To complete this step, contact your private CA to get the appropriate root CA certificate, go to the associated backend setting, choose **not a well-known CA**, and then upload the root CA certificate. Install the complete chain on the backend server, including the root CA certificate, for easy verification.

### Trusted root certificate mismatch (no root certificate on the backend server)

#### Message

 "The intermediate certificate not signed by any root certificates uploaded to the application gateway. Ensure the certificate chain is complete and correctly ordered on the backend server."

#### Cause

None of the root CA certificates that you uploaded to the associated backend setting signed the intermediate certificate that you installed on the backend server. The backend server has only leaf and intermediate certificates installed.

#### Solution

When you use a certificate from a private CA, upload the corresponding root CA certificate to the application gateway. Contact your private CA to get the appropriate root CA certificate, and then upload that file to the backend setting of your application gateway. 

### Trusted root certificate mismatch (root certificate is available on the backend server)

#### Message

The root certificate of the server certificate used by the backend doesn't match the trusted root certificate added to the application gateway. Ensure that you add the correct root certificate to the allowlist for the backend.

#### Cause

This error occurs when none of the root certificates uploaded to the application gateway's backend setting matches the root certificate present on the backend server. 

#### Solution

This error applies to a backend server certificate issued by a private CA or the certificate is self-signed. Identify and upload the right root CA certificate to the associated backend setting. 

To identify and download the root certificate, use the following methods as appropriate.

**For browser** 

Access the backend server directly and not through Application Gateway. Select the certificate padlock icon in the address bar to view the certificate details. 

To identify and download the root certificate, follow these steps:

1. Choose the root certificate in the chain, and then select **Export**. By default, this certificate is a .crt file. 
1. Open the .crt file.
1. Go to the **Details** tab, and then select **Copy to File**.
1. On the **Certificate Export Wizard** page, select **Next**.
1. Select **Base-64 encoded X.509 (.CER)**, and then select **Next**.
1. Provide a new file name, and then select **Next**.
1. Select **Finish**. 
1. Upload the new root .cer file to the application gateway's backend setting.

**For backend server (Windows)**

To identify and download the root certificate, follow these steps:

1. Sign in to the machine where your application is hosted.
1. Select Win+R or right-click **Start**, and then select **Run**.
1. Enter **certlm.msc** and select Enter. You can also search for **Certificate Manager** on the **Start** menu.
1. Locate the certificate (usually in the Certificates folder at Local Computer\Personal\Certificates), and open the certificate.
1. Select the root certificate, and then select **View Certificate**.
1. In the certificate properties, select the **Details** tab, and then select **Copy to File**.
1. On the **Certificate Export Wizard** page, select **Next**.
1. Select **Base-64 encoded X.509 (.CER)**, and then select **Next**.
1. Provide a new file name, and then select **Next**.
1. Select **Finish**. 
1. Upload the new root .cer file to the application gateway's backend setting.

### Leaf must be topmost in chain

#### Message

"The Leaf certificate isn't the topmost certificate in the chain presented by the backend server. Ensure the certificate chain is correctly ordered on the backend server."

#### Cause

The backend server doesn't have the leaf certificate installed in the correct order.

#### Solution

The certificate installation on the backend server must include an ordered list of certificates that includes the leaf certificate and all its signing certificates (intermediate and root CA certificates). This chain must start with the leaf certificate, then the intermediate certificates, and finally the root CA certificate. Install the complete chain on the backend server. 

The following example shows a server certificate installation along with its intermediate and root CA certificates, denoted as depths (0, 1, 2, and so on) in OpenSSL. You can verify the same for your backend server's certificate by using the following OpenSSL commands.

`s_client -connect <FQDN>:443 -showcerts`</br> 
OR </br>
`s_client -connect <IPaddress>:443 -servername <TLS SNI hostname> -showcerts`

:::image type="content" source="./media/application-gateway-backend-health-troubleshooting/cert-chain.png" alt-text="Screenshot showing typical chain of certificates." lightbox="./media/application-gateway-backend-health-troubleshooting/cert-chain.png":::

### Certificate verification failed

#### Message

"The validity of the backend certificate could not be verified. To find out the reason, check OpenSSL diagnostics for the message associated with error code {errorCode}"

#### Cause

This error occurs when Application Gateway can't verify the validity of the certificate.

#### Solution

To resolve this issue, verify that the certificate on your server was created properly. For example, you can use [OpenSSL](https://www.openssl.org/docs/manmaster/man1/verify.html) to verify the certificate and its properties. Then, try reuploading the certificate to the Application Gateway HTTP settings.

### Proxy protocol unsupported

#### Message

"Verify that the backend server is set up to accept the Proxy protocol header sent by the probes."

#### Cause

This error occurs only with the TLS protocol backend settings for which client IP preservation is enabled. In this mode, Application Gateway sends a Proxy protocol header before initiating the TLS handshake with the backend for probes. If the backend server isn't configured to parse such a header, the health probe fails and Application Gateway marks it as **Unhealthy**.

#### Solution

Ensure the backend server is configured to parse the Proxy protocol header on the appropriate port, in accordance with [Proxy protocol specifications](https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt), when using it with Application Gateway.

## Backend health status: Unknown

### Error message - Updates to the DNS entries of the backend pool

#### Message

"The backend health status could not be retrieved. This happens when an NSG/UDR/Firewall on the application gateway subnet is blocking traffic on ports 65503-65534 in case of v1 SKU, and ports 65200-65535 in case of the v2 SKU or if the FQDN configured in the backend pool could not be resolved to an IP address. To learn more visit - https://aka.ms/UnknownBackendHealth."

#### Cause

For FQDN-based backend targets, Application Gateway caches and uses the last-known-good IP address if it doesn't get a response for the next DNS lookup. A `Put` operation on a gateway in this state clears its DNS cache. As a result, there's no destination address the gateway can reach.

#### Solution

Check and fix the DNS servers to ensure they serve a response for the given FQDN's DNS lookup. Also, check if your application gateway's virtual network can reach the DNS servers.

### Other reasons

If the backend health is **Unknown**, the portal view resembles the following screenshot:

:::image type="content" source="./media/application-gateway-backend-health-troubleshooting/appgwunknown.png" alt-text="Screenshot of Application Gateway backend health - Unknown." lightbox="./media/application-gateway-backend-health-troubleshooting/appgwunknown.png":::

This behavior can occur for one or more of the following reasons:

- The NSG on the Application Gateway subnet blocks inbound access to ports 65503-65534 (v1) or 65200-65535 (v2) from the internet.
- The UDR on the Application Gateway subnet is set to the default route (0.0.0.0/0) and the next hop isn't specified as **Internet**.
- The default route is directed by an Azure ExpressRoute or AzureVPN connection to a virtual network over Border Gateway Protocol (BGP).
- The custom DNS server is configured on a virtual network that can't resolve public domain names.
- Application Gateway is in an **Unhealthy** state.

**Solution:**

To resolve this problem, follow these steps:

1. Check whether your NSG blocks access to the ports 65503-65534 (v1) or 65200-65535 (v2) from the internet.
   a. On the Application Gateway **Overview** tab, select the **Virtual Network/Subnet** link.
   b. On the **Subnets** tab of your virtual network, select the subnet where Application Gateway is deployed.
   c. Check whether any NSG is configured.
   d. If an NSG is configured, search for that NSG resource on the **Search** tab or under **All resources**.
   e. In the **Inbound Rules** section, add an inbound rule to allow destination port range 65503-65534 for v1 or 65200-65535 v2 with the **Source** set as **GatewayManager** for the service tag.
   f. Select **Save** and verify that you can view the backend as **Healthy**. Alternatively, you can do that through [PowerShell/CLI](/azure/virtual-network/manage-network-security-group?tabs=network-security-group-portal).

1. Check whether your UDR has a default route (0.0.0.0/0) with the next hop not set as **Internet**.
   a. Follow steps 1a and 1b to determine your subnet.
   b. Check if a UDR is configured. If configured, search for the resource on the search bar or in **All resources**.
   c. Check if there are any default routes (0.0.0.0/0) with the next hop not set as **Internet**. If the setting is either **Virtual Appliance** or **Virtual Network Gateway**, ensure that your virtual appliance (or the on-premises device) can properly route the packet back to the internet destination without modifying the packet. If probes are routed through a virtual appliance and modified, the backend resource displays a **200** status code and the Application Gateway health status can display as **Unknown**. This condition doesn't indicate an error. Traffic should still route through the Application Gateway without issue.
   d. Change the next hop to **Internet**, select **Save**, and then verify the backend health.

1. Check the default route directed by the ExpressRoute or Azure VPN connection to the virtual network over BGP.
   a. If you have an ExpressRoute or Azure VPN connection to the virtual network over BGP, and if it's directing a default route, ensure that the packet is routed back to the internet destination without modifying it. You can verify this condition by using the **Connection Troubleshoot** option in the Application Gateway portal.
   b. Choose the destination manually as any internet-routable IP address (like 1.1.1.1). Set the destination port as anything, and verify the connectivity.
   c. If the next hop is virtual network gateway, there might be a default route directed by ExpressRoute or AzureVPN.

1. If there's a custom DNS server configured on the virtual network, verify that the servers can resolve public domains. Public domain name resolution might be required in scenarios where Application Gateway must reach out to external domains like Online Certificate Status Protocol (OCSP) servers or to check the certificate's revocation status.
1. To verify that Application Gateway is healthy and running, in the portal, go to the **Resource Health** option, and then verify that the state is **Healthy**. If you see an **Unhealthy** or **Degraded** state, contact Azure support.
1. If internet and private traffic are going through an Azure Firewall hosted in a secured virtual hub (using Azure Virtual WAN hub), do the following steps:
   a. Ensure the application gateway can send traffic directly to the internet and configure the following user defined route:

   **Address prefix**: 0.0.0.0/0<br>
   **Next hop**: Internet

   b. Ensure the application gateway can send traffic to the backend pool through an Azure Firewall in the Virtual WAN hub and configure the following user defined route:

   **Address prefix**: Backend pool subnet<br>
   **Next hop**: Azure Firewall private IP address

   c. If the route is correct but the backend health is still Unknown or Unhealthy, Azure Firewall's rules might deny the probe traffic.

> [!NOTE]
> If the application gateway can't access the Certificate Revocation List (CRL) endpoints, it might mark the backend health status as **Unknown**. To prevent these issues, check that your application gateway subnet can access `crl.microsoft.com` and `crl3.digicert.com`. You can do this by configuring your NSGs to send traffic to the CRL endpoints. 

## References

- [Application Gateway backend health diagnostics and logging](/azure/application-gateway/application-gateway-backend-health).
- [Troubleshoot outbound connections](/azure/network-watcher/connection-troubleshoot-manage) 
- [Azure Network Watcher Connection Troubleshoot](/azure/network-watcher/connection-troubleshoot-manage)
