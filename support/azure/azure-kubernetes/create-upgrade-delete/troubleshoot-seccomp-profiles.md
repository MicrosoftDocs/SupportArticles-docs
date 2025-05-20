---
title: Troubleshoot Seccomp Profiles on AKS
description: "Diagnosing workload issues caused by seccomp profiles.” 
author: mayasingh17
ms.author: mayasingh
ms.service: Azure Kubernetes Service
ms.topic: troubleshooting-general #Don't change.
ms.date: 05/05/2025

#customer intent: As a DevOps Engineer, I want to set up an effective Seccomp profile so that I can run my workloads successfully while making them as secure as possible. 

---
# Troubleshoot seccomp profile configurations on Azure Kubernetes Service
Seccomp (Secure Computing Mode) is a Linux kernel feature that enhances the security of containerized workloads by restricting the system calls (syscalls) that containers can make. In Azure Kubernetes Service (AKS), the [containerd](https://containerd.io/) runtime used by AKS nodes natively supports seccomp. However, enabling a seccomp profile can sometimes lead to workload failures due to workload critical syscalls being blocked. This guide explains what seccomp profiles are, how they work, and how you can troubleshoot them using the open source project [Inspektor Gadget](inspektor-gadget.io)’s ```audit seccomp profile``` gadget.

Seccomp profiles define the syscalls that are allowed or denied for a given container. Syscalls are the interface that allows user space programs to request kernel services. There are two seccomp profile values supported on AKS: 

•	```RuntimeDefault```: Use the seccomp profile given by the runtime

•	```Unconfined```: All syscalls are executed 

To enable seccomp on your AKS node pools, see [Secure container access to resources using built-in Linux security features](https://learn.microsoft.com/azure/aks/secure-container-access). You can also configure a custom profile to meet your workload’s specific needs, see [Configure a custom seccomp profile](https://learn.microsoft.com/azure/aks/secure-container-access#configure-a-custom-seccomp-profile) for details. Custom seccomp profiles are not supported or managed by AKS. 

When using seccomp profiles, it’s essential to test and validate their impact on your workloads. Some workloads might require a lower number of syscall restrictions than others. This means that workloads may fail during runtime with the ```RuntimeDefault``` profile. Here's how you can leverage the open source project Inspektor Gadget to diagnose issues and gain visibility into blocked syscalls.

If a workload failure occurs, you might see errors such as:

Workload is existing unexpectedly after the feature is enabled, with ```permission denied``` or ```function not implemented``` errors.

To diagnose the root cause of workload failures due to blocked syscalls by easily getting visibility into pods and containers use the open source project [Inspektor Gadget](https://inspektor-gadget.io/).

## Prerequisites 
- A tool to connect to the Kubernetes cluster, such as the `kubectl` tool. To install `kubectl` using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The seccomp profile that you are trying to troubleshoot 

- The open source project [Inspektor Gadget](https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster)

## Troubleshooting Checklist
### Step 1: Modify your seccomp profile
Before testing, configure a custom seccomp profile that is identical to the one you are trying to troubleshoot and replace the default action in the seccomp profile:

•	Replace ```SCMP_ACT_ERRNO``` with ```SCMP_ACT_LOG``` to log blocked syscalls instead of failing them outright.

•	Your custom seccomp profile might look something like this: 
```console 
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

### Step 2: Install Inspektor Gadget
[Inspektor Gadget](https://inspektor-gadget.io/docs/latest/quick-start) provides insights into syscalls affecting your containers. To install it, run the following commands to add the gadget plugin and deploy it:

```console 
kubectl krew install gadget
```

```console 
kubectl gadget deploy
```

### Step 3: Run the [audit seccomp profile gadget](https://inspektor-gadget.io/docs/latest/gadgets/audit_seccomp)
With Inspektor Gadget installed, start the audit ```seccomp profile gadget``` using the ```kubectl gadget run``` command:
```console
kubectl gadget run ghcr.io/inspektor-gadget/gadget/audit_seccomp:latest
```
### Step 4: Analyze Blocked Syscalls
Start running your workload and then the [audit seccomp profile gadget](https://inspektor-gadget.io/docs/latest/gadgets/audit_seccomp) will log blocked syscalls, along with their associated pods, containers, and processes. You can use this information to identify the root causes of workload failures.

We recommend investigating the following but you can find a larger list of blocked syscalls here. Here are some commonly blocked syscalls to look out for

| Syscall |Consideration |
|---|---|
| `clock_settime`  or `clock_adjtime` | If your workload needs precise time synchronization |
| `add_key` or `key_ctl` | If your workload needs to manage keys, these blocked syscalls prevent containers from using the kernel keyring which is used for retaining security data, authentication keys, encryption keys, and other data in the kernel. |
| `clone`  | This denies cloning new namespaces, except for ```CLONE_NEWUSER```. Workloads that rely on creating new namespaces might be impacted if this syscall is blocked.  |
| `io_uring`  | These syscalls are blocked with the move to containerd 2.0, however were not blocked in the profile for containerd 1.7  |

## Next Steps
If you encounter issues with your workloads due to blocked syscalls:

•	Consider using a custom seccomp profile tailored to the specific needs of your application.

•	If security concerns are minimal, switch to the Unconfined profile to disable syscall restrictions entirely.

Testing and refining your seccomp profiles ensures optimal performance and security for your AKS workloads. For further assistance, consult the [Microsoft Learn documentation on AKS and seccomp](https://learn.microsoft.com/azure/aks/secure-container-access#secure-computing-seccomp).

## Related Content
[Secure container access to resources using built-in Linux security features](https://learn.microsoft.com/azure/aks/secure-container-access#secure-computing-seccomp)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
