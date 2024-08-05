---
title: Fails to mount an Azure Blob storage container
description: Provides causes and solutions for errors that cause the mounting of an Azure Blob storage container to fail.
author: AndreiBarbu95
ms.author: andbar
ms.service: azure-kubernetes-service
ms,subservice: troubleshoot-azure-storage-issues
ms.date: 12/20/2022
ms.reviewer: cssakscic, chiragpa 
ms.custom: sap:Storage
---
# Errors when mounting an Azure Blob storage container

This article provides possible causes and solutions for errors that cause the mounting of an Azure Blob storage container to fail.

## Symptoms

In an Azure Kubernetes Service (AKS) environment, you deploy a Kubernetes resource such as a Deployment and a StatefulSet. The deployment will create a pod that mounts a PersistentVolumeClaim (PVC) referencing an Azure Blob storage container.

However, the pod stays in the **ContainerCreating** status. When you run the `kubectl describe pods` command, you may see one of the following errors in the command output, which causes the mounting operation to fail.

> [!NOTE]
> Azure Blob storage container may use the BlobFuse or Network File System (NFS) version 3.0 protocol. BlobFuse and NFS 3.0 scenarios are documented separately in this article.

### BlobFuse related errors

- [BlobFuse error 1: Exit status 255. Unable to start blobfuse, errno=404. Unable to start blobfuse due to authentication or connectivity issues](#blobfuse-error1)
- [BlobFuse error 2: Exit status 255. Unable to start blobfuse, errno=403. Unable to start blobfuse due to authentication or connectivity issues](#blobfuse-error2)
- [BlobFuse error 3: Context deadline exceeded/An operation with the given Volume ID <…> already exists](#blobfuse-error3)

### NFS 3.0 related errors

- [NFS 3.0 error 1: Exit status 32. No such file or directory](#nfs-error1)
- [NFS 3.0 error 2: Exit status 32, access denied by server while mounting](#nfs-error2)
- [NFS 3.0 error 3: Context deadline exceeded/An operation with the given Volume ID <…> already exists](#nfs-error3)

See the following sections for possible causes and solutions.

> [!NOTE]
> Although the cause of an issue may be similar in some scenarios, the error may differ because of the different nature of the BlobFuse and NFS 3.0 protocols.

## <a id="blobfuse-error1"></a>BlobFuse error 1: Exit status 255 Unable to start blobfuse, errno=404, Unable to start blobfuse due to authentication or connectivity issues

### Cause: The Blob container doesn't exist

To check if the Blob container exists, follow these steps:

1. Search for Storage accounts in the Azure portal and access your storage account.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/access-storage-account.png" alt-text="Screenshot that shows how to find a storage account." lightbox="media/mounting-azure-blob-storage-container-fail/access-storage-account.png":::

1. Select **Containers** under **Data storage** in the storage account and check if the associated PersistentVolume (PV) exists in **Containers**. To see the Persistent Volume (PV), check the Persistent Volume Claim (PVC) associated with the pod in the YAML file, and then check which PV is associated with that PVC.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/persistent-volume-claim.png" alt-text="Screenshot that shows the Persistent Volume Claim in Containers." lightbox="media/mounting-azure-blob-storage-container-fail/persistent-volume-claim.png":::

### Solution: Ensure the container exists

To resolve this issue, make sure that the Blob container that's associated with the PV/PVC exists.

## <a id="blobfuse-error2"></a>BlobFuse error 2: Exit status 255 Unable to start blobfuse, errno=403, Unable to start blobfuse due to authentication or connectivity issues

Here are the possible causes for this error:

- [Cause 1: Kubernetes secret doesn't reference the correct storage account name or key](#cause1-for-blobfuse-error2)
- [Cause 2: AKS's virtual network (VNET) and subnet aren't allowed for the storage account](#cause2-for-blobfuse-error2)

### <a id="cause1-for-blobfuse-error2"></a>Cause 1: Kubernetes secret doesn't reference the correct storage account name or key

If the Blob storage container is created [dynamically](/azure/aks/azure-csi-blob-storage-dynamic), a Kubernetes secret resource is automatically created with the name "azure-storage-account-\<storage-account-name>-secret".

If the Blob storage container is created [manually](/azure/aks/azure-csi-blob-storage-static?tabs=secret), the Kubernetes secret resource should be created manually.

Regardless of the creation method, if the storage account name or the key that's referenced in the Kubernetes secret mismatches the actual value, the mounting operation will fail with the "Permission denied" error.

#### Possible causes for the mismatch

- If the Kubernetes secret is created manually, a typo may occur during the creation.

- If a "Rotate key" operation is performed at the storage account level, the changes won't be reflected at the Kubernetes secret level. This will lead to a mismatch between the key value at the storage account level and the value at the Kubernetes secret level.

    If a "Rotate key" operation happens, an operation with the name "Regenerate Storage Account Keys" will be displayed in the Activity log of the storage account. Be aware of the [90 days retention period for Activity log](/azure/azure-monitor/essentials/activity-log#retention-period).

#### Verify the mismatch

To verify the mismatch, follow these steps:

1. Search for and access the storage account in the Azure portal. Select **Access keys** > **Show keys** in the storage account. You'll see the storage account name and associated keys.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/storage-account-name-associated-keys.png" alt-text="Screenshot that shows the storage account name and associated keys.":::

2. Go to the AKS cluster, select **Configuration** > **Secrets**, and then search for and access the associated secret.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/access-secret.png" alt-text="Screenshot that shows the associated secret." lightbox="media/mounting-azure-blob-storage-container-fail/access-secret.png":::

3. Select **Show** (the eye icon) and compare the values of the storage account name and associated key with the values in step 1.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/storage-account-name-key-values.png" alt-text="Screenshot that shows the values of the storage account name and associated key." lightbox="media/mounting-azure-blob-storage-container-fail/storage-account-name-key-values.png":::

    Before you select **Show**, the values of the storage account name and associated key are encoded into base64 strings. After you select **Show**, the values are decoded.

If you don't have access to the AKS cluster in the Azure portal, perform step 2 at the kubectl level:

1. Get the YAML file of the Kubernetes secret, and then run the following command to get the values of the storage account name and the key from the output:

    ```console
    kubectl get secret <secret-name> -n <secret-namespace> -o <yaml-file-name>
    ```

2. Use the `echo` command to decode the values of the storage account name and the key and compare them with the values at the storage account level.

    Here's an example of decoding the storage account name:

    ```console
    echo -n '<storage account name>' | base64 --decode ;echo
    ```

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/command-decode-storage-account-name.png" alt-text="Screenshot of command that decodes storage account name.":::

#### Solution: Adjust the Kubernetes secret and re-create the pods

If the value of the storage account name or key in the Kubernetes secret doesn't match the value in **Access keys** in the storage account, adjust the Kubernetes secret at the Kubernetes secret level by running the following command:

```console
kubectl edit secret <secret-name> -n <secret-namespace>
```

The value of the storage account name or the key added in the Kubernetes secret configuration should be a base64 encoded value. To get the encoded value, use the `echo` command.

Here's an example of encoding the storage account name:

```console
echo -n '<storage account name>'| base64 | tr -d '\n' ; echo
```

For more information, see [Managing Secrets using kubectl](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/).

After the Kubernetes secret `azure-storage-account-<storage-account-name>-secret` has the correct values, re-create the pods. Otherwise, those pods will continue to use the old values that aren't valid anymore.

### <a id="cause2-for-blobfuse-error2"></a>Cause 2: AKS's VNET and subnet aren't allowed for the storage account

If the storage account's network is limited to selected networks, but the VNET and subnet of the AKS cluster aren't added to the selected networks, the mounting operation will fail.

### Solution: Allow AKS's VNET and subnet for the storage account

1. Identify the node that hosts the faulty pod by running the following command:

    ```console
    kubectl get pod <pod-name> -n <namespace> -o wide
    ```

    Check the node in the command output:

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/kubectl-get-pod-command-output.png" alt-text="Screenshot of the command that can identity the node and output." lightbox="media/mounting-azure-blob-storage-container-fail/kubectl-get-pod-command-output.png":::

2. Go to the AKS cluster in the Azure portal, select **Properties** > **Infrastructure resource group**, access the virtual machine scale set (VMSS) associated with the node, and then check the **Virtual network/subnet** to identify the VNET and subnet.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/identify-vnet-subnet.png" alt-text="Screenshot of the VNET and subnet.":::

3. Access the storage account in the Azure portal, and then select **Networking**. If **Public network access** is set to **Enabled from selected virtual networks** or **Disabled**, and the connectivity isn't through a private endpoint, check if the VNET and subnet of the AKS cluster are allowed under **Firewalls and virtual networks**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/firewalls-and-virtual-networks-settings.png" alt-text="Screenshot of Firewalls and virtual networks settings." lightbox="media/mounting-azure-blob-storage-container-fail/firewalls-and-virtual-networks-settings.png":::

    If the VNET and subnet of the AKS cluster aren't added, select **Add existing virtual network**. On the **Add networks** page, type the VNET and subnet of the AKS cluster, and then select **Add** > **Save**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/add-networks.png" alt-text="Screenshot of the 'Add networks' dialog.":::

    It may take a few moments for the changes to take effect. After the VNET and subnet are added, check if the pod status changes from **ContainerCreating** to **Running**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/pod-status-running.png" alt-text="Screenshot shows that the pod status is 'Running'." lightbox="media/mounting-azure-blob-storage-container-fail/pod-status-running.png":::

## <a id="blobfuse-error3"></a>BlobFuse error 3: Context deadline exceeded/An operation with the given Volume ID <…> already exists

Here are possible causes for this error:

- [Cause 1: Network Security Group blocks traffic between AKS and the storage account](#cause1-for-blobfuse-error3)
- [Cause 2: Virtual Appliance blocks traffic between AKS and the storage account](#cause2-for-blobfuse-error3)

### <a id="initial-troubleshooting-blobfuse-error-3"></a>Initial troubleshooting for BlobFuse error 3

Azure Blob BlobFuse relies on port 443. Make sure that port 443 and/or the IP address of the storage account aren't blocked.

To check the IP address of the storage account, run a Domain Name System (DNS) command like `nslookup`, `dig`, or `host`. For example:

```console
nslookup <storage-account-name>.blob.core.windows.net
```

To check if there's connectivity between the AKS cluster and the storage account, get inside the [node](/azure/aks/ssh) or [pod](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) and run the following `nc` or `telnet` command:

```console
nc -v -w 2 <storage-account-name>.blob.core.windows.net 443
```

```console
telnet <storage-account-name>.blob.core.windows.net 443
```

### <a id="cause1-for-blobfuse-error3"></a>Cause 1: Network Security Group blocks traffic between AKS and the storage account

Check the output of the `nc` or `telnet` command mentioned in the [Initial troubleshooting for BlobFuse error 3](#initial-troubleshooting-blobfuse-error-3) section. If a time-out is displayed, check the [Network Security Group (NSG)](/azure/virtual-network/network-security-groups-overview) and make sure that the IP address of the storage account isn't blocked.

To check if the NSG blocks the IP address of the storage account, follow these steps:

1. In the Azure portal, go to [Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) and select **NSG diagnostic**.
2. Fill in the fields by using the following values:

    - **Protocol**: TCP
    - **Direction**: Outbound
    - **Source type**: IPv4 address/CIDR
    - **IPv4 address/CIDR**: The IP address of an instance that's associated with the AKS node
    - **Destination IP address**: The IP address of the storage account
    - **Destination port**: 443 (if using BlobFuse) and 111/2048 (if using NFS)

3. Select the **Check** button and check the **Traffic** status.

The **Traffic** status can be **Allowed** or **Denied**. The **Denied** status means that the NSG is blocking the traffic between the AKS cluster and the storage account. If the status is **Denied**, the NSG name will be shown.

### Solution: Allow connectivity between AKS and the storage account

To resolve this issue, make changes accordingly at the NSG level to allow the connectivity between the AKS cluster and the storage account on port 443.

### <a id="cause2-for-blobfuse-error3"></a>Cause 2: Virtual Appliance blocks traffic between AKS and the storage account

If you're using a Virtual Appliance (usually a firewall) to control outbound traffic of the AKS cluster (for example, the Virtual Appliance has a route table applied at the AKS cluster's subnet, and the route table has routes that send traffic towards the Virtual Appliance), the Virtual Appliance may block traffic between the AKS cluster and the storage account.

To isolate the issue, add a route in the route table for the IP address of the storage account to send the traffic towards the Internet.

To confirm which route table controls the traffic of the AKS cluster, follow these steps:

1. Go to the AKS cluster in the Azure portal and select **Properties** > **Infrastructure resource group**.
2. Access the VMSS or a virtual machine (VM) in an availability set if you're using such a VM set type.
3. Select **Virtual network/subnet** > **Subnets** and identify the subnet of the AKS cluster. On the right side, you'll see the route table.

To add a route in the route table, follow the steps in [Create a route](/azure/virtual-network/manage-route-table#create-a-route) and fill in the following fields:

- **Address prefix**: \<storage-account's-public-IP>/32
- **Next hop type**：Internet

This route will send all traffic between the AKS cluster and the storage account through the public internet.

After you add the route, test the connectivity by using the `nc` or `telnet` command and perform the mounting operation again.

### Solution: Ensure Virtual Appliance allows traffic between AKS and the storage account

If the mounting operation succeeds, we recommend that you consult your networking team to make sure that the Virtual Appliance can allow traffic between the AKS cluster and the storage account on port 443.

## <a id="nfs-error1"></a>NFS 3.0 error 1: Exit status 32. No such file or directory

### Cause: Blob container doesn't exist

To check if the Blob container exists, follow these steps:

1. Search for **Storage accounts** in the Azure portal and access your storage account.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/access-storage-account.png" alt-text="Screenshot that shows how to search a storage account." lightbox="media/mounting-azure-blob-storage-container-fail/access-storage-account.png":::

2. Select **Containers** under **Data storage** in the storage account and check if the associated PersistentVolume (PV) exists in **Containers**. To see the Persistent Volume (PV), check the Persistent Volume Claim (PVC) associated with the pod in the YAML file, and then check which PV is associated with that PVC.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/nfs-persistent-volume-claim.png" alt-text="Screenshot that shows the Persistent Volume Claim (PVC)." lightbox="media/mounting-azure-blob-storage-container-fail/nfs-persistent-volume-claim.png":::

### Solution: Ensure the Blob container exists

To resolve this issue, make sure that the Blob container that's associated with the PV/PVC exists.

## <a id="nfs-error2"></a>NFS 3.0 error 2: Exit status 32, access denied by server while mounting

### Cause: AKS's VNET and subnet aren't allowed for the storage account

If the storage account's network is limited to selected networks, but the VNET and subnet of the AKS cluster aren't added to the selected networks, the mounting operation will fail.

### Solution: Allow AKS's VNET and subnet for the storage account

1. Identify the node that hosts the faulty pod by running the following command:

    ```console
    kubectl get pod <pod-name> -n <namespace> -o wide
    ```

    Check the node in the command output:

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/nfs-kubectl-get-pod-command-output.png" alt-text="Screenshot that shows the 'kubectl get pod' command output." lightbox="media/mounting-azure-blob-storage-container-fail/nfs-kubectl-get-pod-command-output.png":::

2. Go to the AKS cluster in the Azure portal, select **Properties** > **Infrastructure resource group**, access the VMSS associated with the node, and then check the **Virtual network/subnet** to identify the VNET and subnet.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/identify-vnet-subnet.png" alt-text="Screenshot of the VNET and subnet.":::

3. Access the storage account in the Azure portal, and then select **Networking**. If **Public network access** is set to **Enabled from selected virtual networks** or **Disabled**, and the connectivity isn't through a private endpoint, check if the VNET and subnet of the AKS cluster are allowed under **Firewalls and virtual networks**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/nfs-firewalls-and-virtual-networks-settings.png" alt-text="Screenshot of the settings under 'Firewalls and virtual networks'." lightbox="media/mounting-azure-blob-storage-container-fail/nfs-firewalls-and-virtual-networks-settings.png":::

    If the VNET and subnet of the AKS cluster aren't added, select **Add existing virtual network**. On the **Add networks** page, type the VNET and subnet of the AKS cluster, and then select **Add** > **Save**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/add-networks.png" alt-text="Screenshot of the 'Add networks' dialog.":::

    It may take a few moments for the changes to take effect. After the VNET and subnet are added, check if the pod status changes from **ContainerCreating** to **Running**.

    :::image type="content" source="media/mounting-azure-blob-storage-container-fail/nfs-pod-status-running.png" alt-text="Screenshot of the pod status." lightbox="media/mounting-azure-blob-storage-container-fail/nfs-pod-status-running.png":::

## <a id="nfs-error3"></a>NFS 3.0 error 3: context deadline exceeded / An operation with the given Volume ID <…> already exists

Here are possible causes for this error:

- [Cause 1: Network Security Group blocks traffic between AKS and the storage account](#cause1-for-nfs-error3)
- [Cause 2: Virtual Appliance blocks traffic between AKS and the storage account](#cause2-for-nfs-error3)

### <a id="initial-troubleshooting-nfs-error-3"></a>Initial troubleshooting for NFS 3.0 error 3

[Azure Blob NFS 3.0 relies on ports 111 and 2048](/azure/storage/blobs/network-file-system-protocol-support#supported-network-connections). Make sure that ports 111 and 2048 and/or the IP address of the storage account aren't blocked.

To check the IP address of the storage account, run a Domain Name System (DNS) command like `nslookup`, `dig`, or `host`. For example:

```console
nslookup <storage-account-name>.blob.core.windows.net
```

To check if there's connectivity between the AKS cluster and the storage account, get inside the [node](/azure/aks/ssh) or [pod](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) and run the following `nc` or `telnet` command:

```console
nc -v -w 2 <storage-account-name>.blob.core.windows.net 111
```

```console
nc -v -w 2 <storage-account-name>.blob.core.windows.net 2048
```

```console
telnet <storage-account-name>.blob.core.windows.net 111
```

```console
telnet <storage-account-name>.blob.core.windows.net 2048
```

### <a id="cause1-for-nfs-error3"></a>Cause 1: Network Security Group blocks traffic between AKS and the storage account

Check the output of the `nc` or `telnet` command mentioned in the [Initial troubleshooting for NFS 3.0 error 3](#initial-troubleshooting-nfs-error-3) section. If a time-out is displayed, check the [Network Security Group (NSG)](/azure/virtual-network/network-security-groups-overview) and make sure that the IP address of the storage account isn't blocked.

To check if the NSG blocks the IP address of the storage account, follow these steps:

1. In the Azure portal, go to [Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) and select **NSG diagnostic**.
2. Fill in the fields by using the following values:

    - **Protocol**: TCP
    - **Direction**: Outbound
    - **Source type**: IPv4 address/CIDR
    - **IPv4 address/CIDR**: The IP address of an instance that's associated with the AKS node
    - **Destination IP address**: The IP address of the storage account
    - **Destination port**: 111 then 2048

3. Select the **Check** button and check the **Traffic** status.

The **Traffic** status can be **Allowed** or **Denied**. The **Denied** status means that the NSG is blocking the traffic between the AKS cluster and the storage account. If the status is **Denied**, the NSG name will be shown.

### Solution: Allow connectivity between AKS and the storage account

To resolve this issue, make changes accordingly at the NSG level to allow the connectivity between the AKS cluster and the storage account on port 111/2048.

### <a id="cause2-for-nfs-error3"></a>Cause 2: Virtual Appliance blocks traffic between AKS and the storage account

If you're using a Virtual Appliance (usually a firewall) to control outbound traffic of the AKS cluster (for example, the Virtual Appliance has a route table applied at the AKS cluster's subnet, and the route table has routes that send traffic towards the Virtual Appliance), the Virtual Appliance may block traffic between the AKS cluster and the storage account.

To isolate the issue, add a route in the route table for the IP address of the storage account to send the traffic towards the Internet.

To confirm which route table controls the traffic of the AKS cluster, follow these steps:

1. Go to the AKS cluster in the Azure portal and select **Properties** > **Infrastructure resource group**.

2. Access the virtual machine scale set (VMSS) or a VM in an availability set if you're using such a VM set type.

3. Select **Virtual network/subnet** > **Subnets** and identify the subnet of the AKS cluster. On the right side, you'll see the route table.

To add a route in the route table, follow the steps in [Create a route](/azure/virtual-network/manage-route-table#create-a-route) and fill in the following fields:

- **Address prefix**: \<storage-account's-public-IP>/32
- **Next hop type**: Internet

This route will send all traffic between the AKS cluster and the storage account through the public internet.

After you add the route, test the connectivity by using the `nc` or `telnet` command and perform the mounting operation again.

### Solution: Ensure Virtual Appliance allows traffic between AKS and the storage account

If the mounting operation succeeds, we recommend that you consult your networking team to make sure that the Virtual Appliance can allow traffic between the AKS cluster and the storage account on ports 111 and 2048.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
