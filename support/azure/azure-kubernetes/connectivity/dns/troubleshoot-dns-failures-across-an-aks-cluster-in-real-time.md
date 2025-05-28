---
title: Troubleshoot DNS failures across an AKS cluster in real time
description: Learn how to troubleshoot DNS failures across an AKS cluster in real time using Inspektor Gadget.
ms.reviewer: qasimsarfraz, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.date: 08/09/2024
---
# Real-time DNS traffic analysis to troubleshoot DNS resolution failures in AKS

This article discusses how to troubleshoot Domain Name System (DNS) failures across an Azure Kubernetes Service (AKS) cluster in real time.

> [!NOTE]
> This article is complementary to [Basic troubleshooting of DNS resolution problems in AKS](basic-troubleshooting-dns-resolution-problems.md) guide.

## Symptoms

The following table outlines common symptoms that you might observe in an AKS cluster:

| Symptom |Description|
|----|---|
| High error rate                 | DNS queries fail or return unexpected results, which can affect the performance and reliability of applications that depend on them.                     |
| Unresponsive services           | DNS queries take longer than usual to resolve, which can cause delays or time-outs in applications that rely on them.                                        |
| Service discovery is impacted      | Applications can't locate other applications in the cluster due to DNS issues, which can lead to service disruptions or failures.                              |
| External communication is impacted | Applications have trouble accessing external resources or endpoints outside the cluster due to DNS problems, which can result in errors or degraded performance. |

## Prerequisites

- Azure CLI.

    To install Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).
- A tool to connect to the cluster, such as the Kubernetes command-line tool [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/).

    To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072).

    This tool is used in most troubleshooting steps covered in this article, so make sure to install it on the cluster. To install it on an AKS cluster, see [How to install Inspektor Gadget in an AKS cluster](../../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).
