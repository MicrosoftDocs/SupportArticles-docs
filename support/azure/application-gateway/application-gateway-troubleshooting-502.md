---
title: Troubleshoot bad gateway (502) errors - Azure Application Gateway
description: Troubleshoot Azure Application Gateway 502 Bad Gateway errors and restore backend connectivity quickly. Follow this guide to identify and fix root causes.
services: application-gateway
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 08/28/2026
ms.custom: 
   - sap:Facing 5xx errors,devx-track-azurepowershell
   - sap:backend health
# Customer intent: As an IT administrator troubleshooting application performance, I want to identify and fix 502 Bad Gateway errors in the application gateway, so that I can ensure reliable access and functionality of web applications for users.
---

# Troubleshoot bad gateway (502) errors in Azure Application Gateway

## Summary

Learn how to troubleshoot bad gateway (502) errors in Azure Application Gateway so you can quickly restore reliable access to your web apps.

> [!NOTE]
> Use the Azure Az PowerShell module to interact with Azure. To get started, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell). To learn how to migrate to the Az PowerShell module, see [Migrate Azure PowerShell from AzureRM to Az](/powershell/azure/migrate-from-azurerm-to-az).

## Symptoms

After you configure an application gateway, you might see the error "Server Error: 502 - Web server received an invalid response while acting as a gateway or proxy server". This error can happen for the following reasons:

