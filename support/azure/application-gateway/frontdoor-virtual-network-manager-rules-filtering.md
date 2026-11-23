---
title: Troubleshoot Azure Front Door connectivity issues caused by Azure Virtual Network Manager rules filtering
description: Troubleshoot Azure Front Door connectivity failures and HTTP 504 errors caused by NSG or Virtual Network Manager rules. Learn how to diagnose and fix blocked traffic.
ms.service: azure-application-gateway
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tcsougan, ryanbor
ms.date: 11/06/2026
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---

# Troubleshoot Azure Front Door connectivity issues caused by Azure Virtual Network Manager rules filtering   

## Summary

This article provides guidance for troubleshooting connectivity issues between Azure Front Door and Azure Application Gateway that are caused by Azure Virtual Network Manager rules filtering. It covers network security group (NSG) rules and Virtual Network Manager security admin rules, including failures that appear as HTTP 504 Gateway Timeout responses.

Diagnose and resolve connectivity failures when Front Door uses Application Gateway as an origin and when network filtering blocks traffic. 

## Connectivity path overview

The primary scenario for this article is a publicly reachable Application Gateway origin with this traffic path:

**Client -> Azure Front Door -> Application Gateway listener -> Application backend**

Front Door calls its backend an *origin*. Application Gateway has a separate backend pool. Check these two network connections independently because a failure on either connection can prevent the client from receiving a response.

Virtual Network Manager doesn't filter requests at the Front Door edge. Its security admin rules filter traffic in managed virtual networks where those rules apply. For an Application Gateway subnet, security admin rules apply only when every application gateway in the subnet has [network isolation enabled](/azure/application-gateway/application-gateway-private-deployment). If any gateway in the subnet doesn't have network isolation enabled, security admin rules don't apply to that subnet. Rules can still affect supported application backend subnets.

If your Front Door Premium origin uses Private Link, evaluate its private connectivity path instead. Don't assume that the public-origin service tag rules in this guide apply unchanged.

## Prerequisites

Ensure that you have the following:

- Read access to the Front Door profile, Application Gateway, virtual networks, NSGs, and applicable Virtual Network Manager configurations and deployments.
- Access to diagnostic logs and metrics for both gateways.
- Approval and appropriate permissions to change and deploy network rules if a blocking rule is identified.

## Symptoms and root causes

The following table summarizes common symptoms, possible root causes, and what to check when troubleshooting connectivity issues between Front Door and Application Gateway.

| Symptom | Possible root cause | What to check |
|---|---|---|
| Requests through Front Door fail, but an authorized direct request to Application Gateway succeeds. | A rule allows the test client's IP address but blocks Front Door's origin-facing IP addresses. | Inbound rules for the Application Gateway listener, including the `AzureFrontDoor.Backend` service tag. |
| Front Door returns HTTP 504, and its access logs contain `OriginTimeout` or an origin connection error. | Front Door can't reach its origin, or the origin doesn't respond within the configured timeout. | Front Door origin settings, network filtering, and Application Gateway access logs. A 504 alone doesn't prove a rule blocked traffic. |
| Front Door health probes fail while Application Gateway backend health remains healthy. | The Front Door-to-listener path is blocked, or the probe host, path, protocol, or method is incorrect. | Front Door probe logs and listener settings. Healthy Application Gateway backends don't prove that Front Door can reach the listener. |
| Application Gateway receives the request but reports unhealthy backends or returns a gateway error. | Filtering or an application problem affects the Application Gateway-to-backend path. | Backend health details, backend subnet and network interface card (NIC) NSGs, security admin rules, and application logs. |
| Failures begin after a central security deployment or network group membership change. | A newly applied Virtual Network Manager rule matches the traffic. | Applied configurations, deployment history, activity logs, and network group membership. |
| Requests return HTTP 403 and have matching WAF log entries. | A web application firewall (WAF) rule blocks the HTTP request, including a possible Front Door identifier mismatch. | Front Door and Application Gateway WAF logs. An NSG or security admin deny doesn't itself generate an HTTP 403 response. |

Other causes include DNS resolution errors, incorrect listener ports, Transport Layer Security (TLS) certificate or hostname mismatches, user-defined routes (UDRs), and slow application responses. Rule out these causes rather than changing network rules based only on a status code.

## Diagnosing connectivity

Follow these steps to diagnose connectivity issues between Front Door and Application Gateway:

1. Record a failing request's URL, method, UTC timestamp, response status, and `X-Azure-Ref` response header. Use the tracking reference and timestamp to correlate logs.
1. In the Front Door profile, verify the route, origin group, enabled origin, origin hostname, origin host header, and HTTP or HTTPS port. Confirm that the hostname resolves to the intended Application Gateway frontend.
1. Verify that the Application Gateway listener uses the expected frontend IP, port, protocol, and hostname, and that it has an associated routing rule.
1. Review Front Door access logs and health probe logs. Enable them through **Diagnostic settings** if needed, and reproduce the failure after logging is enabled. Logs aren't collected retrospectively.
   - `OriginConnectionError` or `OriginConnectionRefused` indicates an origin connection problem, but doesn't identify a specific blocking rule.
   - `OriginTimeout` indicates that the origin request timed out. Investigate filtering and origin response time.
   - DNS and TLS errors require corresponding DNS or certificate checks.
