---
title: Can't set the uid and gid mounting options on an Azure disk
description: Troubleshoot Kubernetes failures that are caused when you try to set the uid and GID mounting options on an Azure disk.
ms.date: 05/25/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
#Customer intent: As an Azure Kubernetes user, I want to be able to set the uid and gid mounting options on an Azure disk so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Can't set the uid and gid mounting options on an Azure disk

This article discusses how to fix issues that occur on a Microsoft Azure Kubernetes Service (AKS) cluster when you try to set the mounting options for user identifier (`uid`) and group identifier (`gid`) on an Azure disk.

## Symptoms

If you try to set `uid` and `gid` to 999 in the `mountOptions` setting of the Azure disk's configuration file, you receive an error that resembles the following text:

```output
Warning  FailedMount             63s                  kubelet, aks-nodepool1-29460110-0  MountVolume.MountDevice failed for volume "pvc-d783d0e4-85a1-11e9-8a90-369885447933" : azureDisk - mountDevice:FormatAndMount failed with mount failed: exit status 32
Mounting command: systemd-run
Mounting arguments: --description=Kubernetes transient mount for /var/lib/kubelet/plugins/kubernetes.io/azure-disk/mounts/m436970985 --scope -- mount -t xfs -o dir_mode=0777,file_mode=0777,uid=1000,gid=1000,defaults /dev/disk/azure/scsi1/lun2 /var/lib/kubelet/plugins/kubernetes.io/azure-disk/mounts/m436970985
Output: Running scope as unit run-rb21966413ab449b3a242ae9b0fbc9398.scope.
mount: wrong fs type, bad option, bad superblock on /dev/sde,
       missing codepage or helper program, or other error
```

## Cause

Azure disk uses the ext4/xfs filesystem by default, and mounting options such as `uid=x,gid=x` can't be set at mount time.

## Workaround 1: Use a pod security context to specify the user and group

[Configure the security context for a pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/). In the pod configuration file (YAML format), within the `spec`/`securityContext` field, set the `runAsUser` field to the previously specified `uid` value, and set the `fsGroup` field to the previously specified `gid` value. For example, the beginning of the configuration file might resemble the following code:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 0
    fsGroup: 0
```

> [!NOTE]
> By default, the `gid` and `uid` options are mounted as root or 0. If those options are set as non-root (such as 1000), Kubernetes will use the change owner command (`chown`) to change all directories and files within that disk. This operation can be time-consuming, and it might make the disk-mounting operation very slow.

## Workaround 2: Use an init container and the change owner command to specify the user and group

Set up an [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/), and then run a [chown](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/chown.html) command that specifies the user and group values in the container. The following code shows how to set up an init container to set the user and group:

```yaml
initContainers:
- name: volume-mount
  image: mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11
  command: ["sh", "-c", "chown -R 100:100 /data"]
  volumeMounts:
  - name: <your-data-volume>
    mountPath: /data
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
