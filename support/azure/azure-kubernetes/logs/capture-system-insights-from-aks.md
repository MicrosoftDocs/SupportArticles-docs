---
title:         Capture real-time system insights from an AKS cluster
description:   Learn how to use Inspektor Gadget to capture useful information for debugging issues in an Azure Kubernetes Service (AKS) cluster.
author:        blanquicet
ms.author:     josebl
editor:        v-jsitser
ms.reviewer:   cssakscic, josebl, v-leedennis
ms.service:    azure-kubernetes-service
ms.topic:      how-to
ms.date:       07/01/2025
ms.custom: sap:Monitoring and Logging
---

# Capture real-time system insights from an AKS cluster

This article discusses the process of gathering real-time system insights from your Microsoft Azure Kubernetes Service (AKS) cluster by using Inspektor Gadget. The article contains step-by-step instructions for installing this tool on your AKS environment. It also explores practical examples that show how Inspektor Gadget helps you gather valuable information to do effective debugging of real-world issues.

## Demo: Real-time DNS troubleshooting and critical file-access alerting

To begin, consider the following quick demo. Suppose that you have to figure out why the DNS requests from an application fail. By using Inspektor Gadget, you can capture the DNS traffic in the Kubernetes namespace in which your application is running:

```bash
kubectl gadget run trace_dns \
  --namespace my-ns \
  --fields k8s.node,k8s.podName,id,qr,name,rcode,nameserver
```

```output
K8S.NODE                          K8S.PODNAME  ID    QR  NAME          RCODE  NAMESERVER
aks-nodepool-41788306-vmss000002  demo-pod     13cc  Q   example.com.         1.2.3.4
aks-nodepool-41788306-vmss000002  demo-pod     13cc  Q   example.com.         1.2.3.4
```

From this information, we can see that the DNS requests are directed to the DNS server at IP address `1.2.3.4` (the `NAMESERVER` column), but we only see the queries (`Q` in `QR` column) and no responses (`R` in `QR` column). This means that the DNS server didn't respond to the queries, which is why the application can't resolve the domain name `www.example.com`.

Now, suppose that `1.2.3.4` isn't the default name server configuration, and you suspect that a malicious process is modifying the configuration at runtime. In these kinds of cases, Inspektor Gadget goes beyond DNS diagnostics. It also enables you to monitor processes that access critical files (such as */etc/resolv.conf*) and have the intention of modifying those files. To do that, filter the flags in the output to show any of the [writing file access modes](https://linux.die.net/man/3/open) (`O_WRONLY` to open for writing only, or `O_RDWR` to open for reading and writing):

```bash
kubectl gadget run trace_open \
  --namespace my-ns \
  --filter fname==/etc/resolv.conf,flags~'(O_WRONLY|O_RDWR)' \
  --fields k8s.node,k8s.podName,comm,fname,flags,error
```

```output
K8S.NODE                          K8S.PODNAME  COMM            FNAME             FLAGS     ERROR
aks-nodepool-41788306-vmss000002  demo-pod     malicious-proc  /etc/resolv.conf  O_WRONLY
```

## What is Inspektor Gadget?

[Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) is a framework that's designed for building, packaging, deploying, and running tools that are dedicated to debugging and inspecting Linux and Kubernetes systems. These tools (*Gadgets*) are implemented as [eBPF](https://go.microsoft.com/fwlink/?linkid=2259866) programs. Their primary goal is to gather low-level kernel data to provide insights into specific system scenarios. The Inspektor Gadget framework manages the association of the collected data by using high-level references, such as Kubernetes resources. This integration makes sure that a seamless connection exists between low-level insights and their corresponding high-level context. The integration streamlines the troubleshooting process and the collection of relevant information.

## Gadgets

Inspektor Gadget provides a set of built-in tools that are designed to debug and observe common situations on a system. For example, by using such gadgets, you can trace the following events in your cluster:

- Process creation
- File access
- Network activity, such as TCP connections or DNS resolution

The gadgets present the information that they collected by using different mechanisms. For instance, some gadgets can inform you about the system status at specific times. Other gadgets can report every time a given event occurs, or they can provide periodic updates.

