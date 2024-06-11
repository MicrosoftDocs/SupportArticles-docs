---
title: Troubleshoot DNS failures across an AKS cluster in real time
description: Learn how to troubleshoot DNS failures across an AKS cluster in real time using Inspektor Gadget.
ms.reviewer: qasimsarfraz, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.date: 06/11/2024
---
# Troubleshoot DNS failures across an AKS cluster in real time

Domain Name System (DNS) problems within Kubernetes can disrupt communications between pods, services, and external resources, which results in application failures and performance degradation. This article discusses how to troubleshoot DNS failures across an Azure Kubernetes Service (AKS) cluster in real time.

> [!NOTE]
> This article complements the [Troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md) guide.

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
- [Inspektor Gadget](https://www.inspektor-gadget.io/).

    This tool is used in most troubleshooting steps covered in this article, so make sure to install it on the cluster. To install it on an AKS cluster, see [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).
- Familiarity with [gadgets](../logs/capture-system-insights-from-aks.md#gadgets).
- [Inspektor Gadget DNS gadget](https://www.inspektor-gadget.io/docs/v0.28.0/builtin-gadgets/trace/dns/).

  It's used in all the following troubleshooting steps.

To troubleshoot DNS failures across an AKS cluster, use the instructions in the following sections.

## Step 1: Identify unsuccessful DNS responses across the cluster

You can use the DNS gadget to identify all the unsuccessful DNS responses across the cluster. To perform this check, trace DNS packets on all the nodes and filter unsuccessful responses using the following command:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,qtype,rcode --filter qr:R --filter qtype:A --filter 'rcode:!No Error'
K8S.NODE         K8S.NAMESPACE    K8S.POD     K8S.CONTAINER    NAME                  QTYPE        RCODE 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
```

Here are the explanations of the command parameters:

- `--all-namespaces`: Shows data from pods in all namespaces.
- `-output columns=k8s,name,qtype,rcode`: Shows only Kubernetes information, DNS name, query type, and DNS
  query result.
- `--filter qr:R`: Matches only DNS responses.
- `--filter qtype:A`: Matches only IPv4 host addresses.
- `--filter 'rcode:!No Error'`: Matches DNS responses that don't contain `No Error`. For more information, see `gopacket`
  for [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194)
  or the [relevant RFC](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L128-L148).

Here are some causes of unsuccessful DNS responses:

- The DNS name being resolved has a typo.
- The upstream DNS nameservers experience issues.
- The DNS name becomes invalid after expansion. To understand how DNS queries might be expanded using a pod's `/etc/resolv.conf`, see [Namespaces of Services](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#namespaces-of-services).

## Step 2: Identify slow DNS queries across the cluster

You can use the DNS gadget to identify all the slow DNS queries across the cluster. To perform this check, trace DNS packets on all the nodes and filter slow responses. 

In the following example, you're using a latency value of `5ms` to define slow packets. You can change it to a desired value, for example, `5μs`, `20ms`, `1s`:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,rcode,latency --filter 'latency:>5ms'
K8S.NODE        K8S.NAMESPACE      K8S.POD       K8S.CONTAINER      NAME                            RCODE              LATENCY            
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
``` 

Here are the explanations of the command parameters:

- `--all-namespaces`: Shows data from pods in all namespaces.
- `--output columns=k8s,name,rcode,latency`: Shows only Kubernetes information, DNS name, DNS response result, and
  response latency.
- `--filter 'latency:>5ms'`: Matches only DNS responses with a latency of at least `5 ms`.

Here are some causes of slow DNS queries:

- The upstream DNS nameservers experience issues.
- Networking issues in the cluster.
- The CoreDNS pods are unavailable. To verify the pods are running fine, follow the troubleshooting steps in [Troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

## Step 3: Verify the health of the upstream DNS servers

You can use the DNS gadget to verify the health of the upstream DNS servers used by CoreDNS. If applications try
to reach external domains, the queries are forwarded to the upstream DNS servers via CoreDNS. To understand the health
of these queries, trace the DNS packets leaving the CoreDNS pods and filter by the nameserver.

In the following example, the [default Azure DNS Server](/azure/virtual-network/what-is-ip-address-168-63-129-16) (IP address 168.63.129.16) is used as the upstream nameserver. If you're using a custom DNS server, you can use the IP address of the custom DNS server as the upstream nameserver. You can get the IP address by looking up */etc/resolv.conf* on the node.

```bash
$ kubectl gadget trace dns -n kube-system -l k8s-app=kube-dns -o columns=k8s,id,qr,name,rcode,nameserver,latency -F nameserver:168.63.129.16
K8S.NODE    K8S.NAMESPACE   K8S.POD                        K8S.CONTAINER   ID        QR    NAME               RCODE           NAMESERVER              LATENCY
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      Q     microsoft.com.                     168.63.129.16
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      R     microsoft.com.     No Error        168.63.129.16           500.821223ms
```

Here are the explanations of the command parameters:

- `-n kube-system`: Shows only data from the `kube-system` namespace.
- `-l k8s-app=kube-dns`: Shows only data to/from pods with the label `k8s-app=kube-dns` (CoreDNS pods).
- `-o columns=k8s,id,name,rcode,nameserver,latency`: Shows only Kubernetes information, DNS query ID, query/response,
  DNS name, DNS response result, nameserver, and response latency.
- `-F nameserver:168.63.129.16`: The upstream DNS server used to filter events.

You can use the `ID`, `RCODE`, and `LATENCY` values to determine the health of the upstream DNS server. For example, if there's an unhealthy upstream server, you see the following output:

- A DNS query (`QR=Q`) with an `ID` (for example, `b256`) has no matching response.
- A DNS response (`QR=R`) has a high value under the `LATENCY` column (for example, `500.821223ms`).
- A DNS response (`QR=R`) has an `RCODE` other than `No Error`, for example, "Server failure" and "Query refused." For more
  information, see `gopacket` for [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194).

## Step 4: Verify DNS queries get responses in a timely manner

You can use the DNS gadget to verify that a particular DNS query gets a response in a timely manner. To perform this check, filter the events with a DNS name and match the query/response IDs:

```bash
$ kubectl gadget trace dns -l app=test-pod --output columns=k8s,id,qtype,qr,name,rcode,latency --filter name:microsoft.com.
K8S.NODE       K8S.NAMESPACE   K8S.POD     K8S.CONTAINER   ID          QTYPE     QR  NAME              RCODE               LATENCY
aks-agen...    default         test-pod    nginx           97b3        A         Q   microsoft.com.
aks-agen...    default         test-pod    nginx           97b3        A         R   microsoft.com.    No Error            1.954413ms
aks-agen...    default         test-pod    nginx           97b3        A         R   microsoft.com.    No Error
aks-agen...    default         test-pod    nginx           c6c5        AAAA      Q   microsoft.com.
aks-agen...    default         test-pod    nginx           c6c5        AAAA      R   microsoft.com.    No Error            1.885412ms
aks-agen...    default         test-pod    nginx           c6c5        AAAA      R   microsoft.com.    No Error
```

Here are the explanations of the command parameters:

- `-l app=test-pod`: Shows only data to/from pods with the label `app=test-pod`.
- `--output columns=k8s,id,qtype,qr,name,rcode,latency`: Shows only Kubernetes information, DNS query ID, query type, query/response, DNS name, DNS response result, and response latency.
- `--filter name:microsoft.com.`: Matches only DNS packets with the DNS name `microsoft.com.` To ensure that the filter value is a fully qualified domain name (**FQDN**), add a dot (`.`) to the end of the name.

The `ID` value (for example, `97b3`) can be used to correlate the queries with responses. You also can use the `LATENCY` value to validate that you get the responses in a timely manner.

## Step 5: Verify DNS responses contain the expected IP addresses

You can use the DNS gadget to verify that a particular DNS query gets the expected response. For example, for a [headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) (named *myheadless*), you would expect the response to contain the IP addresses of all the pods.

```bash
$ kubectl gadget trace dns -l app=test-pod  -o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses  -F name:~myheadless 
K8S.NODE         K8S.NAMESPACE      K8S.POD         K8S.CONTAINER   ID    QTYPE   QR  NAME                 RCODE           NUMANSWERS     ADDRESSES
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       Q   myheadless.defau...                  0                              
```

Here are the explanations of the command parameters:

- `-l app=test-pod`: Shows only data to/from pods with the label `app=test-pod`.
- `-o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses`: Shows only Kubernetes information, DNS query ID, query
  type, query/response, DNS name, DNS response result, number of answers, and IP addresses in the response.
- `-F name:~myheadless`: Includes only DNS packets that pass the `~myheadless` regex check.

You can use the `NUMANSWERS` and `ADDRESSES` values to match the values you get from `kubectl get ep myheadless`.

```bash
$ kubectl get ep myheadless 
NAME                  ENDPOINTS                           AGE 
myheadless            10.244.2.18:8080,10.244.2.19:8080   10d 
```

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
