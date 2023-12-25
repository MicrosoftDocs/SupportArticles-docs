---
title:         Capture real-time system insights from an AKS cluster
description:   Learn how to use Inspektor Gadget to capture useful information for debugging issues in an Azure Kubernetes Service (AKS) cluster.
author:        blanquicet
ms.author:     josebl
editor:        v-jsitser
ms.reviewer:   cssakscic, v-leedennis
ms.service:    azure-kubernetes-service
ms.subservice: data-collection-guide
ms.topic:      how-to
ms.date:       12/21/2023
---

# Capture real-time system insights from an AKS cluster

This article discusses the process of gathering real-time system insights from your Microsoft Azure Kubernetes Service (AKS) cluster by using Inspektor Gadget. The article contains step-by-step instructions for installing this tool on your AKS environment. It also explores practical examples that show how Inspektor Gadget helps you gather valuable information to do effective debugging of real-world issues.

## Demo

To begin, consider the following quick demo. Suppose that you have to figure out why the DNS requests from an application fail. By using Inspektor Gadget, you can capture the DNS traffic in the Kubernetes namespace in which your application is running:

```bash
kubectl gadget trace dns --namespace my-ns --output columns=+nameserver
```

```output
K8S.NODE                           K8S.NAMESPACE  K8S.POD  PID      TID      COMM      QR  TYPE      QTYPE  NAME             RCODE NUMANSWERS NAMESERVER
aks-agentpool-97833681-vmss000001  my-ns          my-app   1349264  1349264  nslookup  Q   OUTGOING  A      www.example.com.       0          1.2.3.4
aks-agentpool-97833681-vmss000001  my-ns          my-app   1349264  1349264  nslookup  Q   OUTGOING  AAAA   www.example.com.       0          1.2.3.4
aks-agentpool-97833681-vmss000001  my-ns          my-app   1349264  1349264  nslookup  Q   OUTGOING  A      www.example.com.       0          1.2.3.4
aks-agentpool-97833681-vmss000001  my-ns          my-app   1349264  1349264  nslookup  Q   OUTGOING  AAAA   www.example.com.       0          1.2.3.4
```

From this information, you can see that the DNS requests are directed to the DNS server at IP address `1.2.3.4`, but the server never responds.

Now, suppose that `1.2.3.4` isn't the default name server configuration, and you suspect that a suspicious process is modifying the configuration at runtime. In these kinds of cases, Inspektor Gadget goes beyond DNS diagnostics. It also enables you to monitor processes that access critical files (such as */etc/resolv.conf*) and have the intention of modifying those files. To use this monitoring feature, filter the flags in the output to show any of the [writing file access modes](https://linux.die.net/man/3/open) (`O_WRONLY` to open for writing only, or `O_RDWR` to open for reading and writing):

```bash
kubectl gadget trace open --namespace my-ns \
    --filter path:/etc/resolv.conf,flags:'~(O_WRONLY|O_RDWR)' \
    --output columns=+flags
```

```output
K8S.NODE                           K8S.NAMESPACE  K8S.POD  K8S.CONTAINER  PID      COMM  FD  ERR  PATH              FLAGS
aks-agentpool-97833681-vmss000001  my-ns          my-app   my-app         1365052  vi    3   0    /etc/resolv.conf  O_WRONLY|O_CREAT
```

## What is Inspektor Gadget?

