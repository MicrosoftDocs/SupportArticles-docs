---
title: Troubleshoot DNS failures across an AKS cluster in real-time
description: Learns how to troubleshoot DNS failures across an AKS cluster in real-time using Inspektor Gadget.
ms.reviewer: qasimsarfraz, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.date: 06/05/2024
---
# Troubleshoot DNS failures across an AKS cluster in real-time

This article discusses methods for troubleshooting Domain Name System (DNS) failures across an Azure Kubernetes Service (AKS) cluster in real-time. DNS problems within Kubernetes can disrupt communication between pods, services, and external resources, which results in application failures and degraded performance.

> [!NOTE]
> This article is complementary to the [Troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md) guide.

## Symptoms

The following table outlines the common symptoms that you might observe in an AKS clusters:

| Symptom |Description|
|----|---|
| High error rate                 | DNS queries fail or return unexpected results, which can affect the performance and reliability of the applications that depend on them.                     |
| Unresponsive services           | DNS queries take longer than usual to resolve, which can cause delays or timeouts for the applications that rely on them.                                        |
| Service discovery is impacted      | Applications can't locate other applications in the cluster due to DNS issues, which can lead to service disruptions or failures.                              |
| External communication is impacted | Applications have trouble accessing external resources or endpoints outside the cluster due to DNS problems, which can result in errors or degraded performance. |

## Prerequisites

- Azure CLI.

    To install Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).
