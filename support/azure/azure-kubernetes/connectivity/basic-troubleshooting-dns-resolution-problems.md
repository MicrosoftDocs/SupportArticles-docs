---
title: Basic troubleshooting of DNS resolution problems in AKS
description: Learn how to create a troubleshooting workflow to fix DNS resolution problems in Azure Kubernetes Service (AKS).
author: sturrent
ms.author: seturren
ms.date: 06/05/2024
ms.reviewer: v-rekhanain, v-leedennis, v-weizhu
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to learn how to create a troubleshooting workflow so that I can fix DNS resolution problems in Azure Kubernetes Service (AKS).
---
# Basic troubleshooting of DNS resolution problems in AKS

This article discusses how to create a troubleshooting workflow to fix Domain Name System (DNS) resolution problems in Microsoft Azure Kubernetes Service (AKS).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool

   **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [dig](https://downloads.isc.org/isc/bind9/cur/9.19/doc/arm/html/manpages.html#dig-dns-lookup-utility) command-line tool for DNS lookup

- The [grep](https://linux.die.net/man/1/grep) command-line tool for text search

- The [Wireshark](https://www.wireshark.org) network packet analyzer

## Troubleshooting checklist

Troubleshooting DNS problems in AKS is typically a complex process. You can easily get lost in the many different steps without ever seeing a clear path forward. To help make the process simpler and more effective, use the "scientific" method to organize the work:

- Step 1. Collect the facts.

- Step 2. Develop a hypothesis.

- Step 3. Create and implement an action plan.

- Step 4. Observe the results and draw conclusions.

- Step 5. Repeat as necessary.

### Troubleshooting Step 1: Collect the facts

To better understand the context of the problem, gather facts about the specific DNS problem. By using the following baseline questions as a starting point, you can describe the nature of the problem, recognize the symptoms, and identify the scope of the problem.

| Question | Possible answers |
|--|--|
| Where does the DNS resolution fail? | <ul> <li>Pod</li> <li>Node</li> <li>Both pods and nodes</li> </ul> |
| What kind of DNS error do you get? | <ul> <li>Time-out</li> <li>No such host</li> <li>Other DNS error</li> </ul> |
| How often do the DNS errors occur? | <ul> <li>Always</li> <li>Intermittently</li> <li>In a specific pattern</li> </ul> |
| Which records are affected? | <ul> <li>A specific domain</li> <li>Any domain</li> </ul> |
| Do any custom DNS configurations exist? | <ul> <li>Custom DNS server configured on the virtual network</li> <li>Custom DNS on CoreDNS configuration</li> </ul> |
| What kind of performance problems are affecting the nodes? | <ul> <li>CPU</li> <li>Memory</li> <li>I/O throttling</li> </ul> |
| What kind of performance problems are affecting the CoreDNS pods? | <ul> <li>CPU</li> <li>Memory</li> <li>I/O throttling</li> </ul> |
| What causes DNS latency? | DNS queries that take too much time to receive a response (more the five seconds) |

To get better answers to these questions, follow this three-part process.

#### Part 1: Generate tests at different levels that reproduce the problem

The DNS resolution process for pods on AKS includes many layers. Review these layers to isolate the problem. The following layers are typical:

- CoreDNS pods
- CoreDNS service
- Nodes
- Virtual network DNS

To start the process, run tests from a test pod against each layer.

##### Test the DNS resolution at CoreDNS pod level

1. Deploy a test pod to run DNS test queries by running the following command:

   ```bash
   cat <<EOF | kubectl apply --filename -
   apiVersion: v1
   kind: Pod
   metadata:
     name: aks-test
   spec:
     containers:
     - name: aks-test
       image: contoso/debian-ssh
       command: ["/bin/sh"]
       args: ["-c", "while true; do sleep 1000; done"]
   EOF
   ```

1. Retrieve the IP addresses of the CoreDNS pods by running the following [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/) command:

   ```bash
   kubectl get pod --namespace kube-system --selector k8s-app=kube-dns --output wide
   ```

1. Connect to the test pod and test the DNS resolution against each CoreDNS pod IP address by running the following commands:

   ```bash
   # Placeholder values
   FQDN="<fully-qualified-domain-name>"  # For example, "db.contoso.com"
   DNS_SERVER="<coredns-pod-ip-address>"

   # Test loop
   for i in $(seq 1 1 10)
   do
       echo "host= $(dig +short ${FQDN} @${DNS_SERVER})"
       sleep 1
   done
   ```

##### Test the DNS resolution at CoreDNS service level

1. Retrieve the CoreDNS service IP address by running the following `kubectl get` command:

   ```bash
   kubectl get service kube-dns --namespace kube-system
   ```

1. On the test pod, run the following commands against the CoreDNS service IP address:

   ```bash
   # Placeholder values
   FQDN="<fully-qualified-domain-name>"  # For example, "db.contoso.com"
   DNS_SERVER="<kubedns-service-ip-address>"

   # Test loop
   for i in $(seq 1 1 10)
   do
       echo "host= $(dig +short ${FQDN} @${DNS_SERVER})"
       sleep 1
   done
   ```

##### Test the DNS resolution at node level

1. Connect to the node.

1. Run the following `grep` command to retrieve the list of upstream DNS servers that are configured:

   ```bash
   grep ^nameserver /etc/resolv.conf
   ```

1. Run the following text commands against each DNS that's configured in the node:

   ```bash
   # Placeholder values
   FQDN="<fully-qualified-domain-name>"  # For example, "db.contoso.com"
   DNS_SERVER="<dns-server-in-node-configuration>"

   # Test loop
   for i in $(seq 1 1 10)
   do
       echo "host= $(dig +short ${FQDN} @${DNS_SERVER})"
       sleep 1
   done
   ```

##### Test the DNS resolution at virtual network DNS level

Examine the DNS server configuration of the virtual network, and determine whether the servers can resolve the record in question.

#### Part 2: Review the health and performance of nodes

You might first notice DNS resolution performance problems as intermittent errors, such as time-outs. The main causes of this problem include resource exhaustion and I/O throttling within nodes that host the CoreDNS pods or the client pod.

To check whether resource exhaustion or I/O throttling is occurring, run the following [kubectl describe](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_describe/) command together with the `grep` command on your nodes. This series of commands lets you review the request count and compare it against the limit for each resource. If the limit percentage is more than 100 percent for a resource, that resource is overcommitted.

```bash
kubectl describe node | grep -A5 '^Name:\|^Allocated resources:' | grep -v '.kubernetes.io\|^Roles:\|Labels:'
```

The following snippet shows example output from this command:

```output
Name:               aks-nodepool1-17046773-vmss00000m
--
Allocated resources:
  (Total limits might be more than 100 percent.)
  Resource           Requests           Limits
  --------           --------           ------
  cpu                250m (13 percent)  40m (2 percent)
  memory             420Mi (9 percent)  1762Mi (41 percent)
--
Name:               aks-nodepool1-17046773-vmss00000n
--
Allocated resources:
  (Total limits might be more than 100 percent.)
  Resource           Requests            Limits
  --------           --------            ------
  cpu                612m (32 percent)   8532m (449 percent)
  memory             804Mi (18 percent)  6044Mi (140 percent)
--
Name:               aks-nodepool1-17046773-vmss00000o
--
Allocated resources:
  (Total limits might be more than 100 percent.)
  Resource           Requests           Limits
  --------           --------           ------
  cpu                250m (13 percent)  40m (2 percent)
  memory             420Mi (9 percent)  1762Mi (41 percent)
--
Name:               aks-ubuntu-16984727-vmss000008
--
Allocated resources:
  (Total limits might be more than 100 percent.)
  Resource           Requests            Limits
  --------           --------            ------
  cpu                250m (13 percent)   40m (2 percent)
  memory             420Mi (19 percent)  1762Mi (82 percent)
```

To get a better picture of resource usage at the pod and node level, you can also use Container insights and other cloud-native tools in Azure. For more information, see [Monitor Kubernetes clusters using Azure services and cloud native tools](/azure/azure-monitor/containers/monitor-kubernetes).

#### Part 3: Capture DNS traffic and review DNS resolution performance

A network traffic capture can help you understand how your AKS cluster is handling the DNS queries. Ideally, you want to reproduce the problem on a test pod while you capture the traffic from this test pod and on each of the CoreDNS pods.

Many traffic-capturing tools are available to assist this process, including the following tools:

- [Retina Capture](https://retina.sh/docs/captures/)

- [Dumpy](https://github.com/larryTheSlap/dumpy) - an open source traffic capture plug-in for Kubernetes

If you want to perform these checks in real-time, you can use [Inspektor Gadget](https://inspektor-gadget.io) to [troubleshoot DNS failures in real-time](troubleshoot-dns-failures-across-an-aks-cluster-in-real-time.md).

In this article, we use Dumpy as an example of how to collect DNS traffic captures from each CoreDNS pod and a client DNS pod (in this case, the `aks-test` pod).

##### Network traffic capture commands

To collect the captures from the test client pod, run the following Dumpy command:

```bash
kubectl dumpy capture pod aks-test -f "-i any port 53" --name dns-cap1-aks-test
```

To collect captures for the CoreDNS pods, run the following Dumpy command:

```bash
kubectl dumpy capture deploy coredns-<coredns-pod-name> \
    -n kube-system \
    -f "-i any port 53" \
    --name dns-cap1-coredns-<coredns-pod-name>
```

Ideally, you should be running captures while the problem reproduces. This requirement means that different captures might be running for different amounts of time, depending on how often you can reproduce the problem. To collect the captures, run the following commands:

```bash
mkdir dns-captures
kubectl dumpy export dns-cap1-aks-test ./dns-captures
kubectl dumpy export dns-cap1-coredns ./dns-captures -n kube-system
```

To delete the Dumpy pods, run the following Dumpy command:

```bash
kubectl dumpy delete dns-cap1-coredns-<coredns-pod-name> -n kube-system
kubectl dumpy delete dns-cap1-aks-test
```

To merge all the CoreDNS pod captures, use the [mergecap](https://www.wireshark.org/docs/man-pages/mergecap.html) command line tool for merging capture files. The `mergecap` tool is included in the Wireshark network packet analyzer tool. Run the following `mergecap` command:

```bash
mergecap -w coredns-cap1.pcap dns-cap1-coredns-<coredns-pod-name-1>.pcap dns-cap1-coredns-<coredns-pod-name-2>.pcap [...]
```

##### DNS packet analysis for an individual CoreDNS pod

After you generate and merge your traffic capture files, you can do a DNS packet analysis of the capture files in Wireshark. Follow these steps to view the packet analysis for the traffic of an individual CoreDNS pod:

1. Select **Start**, enter **Wireshark**, and then select **Wireshark** in the search results.
1. In the **Wireshark** window, select the **File** menu, and then select **Open**.
1. Navigate to the folder that contains your capture files, select *dns-cap1-db-check-\<db-check-pod-name>.pcap* (the client-side capture file for an individual CoreDNS pod), and then select the **Open** button.
1. Select the **Statistics** menu, and then select **DNS**. The **Wireshark - DNS** dialog box appears and displays an analysis of the DNS traffic.

   :::image type="content" source="./media/basic-troubleshooting-dns-resolution-problems/wireshark-dns-analysis-single-capture.png" alt-text="Screenshot of Wireshark DNS analysis dialog box for a network capture file of an individual CoreDNS pod." border="false" lightbox="./media/basic-troubleshooting-dns-resolution-problems/wireshark-dns-analysis-single-capture.png":::

The DNS analysis dialog box in Wireshark shows a total of 1,066 packets. Of these packets, 17 (1.59 percent) caused a server failure. Additionally, the maximum response time was 6,308 milliseconds (6.3 seconds), and no response was received for 0.38 percent of the queries. (This total was calculated by subtracting the 49.81 percent of packets that contained responses from the 50.19 percent of packets that contained queries.)

If you enter `(dns.flags.response == 0) && ! dns.response_in` as a display filter in Wireshark, this filter displays DNS queries that didn't receive a response, as shown in the following screenshot.

:::image type="content" source="./media/basic-troubleshooting-dns-resolution-problems/wireshark-display-filter-no-response.png" alt-text="Screenshot of Wireshark display filter of DNS queries that didn't receive a response." border="false" lightbox="./media/basic-troubleshooting-dns-resolution-problems/wireshark-display-filter-no-response.png":::

The Wireshark status bar shows that four of the 1,066 packets, or 0.4 percent, were DNS queries that never received a response. This value essentially matches the 0.38 percent total that you calculated earlier.

If you change the display filter to `dns.time >= 5`, the filter shows query response packets that took five seconds or more to be received, as shown in the updated screenshot.

:::image type="content" source="./media/basic-troubleshooting-dns-resolution-problems/wireshark-display-filter-response-took-five-seconds.png" alt-text="Screenshot of Wireshark display filter of DNS queries that took five seconds or more to be received." lightbox="./media/basic-troubleshooting-dns-resolution-problems/wireshark-display-filter-response-took-five-seconds.png":::

The status bar indicates that eight of the 1,066 packets, or 0.8 percent, were DNS responses that took five seconds or more to be received. However, on most clients, the default DNS time-out value is expected to be five seconds. This expectation means that, although the CoreDNS pods processed and delivered the eight responses, the client already ended the session by issuing a "timed out" error message. The **Info** column in the filtered results shows that all eight packets caused a server failure.

##### DNS packet analysis for all CoreDNS pods

In Wireshark, open the capture file of the CoreDNS pods that you merged earlier (*coredns-cap1.pcap*), and then open the DNS analysis, as described in the previous section. The following Wireshark dialog box appears.

:::image type="content" source="./media/basic-troubleshooting-dns-resolution-problems/wireshark-dns-analysis-merged-capture.png" alt-text="Screenshot of Wireshark DNS analysis dialog box for a merged network capture file of all CoreDNS pods." border="false" lightbox="./media/basic-troubleshooting-dns-resolution-problems/wireshark-dns-analysis-merged-capture.png":::

The dialog box indicates that there were a combined total of 4.5 million packets, of which 2.68 percent caused server failure. The difference in query and response packet percentages shows that 5.94 percent of the queries (52.97 percent minus 47.03 percent) didn't receive a response. The maximum response time was 12 seconds (12,000.532227 milliseconds).

If you apply the display filter for query responses that took five seconds or more (`dns.time >= 5`), most of the packets in the filter results will indicate that a server failure occurred. This is probably because of a client "timed out" error.

The following table is a summary of the capture findings.

| Capture review criteria                                        | Yes      | No       |
|----------------------------------------------------------------|:--------:|:--------:|
| Difference between DNS queries and responses exceeds 2 percent | &#x2610; | &#x2611; |
| DNS latency is more than one second                            | &#x2610; | &#x2611; |

### Troubleshooting Step 2: Develop a hypothesis

This section categorizes common problem types to help you narrow down potential problems and identify components that might require adjustments. This approach sets the foundation for creating a targeted action plan to mitigate and resolve these problems effectively.

#### Common DNS response codes

The following table summarizes the most common DNS return codes.

| DNS return code | DNS return message | Description                                    |
|-----------------|--------------------|------------------------------------------------|
| `RCODE:0`       | `NOERROR`          | The DNS query finished successfully.           |
| `RCODE:1`       | `FORMERR`          | A DNS query format error exists.               |
| `RCODE:2`       | `SERVFAIL`         | The server didn't complete the DNS request.    |
| `RCODE:3`       | `NXDOMAIN`         | The domain name doesn't exist.                 |
| `RCODE:5`       | `REFUSED`          | The server refused to answer the query.        |
| `RCODE:8`       | `NOTAUTH`          | The server isn't authoritative for the zone.   |

#### General problem types

The following table lists problem type categories that help you break down the problem symptoms.

| Problem type | Description |
|--|--|
| Performance | DNS resolution performance problems can cause intermittent errors, such as "timed out" errors from a client's perspective. These problems might occur because nodes experience resource exhaustion or I/O throttling. Additionally, constraints on compute resources in CoreDNS pods can cause resolution latency. If CoreDNS latency is high or increases over time, this might indicate a load problem. If CoreDNS instances are overloaded, you might experience DNS name resolution problems and delays, or you might see problems in workloads and Kubernetes internal services. |
| Configuration | Configuration problems can cause incorrect DNS resolution. In this case, you might experience `NXDOMAIN` or "timed out" errors. Incorrect configurations might occur in CoreDNS, nodes, Kubernetes, routing, virtual network DNS, private DNS zones, firewalls, proxies, and so on. |
| Network connectivity | Network connectivity problems can affect pod-to-pod connectivity (east-west traffic) or pod-and-node connectivity to external resources (north-south traffic). This scenario can cause "timed out" errors. The connectivity problems might occur if the CoreDNS service endpoints aren't up to date (for example, because of kube-proxy problems, routing problems, packet loss, and so on). External resource dependency combined with connectivity problems (for example, dependency on custom DNS servers or external DNS servers) can also contribute to the problem. |

#### Required inputs

Before you formulate a hypothesis of probable causes for the problem, summarize the results from the previous steps of the troubleshooting workflow.

You can collect the results by using the following tables.

##### Results of the baseline questionnaire template

| Question                                 | Possible answers                                                                             |
|------------------------------------------|----------------------------------------------------------------------------------------------|
| Where does the DNS resolution fail?      | &#x2610; Pod <br/> &#x2610; Node <br/> &#x2610; Both pod and node                            |
| What type of DNS error do you get?       | &#x2610; Timed out <br/> &#x2610; `NXDOMAIN` <br/> &#x2610; Other DNS error                  |
| How often do the DNS errors occur?       | &#x2610; Always <br/> &#x2610; Intermittently <br/> &#x2610; In a specific pattern           |
| Which records are affected?              | &#x2610; A specific domain <br/> &#x2610; Any domain                                         |
| Do any custom DNS configurations exist?  | &#x2610; Custom DNS servers on a virtual network <br/> &#x2610; Custom CoreDNS configuration |

##### Results of tests at different levels

| Resolution test results            | Works    | Fails    |
|------------------------------------|:--------:|:--------:|
| From pod to CoreDNS service        | &#x2610; | &#x2610; |
| From pod to CoreDNS pod IP address | &#x2610; | &#x2610; |
| From pod to Azure internal DNS     | &#x2610; | &#x2610; |
| From pod to virtual network DNS    | &#x2610; | &#x2610; |
| From node to Azure internal DNS    | &#x2610; | &#x2610; |
| From node to virtual network DNS   | &#x2610; | &#x2610; |

##### Results of health and performance of the nodes and the CoreDNS pods

| Performance review results | Healthy  | Unhealthy |
|----------------------------|:--------:|:---------:|
| Nodes performance          | &#x2610; | &#x2610;  |
| CoreDNS pods performance   | &#x2610; | &#x2610;  |

##### Results of traffic captures and DNS resolution performance

| Capture review criteria                                        | Yes      | No       |
|----------------------------------------------------------------|:--------:|:--------:|
| Difference between DNS queries and responses exceeds 2 percent | &#x2610; | &#x2610; |
| DNS latency is more than one second                            | &#x2610; | &#x2610; |

#### Map required inputs to problem types

To develop your first hypothesis, map each of the results from the required inputs to one or more of the problem types. By analyzing these results in the context of problem types, you can develop hypotheses about the potential root causes of the DNS resolution problems. Then, you can create an action plan of targeted investigation and troubleshooting.

#### Error type mapping pointers

- If test results show DNS resolution failures at the CoreDNS service, or contain "timed out" errors when trying to reach specific endpoints, then configuration or connectivity problems might exist.

- Indications of compute resource starvation at CoreDNS pod or node levels might suggest performance problems.

- DNS captures that have a considerable mismatch between DNS queries and DNS responses can indicate that packets are being lost. This scenario suggests that there are connectivity or performance problems.

- The presence of custom configurations at the virtual network level or Kubernetes level can contain setups that don't work with AKS and CoreDNS as expected.

### Troubleshooting Step 3: Create and implement an action plan

You should now have enough information to create and implement an action plan. The following sections contain extra recommendations to formulate your plan for specific problem types.

#### Performance problems

If you're dealing with DNS resolution performance problems, review and implement the following best practices and guidance.

| Best practice | Guidance |
|--|--|
| Set up a dedicated system node pool that meets minimum sizing requirements. | [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools) |
| To avoid disk I/O throttling, use nodes that have Ephemeral OS disks. | [Default OS disk sizing](/azure/aks/cluster-configuration#default-os-disk-sizing) and [GitHub issue 1373 in Azure AKS](https://github.com/Azure/AKS/issues/1373#issuecomment-827782655) |
| Follow best resource management practices on workloads within the nodes. | [Best practices for application developers to manage resources in Azure Kubernetes Service (AKS)](/azure/aks/developer-best-practices-resource-management) |

If DNS performance still isn't good enough after you make these changes, consider using [Node Local DNS](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/).

#### Configuration problems

Depending on the component, you should review and understand the implications of the specific setup. See the following list of component-specific documentation for configuration details:

- [Kubernetes DNS configuration options](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
- [AKS CoreDNS custom configuration options](/azure/aks/coredns-custom)
- [Private DNS zones missing a virtual network link](/azure/dns/private-dns-virtual-network-links)

#### Network connectivity problems

- Bugs that involve the Container Networking Interface (CNI) or other Kubernetes or OS components usually require intervention from AKS support or the AKS product group.

- Infrastructure problems, such as hardware failures or hypervisor problems, might require collaboration from infrastructure support teams. Alternatively, these problems might have self-healing features.

### Troubleshooting Step 4: Observe results and draw conclusions

Observe the results of implementing your action plan. At this point, your action plan should be able to fix or mitigate the problem.

### Troubleshooting Step 5: Repeat as necessary

If these troubleshooting steps don't resolve the problem, repeat the troubleshooting steps as necessary.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
