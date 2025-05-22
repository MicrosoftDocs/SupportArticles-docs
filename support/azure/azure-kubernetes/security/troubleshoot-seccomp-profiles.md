---
title: Troubleshoot Seccomp Profiles on AKS
description: Diagnosing workload issues caused by seccomp profiles.
author: mayasingh17
ms.author: mayasingh
ms.reviewer: mayasingh, josebl, qasimsarfraz
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general #Don't change.
ms.date: 05/05/2025
#customer intent: As a DevOps Engineer, I want to set up an effective Seccomp profile so that I can run my workloads successfully while making them as secure as possible.
---
# Troubleshoot seccomp profile configurations on Azure Kubernetes Service

[Seccomp (Secure Computing)](https://www.man7.org/linux/man-pages/man2/seccomp.2.html) is a Linux kernel feature that enhances the security of containerized workloads by restricting the system calls (syscalls) that containers can make. In Azure Kubernetes Service (AKS), the [containerd](https://containerd.io/) runtime used by AKS nodes natively supports seccomp. However, enabling a seccomp profile can sometimes lead to workload failures due to workload critical syscalls being blocked. This guide explains what seccomp profiles are, how they work, and how you can troubleshoot them using the open source project [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072).

## Background

Seccomp profiles define the syscalls that are allowed or denied for a given container. Syscalls are the interface that allows user space programs to request kernel services. There are two seccomp profile values supported on AKS: 

-	`RuntimeDefault`: Use the default seccomp profile given by the runtime
-	`Unconfined`: All syscalls are allowed 

To enable seccomp on your AKS node pools, see [Secure container access to resources using built-in Linux security features](/azure/aks/secure-container-access). You can also configure a custom profile to meet your workload’s specific needs, see [Configure a custom seccomp profile](/azure/aks/secure-container-access#configure-a-custom-seccomp-profile) for details.

When using seccomp profiles, it’s essential to test and validate their impact on your workloads. Some workloads might require a lower number of syscall restrictions than others. This means that workloads may fail during runtime with the `RuntimeDefault` profile if they require syscalls that are not included in the default profile given by the runtime. This article shows how you can leverage the open source project [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) to diagnose issues and gain visibility into blocked syscalls.

## Symptoms

Workload is exiting unexpectedly after configuring it to use a seccomp profile, with `permission denied` or `function not implemented` errors.

## Prerequisites

- A tool to connect to the Kubernetes cluster, such as the `kubectl` tool. To install `kubectl` using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The [krew](https://sigs.k8s.io/krew) package manager for installing [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072)'s plugin. You can follow the [krew quickstart guide](https://krew.sigs.k8s.io/docs/user-guide/quickstart/) to install it.
- The seccomp profile that you are trying to troubleshoot.
- The open source project [Inspektor Gadget](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster).

## Troubleshooting Checklist

### Step 1: Modify your seccomp profile

Before testing, configure a custom seccomp profile that is identical to the one you are trying to troubleshoot and replace its default action (e.g., `SCMP_ACT_ERRNO`) with `SCMP_ACT_LOG` to log blocked syscalls instead of failing them outright. Your custom seccomp profile might look something like this:
 
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

The article [Configure a custom seccomp profile](/azure/aks/secure-container-access#configure-a-custom-seccomp-profile) shows how you can apply your custom seccomp profile to your AKS cluster. Alternatively, you can use `kubectl debug`:

Start by getting the names of the nodes in your AKS cluster. You can do this by running the following command:

```console 
kubectl get nodes 
```
Then, use `kubectl debug` to start a debug pod on the node and make sure there is a seccomp folder and `tar` is installed (needed for copying the profile into the node in the next step):

```console 
kubectl debug node/<node-name> -it --image=mcr.microsoft.com/azurelinux/base/core:3.0
root [ / ]# mkdir -p /host/var/lib/kubelet/seccomp
root [ / ]# tdnf install -y tar
```
In another terminal copy the podname, the pod is created in the `default` namespace and looks like `node-debugger-<node-name>-<random-sufix>`. It is outputted when you create the debug pod. With `kubectl cp` we can transfer the seccomp profile file to the node directly:

```console
kubectl cp <path local seccomp profile>/my-profile.json <podname>:/host/var/lib/kubelet/seccomp/my-profile.json
```

> [!NOTE]
> You need to repeat the above steps for each node in the cluster to ensure that the seccomp profile is available on all nodes where your workload might run.

Now we can modify the `seccompProfile` specification of the target pod, which should be confined to the recorded syscalls. For example:

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

[Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) provides insights into syscalls affecting your containers. To [use it](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster), run the following commands to install the `gadget` kubectl plugin in your host and deploy [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) into the cluster:

```console 
kubectl krew install gadget
```

```console 
kubectl gadget deploy
```

### Step 3: Run the **audit_seccomp gadget**

With [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) installed, start the [audit_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2259786) gadget using the [kubectl gadget run command](https://go.microsoft.com/fwlink/?linkid=2259865):

```console
kubectl gadget run audit_seccomp
```
### Step 4: Analyze Blocked Syscalls

Start running your workload (using `kubectl apply -f`) and then the [audit_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2259786) will log blocked syscalls, along with their associated pods, containers, and processes. You can use this information to identify the root causes of workload failures.
For instance, if you run the above-mentioned `default-pod` pod with the `my-profile.json` profile, the output will look like this:

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

From the output, you can see that the `test-container` is executing the `SYS_CLONE` syscall, but it is being blocked by the seccomp profile. With that information, you can analyze if you really want to allow those syscalls in your container. If that's the case, then tune the seccomp profile by remove the listed syscalls and the workload will stop failing.

Following some commonly blocked syscalls to watch out for. A more comprehensive list is available [here](/azure/aks/secure-container-access#significant-syscalls-blocked-by-default-profile):

| Syscall |Consideration |
|---|---|
| `clock_settime`  or `clock_adjtime` | If your workload needs precise time synchronization |
| `add_key` or `key_ctl` | If your workload needs to manage keys, these blocked syscalls prevent containers from using the kernel keyring which is used for retaining security data, authentication keys, encryption keys, and other data in the kernel. |
| `clone`  | This denies cloning new namespaces, except for ```CLONE_NEWUSER```. Workloads that rely on creating new namespaces might be impacted if this syscall is blocked.  |
| `io_uring`  | This syscall is blocked with the move to containerd 2.0, however was not blocked in the profile for containerd 1.7  |

## Next Steps

If you encounter issues with your workloads due to blocked syscalls, consider using a custom seccomp profile tailored to the specific needs of your application. You can check out the [Inspektor Gadget advise_seccomp gadget](https://go.microsoft.com/fwlink/?linkid=2260408).

Testing and refining your seccomp profiles ensures optimal performance and security for your AKS workloads. For further assistance, consult the [Microsoft Learn documentation on AKS and seccomp](/azure/aks/secure-container-access#secure-computing-seccomp).

## Related Content

[Secure container access to resources using built-in Linux security features](/azure/aks/secure-container-access#secure-computing-seccomp)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
