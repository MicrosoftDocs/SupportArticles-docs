---
title: Troubleshoot Bad Gateway errors - Azure Application Gateway
description: Troubleshoot Azure Application Gateway 502 Bad Gateway errors and restore backend connectivity quickly. Follow this guide to identify and fix root causes.
services: application-gateway
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 03/27/2026
ms.custom: 
   - sap:Facing 5xx errors,devx-track-azurepowershell
   - sap:backend health
# Customer intent: As an IT administrator troubleshooting application performance, I want to identify and fix 502 Bad Gateway errors in the application gateway, so that I can ensure reliable access and functionality of web applications for users.
---

# Troubleshoot bad gateway (502) errors in Azure Application Gateway

## Summary

Learn how to troubleshoot bad gateway (502) errors in Azure Application Gateway so you can quickly restore reliable access to your web apps.

> [!NOTE]
> We recommend that you use the Azure Az PowerShell module to interact with Azure. To get started, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell). To learn how to migrate to the Az PowerShell module, see [Migrate Azure PowerShell from AzureRM to Az](/powershell/azure/migrate-from-azurerm-to-az).

## Symptoms

After you configure an application gateway, you might see the error **Server Error: 502 - Web server received an invalid response while acting as a gateway or proxy server**. This error can happen for the following reasons:

