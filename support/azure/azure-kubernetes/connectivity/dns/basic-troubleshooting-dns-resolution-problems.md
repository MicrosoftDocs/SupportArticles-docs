---
title: Basic troubleshooting of DNS resolution problems in AKS
description: Learn how to create a troubleshooting workflow to fix DNS resolution problems in Azure Kubernetes Service (AKS).
author: sturrent
ms.author: seturren
ms.date: 08/09/2024
ms.reviewer: v-rekhanain, v-leedennis, josebl, v-weizhu, qasimsarfraz
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to learn how to create a troubleshooting workflow so that I can fix DNS resolution problems in Azure Kubernetes Service (AKS).
---
# Troubleshoot DNS resolution problems in AKS

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
       image: debian:stable
       command: ["/bin/sh"]
       args: ["-c", "apt-get update && apt-get install -y dnsutils && while true; do sleep 1000; done"]
   EOF
   ```

1. Retrieve the IP addresses of the CoreDNS pods by running the following [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/) command:

   ```bash
   kubectl get pod --namespace kube-system --selector k8s-app=kube-dns --output wide
   ```

1. Connect to the test pod (using `kubectl exec -it aks-test -- bash`) and test the DNS resolution against each CoreDNS pod IP address by running the following commands:

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

For more information about troubleshooting DNS resolution problems from the pod level, see [Troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

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

#### Part 2: Review the health and performance of CoreDNS pods and nodes

##### Review the health and performance of CoreDNS pods

You can use kubectl commands to check the health and performance of CoreDNS pods. Start by verifying that the CoreDNS pods are running:

```bash
kubectl get pods -l k8s-app=kube-dns -n kube-system
```

Check whether the CoreDNS pods are overused:

```bash
kubectl top pods -n kube-system -l k8s-app=kube-dns
```

```output
NAME                      CPU(cores)   MEMORY(bytes)
coredns-dc97c5f55-424f7   3m           23Mi
coredns-dc97c5f55-wbh4q   3m           25Mi
```

Verify that the nodes that host the CoreDNS pods aren't overused. Also, get the nodes that are hosting the CoreDNS pods:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns -o jsonpath='{.items[*].spec.nodeName}'
```

Check the usage of these nodes:

```bash
kubectl top nodes
```

Verify the logs for the CoreDNS pods:

```bash
kubectl logs -l k8s-app=kube-dns -n kube-system
```

