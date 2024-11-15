---
title: Cannot push images or artifacts to Azure Container Registry
description: Provides guidance for troubleshooting common errors when you push images or artifacts to an Azure container registry.
ms.date: 10/11/2024
ms.reviewer: v-rekhanain;chiragpa;andbar
ms.service: azure-container-registry
ms.custom: sap:Image Push Issues
---

# Troubleshoot push errors in Azure Container Registry

This article helps you troubleshoot issues that you might encounter when you push images or artifacts to an Azure container registry.

## Symptoms and initial troubleshooting

We recommend that you start troubleshooting by checking the [container registry health](/azure/container-registry/container-registry-check-health).

To check the container registry health, run the following command:

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If an issue is detected, the results include an error code and description. For more information about these errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you receive Helm-related or Notary-related errors, this doesn't necessarily mean that your container registry or Microsoft Azure Kubernetes Service (AKS) is not working or has a problem. It indicates only such issues as that Helm or Notary isn't installed, or that Azure CLI isn't compatible with the currently installed version of Helm or Notary.

Verify your authentication before you push to Azure Container Registry. Authentication is necessary to grant you the permissions that are required for the push operation. If you encounter issues when you try to authenticate through an Azure container registry, see [Authenticate with an Azure container registry](/azure/container-registry/container-registry-authentication?tabs=azure-cli) and [Troubleshoot Azure Container Registry authentication errors](acr-authentication-errors.md).

The following sections help you troubleshoot the most common errors that appear during push operations.

## Error 1: The operation is disallowed on this registry

> `The operation is disallowed on this registry, repository or image. View troubleshooting steps at https://aka.ms/acr/faq/#why-does-my-pull-or-push-request-fail-with-disallowed-operation`

### Solution 1: Make sure the repository or image is not locked

This issue might be caused by the write operation being disabled for repositories or images. This state denies the delete and push operations. Azure Container Registry allows you to set the `changeableAttributes` attribute to avoid accidental deletion, or a write or read operation over a repository or a container image.

You can check the current repository attributes by using one of the following commands:

```bash
# Check the repository attributes.
az acr repository show --name myregistry --repository myrepo --output jsonc

# Check the image attributes.
az acr repository show --name myregistry --image myrepo:tag --output jsonc

# Check the image attributes by manifest digest 
az acr repository show --name myregistry --image myrepo@sha256:123456abcdefg --output jsonc
```

Example of the `az acr repository show` output:

```output
{
  "changeableAttributes": {
    "deleteEnabled": false,
    "listEnabled": true,
    "readEnabled": true,
    "writeEnabled": false
  },
  "createdTime": "2024-08-20T15:22:51.0355721Z",
  "imageName": "myImage_0a1c809cc2eb596028fcf7a68e498e09",
  "lastUpdateTime": "2024-08-20T15:23:01.2739647Z",
  "manifestCount": 1,
  "registry": "myACR.azurecr.io",
  "tagCount": 2
}
```

If the `writeEnabled` is set to false, this means that the repository or image is locked from push operations. You can unlock the repository by using one of the following commands:

```azurecli
#unlock the repository
az acr repository update --name myregistry --repository myrepo --write-enabled true 

#unlock the image by tag
az acr repository update --name myregistry --image myrepo:tag --write-enabled true 

#unlock the image by manifest digest
az acr repository update --name myregistry --image myrepo@sha256:123456abcdefg --write-enabled true 
```

### Solution 2: Verify that the container registry reaches storage limit

