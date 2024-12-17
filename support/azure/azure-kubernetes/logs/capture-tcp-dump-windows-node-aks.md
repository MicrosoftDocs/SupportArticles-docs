---
title: Capture a TCP dump from a Windows node in an AKS cluster
description: Understand how to capture a TCP dump from a Windows node within an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/14/2024
ms.reviewer: erbookbi, jopalhei, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Monitoring and Logging
---
# Capture a TCP dump from a Windows node in an AKS cluster

Networking issues may occur when you're using a Microsoft Azure Kubernetes Service (AKS) cluster. To help investigate these issues, this article explains how to capture a TCP dump from a Windows node in an AKS cluster, and then download the capture to your local machine.

## Prerequisites

- Azure CLI, version&nbsp;2.0.59 or later. You can open [Azure Cloud Shell](/azure/cloud-shell/overview) in the web browser to enter Azure CLI commands. Or [install or upgrade Azure CLI](/cli/azure/install-azure-cli-windows) on your local machine. To find the version that's installed on your machine, run `az --version`.
- An AKS cluster. If you don't have an AKS cluster, [create one using Azure CLI](/azure/aks/kubernetes-walkthrough) or [through the Azure portal](/azure/aks/kubernetes-walkthrough-portal).

## Step 1: Find the nodes to troubleshoot

