---
title: How to capture TCP dump from a pod running on an AKS cluster
description: Describes how to capture TCP dump from a POD running on an AKS cluster
ms.date: 07/08/2021
ms.reviewer: erbookbi
ms.service: container-service
---
# Capture TCP packets from a pod running on an AKS cluster

This article shows how to take a TCP traffic capture at the pod level of an Azure Kubernetes Service (AKS), and download the capture to your local machine.

## Prerequisite

You must run The Azure CLI version 2.0.59 or a later version.

Run `az --version` to verify the version. To install the latest version of the Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Identify the pod and install Tcpdump

1. Identify the name of the pod that you want to capture the TCP packets from. To do this, run `kubectl get pods -A` to see the number and state of pods in your cluster. The following is an example of the output:

    ```output
    NAME                               READY     STATUS    RESTARTS   AGE
    azure-vote-back-2549686872-4d2r5   1/1       Running   0          31m
    azure-vote-front-848767080-tf34m   1/1       Running   0          31m
    ```

   If you know the namespace that the pod runs in you, you also run `kubectl get pods -n <namespace> ` to see the pods.
    
1. Connect to the pod that you identified in the previous step:

   ```cli
   kubectl exec <name of the pod> -it -- /bin/bash
   ```
1. After you connect to the pod, run `tcpdump --version` verify if the TCPdump is installed. If you receive the "command not found" message, run the following command to install the TCPdump in the pod:

    ```cli
    apt-get update && apt-get install tcpdump
    ```
    If your pod is using Alpine Linux, run the following command to install TCP dump:

   ```cli
    apk add tcpdump
    ```
## Capturing TCP packets and save it to a local directory

1. Run `tcpdump -s 0 -vvv -w /capture.cap` to start capture TCP packets on your pod.
1. Once the packet capture has completed, you can exit out of your pod shell session, to do this press `Ctrl-D` or type `exit`.
1. Run the following command to save it to your current directory:

    ```cli
    kubectl cp azure-vote-front-85b4df594d-lfbck:/capture.cap capture.cap
    ```