1. Review Application Gateway access logs, WAF logs, and **Backend health** for the same time window.
   - If no corresponding access request appears after log ingestion completes, investigate the Front Door-to-Application Gateway path. Absence of a log isn't proof of filtering; verify diagnostic settings and the selected origin.
   - If the request appears, investigate the Application Gateway response and its connection to the application backend.
1. Compare the first failure time with NSG changes, Virtual Network Manager deployments, and network group membership changes in activity logs.

An authorized direct-origin test can help isolate the failing connection. Preserve the listener hostname, TLS server name, path, and protocol when testing. A direct request might be intentionally denied if the origin accepts only Front Door traffic. Don't remove origin protection or treat that expected denial as evidence of an outage.

For Application Gateway-to-backend problems, use **Connection troubleshoot** in Application Gateway and review backend health details. A test from a VM uses that VM's source IP and network path; it doesn't reproduce Front Door's source addresses or prove that Front Door traffic is allowed.

## Verifying NSG rules for Front Door backends

In the Application Gateway virtual network, identify the NSG associated with the gateway subnet. Review its inbound and outbound rules, not only the rules on application backend VMs.

For a public Application Gateway origin, verify that an inbound allow rule matches the following traffic:

| Setting | Required match |
|---|---|
| Source | `AzureFrontDoor.Backend` service tag |
| Source port | Any |
| Destination | The Application Gateway destination required by its frontend and subnet configuration |
| Destination port | The configured listener ports, such as 443 for HTTPS or 80 if HTTP is used |
| Protocol | TCP |
| Action | Allow |
| Priority | A lower numerical value than a conflicting NSG deny rule |

Use `AzureFrontDoor.Backend`, not `AzureFrontDoor.Frontend`, for origin-facing traffic. The network source is Front Door, not the original client's IP address in `X-Forwarded-For`. NSGs can't evaluate HTTP headers.

