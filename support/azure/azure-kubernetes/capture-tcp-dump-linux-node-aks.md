---
title: Capture a TCP dump from a Linux node in an AKS cluster
description: Understand how to capture a TCP dump from a Linux node within an Azure Kubernetes Service (AKS) cluster.
ms.date: 02/01/2023
ms.topic: how-to
ms.reviewer: erbookbi, amaljuna, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: data-collection-guide
---
# Capture a TCP dump from a Linux node in an AKS cluster

Networking issues may occur when you're using a Microsoft Azure Kubernetes Service (AKS) cluster. To help investigate these issues, this article explains how to capture a TCP dump from a Linux node in an AKS cluster, and then download the capture to your local machine.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli-linux), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- An AKS cluster. If you don't have an AKS cluster, [create one using Azure CLI](/azure/aks/kubernetes-walkthrough) or [through the Azure portal](/azure/aks/kubernetes-walkthrough-portal).
- The [tcpdump](https://www.tcpdump.org/) command-line tool installed on the Linux node.

> [!NOTE]
> You can automate TCP capture through a [Helm chart](https://helm.sh/docs/topics/charts/), which can run in the background as a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). For more information, see this [custom GitHub tool for capturing TCP dumps](https://github.com/amjadaljunaidi/tcpdump), or use the steps in the following sections.

## Step 1: Find the nodes to troubleshoot

How do you determine which node to pull the TCP dump from? You first get the list of nodes in the AKS cluster using the Kubernetes command-line client, [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/). Follow the instructions to connect to the cluster and run the `kubectl get nodes --output wide` command [using the Azure portal](/azure/aks/kubernetes-walkthrough-portal#connect-to-the-cluster) or [Azure CLI](/azure/aks/kubernetes-walkthrough#connect-to-the-cluster). A node list that's similar to the following output appears:

```console
$ kubectl get nodes --output wide
NAME                                STATUS   ROLES   AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION     CONTAINER-RUNTIME
aks-agentpool-34796016-vmss000000   Ready    agent   45h   v1.20.9   10.240.1.81    <none>        Ubuntu 18.04.6 LTS               5.4.0-1062-azure   containerd://1.4.9+azure
aks-agentpool-34796016-vmss000002   Ready    agent   45h   v1.20.9   10.240.2.47    <none>        Ubuntu 18.04.6 LTS               5.4.0-1062-azure   containerd://1.4.9+azure
```

## Step 2: Connect to a Linux node

The next step is to establish a connection to the AKS cluster node that you want to capture the network trace from. For more information, see [Create an interactive shell connection to a Linux node](/azure/aks/node-access#create-an-interactive-shell-connection-to-a-linux-node).

## Step 3: Make sure tcpdump is installed

After you've established a connection to the AKS Linux node, verify the tcpdump tool has been previously installed on a node by running `tcpdump --version`. If tcpdump hasn't been installed, the following error text appears:

```console
# tcpdump --version
bash: tcpdump: command not found
```

Then install tcpdump on your pod by running the Advanced Package Tool's package handling utility, [apt-get](https://manpages.debian.org/bullseye/apt/apt-get.8.en.html):

```bash
apt-get update && apt-get install tcpdump
```

If tcpdump is installed, something similar to the following text appears:

```console
# tcpdump --version
tcpdump version 4.9.3
libpcap version 1.8.1
OpenSSL 1.1.1  11 Sep 2018
```

## Step 4: Create a packet capture

To capture the dump, run the [tcpdump command](https://www.tcpdump.org/manpages/tcpdump.1.html) as follows:

```console
# tcpdump --snapshot-length=0 -vvv -w /capture.cap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
Got 6
```

While the trace is running, replicate your issue many times. This action ensures the issue has been captured within the TCP dump. Note the time stamp while you replicate the issue. To stop the packet capture when you're done, press Ctrl+C:

```console
# tcpdump -s 0 -vvv -w /capture.cap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
^C526 packets captured
526 packets received by filter
0 packets dropped by kernel
```

## Step 5: Transfer the capture locally

After you complete the packet capture, identify the helper pod so you can copy the dump locally. Open a second console, and then get a list of pods by running `kubectl get pods`, as shown below.

```console
$ kubectl get pods
NAME                                                    READY   STATUS    RESTARTS   AGE
azure-vote-back-6c4dd64bdf-m4nk7                        1/1     Running   0          3m29s
azure-vote-front-85b4df594d-jhpzw                       1/1     Running   0          3m29s
node-debugger-aks-nodepool1-38878740-vmss000000-jfsq2   1/1     Running   0          60s
```

The helper pod has a prefix of `node-debugger-aks`, as shown in the third row. Replace the pod name, and then run the following kubectl command. These commands retrieve the packet capture for your Linux node.

```bash
kubectl cp node-debugger-aks-nodepool1-38878740-vmss000000-jfsq2:/capture.cap capture.cap
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