Another potential issue is that your container registry might have reached its storage limit. The container registry has a maximum storage capacity of 40 TiB. For more information, see [Service Tier Features and Limits](/azure/container-registry/container-registry-skus#service-tier-features-and-limits).

If you require storage beyond this limit, contact [Azure Support](#contact-us-for-help).


## Error 2: Request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)

> `Get "https://yourARC.azurecr.io/v2/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)`

### Solution: Ensure network connectivity between the device and the container registry login server on port 443

> [!TIP]
> The container registry login server is also known as the Registry REST API endpoint. The login server name is in the format of `<registry-name>.azurecr.io` (must be all lowercase).

Authentication and registry management operations are handled through the registry's public login server.

If your device is part of a restricted network environment, check whether there are any firewalls, proxy servers, access control lists, or ISP restrictions that might be blocking the connection.

To manually test the connectivity between your device and the container registry login server on port 443, you can use such network tools as `telnet` or `nc`:

```cmd
telnet <acr-name>.azurecr.io 443 
```

```cmd
nc -vz <acr-name>.azurecr.io 443 -w 10
```

Example output:

```output
nc: connect to <acr-name>.azurecr.io 443 port (TCP) failed: Connection timeout
```

If you push to the container registry from an Azure resource, follow these steps to troubleshoot the issue.

**Step 1: Check the NSG associated with the Azure resource**

Check the output of the `nc` or `telnet` command mentioned earlier. If the time-out error is displayed, check the Network Security Group (NSG) and make sure that the IP address of the container registry login server isn't blocked.

To check whether the NSG blocks the IP address of the container registry login server, follow these steps:

1. Locate the IP address of the container registry login server.
   1. In the Azure portal, open the container registry.
   2. Select **Overview**, and check the fully qualified domain name (FQDN) of the **Login server**.
   3. Use tools like `nslookup` to find the IP address of the FQDN: `nslookup <acr-name>.azurecr.io`.
3. In the Azure portal, go to **Network Watcher** and select **NSG diagnostic**.
4. In the form fields, specify the following values:
	- **Protocol**: TCP
	- **Direction**: Outbound	
	- **Source type**: IPv4 address/CIDR
	- **IPv4 address/CIDR**: IP address of the Azure resource
	- **Destination IP address**: IP address of the container registry login server
	- **Destination port**: 443
5. Select the **Run NSG diagnostic** button, and check the **Traffic** status. The Traffic status can be **Allowed** or **Denied**. "Denied" means that the NSG is blocking the traffic between the Azure resource and the login server. If the status is Denied, the NSG name will be shown.

To resolve this issue, make the mecessary changes at the NSG level to allow the connectivity between the Azure device and the container registry login server on port 443.

**Step 2: Check The route table or firewall associated with the Azure resource's subnet**

Check the output of the `nc` or `telnet` command. If a time-out is displayed:

- Make sure that the route table doesn't drop the traffic towards the container registry login server. The traffic is dropped if the next hop for a route that's associated with the container registry login server is set to **None**. For more information, see [Next hop types: None](/azure/virtual-network/virtual-networks-udr-overview#:~:text=custom%20route.-,None,-%3A%20Traffic%20routed%20to).
- If the route table sends the traffic towards a virtual appliance, such as a firewall, make sure that the firewall doesn't block the traffic to the container registry login server on port 443. For more information, see [Configure rules to access an Azure container registry behind a firewall](/azure/container-registry/container-registry-firewall-access-rules).

## Error 3: Denied, client is not allowed access

>`denied: {"errors":[{"code":"DENIED","message":"client with IP \u0027<your-device-IP>\u0027 is not allowed access. Refer https://aka.ms/acr/firewall to grant access."}]}`

### Solution: Make sure the built-in firewall allows your device's IP address

By default, Azure Container Registry accepts connections over the internet from hosts on any network. To limit public access, the container registry has a built-in firewall that can restrict access to specific IP addresses or CIDRs or to fully disable the public network access.

Disabling or restricting access to specific IP addresses or CIDRs can generate the `DENIED` error if your device's IP address was not allowed by the built-in firewall.

To fix this issue, make sure that the container registry's built-in firewall allows the IP address of the device that's used to perform the push operation. For more information, see [Configure public IP network rules for Azure container registry](/azure/container-registry/container-registry-access-selected-networks).
Alternatively, if you disabled the public network access, you can [configure connectivity by using a private endpoint](/azure/container-registry/container-registry-private-link).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
