---
title: Troubleshoot errors when mounting an Azure file share in AKS
description: Troubleshoot Azure file share mount errors in AKS by identifying common causes, fixing connectivity and permission issues, and restoring pod startup. Start now.
ms.date: 06/10/2026
ms.reviewer: chiragpa, akscsscic, shoguo, v-weizhu, v-rekhanain
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
ms.custom: sap:Storage
#Customer intent: As an Azure Kubernetes user, I want to identify why my pod fails to mount an Azure file share so that my workload can start successfully.
---
# Errors when mounting an Azure file share

## Summary

This article provides possible causes and solutions for errors that cause the mounting of an Azure file share to fail.

## Symptoms

When you deploy a Kubernetes resource such as a Deployment or a StatefulSet in an Azure Kubernetes Service (AKS) environment, the deployment creates a pod that mounts a PersistentVolumeClaim (PVC) that references an Azure file share.

However, the pod stays in the **ContainerCreating** status. When you run the `kubectl describe pods` command, you might see one of the following errors in the command output that causes the mounting operation to fail:

- [Mount error(2): No such file or directory](#mounterror2)
- [Mount error(13): Permission denied](#mounterror13)

Refer to the following output as an example:

```output
MountVolume.MountDevice failed for volume "\<pv-fileshare-name>"
rpc error: code = Internal desc =
volume(\<storage-account's-resource-group>#\<storage-account-name>#\<pv/fileshare-name>#) > mount "//\<storage-account-name>.file.core.windows.net/\<pv-fileshare-name>" on "/var/lib/kubelet/plugins/kubernetes.io/csi/pv/\<pv-fileshare-name>/globalmount" failed with
mount failed: exit status 32
Mounting command: mount
Mounting arguments: -t cifs -o dir_mode=0777,file_mode=0777,uid=0,gid=0,mfsymlinks,cache=strict,actimeo=30,\<masked> //\<storage-account-name>.file.core.windows.net/\<pv-name> /var/lib/kubelet/plugins/kubernetes.io/csi/pv/\<pv-name>/globalmount
Output: mount error(\<error-id>): \<error-description>
Refer to the mount.cifs(8) manual page (e.g. man mount.cifs) and kernel log messages (dmesg)
```

> [!NOTE]
>
> - If the storage account is publicly accessible, the hostname displayed in the output is *\<storage-account-name>.file.core.windows.net*.
> - If the storage account is configured privately with a private link, endpoint, or DNS zone, the hostname is *\<storage-account-name>.privatelink.file.core.windows.net*.

## Prerequisites

According to the message in the output, identify the storage account and file share as shown in the following example. Use these values in later troubleshooting steps.

> mount "//\<storage-account-name>.file.core.windows.net/\<pv-fileshare-name>"

See the following sections for possible causes and solutions.

## <a id="mounterror2"></a>Mount error(2): No such file or directory

This error indicates that there's no connectivity between the AKS cluster and the storage account.

### Initial troubleshooting

[Azure Files relies on the SMB protocol (port 445)](/azure/storage/files/storage-files-networking-overview#accessing-your-azure-file-shares). Make sure that port 445 and the IP address of the storage account aren't blocked.

To check the IP address of the storage account, run a Domain Name System (DNS) command such as `nslookup`, `dig`, or `host`. For example:

```console
nslookup <storage-account-name>.file.core.windows.net
```

To check whether there's connectivity between the AKS cluster and the storage account, get inside the [node](/azure/aks/ssh) or [pod](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) and run the following `nc` or `telnet` command:

```console
nc -v -w 2 <storage-account-name>.file.core.windows.net 445
```

```console
telnet <storage-account-name>.file.core.windows.net 445
```

### Possible causes for mount error(2)

- [Cause 1: File share doesn't exist](#filesharenotexist)
- [Cause 2: NSG blocks traffic between AKS and storage account](#nsgblockstraffic)
- [Cause 3: Virtual Appliance blocks traffic between AKS and storage account](#virtualapplianceblockstraffic)
- [Cause 4: FIPS enabled node pool is used](#fipsnodepool)

> [!NOTE]
>
> - Causes 1, 2, and 4 apply to public and private storage account scenarios.
> - Cause 3 applies to the public scenario only.

### <a id="filesharenotexist"></a>Cause 1: File share doesn't exist

To check whether the file share exists, follow these steps:

1. Search **Storage accounts** in the Azure portal and access your storage account.

    :::image type="content" source="media/fail-to-mount-azure-file-share/storage-account-lists.png" alt-text="Screenshot of storage accounts list in Azure portal." lightbox="media/fail-to-mount-azure-file-share/storage-account-lists.png":::

2. Select **File shares** under **Data storage** in the storage account and check whether the associated `PersistentVolumeClaim` (PVC) in the YAML file of the pod, deployment, or statefulset exists in **File shares**.

    :::image type="content" source="media/fail-to-mount-azure-file-share/file-shares.png" alt-text="Screenshot of selecting file shares in the storage account." lightbox="media/fail-to-mount-azure-file-share/file-shares.png":::

#### Solution: Ensure file share exists

To resolve this issue, make sure that the file share that's associated with the `PersistentVolume` (PV) or `PersistentVolumeClaim` (PVC) exists.

### <a id="nsgblockstraffic"></a>Cause 2: Network Security Group blocks traffic between AKS and storage account

Check the output of the `nc` or `telnet` command mentioned in the [Initial troubleshooting](#initial-troubleshooting) section. If a timeout is displayed, check the [network security group (NSG)](/azure/virtual-network/network-security-groups-overview) and make sure that the IP address of the storage account isn't blocked.

To check whether the NSG blocks the IP address of the storage account, follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to [Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) and select **NSG diagnostic**.
2. Fill the fields by using the following values:

    - **Protocol**: Any
    - **Direction**: Outbound
    - **Source type**: IPv4 address/CIDR
    - **IPv4 address/CIDR**: The IP address of an instance that's associated with the AKS node
    - **Destination IP address**: The IP address of the storage account
    - **Destination port**: 445

3. Select **Check** and check the **Traffic** status.

The **Traffic** status can be **Allowed** or **Denied**. The **Denied** status means that the NSG is blocking the traffic between the AKS cluster and storage account. If the status is **Denied**, the NSG name is shown.

#### Solution: Allow connectivity between AKS and storage account

To resolve this issue, make changes at the NSG level to allow the connectivity between the AKS cluster and the storage account on port 445.

### <a id="virtualapplianceblockstraffic"></a>Cause 3: Virtual Appliance blocks traffic between AKS and storage account

If you use a Virtual Appliance (usually a firewall) to control outbound traffic of the AKS cluster (for example, the Virtual Appliance has a route table applied at the AKS cluster's subnet, and the route table has routes that send traffic towards the Virtual Appliance), the Virtual Appliance might block traffic between the AKS cluster and the storage account.

To isolate the issue, add a route in the route table for the IP address of the storage account to send the traffic towards the internet.

To confirm which route table controls the traffic of the AKS cluster, follow these steps:

1. Go to the AKS cluster in the Azure portal and select **Properties** > **Infrastructure resource group**.
2. Access the virtual machine scale set (VMSS) or a VM in an availability set if you use such VM set type.
3. Select **Virtual network/subnet** > **Subnets** and identify the subnet of the AKS cluster. You see the route table to the side.

To add the route in the route table, follow the steps in [Create a route](/azure/virtual-network/manage-route-table#create-a-route) and fill in the following fields:

- **Address prefix**: \<storage-account's-public-IP>/32
- **Next hop type**：Internet

This route sends all traffic between the AKS cluster and storage account through the public internet.

After you add the route, test the connectivity by using the `nc` or `telnet` command and perform the mounting operation again.

#### Solution: Ensure Virtual Appliance allows traffic between AKS and storage account

If the mounting operation succeeds, consult your networking team to make sure that the Virtual Appliance can allow traffic between the AKS cluster and storage account on port 445.

### <a id="fipsnodepool"></a>Cause 4: FIPS-enabled node pool is used

If you use a [Federal Information Processing Standard (FIPS) enabled node pool](/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool), the mounting operation fails because FIPS disables some authentication modules. This limitation prevents the mounting of a CIFS share. This behavior is expected and isn't specific to AKS.

To resolve the issue, use one of the following solutions:

#### Solution 1: Schedule pods on nodes in a non-FIPS node pool

AKS node pools have FIPS disabled by default. You can enable FIPS only during node pool creation by using the `--enable-fips-image` parameter.

To resolve the error, schedule the pods on nodes in a non-FIPS node pool.

#### Solution 2: Create a pod that you can schedule on a FIPS-enabled node

To create a pod that you can schedule on a FIPS-enabled node, follow these steps:

1. Use the Azure Files CSI driver to create a custom StorageClass that uses the NFS protocol.

    Refer to the following YAML file as an example:

    ```yml
    kind: StorageClass 
    apiVersion: storage.k8s.io/v1 
    metadata: 
      name: azurefile-sc-fips 
    provisioner: file.csi.azure.com 
    reclaimPolicy: Delete 
    volumeBindingMode: Immediate 
    allowVolumeExpansion: true 
    parameters: 
      skuName: Premium_LRS 
      protocol: nfs 
    ```

    The SKU is set to Premium_LRS in the YAML file because the Premium SKU is required for NFS. For more information, see [Dynamic Provision](https://github.com/kubernetes-sigs/azurefile-csi-driver/blob/master/docs/driver-parameters.md#dynamic-provision).

    Because of the Premium SKU, the minimum size of the file share is 100 GB. For more information, see [Create a storage class](/azure/aks/azure-files-dynamic-pv#create-a-storage-class).

2. Create a PVC that references the custom StorageClass *azurefile-sc-fips*.

    Refer to the following YAML file as an example:

    ```yml
    apiVersion: v1 
    kind: PersistentVolumeClaim 
    metadata: 
      name: azurefile-pvc-fips 
    spec: 
      accessModes: 
        - ReadWriteMany 
      storageClassName: azurefile-sc-fips 
      resources: 
        requests: 
          storage: 100Gi 
    ```

3. Create a pod that mounts the PVC *azurefile-pvc-fips*.

    Refer to the following YAML file as an example:

    ```yml
    kind: Pod 
    apiVersion: v1 
    metadata: 
      name: azurefile-pod-fips 
    spec: 
      containers: 
      - name: azurefile-pod-fips 
        image: mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine 
        resources: 
          requests: 
            cpu: 100m 
            memory: 128Mi 
          limits: 
            cpu: 250m 
            memory: 256Mi 
        volumeMounts: 
        - mountPath: "/mnt/azure" 
          name: volume 
      volumes: 
        - name: volume 
          persistentVolumeClaim: 
            claimName: azurefile-pvc-fips 
    ```

## <a id="mounterror13"></a>Mount error(13): Permission denied

Here are possible causes for this error:

- [Cause 1: Kubernetes secret doesn't reference the correct storage account name or key](#secretnotusecorrectstorageaccountkey)
- [Cause 2: AKS's virtual network and subnet aren't allowed for the storage account](#akssubnetnotallowed)
- [Cause 3: Connectivity is via a private link but nodes and the private endpoint are in different virtual networks](#aksnotawareprivateipaddress)
- [Cause 4: Storage account is set to require encryption that the client doesn't support](#akssmbencryption)
- [Cause 5: Minimum encryption requirement for a storage account isn't met](#minimumencryption)
- [Cause 6: Security profile is used without the NTLM v2 authentication enabled](#securityprofile)

> [!NOTE]
>
> - Cause 1 applies to public and private scenarios.
> - Cause 2 applies to the public scenario only.
> - Cause 3 applies to the private scenario only.
> - Cause 4 applies to public and private scenarios.
> - Cause 5 applies to public and private scenarios.
> - Cause 6 applies to public and private scenarios.

### <a id="secretnotusecorrectstorageaccountkey"></a>Cause 1: Kubernetes secret doesn't reference correct storage account name or key

If you [dynamically create](/azure/aks/azure-files-dynamic-pv) the file share, the system automatically creates a [Kubernetes secret resource](https://kubernetes.io/docs/concepts/configuration/secret/) with the name `azure-storage-account-<storage-account-name>-secret`.

If you [manually create](/azure/aks/azure-files-volume) the file share, you must create the Kubernetes secret resource manually.

Regardless of the creation method, if the storage account name or key that the Kubernetes secret references doesn't match the actual value, the mounting operation fails with the "Permission denied" error.

#### Possible causes for mismatch

- If you create the Kubernetes secret manually, you might introduce a typo.

- If you perform a **Rotate key** operation at the storage account level, the Kubernetes secret doesn't reflect the changes. This mismatch occurs between the key value at the storage account level and the value at the Kubernetes secret level.

- If you perform a **Rotate key** operation, the Activity log of the storage account displays an operation named **Regenerate Storage Account Keys**. Be aware of the [90 days retention period for Activity log](/azure/azure-monitor/essentials/activity-log#retention-period).

#### Verify mismatch

To verify the mismatch, follow these steps:

1. Search for and access the storage account in the Azure portal. Select **Access keys** > **Show keys** in the storage account. You see the storage account name and associated keys.

    :::image type="content" source="media/fail-to-mount-azure-file-share/storage-account-keys.png" alt-text="Screenshot of storage account name and keys.":::

2. Go to the AKS cluster, select **Configuration** > **Secrets**, and then search for and access the associated secret.

    :::image type="content" source="media/fail-to-mount-azure-file-share/select-storage-account.png" alt-text="Screenshot of searching and selecting storage account." lightbox="media/fail-to-mount-azure-file-share/select-storage-account.png":::

3. Select **Show** (the eye icon) and compare the values of the storage account name and associated key with the values in Step 1.

    :::image type="content" source="media/fail-to-mount-azure-file-share/storage-account-associated-secret-key.png" alt-text="Screenshot of a Kubernetes secret showing the storage account name and key values." lightbox="media/fail-to-mount-azure-file-share/storage-account-associated-secret-key.png":::

    Before you select **Show**, the values of the storage account name and associated key are encoded into base64 strings. After you select **Show**, the values are decoded.

If you don't have access to the AKS cluster in the Azure portal, perform Step 2 at the kubectl level:

1. Get the YAML file of the Kubernetes secret, and then run the following command to get the values of the storage account name and the key from the output:

    ```console
    kubectl get secret <secret-name> -n <secret-namespace> -o <yaml-file-name>
    ```

2. Use the `echo` command to decode the values of the storage account name and the key and compare them with the values at the storage account level.

    Here's an example to decode the storage account name:

    ```console
    echo -n '<storage account name>' | base64 --decode ;echo
    ```

    :::image type="content" source="media/fail-to-mount-azure-file-share/command-decode-storage-account-name.png" alt-text="Screenshot of command that decodes storage account name.":::

#### Solution: Adjust the Kubernetes secret and re-create the pods

If the value of the storage account name or key in the Kubernetes secret doesn't match the value in **Access keys** in the storage account, adjust the Kubernetes secret at the Kubernetes secret level by running the following command:

```console
kubectl edit secret <secret-name> -n <secret-namespace>
```

The value of the storage account name or the key you add in the Kubernetes secret configuration should be a base64 encoded value. To obtain the encoded value, use the `echo` command.

Here's an example to encode the storage account name:

```console
echo -n '<storage account name>'| base64 | tr -d '\n' ; echo
```

For more information, see [Managing Secrets using kubectl](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/).

After the Kubernetes secret `azure-storage-account-<storage-account-name>-secret` has the right values, re-create the pods. Otherwise, those pods continue to use the old values that aren't valid anymore.

### <a id="akssubnetnotallowed"></a>Cause 2: AKS virtual network and subnet aren't allowed for storage account

If firewall rules limit the storage account's network to **selected networks**, but you don't add the virtual network and subnet of the AKS cluster to **selected networks**, the mounting operation fails with the "Permission denied" error. For more information, see [Configure Azure Storage firewalls and virtual networks](/azure/storage/common/storage-network-security) and [Virtual network or firewall rules are enabled on the storage account](/troubleshoot/azure/azure-storage/files/connectivity/files-troubleshoot-smb-connectivity?tabs=linux#cause-2-virtual-network-or-firewall-rules-are-enabled-on-the-storage-account-or-port-445-is-blocked).

#### Solution: Allow AKS virtual network and subnet for storage account

1. Run the following command to identify the node that hosts the faulty pod:

    ```console
    kubectl get pod <pod-name> -n <namespace> -o wide
    ```

    Check the node from the command output:

    :::image type="content" source="media/fail-to-mount-azure-file-share/command-identify-node.png" alt-text="Screenshot of command that can identity node and output.":::

2. Go to the AKS cluster in the Azure portal, select **Properties** > **Infrastructure resource group**, access the VMSS associated with the node, and then check **Virtual network/subnet** to identify the virtual network and subnet.

    :::image type="content" source="media/fail-to-mount-azure-file-share/virtual-network-subnet-value.png" alt-text="Screenshot of virtual network/subnet value.":::

3. Access the storage account in the Azure portal. Select **Networking**. If **Allow access from** is set to **Selected networks**, check whether the virtual network and subnet of the AKS cluster are added.

    :::image type="content" source="media/fail-to-mount-azure-file-share/check-virtual-network-added.png" alt-text="Screenshot of empty selected networks list." lightbox="media/fail-to-mount-azure-file-share/check-virtual-network-added.png":::

    If you didn't add the virtual network and subnet of the AKS cluster, select **Add existing virtual network**. On the **Add networks** page, type the virtual network and subnet of the AKS cluster, and then select **Add** > **Save**.

    :::image type="content" source="media/fail-to-mount-azure-file-share/add-networks.png" alt-text="Screenshot of adding networks to storage account.":::

    It might take a few moments for the changes to take effect. After you add the virtual network and subnet, check whether the pod status changes from **ContainerCreating** to **Running**.

    :::image type="content" source="media/fail-to-mount-azure-file-share/verify-pod-status.png" alt-text="Screenshot of command output that shows current pod status.":::

### <a id="aksnotawareprivateipaddress"></a>Cause 3: Connectivity is via private link but nodes and private endpoint are in different virtual networks

When you connect the AKS cluster and storage account through a private link, you use an approved private endpoint connection.

:::image type="content" source="media/fail-to-mount-azure-file-share/private-endpoint-connections.png" alt-text="Screenshot of private endpoint connection.":::

In this scenario, if the private endpoint and AKS node are in the same virtual network, you can mount an Azure file share.

If the private endpoint and your AKS cluster are in different virtual networks, the mounting operation fails with the "Permission denied" error.

#### Solution: Create virtual network link for virtual network of AKS cluster at private DNS zone

[Get inside the node](/azure/aks/node-access) and check whether the fully qualified domain name (FQDN) is resolved through a public or private IP address. To do this, run the following command:

```console
nslookup <storage-account-name>.privatelink.file.core.windows.net
```

If the FQDN is resolved through a public IP address (see the following screenshot), create a virtual network link for the virtual network of the AKS cluster at the private DNS zone ("privatelink.file.core.windows.net") level. A virtual network link is already automatically created for the virtual network of the storage account's private endpoint.

:::image type="content" source="media/fail-to-mount-azure-file-share/verify-fqdn-resolved.png" alt-text="Screenshot of nslookup output where the storage account FQDN resolves to a public IP address.":::

To create the virtual network link, follow these steps:

1. Access the Private DNS zone and select **Virtual network links** > **Add**.

    :::image type="content" source="media/fail-to-mount-azure-file-share/storage-account-virtual-network-link.png" alt-text="Screenshot of the private DNS zone showing a virtual network link for the storage account." lightbox="media/fail-to-mount-azure-file-share/storage-account-virtual-network-link.png":::

2. Fill in the fields and select the virtual network of the AKS cluster for **Virtual networks**. For how to identify the virtual network of the AKS cluster, see the [Solution: Allow AKS virtual network and subnet for storage account](#solution-allow-aks-virtual-network-and-subnet-for-storage-account) section.

    :::image type="content" source="media/fail-to-mount-azure-file-share/add-virtual-network-link.png" alt-text="Screenshot of the Add virtual network link pane used to select an AKS virtual network.":::

3. Select **OK**.

After you add the virtual network link, the FQDN resolves through a private IP address, and the mounting operation succeeds. See the following screenshot for an example:

:::image type="content" source="media/fail-to-mount-azure-file-share/private-ip-address-resolved.png" alt-text="Screenshot of nslookup output where the storage account FQDN resolves to a private IP address.":::

### <a id="akssmbencryption"></a>Cause 4: Storage account requires encryption that the client doesn't support

[Azure Files Security Settings](/azure/storage/files/files-smb-protocol?tabs=azure-portal#smb-security-settings) contain a number of options for controlling the security and encryption settings on storage accounts. Restricting allowed methods and algorithms can prevent clients from connecting.

The supported SMB encryption algorithm depends on the node operating system and Linux kernel version:

- AKS versions earlier than 1.25 are based on Ubuntu 18.04 LTS, which uses the Linux 5.4 kernel and supports only the AES-128-CCM and AES-128-GCM encryption algorithms. On these versions, the **Maximum security** profile (or a **Custom** profile that disables AES-128-GCM) causes share mapping failures. These AKS versions are out of support, so upgrade to a supported version.
- AKS versions 1.25 and later are based on Ubuntu 22.04 or a later version, which uses the Linux 5.15 kernel or a later version and supports AES-256-GCM.

#### Solution: Allow AES-128-GCM encryption algorithm to be used

Enable the AES-128-GCM algorithm by using the **Maximum compatibility** profile or a **Custom** profile that enables AES-128-GCM. For more information, see [Azure Files Security Settings](/azure/storage/files/files-smb-protocol?tabs=azure-portal#smb-security-settings).

### <a id="minimumencryption"></a>Cause 5: Minimum encryption requirement for a storage account isn't met

This problem occurs when a storage account enforces a minimum SMB encryption algorithm (for example, AES-256-GCM only) that the SMB client on the AKS node doesn't support or isn't configured to use. If the node can't negotiate the required cipher, the mounting operation fails with the "Permission denied" error.

#### Solution: Enable AES-128-GCM encryption algorithm for all storage accounts

To successfully mount or access a file share, enable the AES-128-GCM encryption algorithm for all storage accounts.

If you want to use only the AES-256-GCM encryption, follow these steps:

#### Linux

Use the following script to check whether the client supports AES-256-GCM and enforce it only if it does:

```bash
cifsConfPath="/etc/modprobe.d/cifs.conf"
echo "$(date) before change ${cifsConfPath}:"
cat ${cifsConfPath}

# Check if 'require_gcm_256' is already present in the configuration file
if ! grep -q "require_gcm_256" "${cifsConfPath}"; then

    # Load the CIFS module
    modprobe cifs

    # Set the parameter at runtime
    echo 1 > /sys/module/cifs/parameters/require_gcm_256

    # Persist the configuration
    echo "options cifs require_gcm_256=1" >> "${cifsConfPath}"

    echo "$(date) after changing ${cifsConfPath}:"
    cat "${cifsConfPath}"
else
    echo "require_gcm_256 is already set in ${cifsConfPath}"
fi
```

You can also use a Kubernetes DaemonSet to enforce AES-256 on every node. See the following example:

[support-cifs-aes-256-gcm.yaml](https://github.com/andyzhangx/demo/blob/master/aks/support-cifs-aes-256-gcm.yaml)

#### Windows

Use the [Set-SmbClientConfiguration](/powershell/module/smbshare/set-smbclientconfiguration) PowerShell command to specify the encryption ciphers used by the SMB client and the preferred encryption type without user confirmation:

```powershell
Set-SmbClientConfiguration -EncryptionCiphers "AES_256_GCM" -Confirm:$false
```

> [!NOTE]
> The `EncryptionCiphers` parameter is available beginning with the 2022-06 Cumulative Update for Windows Server version 21H2 for x64-based systems ([KB5014665](https://support.microsoft.com/help/5014665)) and the Cumulative Update for Windows 11, version 22H2 ([KB5014668](https://support.microsoft.com/help/5014668)).

### <a id="securityprofile"></a>Cause 6: Security profile is used without the NTLM v2 authentication enabled

If you use the **Maximum security** profile or a **Custom** security profile without enabling the **NTLM v2** authentication mechanism, the mounting operation fails with the "Mount error(13): Permission denied" error.

#### Solution: Enable NTLM v2 authentication or use the "Maximum compatibility" profile

To mount the share properly in AKS, enable the **NTLM v2** authentication mechanism for the **Custom** security profile or use the **Maximum compatibility** security profile.

## References

If you experience other mount errors, see [Troubleshoot Azure Files problems in Linux](/azure/storage/files/storage-troubleshoot-linux-file-connection-problems).
