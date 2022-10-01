---
title: Troubleshoot connections to pods and services within an AKS cluster
description: Troubleshoot connections to pods and services (internal traffic) from within an Azure Kubernetes Service (AKS) cluster.
ms.date: 9/30/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa
editor: v-jsitser
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot connections to pods and services so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot connection issues to pods or services within an AKS cluster (internal traffic)

This article discusses how to troubleshoot connection issues to pods or services as internal traffic from within the same Microsoft Azure Kubernetes Services (AKS) cluster.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The [Netcat](https://linux.die.net/man/1/nc) (`nc`) command-line tool for TCP connections.

## Troubleshooting checklist

### Step 1: Set up the test pod and make sure the remote server port is open

You'll need to set up the test pod and make sure that the required port is open on the remote server. From within the source pod (or a test pod that's in the same namespace as the source pod), follow these steps:

1. Start a test pod in the cluster by running the [kubectl run]() command:

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable
   ```

1. After you gain access to the pod, run the following `apt-get` commands to install the DNS Utils, cURL, and Netcat packages:

   ```bash  
   apt-get update -y
   apt-get install dnsutils -y
   apt-get install curl -y
   apt-get install netcat -y
   ```

1. After the packages are installed, run the following cURL command to test the connectivity to the IP address of the pod:

   ```bash
   curl -Iv http://<pod-ip-address>:<port>
   ```

1. Run the Netcat command to check whether the remote server has opened the required port.

   ```bash
   nc -z -v <endpoint> <port>
   ```

### Step 2: View operational information about pods, containers, the Kubernetes services, and endpoints

Using kubectl and cURL at the command line, follow these steps to check that everything is operating as expected:

1. Verify that the destination pod is up and running.

   ```bash
   kubectl get pods -n <namespace-name>
   ```

1. View the logs of the pod.

   ```bash
   kubectl logs <pod-name> -n <namespace-name>
   ```

1. View the logs for an individual container in a multicontainer pod.

   ```bash
   kubectl logs <pod-name> -n <namespace-name> -c <container-name>
   ```

1. View the `stdout` dump pod logs for a previous container instance.

   ```bash
   kubectl logs <pod-name> --previous                      
   ```

1. View the `stdout` dump pod container logs (multicontainer case) for a previous container instance.

   ```bash
   kubectl logs <pod-name> -c <container-name> --previous  
   ```

1. Check whether there are any network policies that might block the traffic.

   ```bash
   kubectl get networkpolicy -A
   ```

1. Check whether you can reach the application from the service IP address.

   ```bash
   curl -Iv http://<service-ip-address>:<port>
   ```

1. Show details about the service resource.

   ```bash
   kubectl get svc -n <namespace-name>
   ```

1. Get more verbose information about the service.

   ```bash
   kubectl describe svc <service-name> -n <namespace-name>
   ```

1. Verify whether the pod's IP address is present as an endpoint in the service.

   ```console
   $ kubectl get pods -o wide  # Check the pod's IP address.
   NAME            READY   STATUS        RESTARTS   AGE   IP            NODE                                
   my-pod          1/1     Running       0          12m   10.244.0.15   aks-agentpool-000000-vmss000000  
   ```

1. Check the endpoints in the service.

   ```console
   $ kubectl describe service my-cluster-ip-service
   Name:              my-cluster-ip-service
   Namespace:         default
   Selector:          app=my-pod
   Type:              ClusterIP
   IP Family Policy:  SingleStack
   IP Families:       IPv4
   IP:                10.0.174.133
   IPs:               10.0.174.133
   Port:              <unset>  80/TCP
   TargetPort:        80/TCP
   Endpoints:         10.244.0.15:80     # <--- Here
   ```

1. Check the endpoints directly for verification.

   ```console
   $ kubectl get endpoints
   NAME                      ENDPOINTS           AGE
   my-cluster-ip-service     10.244.0.15:80      14m
   ```

1. If the connection to a service doesn't work, restart the `kube-proxy` and CoreDNS pods.

   ```bash
   kubectl delete pods -n kube-system -l component=kube-proxy
   kubectl delete pods -n kube-system -l k8s-app=kube-dns
   ```

1. Verify that the node isn't overutilized.

   ```bash
   kubectl top nodes
   ```

   You could also use [Azure Monitor to get the utilization data for the cluster](/azure/aks/monitor-aks).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
