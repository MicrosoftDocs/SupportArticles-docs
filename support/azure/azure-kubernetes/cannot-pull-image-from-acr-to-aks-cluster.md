---
title: Can't pull images from Azure Container Registry to Kubernetes
description: This article helps you troubleshoot the most common errors that you may encounter when pulling images from a container registry to an AKS cluster.
ms.date: 05/27/2022
author: genlin
ms.author: genli
ms.reviewer: chiragpa, andbar
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-cant-pull-images-from-acr-to-cluster
ms.custom: devx-track-azurecli
---
# Fail to pull images from Azure Container Registry to Azure Kubernetes Service cluster

When you're using Microsoft Azure Container Registry with Azure Kubernetes Service (AKS), an authentication mechanism needs to be established. You can set up the AKS to Container Registry integration by using a few simple Azure CLI or Azure PowerShell commands. This integration assigns the [AcrPull role](/azure/role-based-access-control/built-in-roles#acrpull) for the identity associated with the AKS cluster to pull images from a container registry.

In some cases, pulling images from a container registry to an AKS cluster fails. This article provides guidance for troubleshooting the most common errors that you encounter when you pull images from a container registry to an AKS cluster.

## Before you begin

This article assumes that you have an existing AKS cluster and an existing container registry. See the following quick starts:

- If you need an AKS cluster, deploy one by using [the Azure CLI](/azure/aks/kubernetes-walkthrough) or [the Azure portal](/azure/aks/kubernetes-walkthrough-portal).

- If you need an Azure Container Registry (ACR), create one by using [the Azure CLI](/azure/container-registry/container-registry-get-started-azure-cli) or [the Azure portal](/azure/container-registry/container-registry-get-started-portal).