Follow the [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure#network-security-groups) guidance for the destination match. In particular, configurations with active public and private listeners sharing a frontend port require the gateway's public and private frontend IP addresses in the inbound rule's destination.

Keep these considerations in mind:

- Use the service tag instead of a fixed list of Front Door IP addresses, which can change.
- Allow both Front Door requests and health probes on their configured destination ports.
- Preserve required Application Gateway platform traffic. Standard deployments without network isolation have `GatewayManager`, `AzureLoadBalancer`, and outbound connectivity requirements. Network-isolated deployments have different restrictions; follow the requirements for the actual deployment mode.
- For the Application Gateway-to-backend connection, verify gateway subnet outbound rules and backend subnet and NIC inbound rules. The backend sees Application Gateway traffic, not the Front Door source IP addresses.
- An NSG allow rule can't override a Virtual Network Manager security admin deny.

For more information about timeout errors on the second connection, see [Troubleshoot HTTP 504 Gateway Timeout errors in Azure Application Gateway](troubleshoot-http-504-gateway-timeout.md).

## Checking Virtual Network Manager IP filtering

Security admin rules match direction, protocol, source and destination IP addresses or service tags, and ports. They don't inspect URLs, HTTP headers, or Front Door profile identifiers.

1. Open the affected virtual network in the Azure portal. Under **Settings**, select **Network Manager**, and then select **Security admin configurations** to view the applied rules.
1. Identify the originating Virtual Network Manager instance, configuration, rule collection, and target network groups. Check effective membership, including dynamic membership, rather than relying only on a list of manually added virtual networks.
1. In the Virtual Network Manager instance, review **Deployments**. Confirm which security admin configuration is deployed to the virtual network's region. A saved configuration isn't necessarily the deployed configuration.
1. Verify applicability before attributing the failure to an admin rule:
   - For the Application Gateway subnet, confirm that every gateway has network isolation enabled.
   - For the application backend subnet, review any service-specific exclusions.
   - A configuration shown at the virtual network level doesn't establish that it applies to every subnet.
1. Compare each applicable rule with the failing connection's source, destination, direction, protocol, and ports. Check for broad IP prefixes, Internet denies, incorrect destination ranges, and static Front Door allowlists that no longer cover the service.
1. Record the matching rule's name, priority, action, scope, and deployment time.

Where security admin rules apply, they are evaluated before NSG rules. Lower numerical values have higher priority within each rule system. Don't compare an NSG priority number with an admin rule priority number.

| Security admin action | Effect |
|---|---|
| Allow | Traffic continues to NSG evaluation, where it can still be denied. |
| Deny | Traffic is blocked. An NSG allow doesn't override this decision. |
| Always Allow | Traffic bypasses further NSG evaluation. Use only when central policy explicitly requires this behavior. |

For example, an applicable admin deny with priority 100 blocks matching Front Door traffic even if an NSG allow has priority 50. A narrowly scoped admin allow with priority 90 can match before that admin deny, but the traffic must still pass the NSG rules.

## Resolving blocked traffic

Make the change at the layer that blocks the connection. Coordinate security admin changes with the central networking team, document the affected scope, and retain a rollback plan.

1. If an NSG deny is the cause, add or correct a narrowly scoped allow for `AzureFrontDoor.Backend` on the required Application Gateway listener ports, with higher priority than the conflicting NSG deny.
1. If a security admin deny is the cause:
   - Open the applicable security configuration and rule collection in Virtual Network Manager.
   - Add or correct an inbound **Allow** rule using the `AzureFrontDoor.Backend` source service tag, the required Application Gateway destination, TCP, and the listener ports.
   - Give it a lower numerical priority than the broad deny it must precede. Keep the broad deny for unrelated traffic.
   - Correct separate rules for the Application Gateway-to-backend connection if that connection is blocked. Use the gateway source range and actual backend destination and port, not the Front Door service tag.
1. For security admin changes, go to **Deployments** > **Deploy configuration**. Include the security admin configuration in the goal state and deploy to each affected region. Editing a rule alone doesn't apply the change.
1. Verify deployment completion and the applied configuration on the virtual network. Allow for propagation before retesting.
1. If filtering is ruled out, correct the identified listener, DNS, TLS, routing, probe, or application issue instead.

Prefer **Allow** over **Always Allow** so that application teams retain NSG enforcement. Don't disable all NSGs, remove a central security configuration, or open all ports to the Internet as a troubleshooting shortcut.

For public origins, retain both IP filtering and validation of the `X-Azure-FDID` header against your Front Door profile's identifier. The service tag is shared by multiple Front Door customers and doesn't identify your profile. Use Application Gateway WAF or application-level checks for the header.

Increasing a timeout doesn't resolve blocked packets. Consider a timeout change only after connectivity is established and measured application processing time justifies it.

## Testing and validation

After the change propagates, validate both successful delivery and continued protection. Follow these steps:

1. Start new requests through Front Door to the previously failing URL, using the same method and relevant headers. Test an endpoint with caching disabled, or confirm a cache miss in Front Door logs. A cached success doesn't prove origin connectivity.
1. Confirm the expected application response and response time, not only the absence of HTTP 504. Repeat the test to check for intermittent failures.
1. Check Front Door origin health metrics and health probe logs. Confirm that probes recover for each affected origin and that new connection errors or timeouts no longer occur.
1. Correlate the test requests in Application Gateway access logs and application logs. Confirm that Application Gateway backend health is healthy.
1. Verify all affected listener ports, origin groups, and regions. Confirm the intended security admin configuration is applied in each region.
1. Perform an approved negative test from a source that isn't permitted to access the public origin. Verify that direct-origin access remains restricted and that an incorrect Front Door identifier is rejected by the configured WAF or application policy.
1. Monitor error rates and latency after the change. If validation fails, use the rollback plan and continue diagnosis with the new evidence.

If the issue persists, collect request timestamps, `X-Azure-Ref` values, origin and listener settings, backend health details, applicable NSG and admin rules, and regional deployment results for Azure support. Remove credentials and sensitive request data before sharing diagnostic evidence.

## Best practices and references

Use the following best practices to ensure secure and reliable connectivity between Front Door and Application Gateway:

- Use `AzureFrontDoor.Backend` for public-origin filtering instead of maintaining static IP allow lists.
- Apply least privilege to sources, destinations, protocols, and ports. Preserve required platform traffic.
- Combine network filtering with `X-Azure-FDID` validation to restrict traffic to your Front Door profile.
- Review central rule changes against Application Gateway deployment mode and every affected backend subnet.
- Validate network group membership and regional deployments after policy changes.
- Enable access and health probe logs, and configure alerts for origin health degradation, gateway errors, and latency.

## References

- [Secure traffic to Azure Front Door origins](/azure/frontdoor/origin-security)
- [Monitor Azure Front Door](/azure/frontdoor/monitor-front-door)
- [Troubleshoot Azure Front Door common issues](../front-door/troubleshoot-issues.md)
- [Application Gateway infrastructure configuration](/azure/application-gateway/configuration-infrastructure)
- [Private Application Gateway deployment](/azure/application-gateway/application-gateway-private-deployment)
- [Security admin rules in Azure Virtual Network Manager](/azure/virtual-network-manager/concept-security-admins)
- [View configurations applied by Azure Virtual Network Manager](/azure/virtual-network-manager/how-to-view-applied-configurations)
- [Configure security admin rules in the Azure portal](/azure/virtual-network-manager/how-to-block-network-traffic-portal)
- [Troubleshoot TCP connection timeout problems in Azure Application Gateway](troubleshoot-tcp-connection-timeout-issues.md)