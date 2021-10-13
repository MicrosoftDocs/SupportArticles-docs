---
title: How to capture TCP dump from a pod running on an AKS cluster
description: Describes how to capture TCP traffic from a POD running on an AKS cluster
ms.date: 07/08/2021
ms.author: genlin
author: y2kdread
ms.service: container-service
---
# Capture TCP packets from a pod on an AKS cluster

This article shows how to take a TCP traffic capture at a pod of an Azure Kubernetes Service (AKS) cluster, and download the capture to your local machine.

## Prerequisite

You must run the Azure CLI version 2.0.59 or a later version.

Run `az --version` to verify the version. To install the latest version of the Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Identify the pod and install TCPdump

1. Identify the name of the pod that you want to capture the TCP packets from. This should be the pod that has the connectivity issues. To do this, run `kubectl get pods -A` to see the list of pods on your AKS cluster. The following is an example of the output:

    ```output
    NAME                               READY     STATUS    RESTARTS   AGE
    azure-vote-back-2549686872-4d2r5   1/1       Running   0          31m
    azure-vote-front-848767080-tf34m   1/1       Running   0          31m
    ```

   If you know the namespace that the pod runs in, you also can run kubectl get pods -n <namespace> to get a list of pods that are running in that namespace.

1. Connect to the pod that you identified in the previous step. The following commands use "azure-vote-front-848767080-tf34m" as the pod name. You must replace them with the correct pod name. If the pods is not in the default namespace, you must add "--namespace" parameter to the "kubectl exec" command.

   ```azurecli
   kubectl exec azure-vote-front-848767080-tf34m -it -- /bin/bash
   ```
1. After you connect to the pod, run `tcpdump --version` verify if the TCPdump is installed. If you receive the "command not found" message, run the following command to install the TCPdump in the pod:

    ```azurecli
    apt-get update && apt-get install tcpdump
    ```
    If your pod is using Alpine Linux, run this command to install TCPdump:

   ```azurecli
    apk add tcpdump
    ```
## Capture TCP packets and save it to a local directory

1. Run `tcpdump -s 0 -vvv -w /capture.cap` to start capture TCP packets on your pod.
1. Once the packet capture has completed, you can exit out of your pod shell session, to do this press `Ctrl-D` or type `exit`.
1. Run the following command to save it to your current directory:

    ```azurecli
    kubectl cp azure-vote-front-848767080-tf34m:/capture.cap capture.cap
    ```