- [Network security group (NSG), user-defined route (UDR), or custom Domain Name System (DNS) issue](/azure/application-gateway/application-gateway-troubleshooting-502#network-security-group-user-defined-route-or-custom-dns-issue)
- [Default health probe can't reach backend VMs](#default-health-probe-cant-reach-backend-vms)
- [Backend request time-out is exceeded](#backend-request-time-out-is-exceeded)
- [Application gateway's backend pool isn't configured or is empty](#application-gateways-backend-pool-isnt-configured-or-is-empty)
- [Unhealthy instances in BackendAddressPool](#unhealthy-instances-in-backendaddresspool)
- [Upstream SSL certificate doesn't match](#upstream-ssl-certificate-doesnt-match)

## Network security group, user-defined route, or custom DNS issue

### Cause

If an NSG, UDR, or custom DNS blocks access to the backend, application gateway instances can't reach the backend pool. This issue causes probe failures, resulting in 502 errors.

You might have an NSG or UDR in either the application gateway subnet or the subnet where the application virtual machines (VMs) are deployed.

Similarly, the presence of a custom DNS in the virtual network (VNet) can also cause problems. The user-configured DNS server for the VNet might not correctly resolve a fully qualified domain name (FQDN) used for backend pool members.

### Solution

Validate your NSG, UDR, and DNS configurations.
To do so, follow these steps:

1. Check the NSGs associated with the application gateway subnet. Ensure that communication to the backend isn't blocked. For more information, see [Network security groups](/azure/application-gateway/configuration-infrastructure#network-security-groups).
1. Check the UDR associated with the application gateway subnet. Ensure that the UDR isn't directing traffic away from the backend subnet. For example, check for routing to network virtual appliances or default routes being advertised to the application gateway subnet by using Azure ExpressRoute or Azure VPN. Run the following commands in Azure PowerShell.

    ```azurepowershell
    $vnet = Get-AzVirtualNetwork -Name vnetName -ResourceGroupName rgName
    Get-AzVirtualNetworkSubnetConfig -Name appGwSubnet -VirtualNetwork $vnet
    ```

1. Check for effective NSGs and routes with the backend VM. Run the following commands in Azure PowerShell.

    ```azurepowershell
    Get-AzEffectiveNetworkSecurityGroup -NetworkInterfaceName nic1 -ResourceGroupName testrg
    Get-AzEffectiveRouteTable -NetworkInterfaceName nic1 -ResourceGroupName testrg
    ```

1. Check for the presence of custom DNS in the VNet. Check DNS by looking at the details of the VNet properties in the output.

    ```json
    Get-AzVirtualNetwork -Name vnetName -ResourceGroupName rgName 
    DhcpOptions            : {
                               "DnsServers": [
                                 "x.x.x.x"
                               ]
                             }
    ```

1. If present, ensure that the DNS server can resolve the backend pool member's FQDN correctly.

## Default health probe can't reach backend VMs

### Cause

A 502 error can also indicate that the default health probe can't reach backend VMs.

When you provision an application gateway instance, it automatically configures a default health probe to each `BackendAddressPool` by using properties of the `BackendHttpSetting`. 

You don't need to provide any input to set this probe. Specifically, when you configure a load-balancing rule, you associate a `BackendHttpSetting` with a `BackendAddressPool`. Each of these associations has a default probe configured, and the application gateway starts a periodic health check connection to each instance in the `BackendAddressPool` at the port specified in the `BackendHttpSetting` element. 

The following table lists the values associated with the default health probe.

| Probe property | Value | Description |
| --- | --- | --- |
| Probe URL |`http://127.0.0.1/` |URL path |
| Interval |30 |Probe interval in seconds |
| Time-out |30 |Probe time-out in seconds |
| Unhealthy threshold |3 |Probe retry count. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

### Solution

Use the following guidance to troubleshoot the default health probe.

- The host value of the request is set to 127.0.0.1. Ensure that a default site is configured and is listening at 127.0.0.1.
- The `BackendHttpSetting` protocol determines the protocol of the request.
- The URI Path is set to `/*`.
- If `BackendHttpSetting` specifies a port other than 80, configure the default site to listen at that port.
- The call to `protocol://127.0.0.1:port` should return an HTTP result code of 200. This code should be returned within the 30-second timeout period.
- Ensure the configured port is open and there are no firewall rules or Azure NSGs blocking incoming or outgoing traffic on the port configured.
- If you use Azure classic VMs or Cloud Service with an FQDN or a public IP, ensure that you open the corresponding [endpoint](/previous-versions/azure/virtual-machines/windows/classic/setup-endpoints).
- If you configure the VM using Azure Resource Manager (ARM) and it's outside the VNet where the application gateway is deployed, configure a [NSG](/azure/virtual-network/network-security-groups-overview) to allow access on the desired port.

For more information, see [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure).

## Invalid or improper configuration of custom health probes

### Cause

Custom health probes give you more flexibility than the default probing behavior. When you use custom probes, you can set the probe interval, the URL, the path to test, and how many failed responses to accept before marking the backend pool instance as unhealthy.

The following table describes the additional properties you can set.

| Probe property | Description |
| --- | --- |
| Name |Name of the probe. Use this name to refer to the probe in backend HTTP settings. |
| Protocol |Protocol used to send the probe. The probe uses the protocol defined in the backend HTTP settings. |
| Host |Host name to send the probe to. This host name is different from the VM host name. In the v1 SKU, Application Gateway uses this value only as the host header of the probe request. In the v2 SKU, it uses the value as both the host header and the Server Name Indication (SNI) value. |
| Path |Relative path of the probe. The valid path starts from '/'. The probe is sent to \<protocol\>://\<host\>:\<port\>\<path\>. |
| Interval |Probe interval in seconds. This value sets the time interval between two consecutive probes. |
| Time-out |Probe time-out in seconds. If a valid response isn't received within this time-out period, the probe is marked as failed. |
| Unhealthy threshold | Probe retry count. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

### Solution

Validate that you configured the custom health probe correctly, as shown in the preceding table. In addition to the preceding troubleshooting guidance, follow this guidance as well.

- Ensure that you specify the probe correctly as per the [guide](/azure/application-gateway/application-gateway-create-probe-ps).
- If you configure the application gateway for a single site, specify the default host name as `127.0.0.1`, unless you configure this otherwise in the custom probe.
- Ensure that a call to `http://<host>:<port><path>` returns an HTTP result code of 200.
- Ensure that `Interval`, `Timeout`, and `UnhealthyThreshold` values are within the acceptable ranges.
- If you use an HTTPS probe in the v2 SKU, Application Gateway also sends the probe host name as the SNI value. Make sure that the host name matches the backend certificate's subject alternative name (SAN), or its common name (CN) if the certificate has no SAN, as described in [RFC 6125](https://www.rfc-editor.org/rfc/rfc6125#section-6.4.4). Application Gateway doesn't send SNI when the host name is an IP address, including the default `127.0.0.1`. For steps to compare the probe host name against the certificate, see [Resolution F in Troubleshoot HTTP 502 errors in Azure Application Gateway](troubleshoot-http-502-bad-gateway.md#resolution-f). If you can't change the backend certificate, adjust the [backend HTTPS validation settings](/azure/application-gateway/configuration-http-settings#backend-https-validation-settings) to use a specific SNI value or to skip subject name validation.

## Backend request time-out is exceeded

### Cause

When the application gateway receives a user request, it applies the configured rules to the request and routes it to a backend pool instance. It waits for a configurable interval of time for a response from the backend instance. By default, this interval is 20 seconds. In Application Gateway v1, if the application gateway doesn't receive a response from the backend application within this interval, the user request gets a 502 error. In Application Gateway v2, if the application gateway doesn't receive a response from the backend application within this interval, the request is tried against a second backend pool member. If the second request also fails, the user request gets a 504 error instead. If users receive 504 errors instead of 502 errors, see [Troubleshoot HTTP 504 errors in Azure Application Gateway](troubleshoot-http-504-gateway-timeout.md).

If your backend application routinely takes longer than the configured interval to respond (for example, a long-running query or report), increase the request time-out on the backend HTTP setting used by that backend pool.

### Solution

The request time-out is a property of the backend HTTP setting, so different backend pools can have different request time-out values. Increase it by using the Azure portal, Azure CLI, or Azure PowerShell. The accepted range is 1 to 86400 seconds. For more information, see [Request timeout](/azure/application-gateway/configuration-http-settings#request-timeout).

#### Azure portal

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to your application gateway.
1. Under **Settings**, select **Backend settings**.
1. Select the backend setting used by the affected backend pool.
1. Increase the **Request time-out (seconds)** value to allow more time for the backend to respond.
1. Select **Save**.

#### Azure CLI

Run the following command in Azure CLI:

```azurecli
az network application-gateway http-settings update \
  --gateway-name <application-gateway-name> \
  --resource-group <resource-group-name> \
  --name <backend-http-settings-name> \
  --timeout <time-out-in-seconds>
```

#### Azure PowerShell

Run the following command in Azure PowerShell:

```azurepowershell
New-AzApplicationGatewayBackendHttpSettings -Name 'Setting01' -Port 80 -Protocol Http -CookieBasedAffinity Enabled -RequestTimeout 60
```

> [!NOTE]
> Increasing the request time-out only masks the symptom if the backend is slow because of an underlying issue, such as high CPU or memory pressure, database contention, or an inefficient query. Also investigate the backend application's response time before raising the time-out value.

## Application gateway's backend pool isn't configured or is empty

### Cause

If the application gateway has no VMs or virtual machine scale set configured in the backend address pool, it can't route any customer request and sends a bad gateway error.

### Solution

Ensure that the backend address pool isn't empty. You can check this condition through Azure PowerShell, Azure CLI, or the portal.
See the following example to check the backend address pool through Azure PowerShell.

```azurepowershell
Get-AzApplicationGateway -Name "SampleGateway" -ResourceGroupName "ExampleResourceGroup"
```

The output from the preceding cmdlet should contain a nonempty backend address pool. The following example shows two returned pools that are configured with an FQDN or IP addresses for the backend VMs. The provisioning state of the `BackendAddressPool` must be `Succeeded`.

```json
[{
    "BackendAddresses": [{
        "ipAddress": "10.0.0.10",
        "ipAddress": "10.0.0.11"
    }],
    "BackendIpConfigurations": [],
    "ProvisioningState": "Succeeded",
    "Name": "Pool01",
    "Etag": "W/\"00000000-0000-0000-0000-000000000000\"",
    "Id": "/subscriptions/<subscription id>/resourceGroups/<resource group name>/providers/Microsoft.Network/applicationGateways/<application gateway name>/backendAddressPools/pool01"
}, {
    "BackendAddresses": [{
        "Fqdn": "xyx.cloudapp.net",
        "Fqdn": "abc.cloudapp.net"
    }],
    "BackendIpConfigurations": [],
    "ProvisioningState": "Succeeded",
    "Name": "Pool02",
    "Etag": "W/\"00000000-0000-0000-0000-000000000000\"",
    "Id": "/subscriptions/<subscription id>/resourceGroups/<resource group name>/providers/Microsoft.Network/applicationGateways/<application gateway name>/backendAddressPools/pool02"
}]
```

## Unhealthy instances in BackendAddressPool

### Cause

If all the instances of `BackendAddressPool` are unhealthy, the application gateway doesn't have any backend to route user requests to. This condition can also occur when backend instances are healthy but don't have the required application deployed.

### Solution

Ensure that the instances are healthy and the application is properly configured. Check if the backend instances can respond to a ping from another VM in the same virtual network. If you configure a public endpoint, ensure a browser request to the web application is serviceable.

## Upstream SSL certificate doesn't match

### Cause

The Transport Layer Security (TLS) certificate installed on backend servers doesn't match the hostname received in the HTTP host request header. 

In scenarios where end-to-end TLS is enabled, achieve the configuration by editing the appropriate **Backend HTTP** settings. Change the configuration of the **Backend protocol** setting to **HTTPS** where necessary. Ensure that the `DNS NAME` of the TLS certificate installed on backend servers matches the hostname coming to the backend in the HTTP host header request.

When you complete this step, the second part of the communication that happens with Application Gateway and the backend servers is encrypted with TLS.

By default, Application Gateway sends the same HTTP host header to the backend as it receives from the client. Ensure that the TLS certificate installed on the backend server is issued with a `DNS NAME` that matches the host name received by that backend server in the HTTP host header. This hostname should be the same as the one received from the client.

### Solution

For steps to align the probe host name and SNI with the certificate's SAN or CN, see [Resolution F in Troubleshoot HTTP 502 errors in Azure Application Gateway](troubleshoot-http-502-bad-gateway.md#resolution-f). For how the **Pick host name from backend target** and **Override with specific domain name** backend settings map to the certificate name that Application Gateway expects, see [Common Name (CN) doesn't match](application-gateway-backend-health-troubleshooting.md#common-name-cn-doesnt-match).
