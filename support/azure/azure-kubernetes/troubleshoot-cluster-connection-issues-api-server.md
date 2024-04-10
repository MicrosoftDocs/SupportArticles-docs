---
title: Troubleshoot cluster connection issues with the API server
description: Troubleshoot issues that occur when you attempt to connect to the API server of an Azure Kubernetes Service (AKS) cluster.
ms.date: 12/06/2021
ms.reviewer: rissing chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-cluster-through-api-server
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting measures so that I can avoid cluster connectivity issues with the API server.
---
# Basic troubleshooting of cluster connection issues with the API server

This article discusses connection issues to an Azure Kubernetes Service (AKS) cluster when you can't reach the cluster's API server through the Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)) or any other tool, such as using REST API through a programming language.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

## Root cause and solutions

Connection issues to the API server can occur for many reasons, but the root cause is often related to an error with one of these items:

- Network
- Authentication
- Authorization

You can take these common troubleshooting steps to check the connectivity to the AKS cluster's API server:

1. Enter the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI. This command gets the fully qualified domain name (FQDN) of your AKS cluster.

    ```azurecli
    az aks show --resource-group <cluster-resource-group> --name <cluster-name> --query fqdn
    ```

1. With the FQDN, check whether the API server is reachable from the client machine by using the name server lookup ([nslookup](/windows-server/administration/windows-commands/nslookup)), client URL ([curl](https://curl.se/docs/manpage.html)), and [telnet](/windows-server/administration/windows-commands/telnet) commands:

    ```bash
    # Check if the DNS Resolution is working:
    $ nslookup <cluster-fqdn>  
    
    # Then check if the API Server is reachable:
    $ curl -Iv https://<cluster-fqdn>
    $ telnet <cluster-fqdn> 443
    ```

1. If the AKS cluster is private, make sure you run the command from a virtual machine (VM) that can access the AKS cluster's Azure Virtual Network. See [Options for connecting to the private cluster](/azure/aks/private-clusters#options-for-connecting-to-the-private-cluster).

1. If necessary, follow the steps in the troubleshooting article [Client IP address can't access the API server](client-ip-address-cannot-access-api-server.md), so the API server adds your client IP address to the IP ranges it authorizes.

1. Make sure the version of kubectl on your client machine isn't two or more minor versions behind the AKS cluster's version of that tool. To install the latest version of kubectl, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command in Azure CLI. You can then run [kubectl version](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#version) command to check the version number of the new installation.

    For example, on Linux you would run these commands:

    ```bash
    sudo az aks install-cli
    kubectl version --client
    ```

    For other client operating systems, use these [kubectl installation instructions](https://kubernetes.io/docs/tasks/tools/).

1. If necessary, follow the steps in the troubleshooting article [Config file isn't available when connecting](config-file-is-not-available-when-connecting.md), so your Kubernetes configuration file (*config*) is valid and can be found at connection time.

1. If necessary, follow the steps in the troubleshooting article [User can't get cluster resources](user-cannot-get-cluster-resources.md), so you can list the details of your cluster nodes.

1. If you're using a firewall to control egress traffic from AKS worker nodes, make sure the firewall allows the [minimum required egress rules for AKS](/azure/aks/limit-egress-traffic).

1. Make sure the [network security group that's associated with AKS nodes](/azure/aks/concepts-security#azure-network-security-groups) allows communication on TCP port 10250 within the AKS nodes.

For other common troubleshooting steps, see [I'm receiving TCP timeouts when using kubectl or other third-party tools connecting to the API server](/azure/aks/troubleshooting#im-receiving-tcp-timeouts-when-using-kubectl-or-other-third-party-tools-connecting-to-the-api-server).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
