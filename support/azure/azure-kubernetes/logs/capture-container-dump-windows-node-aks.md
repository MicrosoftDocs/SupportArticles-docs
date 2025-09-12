---
title: Capture a Windows container dump file from a Windows node in an AKS cluster
description: Understand how to capture a Windows container dump file from a Windows node within an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/17/2024
ms.author: abelch
ms.reviewer: jarrettr
ms.service: azure-kubernetes-service
ms.custom: sap:Monitoring and Logging
---
# Capture a Windows container dump file from a Windows node in an AKS cluster

If a Windows container fails on a Microsoft Azure Kubernetes Service (AKS) cluster, you might have to examine the Windows container dump file to investigate the root cause. This article provides steps to capture a Windows container dump file from a Windows node in an AKS cluster. It also includes instructions to download the dump file to your local computer for further analysis.

## Prerequisites

- An AKS cluster. If you don't have an AKS cluster, [create one by using Azure CLI](/azure/aks/kubernetes-walkthrough) or [through the Azure portal](/azure/aks/kubernetes-walkthrough-portal).

- Windows agent pools that are created after `3/13/2024` or a node image that was upgraded to AKS Windows image version `20240316` or a later version. Alternatively, verify whether the WindowsCSEScriptsPackage version is v0.0.39 or newer, which can be located in `C:\AzureData\CustomDataSetupScript.log` on the Windows nodes.
## Step 1: Add annotations metadata to your deployment

Mount a host folder in the container, and add the annotations metadata in order to request that the Windows container store the dump file in a designated folder:

```yaml
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

Redeploy your deployment, and wait for the Windows container to fail. You can use `kubectl describe pod -n [POD-NAMESPACE] [POD-NAME]` to learn which AKS Windows node is hosting the pod.

## Step 3: Connect to the Windows node

Establish a connection to the AKS cluster node. You authenticate either by using a Secure Shell (SSH) key or the Windows admin password in a Remote Desktop Protocol (RDP) connection. Both methods require that you create an intermediate connection. This is because you can't currently connect directly to the AKS Windows node. Whether you connect to a node through SSH or RDP, you have to specify the user name for the AKS nodes. By default, this user name is `azureuser`.

### [SSH](#tab/ssh)

If you have an SSH key, [create an SSH connection to the Windows node](/azure/aks/ssh#create-the-ssh-connection-to-a-windows-node). The SSH key doesn't persist on your AKS nodes. The SSH key reverts to what was initially installed on the cluster during any of the following actions:

- Restart
- Version upgrade
- Node image upgrade

### [RDP](#tab/rdp)

If you don't have an SSH key, connect by using RDP and the Windows admin password. If you don't have this password for your cluster, reset the password in Azure CLI by running the [az aks update](/cli/azure/aks#az-aks-update) command. Specify the resource group, cluster name, and the new password. The command displays the cluster details after it finishes:

```azurecli-interactivel
az aks update \
    --resource-group <myResourceGroup> \
    --name <myAKSCluster> \
    --windows-admin-password "<myNewPassword>"
```

Use your Windows admin password to [connect to the node by using RDP](/azure/aks/rdp). This action requires that you deploy a "jump" virtual machine (VM) that connects to the same subnet that your cluster connects to.

### Redirect a data drive to the RDP connection

To transfer the capture files to your computer, you have to redirect a hard drive from your computer onto both the created VM and the RDP connection to the AKS Windows node. This redirection lets you copy the capture files you generate later to your computer.

1. On your computer, select Start, and then search for and select **Remote Desktop Connection**.

1. In the **Remote Desktop Connection** dialog box, select **Show Options**.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-show-options.png" alt-text="Screenshot of the Remote Desktop Connection dialog box that has the Show Options expandable button highlighted." border="false":::
1. In the **Local Resources** tab, select **More**.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-local-resources-more.png" alt-text="Screenshot of the Remote Desktop Connection dialog box that has the Local Resources tab selected and the More button highlighted." border="false":::
1. In a new **Remote Desktop Connection** dialog box, select **Drives** to expand the list of drives that are on your computer, and then select the drive that you want to redirect.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/remote-desktop-connection-local-devices-and-resources.png" alt-text="Screenshot of a new Remote Desktop Connection dialog box that shows the full expanded list of drives that you can select to use in the remote session." border="false":::

1. Connect to the Windows VM that you set up earlier.

---

## Step 4: Transfer the dump file locally

### [SSH](#tab/ssh)

After the container fails, identify the helper pod so that you can copy the dump file locally. Open a second console, and then get a list of pods by running the `kubectl get pods` command, as follows:

```output
kubectl get pods
NAME                                                    READY   STATUS    RESTARTS   AGE
azure-vote-back-6c4dd64bdf-m4nk7                        1/1     Running   2          3d21h
azure-vote-front-85b4df594d-jhpzw                       1/1     Running   2          3d21h
node-debugger-aks-nodepool1-38878740-vmss000000-6ztp6   1/1     Running   0          3m58s
```

The helper pod has a prefix of `node-debugger-aks`, as shown in the third row. Replace the pod name, and then run the following Secure Copy (scp) commands to retrieve the dump files (.dmp) that are saved when the container fails:

```cmd
scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:/C:/k/containerdumps/{container_id}/{application}.dmp .
```

You can list the `C:\k\containerdumps` folder to find the full path of the dump files after the connection is made to the Windows node.

### [RDP](#tab/rdp)

To transfer the TCP dump files from the AKS Windows node to the jump VM, follow these steps:

1. Connect to the AKS Windows node.
1. Run the following [net use](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/gg651155(v=ws.11)) command to map the shared resource of the jump VM to a drive that's named **Z**. If the shared resource is something other than drive C, adjust the command.

    ```output
    C:\Users\bookbinder>net use z: \\tsclient\c
    The command completed successfully.
    ```

1. To copy the dump files to your jump VM, run the following copy command:

    ```output
    C:\Users\azureuser>copy C:\k\containerdumps\*\*.dmp z:\
    ```

1. End the connection from the jump VM to the AKS Windows node. The dump files are now on drive C of the jump VM.

To copy the dump files from the jump VM to your computer, follow these steps:

1. In File Explorer on the jump VM, go to the root directory of drive C.
1. Select the *.dmp files.
1. Drag the .dmp files to the connection that's named **C on \<myComputerName>**.

The dump files are now in the root directory of drive C on your computer.

---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