You also need the Azure CLI version 2.0.59 or later to be installed and configured. Run [az version](/cli/azure/reference-index#az-version) to find the version. If you need to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Symptoms and initial troubleshooting

The Kubernetes pod's **STATUS** is **ImagePullBackOff** or **ErrImagePull**. To get detailed errors, run the following command and check **Events** from the output.

```console
kubectl describe pod <podname> -n <namespace>
```

We recommend that you start troubleshooting by checking the [container registry's health](/azure/container-registry/container-registry-check-health) and validating whether the container registry is accessible from the AKS cluster.

To check the container registry's health, run the following command:

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If a problem is detected, it provides an error code and description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you get Helm or Notary related errors, it doesn't mean that you have an issue with Container Registry or AKS. It only indicates that Helm or Notary isn't installed, Azure CLI isn't compatible with the current installed version of Helm or Notary, and so on.

To validate whether the container registry is accessible from the AKS cluster, run the following [az aks check-acr](/cli/azure/aks#az-aks-check-acr) command:

```azurecli
az aks check-acr --resource-group <MyResourceGroup> --name <MyManagedCluster> --acr <myacr>.azurecr.io
```

The following sections help you troubleshoot the most common errors that are displayed in **Events** in the output of the `kubectl describe pod` command.

## Cause 1: 401 Unauthorized error

An AKS cluster requires an identity. This identity can be either a managed identity or a service principal. No matter what the identity is, the proper authorization that's used to pull an image from a container registry is necessary. Otherwise, you may get the following "401 Unauthorized" error:

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch oauth token: **unexpected status: 401 Unauthorized**

A number of solutions can help you resolve this error, subject to the following constraints:

- Solutions [2][cause1-solution2], [3][cause1-solution3], and [4][cause1-solution4] are applicable only to [AKS clusters that use a service principal](/azure/aks/kubernetes-service-principal).

- Solutions [1][cause1-solution1], [2][cause1-solution2], and [3][cause1-solution3] are applicable for the Azure method of [creating the role assignment at Container Registry level for AKS's identity](/azure/aks/cluster-container-registry-integration).

- Solutions [4][cause1-solution4] and [5][cause1-solution5] are applicable for the Kubernetes method of [pulling a Kubernetes secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).

### Solution 1: Ensure AcrPull role assignment is created for identity

The integration between AKS and Container Registry creates an AcrPull role assignment at container registry level for the AKS cluster's identity. Ensure that the role assignment is created.

To check if the AcrPull role assignment is created, use one of the following ways:

- Run the following command:

  ```azurecli
  az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
  ```

- Check in the Azure portal by selecting **Azure Container Registry** > **Access control (IAM)** > **Role assignments**. For more information, see [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal).

Besides the AcrPull role, some [built-in roles](/azure/role-based-access-control/built-in-roles) and [custom roles](/azure/role-based-access-control/custom-roles) can also contain the "[Microsoft.ContainerRegistry](/azure/role-based-access-control/resource-provider-operations#microsoftcontainerregistry)/registries/pull/read" action. Check those roles if you've got any of them.

If the AcrPull role assignment isn't created, create it by [configuring Container Registry integration for the AKS cluster](/azure/aks/cluster-container-registry-integration?tabs=azure-cli#configure-acr-integration-for-existing-aks-clusters) with the following command:

```azurecli
az aks update -n <myAKSCluster> -g <myResourceGroup> --attach-acr <acr-resource-id>
```

### Solution 2: Ensure service principal isn't expired

Ensure that the secret of the service principal that's associated with the AKS cluster isn't expired. To check the expiration date of your service principal, run the following commands:

```azurecli
SP_ID=$(az aks show --resource-group <myResourceGroup> --name <myAKSCluster> \
    --query servicePrincipalProfile.clientId -o tsv)

az ad sp credential list --id "$SP_ID" --query "[].endDate" -o tsv
```

For more information, see [Check the expiration date of your service principal](/azure/aks/update-credentials#check-the-expiration-date-of-your-service-principal).

If the secret is expired, [update the credentials for the AKS cluster](/azure/aks/update-credentials).

### Solution 3: Ensure AcrPull role is assigned to correct service principal

In some cases, for example, when the service principal of the AKS cluster is replaced with a new one, the container registry role assignment still refers to the old service principal. To ensure that the container registry role assignment refers to the correct service principal, follow the steps:

1. To check the service principal that's used by the AKS cluster, run the following command:

    ```azurecli
    az aks show --resource-group <myResourceGroup> \
        --name <myAKSCluster> \
        --query servicePrincipalProfile.clientId \
        --output tsv
    ```

1. To check the service principal that's referenced by the container registry role assignment, run the following command:

    ```azurecli
    az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
    ```

1. Compare the two service principals. If they don't match, integrate the AKS cluster with the container registry again.

### Solution 4: Ensure service principal is correct and secret is valid

If you pull an image by using an [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/), and that Kubernetes secret was created with the values of a service principal, make sure that the associated service principal is correct and the secret is still valid. Follow these steps:

1. Run the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [base64](https://ss64.com/bash/base64.html) command to see the values of the Kubernetes secret:

   ```console
   kubectl get secret <secret-name> --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
   ```

1. Check the expiration date by running the following [az ad sp credential list](/cli/azure/ad/sp/credential#az-ad-sp-credential-list) command. The username is the service principal value.

   ```azurecli
   az ad sp credential list --id "<username>" --query "[].endDate" --output tsv
   ```

1. If necessary, reset the secret of that service principal by running the following [az ad sp credential reset](/cli/azure/ad/sp/credential#az-ad-sp-credential-reset) command:

   ```azurecli
   az ad sp credential reset --name "$SP_ID" --query password --output tsv
   ```

1. Update or re-create the Kubernetes secret accordingly.

### Solution 5: Ensure the Kubernetes secret has the correct values of the container registry admin account

If you pull an image by using an [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/), and that Kubernetes secret was created with values of [container registry admin account](/azure/container-registry/container-registry-authentication#admin-account), make sure that the values in the Kubernetes secret are the same as the values of the container registry admin account. Follow these steps:

1. Run the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [base64](https://ss64.com/bash/base64.html) command to see the values of the Kubernetes secret:

   ```console
   kubectl get secret <secret-name> --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
   ```

1. In the [Azure portal](https://portal.azure.com), search for and select **Container registries**.

1. In the list of container registries, select your container registry.

1. In the navigation pane for the container registry, select **Access keys**.

1. In the **Access keys** page for the container registry, compare the container registry values with the values in the Kubernetes secret.

1. If the values don't match, then update or re-create the Kubernetes secret accordingly.

> [!NOTE]
> If a **Regenerate** password operation happened, an operation that's named "Regenerate Container Registry Login Credentials" will be displayed in the **Activity log** page of the container registry. The **Activity log** has a [90-day retention period](/azure/azure-monitor/essentials/activity-log#retention-period).

## Cause 2: Image not found error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = NotFound desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": **\<acrname>.azurecr.io/\<repository\:tag>: not found**

### Solution: Ensure image name is correct

If you get this error, ensure that the image name is fully correct. You should check the registry name, registry login server, the repository name, and the tag. A common mistake is that the login server is specified as "azureacr.io" instead of "azurecr.io".

When the image name isn't fully correct, the [401 Unauthorized error](#cause-1-401-unauthorized-error) may also occur because AKS always tries anonymous pull no matter whether the container registry has enabled anonymous pull access.

## Cause 3: 403 Forbidden error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch anonymous token: **unexpected status: 403 Forbidden**

### Solution 1: Ensure AKS virtual network link is set in the container registry's Private DNS zone

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks, make sure that the [virtual network link](/azure/dns/private-dns-virtual-network-links) for the AKS cluster's virtual network is set in the Private DNS zone of the container registry. (That link is named "privatelink.azurecr.io" by default.) If the virtual network link isn't in the Private DNS zone of the container registry, add it by using one of the following ways:

- In the Azure portal, select the private DNS zone "privatelink.azurecr.io", select **Virtual network links** > **Add** under the **Settings** panel, and then select a name and the virtual network of the AKS cluster. Select **OK**.

  > [!NOTE]
  > It's optional to check the ["Enable auto registration"](/azure/dns/private-dns-autoregistration) feature.

- [Create a virtual network link to the specified Private DNS zone by using Azure CLI](/cli/azure/network/private-dns/link/vnet#az-network-private-dns-link-vnet-create).

### Solution 2: Add AKS Load Balancer's public IP address to allowed IP address range of the container registry

If the AKS cluster connects publicly to the container registry (NOT through a private link or an endpoint) and the public network access of the container registry is limited to selected networks, add AKS Load Balancer's public IP address to the allowed IP address range of the container registry:

1. Confirm that the public network access is limited to selected networks.

    In the Azure portal, navigate to the container registry. Under **Settings**, select **Networking**. On the **Public access** tab, **Public network access** is set to **Selected networks** or **Disabled**.

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

    - In the Azure portal, navigate to the container registry. Under **Settings**, select **Networking**. On the **Public access** tab, under **Firewall**, add the AKS Load Balancer's public IP address to **Address range** and then select **Save**. For more information, see [Access from selected public network - portal](/azure/container-registry/container-registry-access-selected-networks#access-from-selected-public-network---portal).

      > [!NOTE]
      > If **Public network access** is set to **Disabled**, switch it to **Selected networks** first.

      :::image type="content" source="./media/cannot-pull-image-from-acr-to-aks-cluster/add-aks-load-balancer-public-ip.png" alt-text="Screenshot about how to add AKS Load Balancer's public IP address to Address range":::

## Cause 4: 443 timeout error

> Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/<repository\:tag>": failed to do request: Head "https://\<acrname>.azurecr.io/v2/\<repository>/manifests/v1": dial tcp \<acrprivateipaddress>:**443: i/o timeout**

> [!NOTE]
> The "443 timeout" error only occurs when you [connect privately to a container registry by using Azure Private Link](/azure/container-registry/container-registry-private-link).

### Solution 1: Ensure virtual network peering is used

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks, ensure that [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) is used for both virtual networks. You can check virtual network peering by running the Azure CLI command `az network vnet peering list --resource-group <MyResourceGroup> --vnet-name <MyVirtualNetwork> --output table` or in the Azure portal by selecting the **VNETs** > **Peerings** under the **Settings** panel. For more information about listing all peerings of a specified virtual network, see [az network vnet peering list](/cli/azure/network/vnet/peering#az-network-vnet-peering-list).

If the virtual network peering is used for both virtual networks, ensure that the status is "Connected". If the status is [Disconnected](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-disconnected), delete the peering from both virtual networks, and then re-create it. If the status is "Connected", see the troubleshooting guide: [The peering status is "Connected"](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-connected).

For further troubleshooting, connect to one of the AKS nodes or [pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec), and then test the connectivity with the container registry at TCP level by using the Telnet or Netcat utility. Check the IP address with the `nslookup <acrname>.azurecr.io` command, and then run the `telnet <ip-address-of-the-container-registry> 443` command.

For more information about connecting to AKS nodes, see [Connect with SSH to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/ssh).

### Solution 2: Use Azure Firewall Service

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks, in addition to virtual network peering, you may use Azure Firewall Service to set up a [Hub-spoke network topology in Azure](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli). When you set up the firewall rule, you need to use network rules to explicitly allow the [outbound connection](/azure/firewall/rule-processing#outbound-connectivity) to the container registry private endpoint IP addresses.

## Cause 5: No match for platform in manifest

The host operating system (node OS) is incompatible with the image that's used for the pod or container. For example, if you schedule a pod to run a Linux container on a Windows node, or a Windows container on a Linux node, the following error occurs:

> Failed to pull image "\<acrname>.azurecr.io/\<repository:tag>"\:\
> [\
> &nbsp; rpc error:\
> &nbsp; code = NotFound\
> &nbsp; desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository:tag>": **no match for platform in manifest**: not found,\
> ]

This error can occur for an image that's pulled from any source, as long as the image is incompatible with the host OS. The error isn't limited to images that are pulled from the container registry.

### Solution: Configure the nodeSelector field correctly in your pod or deployment

Specify the correct `nodeSelector` field in the configuration settings of your pod or deployment. The correct value for this field's `kubernetes.io/os` setting ensures that the pod will be scheduled on the correct type of node. The following table shows how to set the `kubernetes.io/os` setting in YAML:

| Container type | YAML setting |
| -------------- | ------------ |
| Linux container | `"kubernetes.io/os": linux` |
| Windows container | `"kubernetes.io/os": windows` |

For example, the following YAML code describes a pod that needs to be scheduled on a Linux node:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: aspnetapp
  labels:
    app: aspnetapp
spec:
  containers:
  - image: "mcr.microsoft.com/dotnet/core/samples:aspnetapp"
    name: aspnetapp-image
    ports:
    - containerPort: 80
      protocol: TCP
  nodeSelector:
    "kubernetes.io/os": linux
```

## More information

If the troubleshooting guidance in this article doesn't help you resolve the issue, here are some other things to consider:

- Check the network security groups and route tables associated with subnets, if you've got any of those items.

- If a virtual appliance like a firewall controls the traffic between subnets, check the firewall and [Firewall access rules](/azure/container-registry/container-registry-firewall-access-rules).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[cause1-solution1]: #solution-1-ensure-acrpull-role-assignment-is-created-for-identity
[cause1-solution2]: #solution-2-ensure-service-principal-isnt-expired
[cause1-solution3]: #solution-3-ensure-acrpull-role-is-assigned-to-correct-service-principal
[cause1-solution4]: #solution-4-ensure-service-principal-is-correct-and-secret-is-valid
[cause1-solution5]: #solution-5-ensure-the-kubernetes-secret-has-the-correct-values-of-the-container-registry-admin-account