- [Network security group (NSG), user-defined route (UDR), or custom DNS issue](/azure/application-gateway/application-gateway-troubleshooting-502#network-security-group-user-defined-route-or-custom-dns-issue).
- [Default health probe can't reach backend VMs](/azure/application-gateway/application-gateway-troubleshooting-502#problems-with-custom-health-probe).
- [Request time-out or connectivity issues with user requests](#request-time-out-or-connectivity-issues-with-user-requests).
- [Application Gateway's backend pool isn't configured or empty](#application-gateways-backend-pool-isnt-configured-or-empty).
- [Unhealthy instances in BackendAddressPool](#unhealthy-instances-in-backendaddresspool).
- [Upstream SSL certificate doesn't match](#upstream-ssl-certificate-doesnt-match).

## Network security group, user-defined route, or custom DNS issue

### Cause

If an NSG, UDR, or custom DNS blocks access to the backend, application gateway instances can't reach the backend pool. This issue causes probe failures, resulting in 502 errors.

The NSG/UDR could be present either in the application gateway subnet or the subnet where the application VMs are deployed.

Similarly, the presence of a custom DNS in the VNet could also cause problems. An FQDN used for backend pool members might not resolve correctly by the user configured DNS server for the VNet.

### Solution

Validate NSG, UDR, and DNS configuration by going through the following steps:

1. Check NSGs associated with the application gateway subnet. Ensure that communication to backend isn't blocked. For more information, see [Network security groups](/azure/application-gateway/configuration-infrastructure#network-security-groups).
1. Check UDR associated with the application gateway subnet. Ensure that the UDR isn't directing traffic away from the backend subnet. For example, check for routing to network virtual appliances or default routes being advertised to the application gateway subnet via ExpressRoute/VPN.

    ```azurepowershell
    $vnet = Get-AzVirtualNetwork -Name vnetName -ResourceGroupName rgName
    Get-AzVirtualNetworkSubnetConfig -Name appGwSubnet -VirtualNetwork $vnet
    ```

1. Check effective NSG and route with the backend VM.

    ```azurepowershell
    Get-AzEffectiveNetworkSecurityGroup -NetworkInterfaceName nic1 -ResourceGroupName testrg
    Get-AzEffectiveRouteTable -NetworkInterfaceName nic1 -ResourceGroupName testrg
    ```

1. Check presence of custom DNS in the VNet. Check DNS by looking at details of the VNet properties in the output.

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

502 errors can also indicate that the default health probe can't reach backend VMs.

When you provision an application gateway instance, it automatically configures a default health probe to each BackendAddressPool by using properties of the BackendHttpSetting. You don't need to provide any input to set this probe. Specifically, when you configure a load-balancing rule, you associate a BackendHttpSetting with a BackendAddressPool. Each of these associations has a default probe configured, and the application gateway starts a periodic health check connection to each instance in the BackendAddressPool at the port specified in the BackendHttpSetting element. 

The following table lists the values associated with the default health probe:

| Probe property | Value | Description |
| --- | --- | --- |
| Probe URL |`http://127.0.0.1/` |URL path |
| Interval |30 |Probe interval in seconds |
| Time-out |30 |Probe time-out in seconds |
| Unhealthy threshold |3 |Probe retry count. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

### Solution

* The host value of the request is set to 127.0.0.1. Ensure that a default site is configured and is listening at 127.0.0.1.
* The BackendHttpSetting protocol determines the protocol of the request.
* The URI Path is set to `/*`.
* If BackendHttpSetting specifies a port other than 80, configure the default site to listen at that port.
* The call to `protocol://127.0.0.1:port` should return an HTTP result code of 200. This code should be returned within the 30-second timeout period.
* Ensure the configured port is open and there are no firewall rules or Azure Network Security Groups blocking incoming or outgoing traffic on the port configured.
* If you use Azure classic VMs or Cloud Service with an FQDN or a public IP, ensure that you open the corresponding [endpoint](/previous-versions/azure/virtual-machines/windows/classic/setup-endpoints).
* If you configure the VM via Azure Resource Manager and it's outside the VNet where the application gateway is deployed, you must configure a [Network Security Group](/azure/virtual-network/network-security-groups-overview) to allow access on the desired port.

For more information, see [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure).

## Invalid or improper configuration of custom health probes

### Cause

Custom health probes give you more flexibility than the default probing behavior. When you use custom probes, you can set the probe interval, the URL, the path to test, and how many failed responses to accept before marking the backend pool instance as unhealthy.

The following table describes the additional properties you can set:

| Probe property | Description |
| --- | --- |
| Name |Name of the probe. Use this name to refer to the probe in backend HTTP settings. |
| Protocol |Protocol used to send the probe. The probe uses the protocol defined in the backend HTTP settings. |
| Host |Host name to send the probe. This property applies only when you configure multi-site on the application gateway. This host name is different from the VM host name. |
| Path |Relative path of the probe. The valid path starts from '/'. The probe is sent to \<protocol\>://\<host\>:\<port\>\<path\>. |
| Interval |Probe interval in seconds. This value sets the time interval between two consecutive probes. |
| Time-out |Probe time-out in seconds. If a valid response isn't received within this time-out period, the probe is marked as failed. |
| Unhealthy threshold |Probe retry count. The backend server is marked down after the consecutive probe failure count reaches the unhealthy threshold. |

### Solution

Validate that you configured the custom health probe correctly, as shown in the preceding table. In addition to the preceding troubleshooting steps, also ensure the following steps:

* Ensure that you specify the probe correctly as per the [guide](/azure/application-gateway/application-gateway-create-probe-ps).
* If you configure the application gateway for a single site, specify the default Host name as `127.0.0.1`, unless you configure otherwise in the custom probe.
* Ensure that a call to `http://<host>:<port><path>` returns an HTTP result code of 200.
* Ensure that Interval, Timeout, and UnhealthyThreshold values are within the acceptable ranges.
* If you use an HTTPS probe, make sure that the backend server doesn't require SNI by configuring a fallback certificate on the backend server itself.

## Request time-out or connectivity issues with user requests

### Cause

When the application gateway receives a user request, it applies the configured rules to the request and routes it to a backend pool instance. It waits for a configurable interval of time for a response from the backend instance. By default, this interval is 20 seconds. In Application Gateway v1, if the application gateway doesn't receive a response from the backend application in this interval, the user request gets a 502 error. In Application Gateway v2, if the application gateway doesn't receive a response from the backend application in this interval, the request is tried against a second backend pool member. If the second request fails, the user request gets a 504 error.

### Solution

You can configure this setting through the BackendHttpSetting, which you can apply to different pools. Different backend pools can have different BackendHttpSetting configurations and different request timeout settings.

```azurepowershell
    New-AzApplicationGatewayBackendHttpSettings -Name 'Setting01' -Port 80 -Protocol Http -CookieBasedAffinity Enabled -RequestTimeout 60
```

## Application Gateway's backend pool isn't configured or empty

### Cause

If the application gateway has no VMs or virtual machine scale set configured in the backend address pool, it can't route any customer request and sends a bad gateway error.

### Solution

Ensure that the backend address pool isn't empty. You can check this condition through PowerShell, CLI, or the portal.

```azurepowershell
Get-AzApplicationGateway -Name "SampleGateway" -ResourceGroupName "ExampleResourceGroup"
```

The output from the preceding cmdlet should contain a nonempty backend address pool. The following example shows two returned pools that are configured with an FQDN or IP addresses for the backend VMs. The provisioning state of the BackendAddressPool must be `Succeeded`.

BackendAddressPoolsText:

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

The TLS certificate installed on backend servers doesn't match the hostname received in the Host request header. 

In scenarios where End-to-end TLS is enabled, a configuration that is achieved by editing the appropriate "Backend HTTP Settings", and changing there the configuration of the "Backend protocol" setting to HTTPS, it's mandatory to ensure that the DNS NAME of the TLS certificate installed on backend servers matches the hostname coming to the backend in the HTTP host header request.

As a reminder, the effect of enabling on the "Backend HTTP Settings" the option of protocol HTTPS rather than HTTP, is that the second part of the communication that happens between the instances of the Application Gateway and the backend servers are encrypted with TLS.

Due to the fact that by default Application Gateway sends the same HTTP host header to the backend as it receives from the client, you need to ensure that the TLS certificate installed on the backend server, is issued with a DNS NAME that matches the host name received by that backend server in the HTTP host header.
Remember that, unless specified otherwise, this hostname would be the same as the one received from the client.

For example:

Imagine that you have an Application Gateway to serve the https requests for domain www.contoso.com. You could have the domain contoso.com delegated to an Azure DNS Public Zone, and a A DNS record in that zone pointing www.contoso.com to the public IP of the specific Application Gateway that is going to serve the requests.

On that Application Gateway you should have a listener for the host www.contoso.com with a rule that has the "Backed HTTP Setting" forced to use protocol HTTPS (ensuring End-to-end TLS). That same rule could have configured a backend pool with two VMs running IIS as Web servers.

As we know enabling HTTPS in the "Backed HTTP Setting" of the rule makes the second part of the communication that happens between the Application Gateway instances and the servers in the backend to use TLS.

If the backend servers do not have a TLS certificate issued for the DNS NAME www.contoso.com or *.contoso.com, the request fails with **Server Error: 502 - Web server received an invalid response while acting as a gateway or proxy server** because the upstream SSL certificate (the certificate installed on the backend servers) doesn't match the hostname in the host header, and hence the TLS negotiation fails. 


www.contoso.com --> APP GW front end IP --> Listener with a rule that configures "Backend HTTP Settings" to use protocol HTTPS rather than HTTP  --> Backend Pool --> Web server (needs to have a TLS certificate installed for www.contoso.com) 

## Solution

It's required that the DNS NAME of the TLS certificate installed on the backend server, matches the host name configured in the HTTP backend settings, otherwise the second part of the End-to-end communication that happens between the instances of the Application Gateway and the backend, fails with "Upstream SSL certificate doesn't match", and throws back a **Server Error: 502 - Web server received an invalid response while acting as a gateway or proxy server**