How do you determine which node to pull the TCP dump from? You first get the list of nodes in the AKS cluster using the Kubernetes command-line client, [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/). Follow the instructions to connect to the cluster and run the `kubectl get nodes --output wide` command [using the Azure portal](/azure/aks/kubernetes-walkthrough-portal#connect-to-the-cluster) or [Azure CLI](/azure/aks/kubernetes-walkthrough#connect-to-the-cluster). A node list that's similar to the following output appears:

```output
$ kubectl get nodes --output wide
NAME                                STATUS   ROLES   AGE     VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION     CONTAINER-RUNTIME
akswin000000                        Ready    agent   3m8s    v1.20.9   10.240.0.4     <none>        Windows Server 2019 Datacenter   10.0.17763.2237    docker://20.10.6
akswin000001                        Ready    agent   3m50s   v1.20.9   10.240.0.115   <none>        Windows Server 2019 Datacenter   10.0.17763.2237    docker://20.10.6
akswin000002                        Ready    agent   3m32s   v1.20.9   10.240.0.226   <none>        Windows Server 2019 Datacenter   10.0.17763.2237    docker://20.10.6
```

## Step 2: Connect to a Windows node

The next step is to establish a connection to the AKS cluster node. You authenticate either using a Secure Shell (SSH) key, or using the Windows admin password in a Remote Desktop Protocol (RDP) connection. Both methods require creating an intermediate connection, because you can't currently connect directly to the AKS Windows node. Whether you connect to a node through SSH or RDP, you need to specify the user name for the AKS nodes. By default, this user name is *azureuser*. Besides using an SSH or RDP connection, you can connect to a Windows node from the HostProcess container.

### [HostProcess](#tab/hostprocess)

1. Create *hostprocess.yaml* with the following content. Replace `AKSWINDOWSNODENAME` with the AKS Windows node name.

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      labels:
        pod: hpc
      name: hpc
    spec:
      securityContext:
        windowsOptions:
          hostProcess: true
          runAsUserName: "NT AUTHORITY\\SYSTEM"
      hostNetwork: true
      containers:
        - name: hpc
          image: mcr.microsoft.com/windows/servercore:ltsc2022 # Use servercore:1809 for WS2019
          command:
            - powershell.exe
            - -Command
            - "Start-Sleep 2147483"
          imagePullPolicy: IfNotPresent
      nodeSelector:
        kubernetes.io/os: windows
        kubernetes.io/hostname: AKSWINDOWSNODENAME
      tolerations:
        - effect: NoSchedule
          key: node.kubernetes.io/unschedulable
          operator: Exists
        - effect: NoSchedule
          key: node.kubernetes.io/network-unavailable
          operator: Exists
        - effect: NoExecute
          key: node.kubernetes.io/unreachable
          operator: Exists
    ```
2. Run the `kubectl apply -f hostprocess.yaml` command to deploy the Windows HostProcess container in the specified Windows node.
3. Run the `kubectl exec -it [HPC-POD-NAME] -- powershell` command.
4. Run any PowerShell commands inside the HostProcess container to access the Windows node.

    > [!Note]
    > To access the files in the Windows node, switch the root folder to `C:\` inside the HostProcess container.

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

## Step 3: Create a packet capture

When you're connected to the Windows node through SSH or RDP, or from the HostProcess container, a form of the Windows command prompt appears:

```cmd
azureuser@akswin000000 C:\Users\azureuser>
```

Now open a command prompt and enter the [Network Shell](/windows-server/networking/technologies/netsh/netsh) (netsh) command below for capturing traces ([netsh trace start](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj129382(v=ws.11)#start)). This command starts the packet capture process.

```cmd
netsh trace start capture=yes tracefile=C:\temp\AKS_node_name.etl
```

Output appears that's similar to the following text:

```output
Trace configuration:
-------------------------------------------------------------------
Status:             Running
Trace File:         AKS_node_name.etl
Append:             Off
Circular:           On
Max Size:           250 MB
Report:             Off
```

While the trace is running, replicate your issue many times. This action ensures the issue has been captured within the TCP dump. Note the time stamp while you replicate the issue. To stop the packet capture when you're done, enter `netsh trace stop`:

```output
azureuser@akswin000000 C:\Users\azureuser>netsh trace stop
Merging traces ... done
Generating data collection ... done
The trace file and additional troubleshooting information have been compiled as "C:\temp\AKS_node_name.cab".
File location = C:\temp\AKS_node_name.etl
Tracing session was successfully stopped.
```

## Step 4: Transfer the capture locally

### [HostProcess](#tab/hostprocess)

After you complete the packet capture, identify the HostProcess pod so that you can copy the dump locally. 

1. On your local machine, open a second console, and then get a list of pods by running the `kubectl get pods` command:

    ```console
    kubectl get pods
    NAME                                                    READY   STATUS    RESTARTS   AGE
    azure-vote-back-6c4dd64bdf-m4nk7                        1/1     Running   2          3d21h
    azure-vote-front-85b4df594d-jhpzw                       1/1     Running   2          3d21h
    hpc                                                     1/1     Running   0          3m58s
    ```

    The HostProcess pod's default name is *hpc*, as shown in the third line.

2. Copy the TCP dump files locally by running the following commands. Replace the pod name with `hpc`.

    ```console
    kubectl cp -n default hpc:/temp/AKS_node_name.etl ./AKS_node_name.etl
    tar: Removing leading '/' from member names
    kubectl cp -n default hpc:/temp/AKS_node_name.etl ./AKS_node_name.cab
    tar: Removing leading '/' from member names
    ```

    The *.etl* and *.cab* files will now be present in your local directory.

### [SSH](#tab/ssh)

After you complete the packet capture, identify the helper pod so you can copy the dump locally. Open a second console, and then get a list of pods by running `kubectl get pods`, as shown below.

```console
kubectl get pods
NAME                                                    READY   STATUS    RESTARTS   AGE
azure-vote-back-6c4dd64bdf-m4nk7                        1/1     Running   2          3d21h
azure-vote-front-85b4df594d-jhpzw                       1/1     Running   2          3d21h
node-debugger-aks-nodepool1-38878740-vmss000000-6ztp6   1/1     Running   0          3m58s
```

The helper pod has a prefix of `node-debugger-aks`, as shown in the third row. Replace the pod name, and then run the following Secure Copy (scp) commands. These commands retrieve the event trace log (.etl) and archive (.cab) files, which are generated for the packet capture.

```console
scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:AKS_node_name.cab .
scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:AKS_node_name.etl .
```

Output similar to the following text appears:

```output
$ scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:AKS_node_name.cab .

Authorized uses only. All activity may be monitored and reported.
AKS_node_name.cab                                                                  100%  571KB 984.0KB/s   00:00

scp -o 'ProxyCommand ssh -p 2022 -W %h:%p azureuser@127.0.0.1' azureuser@10.240.0.97:AKS_node_name.etl .

Authorized uses only. All activity may be monitored and reported.
AKS_node_name.etl                                                                  100% 1536KB   1.3MB/s   00:01
```

### [RDP](#tab/rdp)

First, follow these steps to transfer the TCP dump files from the AKS Windows node to the jump VM:

1. Connect to the AKS Windows node.
1. Run the following [net use](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/gg651155(v=ws.11)) command to map the jump VM's shared resource to a drive name (z:). If the shared resource is something other than the c: drive, adjust the command.

    ```output
    C:\Users\bookbinder>net use z: \\tsclient\c
    The command completed successfully.
    ```

1. Then run the following copy command to copy the TCP dump files to your jump VM:

    ```output
    C:\Users\azureuser>copy c:\temp\AKS_node_name.* z:\
    AKS_node_name.cab
    AKS_node_name.etl
            2 file(s) copied.
    ```

Now you may end your connection from the jump VM to the AKS Windows node. The two files you generated from the dump are now on the c: drive of the jump VM.

Next, follow these steps to copy the dump files from the jump VM to your machine:

1. In File Explorer on the jump VM, go to the root directory of your c: drive.
1. Choose the **AKS_node_name.cab** and **AKS_node_name.etl** files.
1. Drag the two files to the connection named **C on \<myComputerName>**.

    :::image type="content" source="./media/capture-tcp-dump-windows-node-aks/jump-vm-file-explorer.png" alt-text="Screenshot of File Explorer on the jump virtual machine. Drag AKS_node_name.cab and AKS_node_name.etl from the jump VM to your local machine drive." lightbox="./media/capture-tcp-dump-windows-node-aks/jump-vm-file-explorer.png" border="false":::

The dump files are now in the root directory of your machine's c: drive.

---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