- A tool to connect to the cluster, such as the Kubernetes command line tool [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/).

    To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- [Inspektor Gadget](https://www.inspektor-gadget.io/).

    This tool is used in most troubleshooting steps covered in this article, so make sure to install it on the cluster. To install it on an AKS cluster, see [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).
- Familiarity with [Gadgets](../logs/capture-system-insights-from-aks.md#gadgets).
- [Inspektor Gadget DNS gadget](https://www.inspektor-gadget.io/docs/v0.28.0/builtin-gadgets/trace/dns/). It's used in all troubleshooting steps below.

## Troubleshooting step 1: Identify unsuccessful DNS responses across the cluster

You can identify all the unsuccessful DNS responses across the cluster using the DNS gadget. To perform this check, trace DNS packets on all the nodes and filter for unsuccessful responses using the following command:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,qtype,rcode --filter qr:R --filter qtype:A --filter 'rcode:!No Error'
K8S.NODE         K8S.NAMESPACE    K8S.POD     K8S.CONTAINER    NAME                  QTYPE        RCODE 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
```

Here are the explanations for the command parameters:

- `--all-namespaces`: Show data from pods in all namespaces.
- `-output columns=k8s,name,qtype,rcode`: Only show Kubernetes information, DNS name, query type, and result of DNS
  query.
- `--filter qr:R`: Only match the DNS responses.
- `--filter qtype:A`: Only match IPv4 hosts addresses.
- `--filter 'rcode:!No Error'`: Match DNS responses that don't contain `No Error`. For more information, see gopacket
  for [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194)
  or [relevant RFC](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L128-L148).

Here are some causes of unsuccessful DNS responses:

- Having a typo in the DNS name being resolved.
- Upstream DNS nameservers are facing issues.
- DNS name becomes invalid after expansion. To understand how DNS queries might be expanded using Pod's `/etc/resolv.conf`, see the [Namespaces of Services](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#namespaces-of-services) .

## Troubleshooting step 2: Identify slow DNS queries across the cluster

You can identify all the slow DNS queries across the cluster using the DNS gadget. To perform this check, trace DNS packets on all the nodes and filter slow responses. 

In the following example, you're using latency value of `5ms` to define slow packets. You can change it to a desired value, for example, `5μs`, `20ms`, `1s`:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,rcode,latency --filter 'latency:>5ms'
K8S.NODE        K8S.NAMESPACE      K8S.POD       K8S.CONTAINER      NAME                            RCODE              LATENCY            
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
``` 

Here are the explanations for the command parameters:

- `--all-namespaces`: Show data from pods in all namespaces.
- `--output columns=k8s,name,rcode,latency`: Only show Kubernetes information, DNS name, DNS response result, and
  response latency.
- `--filter 'latency:>5ms'`: Only match DNS response that has at least `5 millisecond` latency.

Here are some causes of slow DNS queries:

- Upstream DNS nameservers are facing issues.
- Networking issues in the cluster.
- Unavailability of CoreDNS pods. To verify the pods are running fine, follow the troubleshooting steps in [Troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md).

## Troubleshooting step 3: Verify the health of upstream DNS servers

You can verify the health of upstream DNS servers used by CoreDNS using the DNS gadget. If applications try
to reach external domains, the queries are forwarded to upstream DNS servers via CoreDNS. To understand the health
of these queries, trace DNS packets leaving CoreDNS pods and filter by the nameserver.

In the following example, the [default Azure DNS Server](/azure/virtual-network/what-is-ip-address-168-63-129-16) (IP address 168.63.129.16) is used as the upstream nameserver. If you're using a custom DNS server, you can use the IP address of the custom DNS server as the upstream nameserver. You can get the IP address by looking up */etc/resolv.conf* on the node.

```bash
$ kubectl gadget trace dns -n kube-system -l k8s-app=kube-dns -o columns=k8s,id,qr,name,rcode,nameserver,latency -F nameserver:168.63.129.16
K8S.NODE    K8S.NAMESPACE   K8S.POD                        K8S.CONTAINER   ID        QR    NAME               RCODE           NAMESERVER              LATENCY
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      Q     microsoft.com.                     168.63.129.16
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      R     microsoft.com.     No Error        168.63.129.16           500.821223ms
```

Here are the explanations for the command parameters:

- `-n kube-system`: Only show data from the `kube-system` namespace.
- `-l k8s-app=kube-dns`: Only show data to/from pods with labels `k8s-app=kube-dns` (CoreDNS pods).
- `-o columns=k8s,id,name,rcode,nameserver,latency`: Only show Kubernetes information, DNS query ID, query/response,
  DNS name, DNS response result, nameserver, and response latency.
- `-F nameserver:168.63.129.16`: The upstream DNS server used to filter events.

You can use `ID`, `RCODE` and `LATENCY` values to establish the health of the upstream DNS server. For example, if there's an unhealthy upstream server, you see the folllowing output:

- DNS query (`QR=Q`) with an `ID` (for example, `b256`) doesn't have a matching response.
- DNS response (`QR=R`) has a high value under the `LATENCY` column (for example, `500.821223ms`).
- DNS response (`QR=R`) has `RCODE` other than `No Error`, for example, Server Failure and Query Refused. For more
  information, see gopacket for [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194).

## Troubleshooting step 4: Verify DNS queries get responses in a timely manner

You can verify that a particular DNS query gets a response in a timely manner by using DNS gadget. To perform this check, filter events with a DNS name and match the query/response IDs:

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

Here are the explanations for the command parameters:

- `-l app=test-pod`: Only show data to/from pods with the label `app=test-pod`.
- `--output columns=k8s,id,qtype,qr,name,rcode,latency`: Only show Kubernetes information, DNS query ID, query type, query/response, DNS name, DNS response result, and response latency.
- `--filter name:microsoft.com.`: Only match DNS packets with the DNS name `microsoft.com.`. To ensure that the filter value is Fully Qualified Domain Name (**FQDN**), add dot (`.`) at the end of the name.

The `ID` value (for example, `97b3`) can be used to correlate the queries with responses. You also can use the `LATENCY` value to validate that you get the responses in a timely manner.

## Troubleshooting step 5: Verify DNS responses contain expected IP addresses

You can verify that a particular DNS query gets an expected response by using DNS gadget. For example, for a [headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) (named *myheadless*), you would expect the response to contain IP addresses for all the pods.

```bash
$ kubectl gadget trace dns -l app=test-pod  -o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses  -F name:~myheadless 
K8S.NODE         K8S.NAMESPACE      K8S.POD         K8S.CONTAINER   ID    QTYPE   QR  NAME                 RCODE           NUMANSWERS     ADDRESSES
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       Q   myheadless.defau...                  0                              
```

Here are the explanations for the command parameters:

- `-l app=test-pod`: Only show data to/from pods with the label `app=test-pod`.
- `-o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses`: Only show Kubernetes information, DNS query ID, query
  type, query/response, DNS name, DNS response result, the number of answers, and IP addresses in the response.
- `-F name:~myheadless`: Only include DNS packets that pass the `~headless` regex check.

You can use `NUMANSWERS` and `ADDRESSES` values to match against the values you get from `kubectl get ep myheadless`.

```bash
$ kubectl get ep myheadless 
NAME                  ENDPOINTS                           AGE 
my-headless-service   10.244.2.18:8080,10.244.2.19:8080   10d 
```

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