[Inspektor Gadget](https://aka.ms/ig-website) is a framework that's designed for building, packaging, deploying, and running tools that are dedicated to debugging and inspecting Linux and Kubernetes systems. These tools ("gadgets") are implemented as [eBPF](https://aka.ms/ebpf-website) programs. Their primary goal is to gather low-level kernel data to provide insights into specific system scenarios. The Inspektor Gadget framework manages the association of the collected data by using high-level references, such as Kubernetes resources. This integration makes sure that a seamless connection exists between low-level insights and their corresponding high-level context. The integration streamlines the troubleshooting process and the collection of relevant information.

## Gadgets

Inspektor Gadget provides a set of built-in tools that are designed to debug and observe common situations on a system. For example, by using such gadgets, you can trace the following events in your cluster:

- Process creation
- File access
- Network activity, such as TCP connections or DNS resolution

The gadgets present the information that they collected by using different mechanisms. For instance, some gadgets can inform you about the system status at specific times. Other gadgets can report every time a given event occurs, or they can provide periodic updates.

These are just a few examples. The [official documentation](https://aka.ms/ig-builtin-gadgets) provides detailed descriptions and examples of each gadget so that you can determine the most suitable gadget for your specific use case. However, if you find a use case that the existing gadgets don't currently cover, Inspektor Gadget offers flexibility. You can run scripts that are compatible with the eBPF tracing language [bpftrace](https://github.com/iovisor/bpftrace) by running the [script command](https://aka.ms/ig-builtin-gadgets-script). Or, you can run your own eBPF programs by running the [run command](https://aka.ms/ig-run-ebpf). Because the Inspektor Gadget framework handles the building, packaging, and deployment of your custom programs, it streamlines the process for your unique requirements. Also, it gathers high-level metadata to enrich the data that you collect in your program.

## Use cases

To complement the demo that's presented at the beginning of this article, we compiled a list of issues and practical scenarios that show how Inspektor Gadget helps you tackle debugging challenges. The following examples showcase the potential of Inspektor Gadget. But the capabilities of this tool extend beyond these scenarios. This makes Inspektor Gadget an invaluable asset for navigating the complexities of Kubernetes debugging and observability.

| Problem area | Symptoms | Troubleshooting |
|--|--|--|
| **Disk-intensive applications** | High memory or CPU usage, or inconsistent node readiness | An application might consistently engage in disk read/write operations, such as extensive logging. By using Inspektor Gadget, you can identify in real time which containers generate more [block I/O](https://aka.ms/ig-top-blockio). Or, more specifically, you can find the container that causes more reads and writes into a ⁠[file](https://aka.ms/ig-top-file). |
| **"It's always DNS"** | High application latency, time-outs, or poor end-user experience | <p>By using Inspektor Gadget, you can [trace all the DNS](https://aka.ms/ig-trace-dns) queries and responses in the cluster. In particular, Inspektor Gadget provides the following information that helps you to determine whether the DNS is affecting your application's performance:</p> <ul> <li>Query success</li> <li>Whether the response contains an error</li> <li>The name server that's used for the lookup</li> <li>The query-response latency</li> </ul> |
| **File system access** | Application misbehaves or can't function correctly | <p>The application might be unable to access specific configurations, logs, or other vital files in the file system. In such scenarios, Inspektor Gadget enables you to [trace all the opened files](https://aka.ms/ig-trace-open) inside pods to diagnose access issues. Whenever your application tries to open a file, you can discover the following information:</p> <ul> <li>The flags that are used to open the file (for example, [O_RDONLY, O_WRONLY, O_RDWR](https://linux.die.net/man/3/open), and so on)</li> <li>Whether the file opening attempt succeeds</li> <li>The returned error (if the file opening attempt fails)</li> </ul> <p>For instance, if the attempt to open the file fails because of error 2 ([ENOENT](https://man7.org/linux/man-pages/man3/errno.3.html)), the application is probably trying to open a file that doesn’t exist. This means that you might have a typo in the code, or the file is available in a different path.</p> |
| **Remote code execution (RCE)** | Unauthorized code execution such as [cryptojacking](https://en.wikipedia.org/wiki/Cryptojacking) that's evident in high CPU usage during application idle periods | When attackers try to make this kind of attack on a system, they usually have to run the code by using `bash`. Inspektor Gadget enables you to [trace the creation of new processes](https://aka.ms/ig-trace-exec), particularly processes that involve critical commands such as `bash`. |

## How to install Inspektor Gadget in an AKS cluster

This section outlines the steps for installing Inspektor Gadget in your AKS cluster by running the `kubectl gadget` plug-in. The installation consists of two parts:

- Installing the `kubectl gadget` plug-in on your computer

- Running the `kubectl gadget` plug-in to install Inspektor Gadget in the cluster

  > [!WARNING]
  > Many mechanisms are available to deploy and use Inspektor Gadget. Each of these mechanisms is tailored to specific use cases and requirements. You can use the kubectl gadget plug-in to apply several of these mechanisms, but not all of them. For instance, deploying Inspektor Gadget by using the `kubectl gadget` plug-in depends on the availability of the Kubernetes API server. If you can’t depend on such a component because its availability might be occasionally compromised, we recommend that you avoid using the `kubectl gadget`deployment mechanism. For more information about this and other use cases, see the [Inspektor Gadget documentation](https://aka.ms/ig).

### Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) command-line tool. If you have [Azure CLI](/cli/azure/install-azure-cli-linux), you can run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command to install kubectl.

- An AKS cluster. If you don't have an AKS cluster, [create one by using Azure CLI](/azure/aks/learn/quick-kubernetes-deploy-cli) or [by using the Azure portal](/azure/aks/learn/quick-kubernetes-deploy-portal).

- The [krew](https://sigs.k8s.io/krew) package manager for plug-ins in kubectl. You can follow the [krew quickstart guide](https://krew.sigs.k8s.io/docs/user-guide/quickstart/) to install this package manager.

### Part 1: Install the kubectl plug-in gadget on your computer

We recommend that you use `krew` to install the `kubectl gadget` plug-in.

> [!NOTE]
> To install a specific release or compile it from the source, see [Install kubectl gadget](https://aka.ms/ig-install-kubernetes#installing-kubectl-gadget) on GitHub.

```bash
kubectl krew install gadget
```

Now, verify the installation by running the `version` command:

```bash
kubectl gadget version
```

The `version` command shows you the version of the client (`kubectl gadget` plug-in), but it also tells you that it isn't installed yet on the server (the cluster):

```output
Client version: vX.Y.Z
Server version: not installed
```

### Part 2: Install Inspektor Gadget in the cluster

The following command deploys the [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) controller.

> [!NOTE]
> Several options are available to customize the deployment, as shown in the following list:
>
> - Use a specific container image
> - Deploy to specific nodes
> - Deploy into a custom namespace
>
> To learn about these options, see the [Installing in the cluster](https://aka.ms/ig-install-kubernetes#installing-in-the-cluster) section of the official documentation.

```bash
kubectl gadget deploy
```

Verify the installation by running the `version` command again:

```bash
kubectl gadget version
```

This time, the client and the server are both shown to be correctly installed:

```output
Client version: vX.Y.Z
Server version: vX.Y.Z
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
