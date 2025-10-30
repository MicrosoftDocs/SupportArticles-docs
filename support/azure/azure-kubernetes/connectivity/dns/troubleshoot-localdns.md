---
title: Troubleshooting LocalDNS on AKS
description: Learn how to create a troubleshooting workflow to fix issues seen with LocalDNS in Azure Kubernetes Service (AKS).
author: vaibhavarora
ms.author: vaibhavarora
ms.date: 09/17/2025
ms.reviewer: v-rekhanain, v-leedennis, josebl, v-weizhu, qasimsarfraz
editor: vaibhavarora
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to learn how to create a troubleshooting workflow so that I can fix LocalDNS problems in Azure Kubernetes Service (AKS).
---
# Troubleshoot issues with LocalDNS on Azure Kubernetes Service (AKS)

This article discusses how to create a troubleshooting workflow to fix Domain Name System (DNS) resolution problems in Azure Kubernetes Service (AKS), when using LocalDNS. To learn more about LocalDNS, you can read our overview in [DNS Resolution in Azure Kubernetes Service (AKS)](/azure/aks/dns-concepts#localdns-in-azure-kubernetes-service-preview).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool

   **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [systemctl](https://man7.org/linux/man-pages/man1/systemctl.1.html) command-line tool.

- The [journalctl](https://www.man7.org/linux/man-pages/man1/journalctl.1.html) command-line tool.

## Identifying patterns in DNS failures
Before you begin diagnosing the issues seen with LocalDNS, identify potential patterns with your DNS failures. Some patterns include:
1. DNS resolution failure - is this happening all the time or intermittently?
2. Are you seeing the DNS issues from all the nodes, a specific node pool, a subset of nodes or just a single node?
3. Are you seeing DNS issues from nodes in a specific Azure zone? Or from all the zones?
4. What protocols are failing? Is it both TCP (Transmission Control Protocol) and UDP (User Datagram Protocol), or just one of them?
5. What zones are failing? Is it all zones? or a specific zone traffic?

    **Note:** In this case, "zone" refers to DNS zones like *cluster.local* and root (.) and not to physical zones in Azure.

## Diagnose LocalDNS with a test DNSUtil pod

### Step 1: Deploy a test dnsutils pod
Option 1 - Deploy a test pod to your cluster using the following command:
   ``` bash
   kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
   ```

Option 2 - If you're seeing DNS issues in specific nodes, you can control the deployment of the test pod using nodeSelector:

   ```bash
   cat <<EOF | kubectl create -f -
   apiVersion: v1
   kind: Pod
   metadata:
   name: dnsutils2
   namespace: default
   spec:
   nodeSelector:
       kubernetes.io/hostname: <NODE>
   containers:
   - name: dnsutils
       image: registry.k8s.io/e2e-test-images/agnhost:2.39
       command:
       - sleep
       - "infinity"
       imagePullPolicy: IfNotPresent
   restartPolicy: Always
   EOF
   ```

Option 3 - If you run both linux and windows nodes in your cluster, you can configure the test pod to deploy to all linux nodes

   ```bash
   cat <<EOF | kubectl create -f -
   apiVersion: apps/v1
   kind: DaemonSet
   metadata:
   name: dnsutils
   namespace: default
   spec:
   selector:
       matchLabels:
       app: dnsutils
   template:
       metadata:
       labels:
           app: dnsutils
       spec:
       nodeSelector:
           kubernetes.io/os: linux
       containers:
       - name: dnsutils
           image: registry.k8s.io/e2e-test-images/agnhost:2.39
           command:
           - sleep
           - "infinity"
           imagePullPolicy: IfNotPresent
   EOF
   ```

### Enable Query logging for LocalDNS

Most use cases require query logging to be turned off in production because of its high memory usage and performance implications. However, for troubleshooting purposes, you should enable query logging in your localDNS configuration to root cause the source of your errors. Once the analysis is complete, you can turn it off.

Option 1 - Enable Query logging on all nodes

You can modify your LocalDNS configuration to reflect *queryLogging: Log* for a single or multiple DNS zones.

```json
{
  "mode": "Required",
  "vnetDNSOverrides": {
    ".": {
      "queryLogging": "Log",
      "protocol": "PreferUDP",
      "forwardDestination": "VnetDNS",
      "forwardPolicy": "Sequential",
      "maxConcurrent": 1000,
      "cacheDurationInSeconds": 3600,
      "serveStaleDurationInSeconds": 3600,
      "serveStale": "Immediate"
    },
    "cluster.local": {
      "queryLogging": "Log",
      "protocol": "ForceTCP",
      "forwardDestination": "ClusterCoreDNS",
      "forwardPolicy": "Sequential",
      "maxConcurrent": 1000,
      "cacheDurationInSeconds": 3600,
      "serveStaleDurationInSeconds": 3600,
      "serveStale": "Immediate"
    }
  },
  "kubeDNSOverrides": {
    ".": {
      "queryLogging": "Log",
      "protocol": "PreferUDP",
      "forwardDestination": "ClusterCoreDNS",
      "forwardPolicy": "Sequential",
      "maxConcurrent": 1000,
      "cacheDurationInSeconds": 3600,
      "serveStaleDurationInSeconds": 3600,
      "serveStale": "Immediate"
    },
    "cluster.local": {
      "queryLogging": "Log",
      "protocol": "ForceTCP",
      "forwardDestination": "ClusterCoreDNS",
      "forwardPolicy": "Sequential",
      "maxConcurrent": 1000,
      "cacheDurationInSeconds": 3600,
      "serveStaleDurationInSeconds": 3600,
      "serveStale": "Immediate"
    }
  }
}
```

You can enable this change on the node pool using the Azure CLI

```bash
az aks nodepool update --name mynodepool1 --cluster-name myAKSCluster --resource-group myResourceGroup --localdns-config ./localdnsconfig.json
```

**Note:** Making changes to the LocalDNS configuration triggers a reimage operation in the chosen node pool. 

Option 2 - Enable Query logging on a specific node

You can diagnose LocalDNS issues on a specific node by temporarily rewriting the LocalDNS configuration. You can [connect to the node](/azure/aks/node-access#connect-using-kubectl-debug) manually and update the core file used by LocalDNS, only restarting the specific LocalDNS service. 

**Note:** The changes made this way are ephemeral in nature and don't persist once the troubleshooting is complete.

```bash
# You need to connect to the node before running the following commands

## open the configuration file for LocalDNS 
vi /opt/azure/containers/localdns/localdns.corefile

<Manually change errors to log for a zone or all zones>

# ***********************************************************************************
# WARNING: Changes to this file will be overwritten and not persisted.
# ***********************************************************************************
# whoami (used for health check of DNS)
health-check.localdns.local:53 {
    bind 169.254.10.10 169.254.10.11
    whoami
}
# VnetDNS overrides apply to DNS traffic from pods with dnsPolicy:default or kubelet (referred to as VnetDNS traffic).
.:53 {
    errors
    bind 169.254.10.10
    forward . 168.63.129.16 {
        policy sequential
        max_concurrent 1000
    }
    ready 169.254.10.10:8181
    cache 3600s {
        success 9984
        denial 9984
        serve_stale 3600s verify
        servfail 0
    }
    loop
    nsid localdns
    prometheus :9253
    template ANY ANY internal.cloudapp.net {
        match "^(?:[^.]+\.){4,}internal\.cloudapp\.net\.$"
        rcode NXDOMAIN
        fallthrough
    }
    template ANY ANY reddog.microsoft.com {
        rcode NXDOMAIN
    }
}
cluster.local:53 {
    errors
    bind 169.254.10.10
    forward . 10.0.0.10 {
        force_tcp
        policy sequential
        max_concurrent 1000
    }
    ready 169.254.10.10:8181
    cache 3600s {
        success 9984
        denial 9984
        serve_stale 3600s verify
        servfail 0
    }
    loop
    nsid localdns
    prometheus :9253
}
...

...
<Save the changes>

<Restart localDNS service>
systemctl restart localdns
```

Once restarted, LocalDNS should begin collecting all logs for the chosen zones.

### Generate traffic from dnsutils pod

The next step would be to trigger some DNS traffic on LocalDNS. LocalDNS has two IPs - The KubeDNS traffic goes to the ClusterListenerIP - 169.254.10.11, while VnetDNSTraffic goes to the NodeListenerIP - 169.254.10.10

#### Test KubeDNS zone traffic

```bash
kubectl exec dnsutils -- dig bing.com +ignore +noedns +search +noshowsearch +time=10 +tries=6

; <<>> DiG 9.16.27 <<>> bing.com +ignore +noedns +search +noshowsearch +time=10 +tries=6
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7452
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;bing.com.                      IN      A

;; ANSWER SECTION:
bing.com.               30      IN      A       150.171.27.10
bing.com.               30      IN      A       150.171.28.10

;; Query time: 3 msec
;; SERVER: 169.254.10.11#53(169.254.10.11)
;; WHEN: Thu Jul 03 16:57:42 UTC 2025
;; MSG SIZE  rcvd: 74
``` 

#### Test VnetDNS zone traffic

```bash
kubectl exec dnsutils -- dig bing.com +ignore +noedns +search +noshowsearch +time=10 +tries=6 @169.254.10.10

; <<>> DiG 9.16.27 <<>> bing.com +ignore +noedns +search +noshowsearch +time=10 +tries=6 @169.254.10.10
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 3580
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;bing.com.                      IN      A

;; ANSWER SECTION:
bing.com.               1315    IN      A       150.171.28.10
bing.com.               1315    IN      A       150.171.27.10

;; Query time: 7 msec
;; SERVER: 169.254.10.10#53(169.254.10.10)
;; WHEN: Thu Jul 03 16:59:07 UTC 2025
;; MSG SIZE  rcvd: 74
```

### View LocalDNS logs collected

Lastly, you can now view the logs from your LocalDNS instances. To view the logs, you can connect to the node and run the following commands.

```bash
# view the logs for the aks-local-dns service
journalctl -u localdns

# To view logs in reverse chronological order (latest logs first)
journalctl -u localdns --reverse

# To continuously follow the logs.
journalctl -u localdns -f

# sample output using journalctl for the bing.com responses
journalctl -u localdns | grep bing.com
Jul 03 16:57:42 aks-userpool-24995383-vmss000000 localdns-coredns[2491520]: [INFO] 10.244.0.95:41796 - 7452 "A IN bing.com. udp 26 false 512" NOERROR qr,rd,ra 74 0.004490668s
Jul 03 16:59:07 aks-userpool-24995383-vmss000000 localdns-coredns[2491520]: [INFO] 10.244.0.95:58454 - 3580 "A IN bing.com. udp 26 false 512" NOERROR qr,rd,ra 74 0.001570158s
```

If you see logs for your traffic, the pod is able to reach the LocalDNS service.

## Next steps
If the above logs fail to help root cause the issue, you can enable [Query logging for CoreDNS](/azure/aks/coredns-custom#enable-dns-query-logging) to validate if CoreDNS is working as intended.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]



