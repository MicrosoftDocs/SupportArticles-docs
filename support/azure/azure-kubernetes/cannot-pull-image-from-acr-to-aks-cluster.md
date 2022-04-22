---
title: Can't pull images from Azure Container Registry to Azure Kubernetes Service cluster
description: This article helps you troubleshoot the most common errors that you may encounter when pulling images from an ACR to an AKS cluster.
ms.date: 02/19/2022
author: genlin
ms.author: genli
ms.reviewer: chiragpa
ms.service: container-service
---
# Fail to pull images from Azure Container Registry to Azure Kubernetes Service cluster

According to [Authenticate with Azure Container Registry from Azure Kubernetes Services](/azure/aks/cluster-container-registry-integration?tabs=azure-cli), when you're using Azure Container Registry (ACR) with Azure Kubernetes Service (AKS), an authentication mechanism needs to be established. You can set up the AKS to ACR integration by using a few simple Azure CLI or Azure PowerShell commands. This integration assigns the [AcrPull role](/azure/role-based-access-control/built-in-roles#acrpull) for the identity associated with the AKS cluster to pull images from an ACR.

In some cases, pulling images from an ACR to an AKS cluster fails. This article provides guidance for troubleshooting the most common errors that you encounter when you pull images from an ACR to an AKS cluster.

## Before you begin

This article assumes that you have an existing AKS cluster and an existing ACR. See the following quick starts:

- If you need an AKS cluster, deploy an Azure Kubernetes Service cluster [using the Azure CLI](/azure/aks/kubernetes-walkthrough) or [using the Azure portal](/azure/aks/kubernetes-walkthrough-portal).
- If you need an ACR, create a private container registry [using the Azure CLI](/azure/container-registry/container-registry-get-started-azure-cli) or [using the Azure portal](/azure/container-registry/container-registry-get-started-portal).

