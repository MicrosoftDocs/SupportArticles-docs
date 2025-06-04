---
title: Troubleshoot Seccomp Profiles in Azure Kubernetes Service
description: Helps you troubleshoot Azure Kubernetes Service workload issues caused by seccomp profiles.
ms.reviewer: mayasingh, josebl, qasimsarfraz, v-weizhu
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general #Don't change.
ms.date: 06/04/2025
#customer intent: As a DevOps Engineer, I want to set up an effective Seccomp profile so that I can run my workloads successfully while making them as secure as possible.
---
# Troubleshoot seccomp profile configuration in Azure Kubernetes Service

[Secure computing (seccomp)](https://www.man7.org/linux/man-pages/man2/seccomp.2.html) is a Linux kernel feature that restricts the system calls (syscalls) containers can make, enhancing the security of containerized workloads. In Azure Kubernetes Service (AKS), the [containerd](https://containerd.io/) runtime used by AKS nodes natively supports seccomp. Enabling a seccomp profile might cause AKS workloads to fail because workload critical syscalls are blocked. This article introduces what seccomp profiles are, how they work, and how to troubleshoot them using the open source project [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072).

## Background

Seccomp profiles specify the syscalls that are allowed or denied for a specify container. Syscalls are the interface that allows user space programs to request kernel services. There are two values supported on AKS:

- `RuntimeDefault`: Use the default seccomp profile given by the runtime.
- `Unconfined`: All syscalls are allowed.

To enable seccomp on your AKS node pools, see [Secure container access to resources using built-in Linux security features](/azure/aks/secure-container-access). You can also configure a custom profile to meet your workload's specific needs, see [Configure a custom seccomp profile](/azure/aks/secure-container-access#configure-a-custom-seccomp-profile) for details.

When using seccomp profiles, it's important to test and validate the affect on your workloads. Some workloads might require a lower number of syscall restrictions than others. This means that if workloads require syscalls that aren't included in the default profile, they might fail during runtime with the RuntimeDefault profile.

This article shows how to use the open source project [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) to diagnose issues and gain visibility into blocked syscalls.

## Symptoms

After you configuring AKS workloads to use a seccomp profile, the workloads exits unexpectedly with one of the following errors:

- > permission denied
- > function not implemented

## Prerequisites

- A tool to connect to the Kubernetes cluster, such as the `kubectl` tool. To install `kubectl` using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The [krew](https://sigs.k8s.io/krew) package manager for installing [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072)'s plugin. You can follow the [krew quickstart guide](https://krew.sigs.k8s.io/docs/user-guide/quickstart/) to install it.
- The seccomp profile that you're trying to troubleshoot.
- The open source project [Inspektor Gadget](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster).

## Troubleshooting checklist

### Step 1: Modify your seccomp profile

Create a custom seccomp profile matching the one you're troubleshooting and replace its default action such as  `SCMP_ACT_ERRNO` with `SCMP_ACT_LOG` to log blocked syscalls instead of failing them.

Your custom seccomp profile might look like this:

```json  
{
    "defaultAction": "SCMP_ACT_ALLOW",
    "syscalls": [
      {
        "names": ["acct",
                "add_key",
                "bpf",
                "clock_adjtime",
                "clock_settime",
                "clone",
                "create_module",
                "delete_module",
                "finit_module",
                "get_kernel_syms",
                "get_mempolicy",
                "init_module",
                "ioperm",
                "iopl",
                "kcmp",
                "kexec_file_load",
                "kexec_load",
                "keyctl",
                "lookup_dcookie",
                "mbind",
                "mount",
                "move_pages",
                "nfsservctl",
                "open_by_handle_at",
                "perf_event_open",
                "personality",
                "pivot_root",
                "process_vm_readv",
                "process_vm_writev",
                "ptrace",
                "query_module",
                "quotactl",
                "reboot",
                "request_key",
                "set_mempolicy",
                "setns",
                "settimeofday",
                "stime",
                "swapon",
                "swapoff",
                "sysfs",
                "_sysctl",
                "umount",
                "umount2",
                "unshare",
                "uselib",
                "userfaultfd",
                "ustat",
                "vm86",
                "vm86old"],
        "action": "SCMP_ACT_LOG"
      }
    ]
  }
  ```

The article [Configure a custom seccomp profile](/azure/aks/secure-container-access#configure-a-custom-seccomp-profile) shows how you can apply your custom seccomp profile to your AKS cluster. Alternatively, you can follow these steps:

1. Get the names of the nodes in your AKS cluster by running the following command:

    ```console
    kubectl get nodes 
    ```

2. Use the `kubectl debug` command to start a debug pod on the node and make sure the **seccomp** folder exists and the `tar` tool is installed (for copying the profile into the node in the next step):

    ```console
    kubectl debug node/<node-name> -it --image=mcr.microsoft.com/azurelinux/base/core:3.0
    root [ / ]# mkdir -p /host/var/lib/kubelet/seccomp
    root [ / ]# tdnf install -y tar
    ```

3. In another terminal, copy the pod name. The pod is created in the `default` namespace and the name looks like `node-debugger-<node-name>-<random-sufix>`. It's outputted when you create the debug pod.

4. Transfer the seccomp profile file to the node directly:

    ```console
    kubectl cp <the path of the local seccomp profile>/my-profile.json <pod name>:/host/var/lib/kubelet/seccomp/my-profile.json
    ```

> [!NOTE]
> Repeat the preceding steps for each node in the cluster to ensure that the seccomp profile is available on all nodes where your workload might run.

Now, you can modify the `seccompProfile` specification of the target pod, which should be confined to the recorded syscalls. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-pod
  labels:
    app: default-pod
spec:
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: my-profile.json
  containers:
  - name: test-container
    image: docker.io/library/nginx:latest
```

### Step 2: Install Inspektor Gadget

[Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) provides insights into syscalls affecting your containers. To use it, run the following commands to install the `gadget` kubectl plugin in your host and deploy [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) into the cluster:

```console
kubectl krew install gadget
```

```console
kubectl gadget deploy
```

For more information, see [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).

### Step 3: Run the audit_seccomp gadget

With [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) installed, start the [audit_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2259786) using the [kubectl gadget run command](https://go.microsoft.com/fwlink/?linkid=2259865):

```console
kubectl gadget run audit_seccomp
```

### Step 4: Analyze blocked syscalls

Run your workload using the `kubectl apply -f` command. Then, the [audit_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2259786) will log blocked syscalls, along with their associated pods, containers, and processes. You can use this information to identify the root causes of workload failures.

For example, if you run the above-mentioned `default-pod` pod with the `my-profile.json` profile, the output looks like the following one:

```output
K8S.NODE                           K8S.NAMESPACE K8S.PODNAME  K8S.CONTAINERNAME  COMM                 PID      TID  CODE             SYSCALL
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     docker-entrypoi  3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     docker-entrypoi  3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     docker-entrypoi  3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     docker-entrypoi  3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     docker-entrypoi  3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996628  3996628  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996628  3996628  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996632  3996632  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996632  3996632  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996632  3996632  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996628  3996628  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     10-listen-on-ip  3996628  3996628  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     20-envsubst-on-  3996639  3996639  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     20-envsubst-on-  3996639  3996639  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     20-envsubst-on-  3996641  3996641  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     30-tune-worker-  3996643  3996643  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     nginx            3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
aks-nodepool1-38695788-vmss000002  default       default-pod  test-container     nginx            3996610  3996610  SECCOMP_RET_LOG  SYS_CLONE
```

The output indicates that the `test-container` executes the `SYS_CLONE` syscall which the seccomp profile blocks. With this information, you can determine whether to permit the syscalls in your container. If so, adjust the seccomp profile by removing the listed syscalls, which will prevent the workload from failing.

Here are some commonly blocked syscalls to watch out for. A more comprehensive list is available in [Significant syscalls blocked by default profile](/azure/aks/secure-container-access#significant-syscalls-blocked-by-default-profile).

| Blocked syscall |Consideration |
|---|---|
| `clock_settime`  or `clock_adjtime` | If your workload needs accurate time synchronization |
| `add_key` or `key_ctl` | If your workload requires key management, these blocked syscalls prevent containers from using the kernel keyring which is used for retaining security data, authentication keys, encryption keys, and other data within the kernel. |
| `clone`  | This syscall prevents the cloning of new namespaces, except for `CLONE_NEWUSER`. Workloads that depend on creating new namespaces might be affected if this syscall is blocked.  |
| `io_uring`  | This syscall is blocked with the move to `containerd` 2.0. However, it's not blocked in the profile for `containerd` 1.7.  |

## Next steps

If you encounter issues with your workloads due to blocked syscalls, consider using a custom seccomp profile suited to the specific needs of your application. You can check out the [Inspektor Gadget advise_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2260408).

Testing and refining seccomp profiles helps maintain performance and security for AKS workloads. For further assistance, see [Secure computing](/azure/aks/secure-container-access#secure-computing-seccomp).

## Related content

[Secure container access to resources using built-in Linux security features](/azure/aks/secure-container-access#secure-computing-seccomp)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
