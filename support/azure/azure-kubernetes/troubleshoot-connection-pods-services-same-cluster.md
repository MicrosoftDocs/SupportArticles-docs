---
title: Troubleshoot connections to pods and services within an AKS cluster
description: Troubleshoot connections to pods and services (internal traffic) from within an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/04/2022
ms.reviewer: chiragpa, rissing, v-leedennis
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-outbound-connections
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

### Step 1: Set up the test pod and remote server port

Set up the test pod and make sure that the required port is open on the remote server. From within the source pod (or a test pod that's in the same namespace as the source pod), follow these steps:

1. Start a test pod in the cluster by running the [kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run) command:

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

1. Run the Netcat command to check whether the remote server opened the required port:

   ```bash
   nc -z -v <endpoint> <port>
   ```

### Step 2: View operational information about pods, containers, the Kubernetes services, and endpoints

Using kubectl and cURL at the command line, follow these steps to check that everything works as expected:

1. Verify that the destination pod is up and running:

   ```bash
   kubectl get pods -n <namespace-name>
   ```

   If the destination pod is working correctly, the pod status is shown as `Running`, and the pod is shown as `READY`.

   ```output
   NAME           READY   STATUS    RESTARTS   AGE
   my-other-pod   1/1     Running   0          44m
   my-pod         1/1     Running   0          44m
   ```

1. Search the pod logs for access errors:

   ```bash
   kubectl logs <pod-name> -n <namespace-name>
   ```

1. Search the pod logs for an individual container in a multicontainer pod:

   ```bash
   kubectl logs <pod-name> -n <namespace-name> -c <container-name>
   ```

1. If the application that's inside the pod restarts repeatedly, view the `stdout` dump pod logs of a previous container instance to get the exit messages. For the multicontainer case, get the exit messages by viewing the `stdout` dump pod container logs for a previous container instance:

   ```bash
   kubectl logs <pod-name> --previous                      
   ```

   ```bash
   kubectl logs <pod-name> -c <container-name> --previous  
   ```

1. Check whether there are any network policies that might block the traffic:

   ```bash
   kubectl get networkpolicies -A
   ```

   You should see output that resembles the following table.

   ```output
   NAMESPACE     NAME                 POD-SELECTOR             AGE
   kube-system   konnectivity-agent   app=konnectivity-agent   4d1h
   ```

   If you see any other network policy that's custom-created, check whether that policy is blocking access to or from the pods.

1. Check whether you can reach the application from the service IP address. First, show details about the service resource, such as the external IP address and port, by running the `kubectl get services` command:

   ```bash
   kubectl get services -n <namespace-name>
   ```

   ```output
   NAME         TYPE           CLUSTER-IP   EXTERNAL-IP      PORT(S)        AGE
   my-service   LoadBalancer   10.0.21.43   20.119.121.232   80:31773/TCP   28s
   ```

   Then, run cURL by using the service IP address and port to check whether you can reach the application:

   ```console
   curl -Iv http://20.119.121.232:80
   .
   .
   .
   < HTTP/1.1 200 OK
   HTTP/1.1 200 OK
   ```

1. Get more verbose information about the service:

   ```bash
   kubectl describe services <service-name> -n <namespace-name>
   ```

1. Check the pod's IP address:
  
   ```bash
   kubectl get pods -o wide  
   ```
  
   ```output
   NAME            READY   STATUS        RESTARTS   AGE   IP            NODE                                
   my-pod          1/1     Running       0          12m   10.244.0.15   aks-agentpool-000000-vmss000000  
   ```

1. Verify that the pod's IP address exists as an endpoint in the service:

   ```bash
   kubectl describe services my-cluster-ip-service
   ```

   ```output
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

1. Verify the endpoints directly:

   ```bash
   kubectl get endpoints
   ```

   ```output
   NAME                      ENDPOINTS           AGE
   my-cluster-ip-service     10.244.0.15:80      14m
   ```

1. If the connection to a service doesn't work, restart the `kube-proxy` and CoreDNS pods:

   ```bash
   kubectl delete pods -n kube-system -l component=kube-proxy
   kubectl delete pods -n kube-system -l k8s-app=kube-dns
   ```

1. Verify that the node isn't overused:

   ```bash
   kubectl top nodes
   ```

   > [!NOTE]
   > You can also use [Azure Monitor to get the usage data for the cluster](/azure/aks/monitor-aks).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