You also need the Azure CLI version 2.0.59 or later to be installed and configured. Run [az version](/cli/azure/reference-index#az-version) to find the version. If you need to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Symptoms and initial troubleshooting

The Kubernetes pod's **STATUS** is **ImagePullBackOff** or **ErrImagePull**. To get detailed errors, run the following command and check **Events** from the output.

```console
kubectl describe pod <podname> -n <namespace>
```

We recommend that you start troubleshooting by checking [ACR's health](/azure/container-registry/container-registry-check-health) and validating whether the ACR is accessible from the AKS cluster.

To check ACR's health, run the following command:

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If a problem is detected, it provides an error code and description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you get Helm or Notary related errors, it doesn't mean that you have an issue with ACR or AKS. It only indicates that Helm or Notary isn't installed, Azure CLI isn't compatible with the current installed version of Helm or Notary, and so on.

To validate whether the ACR is accessible from the AKS cluster, run the [az aks check-acr](/cli/azure/aks#az-aks-check-acr) command.

## Common errors and solutions

This section helps you troubleshoot the following most common errors that are displayed in **Events** in the output of the `kubectl describe pod` command:

- [401 Unauthorized error](#401unauthorizederror)
- [Image not found error](#imagenotfounderror)
- [403 Forbidden error](#403forbiddenerror)
- [443 timeout error](#443timeouterror)

> [!NOTE]
> The "403 Forbidden" error and "443 timeout" error only occur when you [connect privately to ACR by using Azure Private Link](/azure/container-registry/container-registry-private-link).

### <a id="401unauthorizederror"></a>401 Unauthorized error

An AKS cluster requires an identity. This identity can be either a managed identity or a service principal. No matter what the identity is, the proper authorization that's used to pull an image from ACR is necessary. Otherwise, you may get the following "401 Unauthorized" error:

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch oauth token: unexpected status: 401 Unauthorized

The following solutions help you resolve this error. Solution 2 to 4 are applicable only to [AKS clusters which use service principal](/azure/aks/kubernetes-service-principal?tabs=azure-cli).

#### Solution 1: Ensure AcrPull role assignment is created for identity

The integration between AKS and ACR creates an AcrPull role assignment at ACR level for the AKS cluster's identity. Ensure that the role assignment is created.

To check if the AcrPull role assignment is created, use one of the following ways:

- Run the following command:

    ```azurecli
    az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
    ```

- Check in the Azure portal by selecting **Azure Container Registry** > **Access control (IAM)** > **Role assignments**. For more information, see [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal).

Besides the AcrPull role, some [built-in roles](/azure/role-based-access-control/built-in-roles) and [custom roles](/azure/role-based-access-control/custom-roles) can also contain the "[Microsoft.ContainerRegistry](/azure/role-based-access-control/resource-provider-operations#microsoftcontainerregistry)/registries/pull/read" action. Check them if you have any.

If the AcrPull role assignment isn't created, create it by [configuring ACR integration for the AKS cluster](/azure/aks/cluster-container-registry-integration?tabs=azure-cli#configure-acr-integration-for-existing-aks-clusters) with the following command:

```azurecli
az aks update -n <myAKSCluster> -g <myResourceGroup> --attach-acr <acr-resource-id>
```

#### Solution 2: Ensure service principal isn't expired

Ensure that the secret of the service principal that's associated with the AKS cluster isn't expired. To check the expiration date of your service principal, run the following commands:

```azurecli
SP_ID=$(az aks show --resource-group <myResourceGroup> --name <myAKSCluster> \
    --query servicePrincipalProfile.clientId -o tsv)

az ad sp credential list --id "$SP_ID" --query "[].endDate" -o tsv
```

For more information, see [Check the expiration date of your service principal](/azure/aks/update-credentials#check-the-expiration-date-of-your-service-principal).

If the secret is expired, [update the credentials for the AKS cluster](/azure/aks/update-credentials).

#### Solution 3: Ensure AcrPull role is assigned to correct service principal

In some cases, for example, when the service principal of the AKS cluster is replaced with a new one, the ACR role assignment still refers to the old service principal. To ensure that the ACR role assignment refers to the correct service principal, follow the steps:

1. To check the service principal that's used by the AKS cluster, run the following command:

    ```azurecli
    az aks show --resource-group <myResourceGroup> --name <myAKSCluste> --query servicePrincipalProfile.clientId -o tsv
    ```

1. To check the service principal that's referenced by the ACR role assignment, run the following command:

    ```azurecli
    az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
    ```

1. Compare the two service principals. If they don't match, integrate the AKS cluster with ACR again.

#### Solution 4: Ensure service principal is correct and secret is valid

If you pull an image by using an [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/), ensure that the associated service principal is correct and the secret is still valid.

### <a id="imagenotfounderror"></a>Image not found error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = NotFound desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": \<acrname>.azurecr.io/\<repository\:tag>: not found

#### Solution: Ensure image name is correct

If you get this error, ensure that the image name is fully correct. You should check the registry name, registry login server, the repository name, and the tag. A common mistake is that the login server is specified as "azureacr.io" instead of "azurecr.io".

When the image name isn't fully correct, the [401 Unauthorized error](#401unauthorizederror) may also occur because AKS always tries anonymous pull no matter whether the container registry has enabled anonymous pull access.

### <a id="403forbiddenerror"></a>403 Forbidden error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch anonymous token: unexpected status: 403 Forbidden

#### Solution 1: Ensure AKS virtual network link is set in ACR Private DNS zone

If the network interface of the ACR's private endpoint and the AKS cluster are in different virtual networks (VNETs), ensure that the [virtual network link](/azure/dns/private-dns-virtual-network-links) for the AKS cluster VNET is set in the Private DNS zone of the ACR (it's named "privatelink.azurecr.io" by default). If the virtual network link isn't in the Private DNS zone of the ACR, add it by using one of the following ways:

- In the Azure portal, select the private DNS zone "privatelink.azurecr.io", select **Virtual network links** > **Add** under the **Settings** panel, and then select a name and the virtual network of the AKS cluster. Select **OK**.

    > [!NOTE]
    > It's optional to check the ["Enable auto registration"](/azure/dns/private-dns-autoregistration) feature.

- [Create a virtual network link to the specified Private DNS zone by using Azure CLI](/cli/azure/network/private-dns/link/vnet#az-network-private-dns-link-vnet-create).

#### Solution 2: Add AKS Load Balancer's public IP address to allowed IP address range of ACR

If the AKS cluster connects publicly to the ACR (NOT through a private link or an endpoint) and the public network access of the ACR is limited to selected networks, add AKS Load Balancer's public IP address to the allowed IP address range of the ACR:

1. Confirm that the public network access is limited to selected networks.

    In the Azure portal, navigate to the ACR. Under **Settings**, select **Networking**. On the **Public access** tab, **Public network access** is set to **Selected networks** or **Disabled**.

2. Obtain the AKS Load Balancer's public IP address by using one of the following ways:

    - In the Azure portal, navigate to the AKS cluster. Under **Settings**, select **Properties**, select one of the virtual machine scale sets in the infrastructure resource group, and check the public IP address of the AKS Load Balancer.

    - Run the following command:

        ```azurecli
        az network public-ip show --resource-group <infrastructure-resource-group> --name <public-IP-name> --query ipAddress -o tsv
        ```

3. Allow access from the AKS Load Balancer's public IP address by using one of the following ways:

    - Run `az acr network-rule add` command as follows:

        ```azurecli
        az acr network-rule add --name acrname --ip-address <AKS-load-balancer-public-IP-address>
        ```

        For more information, see [Add network rule to registry](/azure/container-registry/container-registry-access-selected-networks#add-network-rule-to-registry).

    - In the Azure portal, navigate to the ACR. Under **Settings**, select **Networking**. On the **Public access** tab, under **Firewall**, add the AKS Load Balancer's public IP address to **Address range** and then select **Save**. For more information, see [Access from selected public network - portal](/azure/container-registry/container-registry-access-selected-networks#access-from-selected-public-network---portal).

        > [!NOTE]
        > If **Public network access** is set to **Disabled**, switch it to **Selected networks** first.

        :::image type="content" source="./media/cannot-pull-image-from-acr-to-aks-cluster/add-aks-load-balancer-public-ip.png" alt-text="Screenshot about how to add AKS Load Balancer's public IP address to Address range":::

### <a id="443timeouterror"></a>443 timeout error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/<repository\:tag>": failed to do request: Head "https://\<acrname>.azurecr.io/v2/\<repository>/manifests/v1": dial tcp \<acrprivateipaddress>:443: i/o timeout

#### Solution 1: Ensure VNET peering is used

If the network interface of ACR's private endpoint and the AKS cluster are in different Virtual Networks (VNETs), ensure that [VNET peering](/azure/virtual-network/virtual-network-peering-overview) is used for both VNETs. You can check VNET peering by running the Azure CLI command `az network vnet peering list -g <MyResourceGroup> --vnet-name <MyVnet> -o table` or in the Azure portal by selecting the **VNETs** > **Peerings** under the **Settings** panel. For more information about listing all peerings of a specified virtual network, see [az network vnet peering list](/cli/azure/network/vnet/peering#az-network-vnet-peering-list).

If the VNET peering is used for both VNETs, ensure that the status is "Connected". If the status is [Disconnected](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-disconnected), delete the peering from both VNETs, and then re-create it. If the status is "Connected", see the troubleshooting guide: [The peering status is "Connected"](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-connected).

For further troubleshooting, connect to one of the AKS nodes or [pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec), and then test the connectivity with the ACR at TCP level by using Telnet or Netcat utility. Check the IP address with the `nslookup <acrname>.azurecr.io` command, and then run the `telnet <ip address of ACR> 443` command.

For more information about connecting to AKS nodes, see [Connect with SSH to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/ssh).

#### Solution 2: Use Azure Firewall Service

If the network interface of ACR's private endpoint and the AKS cluster are in different Virtual Networks (VNETs), in addition to VNET peering, you may use Azure Firewall Service to set up a [Hub-spoke network topology in Azure](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli). When you set up the firewall rule, you need to use network rules to explicitly allow the [outbound connection](/azure/firewall/rule-processing#outbound-connectivity) to the ACR private endpoint IP addresses.

## More information

If the troubleshooting guidance in this article doesn't help you resolve the issue, here are some other things to consider:

- Check the network security groups and route tables associated with subnets if you have any.
- If a virtual appliance like a firewall controls the traffic between subnets, check the firewall and [Firewall access rules](/azure/container-registry/container-registry-firewall-access-rules).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