These are just a few examples. The [official documentation](https://go.microsoft.com/fwlink/?linkid=2260507) provides detailed descriptions and examples of each gadget so that you can determine the most suitable gadget for your specific use case. However, if you find a use case that the existing gadgets don't currently cover, Inspektor Gadget allows you to run your own eBPF programs by using the [run command](https://go.microsoft.com/fwlink/?linkid=2259865). Because the Inspektor Gadget framework handles the building, packaging, and deployment of your custom programs, it streamlines the process for your unique requirements. Also, it gathers high-level metadata to enrich the data that you collect in your program.

## Use cases

To complement the demo that's presented at the beginning of this article, we compiled a list of issues and practical scenarios that show how Inspektor Gadget helps you tackle debugging challenges. The following examples showcase the potential of Inspektor Gadget. But the capabilities of this tool extend beyond these scenarios. This makes Inspektor Gadget an invaluable asset for navigating the complexities of Kubernetes debugging and observability.

| Problem area | Symptoms | Troubleshooting |
|--|--|--|
| **Disk-intensive applications** | High memory or CPU usage, or inconsistent node readiness | An application might consistently engage in disk read/write operations, such as extensive logging. By using Inspektor Gadget, you can identify in real time which containers generate more [block I/O](https://go.microsoft.com/fwlink/?linkid=2260070). Or, more specifically, you can find the container that causes more reads and writes into a ⁠[file](https://go.microsoft.com/fwlink/?linkid=2260071). |
| **"It's always DNS"** | High application latency, timeouts, or poor end-user experience | <p>By using Inspektor Gadget, you can [trace all the DNS](https://go.microsoft.com/fwlink/?linkid=2260317) queries and responses in the cluster. In particular, Inspektor Gadget provides the following information that helps you to determine whether the DNS is affecting your application's performance:</p> <ul> <li>Query success</li> <li>Whether the response contains an error</li> <li>The name server that's used for the lookup</li> <li>The query-response latency</li> </ul> |
| **File system access** | Application misbehaves or can't function correctly | <p>The application might be unable to access specific configurations, logs, or other vital files in the file system. In such scenarios, Inspektor Gadget enables you to [trace all the opened files](https://go.microsoft.com/fwlink/?linkid=2260318) inside pods to diagnose access issues. Whenever your application tries to open a file, you can discover the following information:</p> <ul> <li>The flags that are used to open the file (for example, [O_RDONLY, O_WRONLY, O_RDWR](https://linux.die.net/man/3/open), and so on)</li> <li>Whether the file opening attempt succeeds</li> <li>The returned error (if the file opening attempt fails)</li> </ul> <p>For instance, if the attempt to open the file fails because of error 2 ([ENOENT](https://man7.org/linux/man-pages/man3/errno.3.html)), the application is probably trying to open a file that doesn’t exist. This means that you might have a typo in the code, or the file is available in a different path.</p> |
| **Remote code execution (RCE)** | Unauthorized code execution such as [cryptojacking](https://en.wikipedia.org/wiki/Cryptojacking) that's evident in high CPU usage during application idle periods | When attackers try to make this kind of attack on a system, they usually have to run the code by using `bash`. Inspektor Gadget enables you to [trace the creation of new processes](https://go.microsoft.com/fwlink/?linkid=2260319), particularly processes that involve critical commands such as `bash`. |

## How to install Inspektor Gadget in an AKS cluster

### One-Click Inspektor Gadget deployment

By selecting the following button, an AKS cluster will be automatically created, and Inspektor Gadget will be deployed in the cluster. After the deployment is finished, you can explore all the features of Inspektor Gadget in the provided shell environment.

[![Deploy Inspektor Gadget in an AKS cluster](https://aka.ms/deploytoazurebutton)](https://go.microsoft.com/fwlink/?linkid=2286151)

### Install Inspektor Gadget by running the "kubectl gadget" plug-in

This section outlines the steps for installing Inspektor Gadget in your AKS cluster by running the `kubectl gadget` plug-in. The installation consists of two parts:

1. Installing the `kubectl gadget` plug-in on your workstation

2. Running the `kubectl gadget` plug-in to deploy Inspektor Gadget in the cluster

  > [!WARNING]
  > Many mechanisms are available to deploy and use Inspektor Gadget. Each of these mechanisms is tailored to specific use cases and requirements. You can use the kubectl gadget plug-in to apply several of these mechanisms, but not all of them. For instance, deploying Inspektor Gadget by using the `kubectl gadget` plug-in depends on the availability of the Kubernetes API server. If you can’t depend on such a component because its availability might be occasionally compromised, we recommend that you avoid using the `kubectl gadget` deployment mechanism. For more information about this and other use cases, see the [Inspektor Gadget documentation](https://go.microsoft.com/fwlink/?linkid=2326106).

#### Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) command-line tool. If you have [Azure CLI](/cli/azure/install-azure-cli-linux), you can run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command to install kubectl.

- An AKS cluster. If you don't have an AKS cluster, [create one by using Azure CLI](/azure/aks/learn/quick-kubernetes-deploy-cli) or [by using the Azure portal](/azure/aks/learn/quick-kubernetes-deploy-portal).

#### Part 1: Install the kubectl gadget plug-in on your workstation

Use the instructions for your OS:

- Azure Linux 3.0
- Ubuntu 18.04 / 20.04 / 22.04

> [!NOTE]
> To install a specific release or compile it from the source, see [Install kubectl gadget](https://go.microsoft.com/fwlink/?linkid=2260075#installing-the-kubectl-gadget-client) on GitHub.

##### [Azure Linux 3.0](#tab/azurelinux30)

1. Add the Microsoft Cloud-Native repository to your system:

    ```bash
    echo "[azurelinux-cloud-native]
    name=Azure Linux Cloud Native 3.0
    baseurl=https://packages.microsoft.com/azurelinux/3.0/prod/cloud-native/$(uname -i)
    gpgkey=file:///etc/pki/rpm-gpg/MICROSOFT-RPM-GPG-KEY
    gpgcheck=1
    repo_gpgcheck=1
    enabled=1
    skip_if_unavailable=True
    sslverify=1
    " > /etc/yum.repos.d/azurelinux-cloud-native.repo
    ```

2. Install the `kubectl gadget` plug-in:

    ```bash
    tdnf install --refresh -y kubectl-gadget
    ```

##### [Ubuntu 22.04](#tab/ubuntu2204)

1. Get `curl` if you don't have it installed:

   ```bash
   apt update && apt install -y curl
   ```

2. Download Microsoft GNU Privacy Guard (GPG) public key:

    ```bash
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /usr/share/keyrings/microsoft.asc
    ```

3. Add the Microsoft Cloud-Native repository to your system:

    ```bash
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.asc] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" | tee /etc/apt/sources.list.d/packages-microsoft-prod.list
    ```

4. Update the package index:

    ```bash
    apt update
    ```

5. Install the `kubectl gadget` plug-in:

    ```bash
    apt install -y kubectl-gadget
    ```

##### [Ubuntu 20.04](#tab/ubuntu2004)

1. Get `curl` if you don't have it installed:

   ```bash
   apt update && apt install -y curl
   ```

2. Download Microsoft GNU Privacy Guard (GPG) public key:

    ```bash
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /usr/share/keyrings/microsoft.asc
    ```

3. Add the Microsoft Cloud-Native repository to your system:

    ```bash
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.asc] https://packages.microsoft.com/ubuntu/20.04/prod focal main" | tee /etc/apt/sources.list.d/packages-microsoft-prod.list
    ```

4. Update the package index:

    ```bash
    apt update
    ```

5. Install the `kubectl gadget` plug-in:

    ```bash
    apt install -y kubectl-gadget
    ```

##### [Ubuntu 18.04](#tab/ubuntu1804)

1. Get `curl` if you don't have it installed:

   ```bash
   apt update && apt install -y curl
   ```

2. Download Microsoft GNU Privacy Guard (GPG) public key:

    ```bash
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /usr/share/keyrings/microsoft.asc
    ```

3. Add the Microsoft Cloud-Native repository to your system:

    ```bash
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.asc] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" | tee /etc/apt/sources.list.d/packages-microsoft-prod.list
    ```

4. Update the package index:

    ```bash
    apt update
    ```

5. Install the `kubectl gadget` plug-in:

    ```bash
    apt install -y kubectl-gadget
    ```

---

Now, verify the installation by running the `version` command:

```bash
kubectl gadget version
```

The command output shows you the version of the client (`kubectl gadget` plug-in), and it isn't installed yet on the server (the cluster):

```output
Client version: vX.Y.Z
Server version: not installed
```

#### Part 2: Deploy Inspektor Gadget in the cluster

The following command deploys the [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) controller.

> [!NOTE]
> Several options are available to customize the deployment, as shown in the following list:
>
> - Use a specific container image
> - Deploy to specific nodes
> - Deploy into a custom namespace
>
> To learn about these options, see the [Installing in the cluster](https://go.microsoft.com/fwlink/?linkid=2260075#installing-in-the-cluster) section of the official documentation.

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

When deploying Inspektor Gadget with the `kubectl gadget` plug-in available in the Microsoft Cloud-Native repository, the container image used for the DaemonSet is automatically pulled from the Microsoft Container Registry (MCR):

```bash
kubectl get daemonset gadget -n gadget -o jsonpath='{.spec.template.spec.containers[*].image}'
```

```output
mcr.microsoft.com/oss/v2/inspektor-gadget/inspektor-gadget:vX.Y.Z
```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
