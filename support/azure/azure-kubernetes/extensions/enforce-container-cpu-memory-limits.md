---
title: AKS container CPU and memory limits aren't enforced
description: Provide a solution to an issue where CPU and memory limits aren't enforced for AKS containers.
ms.date: 04/10/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# AKS container CPU and memory limits aren't enforced

This article provides a solution to an issue where CPU and memory limits aren't enforced for containers when you use Azure Policy Add-on for Azure Kubernetes Service (AKS).

## Symptoms

When you deploy an application to an AKS cluster, you receive an error like the following sample:

> "validation.gatekeeper.sh" denied the request: [container-must-have-limits] container \<name> has no resource/memory limit

## Cause

CPU and memory limits aren't configured in the container specification.

## Resolution

To resolve this issue, ensure that container CPU and memory limits are enforced by following these steps:

1. Run the following command to check the compliance of your cluster: 

    ```console
    kubectl describe k8sazurecontainerlimits 
    ```
    
    This command provides information about the current CPU and memory limits that are configured for your containers. 

2. Configure the CPU and memory limits properly within the container specification for all your existing deployments.

  	Here's an example: 

    ```yaml
    spec: 
      containers: 
      - name: cache-service 
        image: xasag94215/flask-cache 
        ports: 
        - containerPort: 5000 
          name: rest 
        resources: 
          requests: 
            cpu: 25m 
            memory: 64Mi 
          limits: 
            cpu: 410m 
            memory: 512Mi 
     ```

      > [!NOTE]
      > Adjust the CPU and memory values based on your specific requirements. 

3. After updating the container specification, trigger a rescan or on-demand scan to evaluate the compliance status. You can use the Azure CLI to perform an on-demand evaluation scan. For more information about triggering an on-demand scan, see [On-demand evaluation scan - Azure CLI](/azure/governance/policy/how-to/get-compliance-data#on-demand-evaluation-scan---azure-cli). 

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
