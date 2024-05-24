---
title: Troubleshoot DNS failures across an AKS cluster in real-time
description: Learn how to troubleshoot DNS failures across an AKS cluster in real-time using Inspektor Gadget.
author: mqasimsarfraz
ms.author: qasimsarfraz
ms.topic: troubleshooting-general
ms.date: 05/25/2024
---

# Troubleshoot DNS failures across an AKS cluster in real-time

This article discusses methods for troubleshooting DNS (Domain Name System) failures across an AKS cluster in real-time.
DNS problems within Kubernetes can disrupt communication between pods, services, and external resources leading to
application failures and degraded performance. The guide is complementary
to [troubleshoot DNS resolution failures from inside the pod](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md)
guide.

## Prerequisites

- Azure CLI. To install Azure CLI, refer to the [installation guide](/cli/azure/install-azure-cli).
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to
  the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run
  the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- [Inspektor Gadget](https://www.inspektor-gadget.io/) tool. To install on an AKS cluster, refer to the
  [installation guide](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster).
- Familiarity
  with [Gadgets](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#gadgets).
  You use [Inspektor Gadget DNS gadget](https://www.inspektor-gadget.io/docs/v0.28.0/builtin-gadgets/trace/dns/) to
  troubleshoot all the scenarios.

## Symptoms

The following table outlines the common symptoms that one might observe in an AKS clusters:

| Symptom                         | Description                                                                                                                                                            |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| High Error Rate                 | DNS queries are failing or returning unexpected results, which can affect the performance and reliability of the applications that depend on them.                     |
| Unresponsive Services           | DNS queries are taking longer than usual to resolve, which can cause delays or timeouts for the applications that rely on them.                                        |
| Service Discovery Impacted      | Applications are unable to locate other applications in the cluster due to DNS issues, which can lead to service disruptions or failures.                              |
| External Communication Impacted | Applications are having trouble accessing external resources or endpoints outside the cluster due to DNS problems, which can result in errors or degraded performance. |

## Troubleshooting check list

Most scenarios covered in this guide use [Inspektor Gadget](https://inspektor-gadget.io/), so make sure to
install it on the cluster. To install on an AKS cluster, refer to
the [installation guide](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster).

### Scenario 1: Identify unsuccessful DNS responses across the cluster

You can identify all the unsuccessful DNS responses across the cluster using the DNS gadget. To perform this check, you
need to trace DNS packets on all the nodes and filter for unsuccessful responses using:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,qtype,rcode --filter qr:R --filter qtype:A --filter 'rcode:!No Error'
K8S.NODE         K8S.NAMESPACE    K8S.POD     K8S.CONTAINER    NAME                  QTYPE        RCODE 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
aks-agen...      default          test-pod    nginx            myaks-troubleshoot.   A            Non-Existent Domain 
```

Where:

- `--all-namespaces`: Show data from pods in all namespaces.
- `-output columns=k8s,name,qtype,rcode`: Only show Kubernetes information, DNS name, query type, and result of DNS
  query.
- `--filter qr:R`: Only match the DNS responses.
- `--filter qtype:A`: Only match IPv4 hosts addresses.
- `--filter 'rcode:!No Error'`: Match DNS responses that don't contain `No Error`. For more information, see gopacket
  for
  [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194)
  or [relevant RFC](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L128-L148).

#### Cause

- Having a typo in the DNS name being resolved.
- Upstream DNS nameservers are facing issues.
- DNS name becomes invalid after expansion. Refer to
  the [guide](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#namespaces-of-services) to
  understand how DNS queries might be expanded using Pod's `/etc/resolv.conf`.

## Scenario 2: Identify slow DNS queries across the cluster

You can identify all the slow DNS queries across the cluster using the DNS gadget. To perform this check, you need to
trace DNS packets on all the nodes and filter slow responses. In this case, you're using latency value of `5ms` to
define slow packets but feel free to change it to a desired value, for example, `5μs`, `20ms`, `1s`:

```bash
$ kubectl gadget trace dns --all-namespaces --output columns=k8s,name,rcode,latency --filter 'latency:>5ms'
K8S.NODE        K8S.NAMESPACE      K8S.POD       K8S.CONTAINER      NAME                            RCODE              LATENCY            
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
aks-agen...     kube-system        coredn...     coredns            global.prod.micro...            No Error           5.373123ms 
``` 

Where:

- `--all-namespaces`: Show data from pods in all namespaces.
- `--output columns=k8s,name,rcode,latency`: Only show Kubernetes information, DNS name, DNS response result, and
  response latency.
- `--filter 'latency:>5ms'`: Only match DNS response that has at least `5 millisecond` latency.

#### Causes

- Upstream DNS nameservers are facing issues.
- Networking issues in the Cluster.
- Unavailability of CoreDNS pods. You can use steps from
  the [above-mentioned guide](troubleshoot-dns-failure-from-pod-but-not-from-worker-node.md)
  to verify the pods are running fine.

### Scenario 3: Verify the health of Upstream DNS servers

You can verify the health of Upstream DNS servers used by CoreDNS using the DNS gadget. If applications are trying
to reach external domains, the queries are forwarded to upstream DNS servers via CoreDNS. To understand the health
of these queries, you need to trace DNS packets leaving CoreDNS pods and filter by nameserver. In this scenario, you use
the [default Azure DNS Server](/azure/virtual-network/what-is-ip-address-168-63-129-16) (`168.63.129.16`)
as the upstream nameserver but feel free to use any other value (for example, by looking up `/etc/resolv.conf` on the
node) in case you're using a custom DNS server:

```bash
$ kubectl gadget trace dns -n kube-system -l k8s-app=kube-dns -o columns=k8s,id,qr,name,rcode,nameserver,latency -F nameserver:168.63.129.16
K8S.NODE    K8S.NAMESPACE   K8S.POD                        K8S.CONTAINER   ID        QR    NAME               RCODE           NAMESERVER              LATENCY
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      Q     microsoft.com.                     168.63.129.16
aks-agen... kube-system     coredns-6d5bb68c46-ntz2q       coredns         b256      R     microsoft.com.     No Error        168.63.129.16           500.821223ms
```

Where:

- `-n kube-system`: Only show data from the `kube-system` namespace.
- `-l k8s-app=kube-dns`: Only show data to/from pods with labels `k8s-app=kube-dns` (CoreDNS pods).
- `-o columns=k8s,id,name,rcode,nameserver,latency`: Only show Kubernetes information, DNS query ID, query / response,
  DNS name, DNS response result, nameserver, and response latency.
- `-F nameserver:168.63.129.16`: Upstream DNS server used to filter events.

Here you can use `ID`, `RCODE` and `LATENCY` to establish the health of the Upstream DNS server. For example, if there's
an unhealthy upstream server, you can expect that:

- DNS query (`QR=Q`) with an `ID` (for example, `b256`) doesn't have a matching response.
- DNS response (`QR=R`) has a high column value under `LATENCY` (for example, `500.821223ms`).
- DNS response (`QR=R`) has `RCODE` other than `No Error` for example, Server Failure, Query Refused, etc. For more
  information, see gopacket
  for [possible values of rcode](https://github.com/google/gopacket/blob/32ee38206866f44a74a6033ec26aeeb474506804/layers/dns.go#L151-L194)

### Scenario 4: Verify DNS queries are getting responses timely manner

You can verify that a particular DNS query is getting a response in a timely manner using DNS gadget. To perform this
check, you need to filter events with DNS name you're interested in and match the query / response IDs:

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

Where:

- `-l app=test-pod`: Only show data to/from pods with labels `app=test-pod`.
- `--output columns=k8s,id,qtype,qr,name,rcode,latency`: Only show Kubernetes information, DNS query ID, query type,
  query /
  response, DNS name, DNS response result, and response latency.
- `-F name:microsoft.com.`: Only match DNS packets with DNS name `microsoft.com.`. Ensure the filter value is
  Fully Qualified Domain Name (**FQDN**), so make sure to add dot (`.`) at the end of the name.

Here `ID` column value (for example, `97b3`) can be used to correlate the queries with responses. Also, you can use
the `LATENCY` column to validate you're getting the responses in a timely manner.

### Scenario 5:  Verify DNS responses contain the expected IP addresses

You can verify that a particular DNS query is getting an expected response by using DNS gadget. For example, for
a [headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) (named
`myheadless`) you would expect the response to contain IP addresses for all the pods:

```bash
$ kubectl gadget trace dns -l app=test-pod  -o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses  -F name:~myheadless 
K8S.NODE         K8S.NAMESPACE      K8S.POD         K8S.CONTAINER   ID    QTYPE   QR  NAME                 RCODE           NUMANSWERS     ADDRESSES
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       R   myheadless.defau...  No Error        2              10.244.2.18,10.244.2.19 
aks-agen...      default            test-pod        nginx           f930  A       Q   myheadless.defau...                  0                              
```

Where:

- `-l app=test-pod`: Only show data to/from pods with labels `app=test-pod`.
- `-o columns=k8s,id,qtype,qr,name,rcode,numAnswers,addresses`: Only show Kubernetes information, DNS query ID, query
  type,
  query / response, DNS name, DNS response result, number of answers, and IP addresses in the response.
- `-F name:~myheadless`: Only include DNS packets that pass the `~headless` regex check.

Here you can use `NUMANSWERS` and `ADDRESSES` to match against the values you get from `kubectl get ep myheadless`.

```bash
$ kubectl get ep myheadless 
NAME                  ENDPOINTS                           AGE 
my-headless-service   10.244.2.18:8080,10.244.2.19:8080   10d 
```

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
