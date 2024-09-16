---
title: Troubleshoot the Kubernetes Event-driven Autoscaling (KEDA) add-on
description: Learn how to troubleshoot the Kubernetes Event-driven Autoscaling (KEDA) add-on to the Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
ms.date: 08/13/2024
editor: 
ms.reviewer: 
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot problems that involve the Kubernetes Event-driven Autoscaling (KEDA) add-on so that I can successfully use event-driven autoscaling on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Breaking changes in Event-driven Autoscaling Add-ons 2.15 and 2.14 for AKS v1.30+

The Event-driven Autoscaling (KEDA) add-on is upgraded to version 2.15 for AKS clusters running Kubernetes versions 1.31 and later. Additionally, KEDA version 2.14 has been released for AKS version 1.30.

## Breaking Changes

### KEDA 2.15

- [Pod Identity support is removed](https://github.com/kedacore/keda/issues/5035). If you use pod identity, we recommend you move over to workload identity for your authentication.

### KEDA 2.14

- [Removal of Azure Data Explorer 'metadata.clientSecret' as it was not safe for managing secrets](https://github.com/kedacore/keda/issues/4514). Use `clientSecretFromEnv` instead.
- [Removal of the deprecated `metricName` from trigger metadata section](https://github.com/kedacore/keda/issues/4240). The two impacted Azure Scalers are Azure Blob Scaler and Azure Log Analytics Scaler. If you are using `metricName` , move `metricName` outside of trigger metadata section to trigger.name in the trigger section to optionally name your trigger. 

     An example before KEDA 2.14 and 2.15

     ```
     triggers:
     - type: any-type
     metadata:
     metricName: "my-custom-name"
     ```

     An example with KEDA 2.14, 2.15 or later

     ```
     triggers:
     - type: any-type
     name: "my-custom-name"
     metadata:
     ```
## FAQ

**How can I confirm if my cluster is impacted?**

1. Check the Kubernetes Version:

     Identify the Kubernetes version of your AKS cluster. Clusters running Kubernetes versions 1.30 or above will be impacted by the KEDA upgrades (2.14 or 2.15). If you are on 1.29 or below, these changes are important.
     
     You can check your cluster version using the Azure CLI:

     ```
     az aks show --resource-group <your-resource-group> --name <your-cluster-name> --query kubernetesVersion
     ```
2. Audit KEDA Scalers in Use:

     - Review the configurations of KEDA Scalers currently deployed in your cluster:
          - If you are using Azure Data Explorer Scaler and have defined metadata.clientSecret, you need to update it to clientSecretFromEnv. You can see clientSecretFromEnv is defined in the official KEDA docs.
          - If you are using Azure Blob Scaler or Azure Log Analytics Scaler and have defined the optional metricName inside the trigger.metadata section, you need to move it to the trigger.name field. 
    - Check if Entra Pod-Managed Identities is used for authentication. The following command will give output if you are running Pod Identity with KEDA  
         ```
         kubectl get TriggerAuthentication --all-namespaces -o jsonpath='{range .items[?(@.spec.podIdentity.provider=="azure")]}{.metadata.namespace}{"/"}{.metadata.name}{"\n"}{end}'
         ```
     - We also recommend you move to workload identity for your authentication so there is no breaking change when you upgrade to AKS 1.31.
3. Review the Cluster Logs:

     Look for any deprecation warnings or errors related to the removed or changed fields in KEDA, such as metricName or metadata.clientSecret.

**What steps can I take to mitigate the issues?**

1. Migrate from Entra Pod-Managed Identities to Workload Identity:
    Set up Workload Identity as the authentication method. Follow the Azure documentation to configure Workload Identity for your AKS cluster.
2. Update Scaler Configurations:
    Modify your KEDA Scalers to align with the new configuration requirements:
    For Azure Data Explorer Scaler, replace metadata.clientSecret with clientSecretFromEnv.
    For Azure Blob Scaler and Azure Log Analytics Scaler, move  trigger.metadata.metricName to trigger.name.
3. Test Changes in a Non-Production Environment:
    Deploy the updated configurations in a staging or development environment to ensure they work correctly and do not impact your applications.
4. Monitor Logs and Alerts:
    After making changes, monitor the cluster logs for any warnings or errors related to the new KEDA configuration and behavior.

**How to reach out to support if I have follow-up questions?**

Contact Microsoft Support:
    1. If you are an Azure customer, you can reach out to Microsoft Azure Support through the Azure portal:
    2. Navigate to Help + Support > New support request.
    3. Provide details about your issue and specify that it pertains to the KEDA addon in AKS.


[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


