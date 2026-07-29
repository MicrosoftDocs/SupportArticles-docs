---
title: Collect network data for AKS troubleshooting
description: Collect AKS networking diagnostic data to resolve connectivity issues faster and reduce support case back-and-forth. Learn what data to gather for your symptom.
ms.date: 07/28/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, arfallas, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes Service (AKS) user, I want to collect the right networking diagnostic data for my symptom so that I can resolve connectivity issues faster and reduce back-and-forth on a support case.
ms.custom: sap:Connectivity
---
# Collect network data for AKS troubleshooting

## Summary

This article is a self-service data collection guide for Azure Kubernetes Service (AKS) customers who experience networking problems. Collect the data for the scenario that best matches your symptoms *before* (or while) you open a support case. Having this evidence ready reduces back-and-forth and shortens the time to resolution.

## How to use this guide

1. Use the [decision tree](#decision-tree-which-section-applies) to find the scenario that best matches your symptom.
1. Go to that numbered section and run the listed commands.
1. For rows marked **LIVE**, capture the data *while the issue is actively reproducing*. The capture loses value if you collect it afterward.
1. Attach the output to your support case, together with the *exact timestamps (including the time zone)* of when the failure occurred and a short written description of the symptom.

> [!IMPORTANT]
> Many application images don't include tools such as `tcpdump`, `mtr`, `ping`, `ss`, `nslookup`, or `openssl`. If `kubectl exec ... -- <tool>` returns "command not found," run the tool from an ephemeral debug container instead (`kubectl debug -it <pod> -n <ns> --image=<tools-image> -- <command>`), or capture at the node level as described in [Capture a TCP dump from a Linux node in an AKS cluster](/troubleshoot/azure/azure-kubernetes/logs/capture-tcp-dump-linux-node-aks).

### Legend

- **LIVE**: Capture while the failure is happening.
- `<rg>`: Cluster resource group. `MC_<rg>`: Node resource group (starts with `MC_`).
- Replace `<ns>`, `<pod>`, `<svc>`, `<node>`, `<vnet>`, `<subnet>`, `<lb>`, `<nsg>`, `<rt>`, and `<nat>` with your own values.

## Decision tree: which section applies?

Follow the diamonds. The green boxes are the section that you should go to and collect data from. If more than one path applies to your symptom, collect data for each section.

:::image type="content" source="media/aks-networking-customer-data-collection/aks-network-troubleshooting-decision-flowchart.png" alt-text="Screenshot of an AKS network troubleshooting decision tree flowchart with branching decision points." lightbox="media/aks-networking-customer-data-collection/aks-network-troubleshooting-decision-flowchart.png":::

### Quick index

| Symptom keyword | Section |
|---|---|
| latency, retransmits, mtr, timeout | [Section 1](#1-network-path-performance-latency-intermittent-timeouts-retransmissions) |
| firewall, NVA, UDR, route table, asymmetric | [Section 2](#2-firewall-nva-udr-asymmetric-routing) |
| DNS, CoreDNS, nslookup, NXDOMAIN, SERVFAIL, ndots | [Section 3](#3-dns-resolution-coredns-custom-dns-private-dns-zones) |
| image pull, MCR, ACR, egress, provisioning | [Section 4](#4-outbound-connectivity-egress-blocked-image-pull-node-provisioning-mcr-ubuntu-acr) |
| SNAT, outbound rule, LoadBalancer | [Section 5](#5-load-balancer-snat-port-exhaustion-nat) |
| private endpoint, private DNS, privatelink | [Section 6](#6-private-endpoint-private-dns-private-link) |
| kubectl timeout, private cluster, API server | [Section 7](#7-cannot-reach-api-server-private-cluster-or-not) |
| Service, Ingress, 502, 504, 4xx/5xx | [Section 8](#8-application-unreachable-through-service-or-ingress-4xx5xx-502-504) |
| IPAM, sandbox, Pending, IP exhaustion | [Section 9](#9-azure-cni-cns-ipam-ip-exhaustion) |
| ExpressRoute, VPN, on-prem, hybrid, MTU | [Section 10](#10-expressroute-vpn-hybrid-connectivity) |
| NSG, effective rules, flow logs | [Section 11](#11-nsg-blocking-or-unexpected-drops) |
| TLS, certificate, chain, cipher | [Section 12](#12-tls-certificate-path-issues) |
| TIME_WAIT, ephemeral ports | [Section 13](#13-port-and-connection-exhaustion-snat-ephemeral-time_wait) |
| conntrack, nf_conntrack table full | [Section 14](#14-conntrack-table-full-nf_conntrack-table-full-dropping-packet) |
| CIDR overlap, pod/service CIDR | [Section 15](#15-overlapping-cidrs-pod-or-service-cidr-compared-to-on-premises-or-peered-virtual-network) |
| pod-to-pod, east-west, intermittent | [Section 16](#16-intermittent-pod-to-pod-or-pod-to-service-connectivity) |
| Application Gateway, AGIC | [Section 17](#17-application-gateway-agic) |

## 1. Network path performance, latency, intermittent timeouts, retransmissions

| What to run | Why |
|---|---|
| `kubectl exec <pod> -- curl -w "@curl-timing.txt" -o /dev/null -s http://<target>` | End-to-end latency breakdown (DNS, connect, TTFB). Creates `curl-timing.txt` with `time_namelookup: %{time_namelookup}\ntime_connect: %{time_connect}\ntime_appconnect: %{time_appconnect}\ntime_starttransfer: %{time_starttransfer}\ntime_total: %{time_total}\n`. |
| `kubectl exec <pod> -- ping -c 50 <target>` | Shows packet loss and jitter on the path. |
| `kubectl exec <pod> -- mtr -rwc 100 <target>` (or `traceroute`) | Shows hop-by-hop latency and loss. |
| **LIVE** `kubectl exec <pod> -- tcpdump -i eth0 -w /tmp/cap.pcap -c 5000`, then `kubectl cp <ns>/<pod>:/tmp/cap.pcap ./src.pcap` | Provides packet evidence of retransmits, resets, and duplicate ACKs. |
| **LIVE** The same `tcpdump` command on the *destination* pod or server | A packet capture on both ends is required to localize the drop. |
| Exact timestamps (with time zone) of slow or failed requests | Correlate with platform telemetry. |

> [!NOTE]
> Capture on *both* endpoints when possible. A one-sided trace usually can't prove where the loss is. Use `-i eth0` for standard pods and `-i any` for `hostNetwork` pods. ICMP (`ping`/`mtr`) is often blocked on Azure and is unreliable for loss measurement, so prefer TCP-based probes (`curl`, `tcpdump`) as the primary signal.

## 2. Firewall, NVA, UDR, asymmetric routing

| What to run | Why |
|---|---|
| `az network route-table show -g <rg> -n <rt> -o json > routes.json` | A user-defined route (UDR) that might override Azure default paths. |
| `az network vnet subnet show -g <rg> --vnet-name <vnet> -n <subnet> --query "{udr:routeTable,nsg:networkSecurityGroup,delegations:delegations}"` | Shows which UDR and network security group (NSG) are applied to the node subnet. |
| `az network nic show-effective-route-table --ids <node-nic-id> -o table` | Shows effective routes seen by a node NIC (run for one node NIC). |
| `az network nsg show -g <rg> -n <nsg> --query securityRules -o json > nsg-rules.json` | NSG rule set. |
| Firewall or NVA rule export (Azure Firewall: `az network firewall ...`; third-party: vendor export) | Proves which rule allowed or denied the traffic. |
| `kubectl exec <pod> -- curl -v --connect-timeout 5 <endpoint>` | Reproduces from inside the cluster. |
| [AKS required outbound endpoints](/azure/aks/outbound-rules-control-egress) reviewed against the firewall allowlist | A common cause of provisioning and image-pull failures. |

## 3. DNS resolution (CoreDNS, custom DNS, private DNS zones)

| What to run | Why |
|---|---|
| `kubectl exec <pod> -- cat /etc/resolv.conf` | Check `ndots`, search domains, and nameserver settings. |
| `kubectl exec <pod> -- nslookup <failing-name>` and `... <failing-name> <coredns-pod-ip>` | Reproduce and bypass CoreDNS issues. |
| `kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide` | View CoreDNS pod count and node placement. |
| `kubectl top pods -n kube-system -l k8s-app=kube-dns` | Monitor CoreDNS CPU and memory usage. |
| `kubectl logs -n kube-system -l k8s-app=kube-dns --tail=500 > coredns.log` | Check CoreDNS errors and upstream timeouts. |
| `kubectl get configmap -n kube-system coredns-custom -o yaml` | View any custom DNS configuration. |
| `az network vnet show -g <rg> -n <vnet> --query dhcpOptions` | Check upstream DNS servers on the virtual network. |
| `az network private-dns link vnet list -g <rg> -z <zone> -o table` | View virtual network links for private DNS zones. |
| `az network private-dns zone list -g <rg> -o table` | View private DNS zones that should be linked. |
| **LIVE** `kubectl exec <pod> -- tcpdump -i eth0 port 53 -w /tmp/dns.pcap -c 3000` | Capture DNS packet trace when the failure is intermittent. |

## 4. Outbound connectivity, egress blocked (image pull, node provisioning, MCR, Ubuntu, ACR)

| What to run | Why |
|---|---|
| `kubectl describe pod <pod> \| grep -A5 Events` | Identify `ImagePullBackOff` or `ErrImagePull` errors. |
| `kubectl exec <pod> -- curl -v --connect-timeout 5 https://mcr.microsoft.com/v2/` | Test Microsoft Artifact Registry (MCR) reachability from inside the cluster. |
| `kubectl exec <pod> -- curl -v --connect-timeout 5 https://<acr-name>.azurecr.io/v2/` | Test private Azure Container Registry (ACR) reachability. |
| `az aks show -g <rg> -n <cluster> --query "networkProfile.{outbound:outboundType,loadBalancer:loadBalancerProfile,nat:natGatewayProfile}"` | Check how outbound traffic leaves the cluster. |
| `az network nat gateway show -g <rg> -n <nat>` (if used) | View NAT gateway configuration, idle timeout, and SNAT ports. |
| Firewall allowlist compared against [AKS required outbound endpoints](/azure/aks/outbound-rules-control-egress) | A missing FQDN rule is the most common cause. |
| Exact failing FQDN, port, timestamp, and error text | Required for root cause analysis (RCA). |

## 5. Load Balancer, SNAT port exhaustion, NAT

| What to run | Why |
|---|---|
| `kubectl get svc <svc> -n <ns> -o yaml > svc.yaml` | Annotations drive Load Balancer behavior (idle timeout, internal, and so on). |
| `kubectl get endpoints <svc> -n <ns> -o yaml` | Backend programming. |
| `az network lb show -g MC_<rg> -n kubernetes -o json > lb.json` | Load Balancer rules and backend pools. |
| `az network lb outbound-rule list -g MC_<rg> --lb-name kubernetes -o table` | Allocated outbound SNAT ports. |
| `az monitor metrics list --resource <lb-id> --metric SnatConnectionCount,AllocatedSnatPorts,UsedSnatPorts --interval PT1M` | SNAT port utilization over time. |
| **LIVE** `kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0 -- chroot /host ss -s` | Total sockets in `TIME_WAIT`, the classic SNAT pressure signature (collected at the node, not the pod). |
| **LIVE** `kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0 -- chroot /host sh -c "wc -l < /proc/net/nf_conntrack"` | Current node conntrack entry count. |
| **LIVE** `kubectl exec <pod> -- tcpdump -i eth0 -w /tmp/snat.pcap -c 5000` | Proves the outbound failure at the packet level. |

> [!NOTE]
> SNAT ports and conntrack entries are allocated per node behind the load balancer, so collect them at the node level. A count from inside a single pod isn't representative of node SNAT pressure.

## 6. Private endpoint, private DNS, private link

| What to run | Why |
|---|---|
| `az network private-endpoint list -g <rg> -o table` | All private endpoints in the resource group. |
| `az network private-endpoint show -g <rg> -n <pe> -o json > pe.json` | Private endpoint state, subnet, and connections. |
| `az network private-dns zone list -g <rg> -o table` | Private DNS zones that should exist. |
| `az network private-dns link vnet list -g <rg> -z <zone> -o table` | Zone-to-virtual-network links (a missing link is the top cause). |
| `az network private-dns record-set a list -g <rg> -z <zone> -o table` | A records present in the zone. |
| `nslookup <private-fqdn>` *from the client* and *from a pod* | Confirms which IP the client actually resolves. |
| `az aks show -g <rg> -n <cluster> --query "apiServerAccessProfile"` (private cluster) | Private cluster configuration. |

## 7. Cannot reach API server (private cluster or not)

| What to run | Why |
|---|---|
| Exact `kubectl` error text (TLS error, i/o timeout, 403, and so on) | The error shape determines the path. |
| `az aks show -g <rg> -n <cluster> --query "{fqdn:fqdn,privateFqdn:privateFqdn,apiServerAccessProfile:apiServerAccessProfile}"` | Public compared to private endpoint, and authorized IP ranges. |
| `nslookup <api-server-fqdn>` from the failing client | DNS resolution path. |
| `curl -vk https://<api-server-fqdn>:443/livez` from the failing client | TLS handshake and reachability. A `401 Unauthorized` response is expected (the endpoint requires authentication) and still confirms the endpoint is reachable. |
| `az network private-endpoint list -g MC_<rg>` (private cluster) | API server private endpoint state. |
| Client topology: VPN, ExpressRoute, peered virtual network, or jump box | Needed to understand the path. |
| **LIVE** `tcpdump -i any host <api-server-ip> -w /tmp/api.pcap` from the client | TLS interception, MITM, or reset evidence. |

## 8. Application unreachable through Service or Ingress (4xx/5xx, 502, 504)

| What to run | Why |
|---|---|
| `kubectl get svc <svc> -n <ns> -o yaml` and `kubectl get ingress -A -o wide` | Service and Ingress definitions. |
| `kubectl get endpoints <svc> -n <ns>` | Backends programmed. |
| `kubectl get pods -l <selector> -n <ns> -o wide` | Backend pod health. |
| `kubectl describe pod <backend-pod>` | Readiness probe and recent restarts. |
| `kubectl logs <backend-pod> --tail=200` | Application errors. |
| `kubectl exec <another-pod> -- curl -v http://<svc>.<ns>.svc.cluster.local:<port>` | Rule out the external path. |
| For AppGW or AGIC: `az network application-gateway show-backend-health -g <rg> -n <appgw>` | Backend health from the Application Gateway side. |
| For AGIC: `kubectl logs -n kube-system -l app=ingress-appgw --tail=200` | Application Gateway Ingress Controller (AGIC) reconcile errors. |
| **LIVE** `kubectl exec <backend-pod> -- tcpdump -i eth0 port <app-port> -w /tmp/ing.pcap -c 3000` | Whether the request reaches the pod. |

## 9. Azure CNI, CNS, IPAM, IP exhaustion

| What to run | Why |
|---|---|
| `kubectl describe pod <pending-pod>` | Shows sandbox or IPAM error events. |
| `kubectl get pods -A -o wide \| awk '{print $8}' \| sort \| uniq -c` | Displays pod-per-node distribution. |
| `az aks show -g <rg> -n <cluster> --query networkProfile` | Shows CNI mode (kubenet, Azure CNI, Overlay, or Cilium). |
| `az network vnet subnet show -g <rg> --vnet-name <vnet> -n <subnet> --query "{cidr:addressPrefix,used:ipConfigurations}"` | Compares subnet size to NICs in use. |
| `kubectl get nodes -o custom-columns=NAME:.metadata.name,PODS:.status.allocatable.pods` | Shows maximum pods per node. |
| `az aks nodepool show -g <rg> --cluster-name <cluster> -n <pool> --query "{maxPods:maxPods,podSubnet:podSubnetId}"` | Shows maximum  pods and pod subnet configuration. |

## 10. ExpressRoute, VPN, hybrid connectivity

| What to run | Why |
|---|---|
| From an on-premises host: `traceroute <target>`, `mtr -rwc 100 <target>`, `curl -v --connect-timeout 5 <target>` | Confirms the path and latency from the on-premises side. |
| The same probes from an Azure VM in the *same virtual network* as the cluster | Isolates whether the issue is hybrid-only. |
| `az network vnet-gateway list-bgp-peer-status -g <rg> -n <gw>` (VPN) | Shows peering state. |
| `az network express-route list-route-tables -g <rg> -n <circuit> --peering-name AzurePrivatePeering --path primary` | Shows routes advertised over ExpressRoute. |
| MTU and MSS settings on the on-premises side | An MTU mismatch is a common hybrid cause. |
| **LIVE** Packet capture on *both* the on-premises and Azure sides | Required to prove where packets are lost. |

## 11. NSG blocking or unexpected drops

| What to run | Why |
|---|---|
| `az network nsg show -g <rg> -n <nsg> --query securityRules -o json > nsg.json` | Declared rules. |
| `az network nic list-effective-nsg --ids <nic-id>` | Effective NSG on a specific node NIC (declared plus inherited). |
| NSG flow logs (if enabled) for the failure window | Allow or deny evidence per flow. |
| Source and destination IPs, ports, direction, and timestamps of failed connections | Needed to map to NSG rule evaluation. |

## 12. TLS, certificate path issues

| What to run | Why |
|---|---|
| `openssl s_client -connect <host>:443 -servername <host> -showcerts </dev/null` | Certificate chain as seen from the client. |
| `curl -vk https://<host>` | TLS version and cipher negotiated. |
| `kubectl exec <pod> -- openssl s_client -connect <host>:443 -servername <host> </dev/null` | Chain as seen from inside the pod (catches TLS inspection by intermediaries). |
| Any intermediate proxy or firewall TLS inspection configuration | TLS interception is the most common hybrid TLS failure. |

## 13. Port and connection exhaustion (SNAT, ephemeral, TIME_WAIT)

| What to run | Why |
|---|---|
| **LIVE** `kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0 -- chroot /host ss -s` | Node socket states (`TIME_WAIT`, `ESTAB`). |
| **LIVE** `kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0 -- chroot /host sh -c "ss -tan state time-wait \| wc -l"` | Node `TIME_WAIT` count. |
| `kubectl exec <pod> -- cat /proc/sys/net/ipv4/ip_local_port_range` | Ephemeral port range (client-side). |
| `kubectl debug node/<node> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0 -- chroot /host sh -c "wc -l < /proc/net/nf_conntrack"` and `chroot /host sysctl net.netfilter.nf_conntrack_max` | Node conntrack usage compared to max. |
| Application client-side connection pool and keep-alive settings | Creating a new connection per request is the top cause. |

> [!NOTE]
> SNAT, `TIME_WAIT`, and conntrack pressure are per node behind the load balancer. Collect these from the node (as shown), not from inside a single pod.

## 14. Conntrack table full (nf_conntrack: table full, dropping packet)  

| What to run | Why |
|---|---|
| **LIVE** `kubectl debug node/<node> -- chroot /host dmesg \| grep -i conntrack` | Kernel-level evidence of dropped packets. |
| `kubectl debug node/<node> -- chroot /host sysctl net.netfilter.nf_conntrack_max net.netfilter.nf_conntrack_count` | Current value compared to maximum. |
| `az aks nodepool show -g <rg> --cluster-name <cluster> -n <pool> --query linuxOsConfig` | Whether `customLinuxOsConfig` is set to raise the maximum. |
| [AKS custom node configuration (sysctl)](/azure/aks/custom-node-configuration) | Supported way to increase `nf_conntrack_max`. |

## 15. Overlapping CIDRs (pod or service CIDR compared to on-premises or peered virtual network) 

| What to run | Why |
|---|---|
| `az aks show -g <rg> -n <cluster> --query "networkProfile.{podCidr:podCidr,serviceCidr:serviceCidr}"` | Cluster CIDRs. |
| `az network vnet list --query "[].{name:name,addressSpace:addressSpace.addressPrefixes}" -o table` | Virtual network address spaces that might overlap. |
| On-premises route advertisements (ExpressRoute or VPN) | Confirm overlaps across the hybrid boundary. |
| Sample failing source and destination IP pairs | Make the overlap concrete. |

> [!NOTE]
> `podCidr` is populated only for kubenet and Azure CNI Overlay. With traditional Azure CNI, pods receive VNet IPs and `podCidr` is null; compare the pod subnet address space in that case.

## 16. Intermittent pod-to-pod or pod-to-service connectivity 

| What to run | Why |
|---|---|
| `kubectl get pods -o wide` (source and destination) | Node placement (same node compared to cross-node). |
| `kubectl get endpoints <svc>` | Backends match healthy pods. |
| `kubectl exec <pod> -- curl -w "%{time_connect} %{time_total}\n" -o /dev/null -s http://<svc>:<port>/health` | Baseline timing. |
| **LIVE** TCP dump on *both* the source and destination pods | Localize the drop. |
| `kubectl get svc -A \| wc -l` and `kubectl logs -n kube-system ds/kube-proxy --tail=200` | kube-proxy rule programming pressure (iptables mode clusters). |
| `az aks show -g <rg> -n <cluster> --query networkProfile.networkDataplane` | Check whether Cilium replaces kube-proxy. |

## 17. Application Gateway, AGIC

| What to run | Why |
|---|---|
| `kubectl get ingress -A -o wide` and `kubectl describe ingress <ingress>` | Declared Ingress and annotations. |
| `az network application-gateway show -g <rg> -n <appgw>` | Application Gateway configuration. |
| `az network application-gateway show-backend-health -g <rg> -n <appgw>` | Backend probe results. |
| `kubectl logs -n kube-system -l app=ingress-appgw --tail=300` | AGIC reconcile errors. |
| Application Gateway diagnostic logs (`ApplicationGatewayAccessLog`, `FirewallLog`) for the failure window | Per-request backend status and WAF decisions. |
| HTTP response headers showing `x-ms-request-id` and `server-timing` | Correlate with Application Gateway logs. |

## Package the data for your support case

Put everything in one folder and upload it as a single archive:

```bash
mkdir aks-netdata && cd aks-netdata
# Run the command block(s) that match your scenario(s) from the preceding sections.
# Include any *.pcap and *.log files, and a README.txt with:
#   - Cluster name, resource group, region
#   - Symptom description
#   - Exact timestamps with time zone
#   - Which section(s) you collected data for
cd .. && tar czf aks-netdata-$(date -u +%Y%m%dT%H%M%SZ).tgz aks-netdata/
```

## Related content

- [AKS outbound network and FQDN rules](/azure/aks/outbound-rules-control-egress)
- [Use a standard Load Balancer in AKS (SNAT troubleshooting)](/azure/aks/load-balancer-standard)
- [Azure Load Balancer TCP reset and idle timeout](/azure/load-balancer/load-balancer-tcp-idle-timeout)
- [AGIC troubleshooting](/azure/application-gateway/ingress-controller-troubleshoot)
- [AKS custom node configuration (sysctl)](/azure/aks/custom-node-configuration)
- [Customize CoreDNS for AKS](/azure/aks/coredns-custom)
- [Network concepts for AKS](/azure/aks/concepts-network)
- [Capture a TCP dump from a Linux node in an AKS cluster](/troubleshoot/azure/azure-kubernetes/logs/capture-tcp-dump-linux-node-aks)
- [Container network observability with Advanced Container Networking Services](/azure/aks/container-network-observability-guide)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
