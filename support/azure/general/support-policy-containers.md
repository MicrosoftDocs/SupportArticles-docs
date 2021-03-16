---
title: Support policy for containers and related services on Azure
description: Describes the support options and coverage that Microsoft offers for containers and surrounding infrastructure services.
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.reviewer: 
ms.service: container-service
ms.author: genli
author: genlin
---
# Support policy for containers and related services on Azure

Azure provides flexible, extensive support options for container deployments. This article outlines the support options and coverage for containers and the surrounding infrastructure services that Microsoft offers.

_Original product version:_ &nbsp; Container Service  
_Original KB number:_ &nbsp; 4035670

## Supported components

### Containers running on physical infrastructure

For containers that are running on physical infrastructure and servers, Microsoft supports instances of Windows Server Containers on Windows Server 2016. For more information, see [Docker Engine on Windows](https://docs.microsoft.com/virtualization/windowscontainers/manage-docker/configure-docker-daemon).

For ­­­ support of Linux operating systems that are running on physical infrastructure and servers, customers have to contact the distribution provider for support, such as [Canonical](https://www.canonical.com/services), [CoreOS](https://coreos.com/support), or [Red Hat](https://www.redhat.com/en/services/support).

Physical infrastructure support is not provided by Microsoft, except in cases in which the hardware is a Microsoft product under warranty or a support plan, such as for Surface Pro 4.

:::image type="content" source="./media/support-policy-containers/4036515_en_1.png" alt-text="Physical Infrastructure.":::

## Containers on Azure Cloud Services

Container orchestrators are enabled to work with container deployments as mentioned in the previous section, such as Windows Server Containers and Azure Container Service. Microsoft provides support for the deployment of common orchestrators such as Docker Swarm, Kubernetes, DC or system, and several others on ACS only. Microsoft does not currently offer phone-based or web-based technical support for the configuration or operation of these container orchestrators within ACS or any support for third-party container orchestrators outside of ACS.

### Azure platform and operating system

:::image type="content" source="./media/support-policy-containers/4037697_en_1.png" alt-text="Azure platform.":::

- Azure platform (storage, disk, computer, and so on): Fully supported
- Operating System
  - Window Server 2016: Fully supported by Microsoft
  - Linux: Endorsed distributions are specifically enabled to run the Docker container engine on Azure. For more information, see [Linux on distributions endorsed by Azure](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros). Customers who use an endorsed distribution receive commercially reasonable support for issues related to the system, as described in [Support for Linux and open source technology in Azure](https://support.microsoft.com/help/2941892/support-for-linux-and-open-source-technology-in-azure).

### Container engine

#### Windows Server 2016

Customers who use Windows Server 2016 and Windows Server Containers (WSC) receive full support for issues that are related to the operating system or container engine.

:::image type="content" source="./media/support-policy-containers/4037698_en_1.png" alt-text="container engine.":::

#### Linux operating system

Customers who use an endorsed distribution receive commercially reasonable support for issues related to the system only. Container engine issues are covered by the third party. For more information, see [Support for Linux and open source technology in Azure](https://support.microsoft.com/help/2941892). 

:::image type="content" source="./media/support-policy-containers/4037700_en_1.png" alt-text="Docker service.":::

### Azure Container Service

Many customers use the Azure Container Service (ACS) to quickly deploy a preferred container configuration in Azure. ACS deploys the Docker Engine on either a Linux or Windows system. Full support for issues in deploying Windows Containers in ACS is provided by Microsoft, as was described earlier. Microsoft provides commercially reasonable support for Linux issues. For container engine issues on Linux (Docker), customers should contact [Docker support](https://www.docker.com/docker-support-services).

The deployment and scaling of the container infrastructure in Azure by using ACS is fully supported by Microsoft.

### AKS Engine

The Azure Kubernetes Service Engine (AKS Engine) generates Azure Resource Manager templates that allow you to easily create Kubernetes clusters on Microsoft Azure. The input to the tool is a cluster definition file with the desired cluster configuration. The cluster definition is the same as the Azure Resource Manager template syntax that is used to deploy a Microsoft AKS cluster

AKS Engine is an open-source project with no official support from Microsoft, any issues can be raised in [GitHub](https://github.com/Azure/aks-engine). 

### Azure Kubernetes Service (AKS)

Azure Kubernetes Services allows customers to deploy a managed Kubernetes environment without having to configure or deploy an orchestrator. 

**What is covered:**  

Support for AKS is scoped to availability and operations against the Kubernetes API.
Examples of supported issues:

- The ability to successfully connect to the Kubernetes API
- The ability for VMs in the cluster to connect and register successfully
- The ability for customers to horizontally scale the VMs attached to their cluster
- The ability for customers to upgrade their cluster between minor and patch versions 

**What is not covered:**  

Issues that use Deployments, Namespaces, containerizing applications, or complex advisory scenarios are not supported.

As a free service, AKS does not offer a financially backed service level agreement. We will strive to attain at least 99.5 percent availability for the Kubernetes API server. The availability of the agent nodes in your cluster is covered by the Virtual Machines SLA. See the [Virtual Machines SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_0/) for more details. 

For the limitation of Container workload support, see [Container Workloads](https://docs.microsoft.com/azure/batch/batch-docker-container-workloads).

### Azure Container Instances (ACI)

Azure Container Instances is the fastest way to implement a container in Azure and does not require the provision of VMs or other resources.

**What is covered:**  

Web-assisted and phone-assisted support for ACI is scoped to operation and availability scenarios.

Customers will receive support for the deployment and operation of ACI running in Azure inclusive of Azure Platform and container components that are required for operation.
Examples of supported Issues:

- ACI connectivity issues
- ACI deployment, configuration issues  

**What is not covered:**  

Issues that use Deployments, Namespaces, containerizing applications, or complex advisory scenarios are not supported.

## Container orchestrators

### Azure Service Fabric

Customers who have deployed Windows Server Containers on Windows Server 2016 can use Azure Service Fabric as a container orchestrator. Azure Service Fabric is fully supported by Microsoft in this scenario, which includes the Azure Cloud Platform, Windows operating system, Container Service, and orchestrator.

### Third-party orchestrators

Container orchestrators are enabled to work with container deployments as mentioned above, such as Windows Server Containers and Azure Container Service. Microsoft provides support for the deployment of common orchestrators such as Docker Swarm, Kubernetes, DC or system, and several others on **ACS ONLY**. Microsoft does not currently offer phone or web-based technical support for the configuration or operation of these container orchestrators within ACS or any support for third-party container orchestrators outside of ACS. 

We recommend that you use community resources or contact the orchestrator provider for additional technical assistance:

- [Mesosphere](https://support.mesosphere.com/hc/en-us) 
- [Docker Swarm](https://success.docker.com/Policies/Scope_of_Support) 
- [DC/OS](https://dcos.io/community/) 
- [Kubernetes](https://kubernetes.io/community/) 

If you think you have encountered a bug, visit the ACS community issue page on GitHub: [ACS Community on GitHub](https://github.com/Azure/ACS) 

## Container workloads

Support for issues within a container is limited to "Hello, world" scenarios that help verify whether the container implementation is operating as expected.

## Azure networking and storage

Microsoft supports Microsoft products when it can be determined that the issue is not caused by the container configuration or container engine.

For third-party (non-Microsoft technology), Microsoft provides commercially reasonable support. Example scope of support available from Microsoft:

- Deployment and configuration issues
- Performance issues related to Azure platform
- Networking

:::image type="content" source="./media/support-policy-containers/4037701_en_1.png" alt-text="Container services.":::

## Azure Web Apps and containers

Customers may also choose to deploy containers to Azure Web Apps on Linux. In this scenario, customers can deploy a web app on Linux and then deploy containers within the app by using the Azure Container Registry, Docker Hub, a default container, or a private registry.

### Component support

Microsoft offers commercially reasonable support for the components that are deployed in this scenario, including the operating system, Docker Engine, and hosted elements in the container (such as Node.js). Customized code is not within the scope of support.

:::image type="content" source="./media/support-policy-containers/4037702_en_1.png" alt-text="Component support.":::

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

**Third-party contact disclaimer**

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.