- Familiarity with [gadgets](../../logs/capture-system-insights-from-aks.md#gadgets).
- [Inspektor Gadget DNS gadget](https://go.microsoft.com/fwlink/?linkid=2260317).

  It's used in all the following troubleshooting steps.

To troubleshoot DNS failures across an AKS cluster, use the instructions in the following sections. Before we start, export the gadget version to a variable. This variable is used in all the commands in this article.

```bash
GADGET_VERSION=$(kubectl gadget version | grep Server | awk '{print $3}')
```

Please feel free to choose a different version. For example, you can use `latest` or `main` to get the latest stable or development version of the gadget respectively.

## Step 1: Identify unsuccessful DNS responses across the cluster

You can use the DNS gadget to identify all the unsuccessful DNS responses across the cluster. To perform this check, trace DNS packets on all the nodes and filter unsuccessful responses.

```bash
kubectl gadget run trace_dns:$GADGET_VERSION \
  --all-namespaces \
  --fields k8s.node,src,dst,name,qtype,rcode \
  --filter "qr==R,rcode!=Success"
```

Here are the explanations of the command parameters:

- `--all-namespaces`: Shows data from pods in all namespaces.
- `--fields k8s.node,src,dst,name,qtype,rcode`: Shows only Kubernetes information, source and destination of the DNS packets, DNS name, DNS query type, and DNS response code.
- `--filter "qr==R,rcode!=Success"`: Matches only DNS responses (`qr==R`) with a response code other than `Success`.

The output should look similar to the following:

```output
K8S.NODE                      SRC                                    DST                                    NAME                         QTYPE           RCODE   
aks-agentpool-…919-vmss000000 p/kube-system/coredns-57d886c994-r2ts… p/default/mypod:38480                  myaks-troubleshoot.          A               NameError
aks-agentpool-…919-vmss000000 s/kube-system/kube-dns:53              p/default/mypod:38480                  myaks-troubleshoot.          A               NameError
```

Where `RCODE` is the DNS response code and helps you identify the type of DNS failure. 

Here are some causes of unsuccessful DNS responses:

- The DNS name being resolved has a typo.
- The upstream DNS nameservers experience issues.
- A misconfigured networking configuration (such as NetworkPolicy (NetPol), firewall or NSG rules) blocks DNS traffic.
- The DNS name becomes invalid after expansion.

  To understand how DNS queries might be expanded using the `/etc/resolv.conf` file of a pod, see [Namespaces of Services](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#namespaces-of-services).

## Step 2: Identify slow DNS queries across the cluster

You can use the DNS gadget to identify all the slow DNS queries across the cluster. To perform this check, trace DNS packets on all the nodes and filter slow responses.

In the following example, you're using a latency value of `5ms` to define slow packets. You can change it to a desired value, for example, `5μs`, `20ms`, `1s`:

```bash
kubectl gadget run trace_dns:$GADGET_VERSION \
  --all-namespaces \
  --fields k8s.node,src,dst,name,qtype,rcode,latency_ns \
  --filter "latency_ns_raw>5000000"
```

Here are the explanations of the command parameters:

- `--all-namespaces`: Shows data from pods in all namespaces.
- `--fields k8s.node,src,dst,name,qtype,rcode,latency_ns`: Shows only Kubernetes information, source and destination of the DNS packets, DNS name, DNS query type, DNS response code, and latency in nanoseconds.
- `--filter "latency_ns_raw>5000000"`: Matches only DNS responses with latency greater than `5ms` (`5000000` nanoseconds).

The output should look similar to the following:

```output
K8S.NODE                   SRC                                DST                               NAME                      QTYPE         RCODE          LATENCY_NS
aks-agentpool…9-vmss000001 168.63.129.16:53                   p/kube-system/coredns-57d886c994… microsoft.com.            A             Success           14.02ms
aks-agentpool…9-vmss000000 s/kube-system/kube-dns:53          p/default/mypod:39168             microsoft.com.            A             Success           15.40ms
aks-agentpool…9-vmss000000 168.63.129.16:53                   p/kube-system/coredns-57d886c994… microsoft.com.            AAAA          Success            5.90ms
aks-agentpool…9-vmss000000 s/kube-system/kube-dns:53          p/default/mypod:38953             microsoft.com.            AAAA          Success            6.41ms
```

Here are some causes of slow DNS queries:

- The upstream DNS nameservers experience issues.
- Networking issues in the cluster.

## Step 3: Verify the health of the upstream DNS servers

You can use the DNS gadget to verify the health of the upstream DNS servers used by CoreDNS. If applications try
to reach external domains, the queries are forwarded to the upstream DNS servers via CoreDNS. To understand the health
of these queries, trace the DNS packets leaving the CoreDNS pods and filter by the nameserver.

In the following example, the [default Azure DNS Server](/azure/virtual-network/what-is-ip-address-168-63-129-16) (IP address 168.63.129.16) is used as the upstream nameserver. If you're using a custom DNS server, you can use the IP address of the custom DNS server as the upstream nameserver. You can get the IP address by looking up */etc/resolv.conf* on the node.

```bash
kubectl gadget run trace_dns:$GADGET_VERSION \
  --all-namespaces \
  --fields src,dst,id,qr,name,nameserver,rcode,latency_ns \
  --filter "nameserver.addr==168.63.129.16"
```

Here are the explanations of the command parameters:
- `--all-namespaces`: Shows data from pods in all namespaces.
- `--fields src,dst,id,qr,name,nameserver,rcode,latency_ns`: Shows only source and destination of the DNS packets, DNS query ID, query/response, DNS name, nameserver, DNS response result, and latency in nanoseconds.
- `--filter "nameserver.addr==168.63.129.16" `: Matches only DNS packets with the nameserver IP address `168.63.129.16`.

The output should look similar to the following:

```output
SRC                                        DST                                        ID                QR NAME                           NAMESERVER       RCODE              LATENCY_NS
p/kube-system/coredns-57d886c994-vsj7g:60… r/168.63.129.16:53                         4828              Q  qasim-cluster-dns-sqia0j5i.hc… 168.63.129.16                              0ns
p/kube-system/coredns-57d886c994-pcv59:51… r/168.63.129.16:53                         5015              Q  qasim-cluster-dns-sqia0j5i.hc… 168.63.129.16                              0ns
r/168.63.129.16:53                         p/kube-system/coredns-57d886c994-pcv59:51… 5015              R  qasim-cluster-dns-sqia0j5i.hc… 168.63.129.16    Success                5.06ms
r/168.63.129.16:53                         p/kube-system/coredns-57d886c994-vsj7g:60… 4828              R  qasim-cluster-dns-sqia0j5i.hc… 168.63.129.16    Success               23.01ms
```

You can use the `RCODE`, and `LATENCY` values to determine the health of the upstream DNS server. For example, if there's an unhealthy upstream server, you see the following output:

- A DNS query (`QR=Q`) with an ID (for example, `4828`) has no matching response.
- A DNS response (`QR=R`) has a high value under the `LATENCY_NS` column (for example, `23.01ms`).
- A DNS response (`QR=R`) has an `RCODE` other than `Success`, for example, "ServerFailure" and "Refused".

## Step 4: Verify DNS queries get responses in a timely manner

You can use the DNS gadget to verify that a particular DNS query gets a response in a timely manner. To perform this check, filter the events with a DNS name and match the query/response IDs:

```bash
kubectl gadget run trace_dns:$GADGET_VERSION \
    -l app=test-pod \
    --fields k8s.node,k8s.namespace,k8s.podname,id,qtype,qr,name,rcode,latency_ns \
    --filter name==microsoft.com.
```

Here are the explanations of the command parameters:
- `-l app=test-pod`: Shows only data to/from pods with the label `app=test-pod` in the default namespace.
- `--fields k8s.node,k8s.namespace,k8s.podname,id,qtype,qr,name,rcode,latency_ns`: Shows only Kubernetes information, DNS query ID, query type, query/response, DNS name, DNS response result, and latency in nanoseconds.
- `--filter name==microsoft.com.`: Matches only DNS packets with the DNS name `microsoft.com.` Ensure that the filter value is a fully qualified domain name (**FQDN**) by adding a dot (`.`) to the end of the name.

The output should look similar to the following:

```output
K8S.NODE                  K8S.NAMESPACE             K8S.PODNAME               ID             QTYPE          QR NAME                     RCODE          LATENCY_NS
aks-agentpoo…9-vmss000000 default                   mypod                     102d           A              Q  microsoft.com.                                 0ns
aks-agentpoo…9-vmss000000 default                   mypod                     102d           A              R  microsoft.com.           Success           11.87ms
aks-agentpoo…9-vmss000000 default                   mypod                     d482           AAAA           Q  microsoft.com.                                 0ns
aks-agentpoo…9-vmss000000 default                   mypod                     d482           AAAA           R  microsoft.com.           Success            9.27ms
```

The `ID` value (for example, `102d`) can be used to correlate the queries with responses. You also can use the `LATENCY_NS` value to validate that you get the responses in a timely manner.

## Step 5: Verify DNS responses contain the expected IP addresses

You can use the DNS gadget to verify that a particular DNS query gets the expected response. For example, for a [headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) (named *myheadless*), you would expect the response to contain the IP addresses of all the pods.

```bash
kubectl gadget run trace_dns:$GADGET_VERSION \
  --fields k8s.podname,id,qtype,qr,name,rcode,num_answers,addresses  \
  --filter name~myheadless
```

Here are the explanations of the command parameters:
- `--fields k8s.podname,id,qtype,qr,name,rcode,num_answers,addresses`: Shows only Kubernetes information, DNS query ID, query type, query/response, DNS name, DNS response result, number of answers, and IP addresses in the response.
- `--filter name~myheadless`: Matches only DNS packets with the DNS name that contains `myheadless`. The `~` operator is used to match a regex.

The output should look similar to the following:

```output
K8S.PODNAME                           ID                   QTYPE                QR NAME                                 RCODE     NUM_ANSWERS ADDRESSES          
mypod                                 f8b0                 A                    Q  myheadless.default.svc.cluster.loca…           0                              
mypod                                 f8b0                 A                    R  myheadless.default.svc.cluster.loca… Success   2           10.244.0.146,10.24…
mypod                                 abcd                 AAAA                 Q  myheadless.default.svc.cluster.loca…           0                              
mypod                                 abcd                 AAAA                 R  myheadless.default.svc.cluster.loca… Success   0                              
```

You can use the `NUM_ANSWERS` and `ADDRESSES` values to match the values you get from `kubectl get ep myheadless`.

```bash
kubectl get ep myheadless 
NAME                  ENDPOINTS                           AGE 
myheadless            10.244.0.146:80,10.244.1.207:80   10d 
```

[!INCLUDE [Third-party information disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