> [!NOTE]
> To see more debugging information, enable verbose logs in CoreDNS. To enable verbose logging in CoreDNS, see [Troubleshooting CoreDNS customizations in AKS](/azure/aks/coredns-custom#troubleshooting).

##### Review the health and performance of nodes

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

#### Part 3: Analyze DNS traffic and review DNS resolution performance

Analyzing DNS traffic can help you understand how your AKS cluster is handling the DNS queries. Ideally, you want to reproduce the problem on a test pod while you capture the traffic from this test pod and on each of the CoreDNS pods.

There are two main ways to analyze DNS traffic:

- Using real-time DNS analysis tools (e.g. [Inspektor Gadget](../../logs/capture-system-insights-from-aks.md#what-is-inspektor-gadget)) to analyze the DNS traffic in real time.
- Using traffic capture tools (e.g. [Retina Capture](https://retina.sh/docs/Troubleshooting/capture), [Dumpy](https://github.com/larryTheSlap/dumpy)) to collect the DNS traffic and analyze the traffic in a network packet analyzer tool, such as Wireshark. 

In both the approaches the goal would be to understand the health and performance of DNS responses using DNS response codes, response times, and other metrics. You are free to choose the approach that best fits your needs.

##### Real-time DNS traffic analysis

In this section, we will use [Inspektor Gadget](../../logs/capture-system-insights-from-aks.md#what-is-inspektor-gadget) to analyze the DNS traffic in real time. Follow this [guide](../../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster) to install Inspektor Gadget to your cluster.
We can use the following command to trace DNS traffic across all namespaces

```bash
# Get the version of Gadget
GADGET_VERSION=$(kubectl gadget version | grep Server | awk '{print $3}')
# Run the trace_dns gadget
kubectl gadget run trace_dns:$GADGET_VERSION --all-namespaces --fields "src,dst,name,qr,qtype,id,rcode,latency_ns"
```

Where `--fields` is a comma-separated list of fields to be displayed. The following table describes the fields that are used in the command:
- `src`: The source of the request with Kubernetes information (`<kind>/<namespace>/<name>:<port>`).
- `dst`: The destination of the request with Kubernetes information (`<kind>/<namespace>/<name>:<port>`).
- `name`: The name of the DNS request.
- `qr`: The query/response flag.
- `qtype`: The type of the DNS request.
- `id`: The ID of the DNS request, which is used to match the request and response.
- `rcode`: The response code of the DNS request.
- `latency_ns`: The latency of the DNS request.

The output of the command will look like the following:

```output
SRC                                  DST                                  NAME                        QR QTYPE          ID             RCODE           LATENCY_NS
p/default/aks-test:33141             p/kube-system/coredns-57d886c994-r2… db.contoso.com.             Q  A              c215                                  0ns
p/kube-system/coredns-57d886c994-r2… 168.63.129.16:53                     db.contoso.com.             Q  A              323c                                  0ns
168.63.129.16:53                     p/kube-system/coredns-57d886c994-r2… db.contoso.com.             R  A              323c           NameErr…           13.64ms
p/kube-system/coredns-57d886c994-r2… p/default/aks-test:33141             db.contoso.com.             R  A              c215           NameErr…               0ns
p/default/aks-test:56921             p/kube-system/coredns-57d886c994-r2… db.contoso.com.             Q  A              6574                                  0ns
p/kube-system/coredns-57d886c994-r2… p/default/aks-test:56921             db.contoso.com.             R  A              6574           NameErr…               0ns
```

Here you can use `ID` to identify if a query has a response or not. The `RCODE` field will show you the response code of the DNS request. The `LATENCY_NS` field will show you the latency of the DNS request in nanoseconds. Together, these fields can help you understand the health and performance of DNS responses.
For more information about real-time DNS analysis, see [Troubleshoot DNS failures across an AKS cluster in real time](troubleshoot-dns-failures-across-an-aks-cluster-in-real-time.md)

##### Capture DNS traffic

In this section, we use Dumpy as an example of how to collect DNS traffic captures from each CoreDNS pod and a client DNS pod (in this case, the `aks-test` pod).

To collect the captures from the test client pod, run the following Dumpy command:

```bash
kubectl dumpy capture pod aks-test -f "-i any port 53" --name dns-cap1-aks-test
```

To collect captures for the CoreDNS pods, run the following Dumpy command:

```bash
kubectl dumpy capture deploy coredns \
    -n kube-system \
    -f "-i any port 53" \
    --name dns-cap1-coredns
```

Ideally, you should be running captures while the problem reproduces. This requirement means that different captures might be running for different amounts of time, depending on how often you can reproduce the problem. To collect the captures, run the following commands:

```bash
mkdir dns-captures
kubectl dumpy export dns-cap1-aks-test ./dns-captures
kubectl dumpy export dns-cap1-coredns ./dns-captures -n kube-system
```

To delete the Dumpy pods, run the following Dumpy command:

```bash
kubectl dumpy delete dns-cap1-coredns -n kube-system
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
1. Select the **Statistics** menu, and then select **DNS**. The **Wireshark - DNS** dialog box appears and displays an analysis of the DNS traffic. The contents of the dialog box are shown in the following table.

   | Topic / Item                                 | Count   | Average | Min Val  | Max Val         | Rate (ms) | Percent    | Burst Rate | Burst Start |
   |----------------------------------------------|---------|---------|----------|-----------------|-----------|------------|------------|-------------|
   | &blacktriangledown; Total Packets            | 1066    |         |          |                 | 0.0017    | 100%       | 0.1200     | 0.000       |
   | &emsp;&blacktriangledown; rcode              | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&emsp;&emsp;**Server failure**         | **17**  |         |          |                 | 0.0000    | **1.59%**  | 0.0100     | 99.332      |
   | &emsp;&emsp;&emsp;No such name               | 353     |         |          |                 | 0.0006    | 33.11%     | 0.0400     | 0.000       |
   | &emsp;&emsp;&emsp;No error                   | 696     |         |          |                 | 0.0011    | 65.29%     | 0.0800     | 0.000       |
   | &emsp;&blacktriangledown; opcodes            | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&emsp;&emsp;Standard query             | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&blacktriangledown; Query/Response     | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&emsp;&emsp;**Response**               | **531** |         |          |                 | 0.0009    | **49.81%** | 0.0600     | 0.000       |
   | &emsp;&emsp;&emsp;**Query**                  | **535** |         |          |                 | 0.0009    | **50.19%** | 0.0600     | 0.000       |
   | &emsp;&blacktriangledown; Query Type         | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&emsp;&emsp;AAAA                       | 167     |         |          |                 | 0.0003    | 15.67%     | 0.0200     | 0.000       |
   | &emsp;&emsp;&emsp;A                          | 899     |         |          |                 | 0.0015    | 84.33%     | 0.1000     | 0.000       |
   | &emsp;&blacktriangledown; Class              | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &emsp;&emsp;&emsp;IN                         | 1066    |         |          |                 | 0.0017    | 100.00%    | 0.1200     | 0.000       |
   | &blacktriangledown; Service Stats            | 0       |         |          |                 | 0.0000    | 100%       | -          | -           |
   | &emsp;&emsp;**request-response time (msec)** | 531     | 184.42  | 0.067000 | **6308.503906** | 0.0009    |            | 0.0600     | 0.000       |
   | &emsp;&emsp;no. of unsolicited responses     | 0       |         |          |                 | 0.0000    |            | -          | -           |
   | &emsp;&emsp;no. of retransmissions           | 0       |         |          |                 | 0.0000    |            | -          | -           |
   | &blacktriangledown; Response Stats           | 0       |         |          |                 | 0.0000    | 100%       | -          | -           |
   | &emsp;&emsp;no. of questions                 | 1062    | 1.00    | 1        | 1               | 0.0017    |            | 0.1200     | 0.000       |
   | &emsp;&emsp;no. of authorities               | 1062    | 0.82    | 0        | 1               | 0.0017    |            | 0.1200     | 0.000       |
   | &emsp;&emsp;no. of answers                   | 1062    | 0.15    | 0        | 1               | 0.0017    |            | 0.1200     | 0.000       |
   | &emsp;&emsp;no. of additionals               | 1062    | 0.00    | 0        | 0               | 0.0017    |            | 0.1200     | 0.000       |
   | &blacktriangledown; Query Stats              | 0       |         |          |                 | 0.0000    | 100%       | -          | -           |
   | &emsp;&emsp;Qname Len                        | 535     | 32.99   | 14       | 66              | 0.0009    |            | 0.0600     | 0.000       |
   | &emsp;&blacktriangledown; Label Stats        | 0       |         |          |                 | 0.0000    |            | -          | -           |
   | &emsp;&emsp;&emsp;4th Level or more          | 365     |         |          |                 | 0.0006    |            | 0.0400     | 0.000       |
   | &emsp;&emsp;&emsp;3rd Level                  | 170     |         |          |                 | 0.0003    |            | 0.0200     | 0.000       |
   | &emsp;&emsp;&emsp;2nd Level                  | 0       |         |          |                 | 0.0000    |            | -          | -           |
   | &emsp;&emsp;&emsp;1st Level                  | 0       |         |          |                 | 0.0000    |            | -          | -           |
   | &emsp;Payload size                           | 1066    | 92.87   | 32       | 194             | 0.0017    | 100%       | 0.1200     | 0.000       |

The DNS analysis dialog box in Wireshark shows a total of 1,066 packets. Of these packets, 17 (1.59 percent) caused a server failure. Additionally, the maximum response time was 6,308 milliseconds (6.3 seconds), and no response was received for 0.38 percent of the queries. (This total was calculated by subtracting the 49.81 percent of packets that contained responses from the 50.19 percent of packets that contained queries.)

If you enter `(dns.flags.response == 0) && ! dns.response_in` as a display filter in Wireshark, this filter displays DNS queries that didn't receive a response, as shown in the following table.

| No. | Time                       | Source    | Destination | Protocol | Length | Info                                                                                       |
|----:|----------------------------|-----------|-------------|----------|-------:|--------------------------------------------------------------------------------------------|
| 225 | 2024-04-01 16:50:40.000520 | 10.0.0.21 | 172.16.0.10 | DNS      | 80     | Standard query 0x2c67 AAAA db.contoso.com                                                  |
| 426 | 2024-04-01 16:52:47.419907 | 10.0.0.21 | 172.16.0.10 | DNS      | 132    | Standard query 0x8038 A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net |
| 693 | 2024-04-01 16:55:23.105558 | 10.0.0.21 | 172.16.0.10 | DNS      | 132    | Standard query 0xbcb0 A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net |
| 768 | 2024-04-01 16:56:06.512464 | 10.0.0.21 | 172.16.0.10 | DNS      | 80     | Standard query 0xe330 A db.contoso.com                                                     |

Additionally, the Wireshark status bar displays the text **Packets: 1066 - Displayed: 4 (0.4%)**. This information means that four of the 1,066 packets, or 0.4 percent, were DNS queries that never received a response. This percentage essentially matches the 0.38 percent total that you calculated earlier.

If you change the display filter to `dns.time >= 5`, the filter shows query response packets that took five seconds or more to be received, as shown in the updated table.

| No. | Time                       | Source      | Destination | Protocol | Length | Info                                                                                                      | SourcePort | Additional RRs | dns resp time |
|----:|----------------------------|-------------|-------------|----------|-------:|-----------------------------------------------------------------------------------------------------------|-----------:|---------------:|--------------:|
| 213 | 2024-04-01 16:50:32.644592 | 172.16.0.10 | 10.0.0.21   | DNS      | 132    | Standard query 0x9312 Server failure A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net | 53         | 0              | 6.229941      |
| 320 | 2024-04-01 16:51:55.053896 | 172.16.0.10 | 10.0.0.21   | DNS      | 80     | Standard query 0xe5ce Server failure A db.contoso.com                                                     | 53         | 0              | 6.065555      |
| 328 | 2024-04-01 16:51:55.113619 | 172.16.0.10 | 10.0.0.21   | DNS      | 132    | Standard query 0x6681 Server failure A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net | 53         | 0              | 6.029641      |
| 335 | 2024-04-01 16:52:02.553811 | 172.16.0.10 | 10.0.0.21   | DNS      | 80     | Standard query 0x6cf6 Server failure A db.contoso.com                                                     | 53         | 0              | 6.500504      |
| 541 | 2024-04-01 16:53:53.423838 | 172.16.0.10 | 10.0.0.21   | DNS      | 80     | Standard query 0x07b3 Server failure AAAA db.contoso.com                                                  | 53         | 0              | 6.022195      |
| 553 | 2024-04-01 16:54:05.165234 | 172.16.0.10 | 10.0.0.21   | DNS      | 132    | Standard query 0x1ea0 Server failure A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net | 53         | 0              | 6.007022      |
| 774 | 2024-04-01 16:56:17.553531 | 172.16.0.10 | 10.0.0.21   | DNS      | 80     | Standard query 0xa20f Server failure AAAA db.contoso.com                                                  | 53         | 0              | 6.014926      |
| 891 | 2024-04-01 16:56:44.442334 | 172.16.0.10 | 10.0.0.21   | DNS      | 132    | Standard query 0xa279 Server failure A db.contoso.com.iosffyoulcwehgo1g3egb3m4oc.jx.internal.cloudapp.net | 53         | 0              | 6.044552      |

After you change the display filter, the status bar is updated to show the text **Packets: 1066 - Displayed: 8 (0.8%)**. Therefore, eight of the 1,066 packets, or 0.8 percent, were DNS responses that took five seconds or more to be received. However, on most clients, the default DNS time-out value is expected to be five seconds. This expectation means that, although the CoreDNS pods processed and delivered the eight responses, the client already ended the session by issuing a "timed out" error message. The **Info** column in the filtered results shows that all eight packets caused a server failure.

##### DNS packet analysis for all CoreDNS pods

In Wireshark, open the capture file of the CoreDNS pods that you merged earlier (*coredns-cap1.pcap*), and then open the DNS analysis, as described in the previous section. A Wireshark dialog box appears that displays the following table.

| Topic / Item                                 | Count       | Average | Min Val  | Max Val          | Rate (ms) | Percent    | Burst Rate | Burst Start |
|----------------------------------------------|-------------|---------|----------|------------------|-----------|------------|------------|-------------|
| &blacktriangledown; **Total Packets**        | **4540233** |         |          |                  | 7.3387    | 100%       | 84.7800    | 592.950     |
| &emsp;&blacktriangledown; rcode              | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&emsp;&emsp;**Server failure**         | **121781**  |         |          |                  | 0.1968    | **2.68%**  | 8.4600     | 599.143     |
| &emsp;&emsp;&emsp;No such name               | 574658      |         |          |                  | 0.9289    | 12.66%     | 10.9800    | 592.950     |
| &emsp;&emsp;&emsp;No error                   | 3843794     |         |          |                  | 6.2130    | 84.66%     | 73.2500    | 592.950     |
| &emsp;&blacktriangledown; opcodes            | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&emsp;&emsp;Standard query             | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&blacktriangledown; Query/Response     | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&emsp;&emsp;**Response**               | **2135116** |         |          |                  | 3.4512    | **47.03%** | 39.0400    | 581.680     |
| &emsp;&emsp;&emsp;**Query**                  | **2405117** |         |          |                  | 3.8876    | **52.97%** | 49.1400    | 592.950     |
| &emsp;&blacktriangledown; Query Type         | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&emsp;&emsp;SRV                        | 3647        |         |          |                  | 0.0059    | 0.08%      | 0.1800     | 586.638     |
| &emsp;&emsp;&emsp;PTR                        | 554630      |         |          |                  | 0.8965    | 12.22%     | 11.5400    | 592.950     |
| &emsp;&emsp;&emsp;NS                         | 15918       |         |          |                  | 0.0257    | 0.35%      | 0.7200     | 308.225     |
| &emsp;&emsp;&emsp;MX                         | 393016      |         |          |                  | 0.6353    | 8.66%      | 7.9700     | 426.930     |
| &emsp;&emsp;&emsp;AAAA                       | 384032      |         |          |                  | 0.6207    | 8.46%      | 8.4700     | 438.155     |
| &emsp;&emsp;&emsp;A                          | 3188990     |         |          |                  | 5.1546    | 70.24%     | 57.9600    | 592.950     |
| &emsp;&blacktriangledown; Class              | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &emsp;&emsp;&emsp;IN                         | 4540233     |         |          |                  | 7.3387    | 100.00%    | 84.7800    | 592.950     |
| &blacktriangledown; Service Stats            | 0           |         |          |                  | 0.0000    | 100%       | -          | -           |
| &emsp;&emsp;**request-response time (msec)** | 2109677     | 277.18  | 0.020000 | **12000.532227** | 3.4100    |            | 38.0100    | 581.680     |
| &emsp;&emsp;no. of unsolicited responses     | 25402       |         |          |                  | 0.0411    |            | 5.1400     | 587.832     |
| &emsp;&emsp;no. of retransmissions           | 37          |         |          |                  | 0.0001    |            | 0.0300     | 275.702     |
| &blacktriangledown; Response Stats           | 0           |         |          |                  | 0.0000    | 100%       | -          | -           |
| &emsp;&emsp;no. of questions                 | 4244830     | 1.00    | 1        | 1                | 6.8612    |            | 77.0500    | 581.680     |
| &emsp;&emsp;no. of authorities               | 4244830     | 0.39    | 0        | 11               | 6.8612    |            | 77.0500    | 581.680     |
| &emsp;&emsp;no. of answers                   | 4244830     | 1.60    | 0        | 22               | 6.8612    |            | 77.0500    | 581.680     |
| &emsp;&emsp;no. of additionals               | 4244830     | 0.29    | 0        | 26               | 6.8612    |            | 77.0500    | 581.680     |
| &blacktriangledown; Query Stats              | 0           |         |          |                  | 0.0000    | 100%       | -          | -           |
| &emsp;&emsp;Qname Len                        | 2405117     | 20.42   | 2        | 113              | 3.8876    |            | 49.1400    | 592.950     |
| &emsp;&blacktriangledown; Label Stats        | 0           |         |          |                  | 0.0000    |            | -          | -           |
| &emsp;&emsp;&emsp;4th Level or more          | 836034      |         |          |                  | 1.3513    |            | 16.1900    | 592.950     |
| &emsp;&emsp;&emsp;3rd Level                  | 1159513     |         |          |                  | 1.8742    |            | 23.8900    | 592.950     |
| &emsp;&emsp;&emsp;2nd Level                  | 374182      |         |          |                  | 0.6048    |            | 8.7800     | 592.955     |
| &emsp;&emsp;&emsp;1st Level                  | 35388       |         |          |                  | 0.0572    |            | 0.9200     | 294.492     |
| &emsp;Payload size                           | 4540233     | 89.87   | 17       | 1128             | 7.3387    | 100%       | 84.7800    | 592.950     |

The dialog box indicates that there were a combined total of about 4.5 million (4,540,233) packets, of which 2.68 percent caused server failure. The difference in query and response packet percentages shows that 5.94 percent of the queries (52.97 percent minus 47.03 percent) didn't receive a response. The maximum response time was 12 seconds (12,000.532227 milliseconds).

If you apply the display filter for query responses that took five seconds or more (`dns.time >= 5`), most of the packets in the filter results will indicate that a server failure occurred. This is probably because of a client "timed out" error.

The following table is a summary of the capture findings.

| Capture review criteria                                          | Yes      | No       |
|------------------------------------------------------------------|:--------:|:--------:|
| Difference between DNS queries and responses exceeds two percent | &#x2611; | &#x2610; |
| DNS latency is more than one second                              | &#x2611; | &#x2610; |

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

| Capture review criteria                                          | Yes      | No       |
|------------------------------------------------------------------|:--------:|:--------:|
| Difference between DNS queries and responses exceeds two percent | &#x2610; | &#x2610; |
| DNS latency is more than one second                              | &#x2610; | &#x2610; |

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

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

