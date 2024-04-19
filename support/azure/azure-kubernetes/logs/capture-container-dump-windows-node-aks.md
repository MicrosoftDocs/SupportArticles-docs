---
title: Capture a Windows container dump from a Windows node in an AKS cluster
description: Understand how to capture a Windows container dump from a Windows node within an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/17/2024
ms.reviewer: genli
ms.service: azure-kubernetes-service
ms.custom: sap:Monitoring and Logging
---
# Capture a Windows container dump from a Windows node in an AKS cluster

Windows container may crash when you're using a Microsoft Azure Kubernetes Service (AKS) cluster. To help investigate these issues, this article explains how to capture a Windows container dump from a Windows node in an AKS cluster, and then download the dump to your local machine.

## Prerequisites

- An AKS cluster. If you don't have an AKS cluster, [create one using Azure CLI](/azure/aks/kubernetes-walkthrough) or [through the Azure portal](/azure/aks/kubernetes-walkthrough-portal).

- The Windows agent pools are created after `3/13/2024` or the node image has been upgraded to AKS Windows image versions equal to or newer than `20240316`. Users also can check the AKS Windows CSE script package version (`v0.0.39` or newer) in the CSE log `WindowsCSEScriptsPackage is ` in `C:\AzureData\CustomDataSetupScript.log` in the Windows nodes.

## Step 1: Add annotations in your deployment

You need to mount a host folder in the container and add annotations to request Windows containerd to store the dump in the folder.

```
metadata:
  ...
  annotations:
    "io.microsoft.container.processdumplocation": "C:\\CrashDumps\\{container_id}"
    "io.microsoft.wcow.processdumptype": "mini"
    "io.microsoft.wcow.processdumpcount": "10"
spec:
  ...
  containers:
  - name: containername
    image: ...
    ...
    volumeMounts:
      - mountPath: C:\CrashDumps
        name: local-dumps
  volumes:
  - name: local-dumps
    hostPath:
      path: C:\k\containerdumps
      type: DirectoryOrCreate
```

## Step 2: Reproduce the issue

Redeploy your deployment and wait that the Windows container crashes. You can use `kubectl describe pod -n [POD-NAMESPACE] [POD-NAME]` to find which AKS Windows node is hosting the pod.

## Step 3: Connect to the Windows node

The next step is to establish a connection to the AKS cluster node. You authenticate either using a Secure Shell (SSH) key, or using the Windows admin password in a Remote Desktop Protocol (RDP) connection. Both methods require creating an intermediate connection, because you can't currently connect directly to the AKS Windows node. Whether you connect to a node through SSH or RDP, you need to specify the user name for the AKS nodes. By default, this user name is *azureuser*.

### [SSH](#tab/ssh)

If you have an SSH key, [create an SSH connection to the Windows node](/azure/aks/ssh#create-the-ssh-connection-to-a-windows-node). The SSH key doesn't persist on your AKS nodes. The SSH key reverts to what was initially installed on the cluster during any:

- Reboot
- Version upgrade
- Node image upgrade

### [RDP](#tab/rdp)

If you don't have an SSH key, connect using RDP and the Windows admin password. What if you don't have this password for your cluster? Then reset the password in Azure CLI by running the [az aks update](/cli/azure/aks#az-aks-update) command. Specify the resource group, cluster name, and the new password. The command displays the cluster details after it completes.

```azurecli-interactive
az aks update \
    --resource-group <myResourceGroup> \
    --name <myAKSCluster> \
    --windows-admin-password "<myNewPassword>"
```

Using your Windows admin password, [connect to the node with RDP](/azure/aks/rdp), which involves first deploying a "jump" virtual machine to the same subnet as your cluster.

### Redirect a data drive to the RDP connection

To transfer the capture files to your machine, you need to redirect a disk drive from your machine onto both the created virtual machine (VM) and the RDP connection to the AKS Windows node. This redirection lets you copy the capture files you generate later to your machine.

1. On your machine, select the Start menu, then search for and select **Remote Desktop Connection**.

1. In the **Remote Desktop Connection** dialog box, select **Show Options**.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-show-options.png" alt-text="Screenshot of the Remote Desktop Connection dialog box, with the Show Options expandable button highlighted." border="false":::
1. In the **Local Resources** tab, select **More**.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-local-resources-more.png" alt-text="Screenshot of the Remote Desktop Connection dialog box, with the Local Resources tab selected and the More button highlighted." border="false":::
1. In a new **Remote Desktop Connection** dialog box, select **Drives** to expand the list of drives on your machine, and then select the drive you want to redirect.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-local-devices-and-resources.png" alt-text="Screenshot of a new Remote Desktop Connection dialog box, showing the full expanded list of drives that you can choose to use in the remote session." border="false":::

Then finish connecting to the Windows virtual machine that you set up earlier.

---

## Step 4: Transfer the dump locally

### [SSH](#tab/ssh)

After the container crashes, identify the helper pod so you can copy the dump locally. Open a second console, and then get a list of pods by running `kubectl get pods`, as shown below.

```output
kubectl get pods
NAME                                                    READY   STATUS    RESTARTS   AGE
azure-vote-back-6c4dd64bdf-m4nk7                        1/1     Running   2          3d21h
azure-vote-front-85b4df594d-jhpzw                       1/1     Running   2          3d21h
node-debugger-aks-nodepool1-38878740-vmss000000-6ztp6   1/1     Running   0          3m58s
```

The helper pod has a prefix of `node-debugger-aks`, as shown in the third row. Replace the pod name, and then run the following Secure Copy (scp) commands. These commands retrieve the dump (.dmp) files, which are saved when the container crashes.

```cmd
scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:/C:/k/containerdumps/{container_id}/{application}.dmp .
```

You can list the folder `C:\k\containerdumps` to find the full path of the dump files after connecting to the Windows node.

### [RDP](#tab/rdp)

First, follow these steps to transfer the TCP dump files from the AKS Windows node to the jump VM:

1. Connect to the AKS Windows node.
1. Run the following [net use](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/gg651155(v=ws.11)) command to map the jump VM's shared resource to a drive name (z:). If the shared resource is something other than the c: drive, adjust the command.

    ```output
    C:\Users\bookbinder>net use z: \\tsclient\c
    The command completed successfully.
    ```

1. Then run the following copy command to copy the dump files to your jump VM:

    ```output
    C:\Users\azureuser>copy C:\k\containerdumps\*\*.dmp z:\
    ```

Now you may end your connection from the jump VM to the AKS Windows node. The dump files are now on the c: drive of the jump VM.

Next, follow these steps to copy the dump files from the jump VM to your machine:

1. In File Explorer on the jump VM, go to the root directory of your c: drive.
1. Choose the ***.dmp** files.
1. Drag those dump files to the connection named **C on \<myComputerName>**.

The dump files are now in the root directory of your machine's c: drive.

---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
