---
title: Find Azure Container Registry image vulnerability scanning results and in Microsoft Defender for Cloud 
description: Learn to find image scanning results and common steps to fix vulnerability in Microsoft Defender for Containers 
ms.date: 08/13/2024
ms.reviewer: 
ms.service: azure-container-instances
ms.custom: sap:Configure registry settings
---
# Find Azure Container Registry image vulnerability scanning results

This article describes how to view Azure Container Registry image vulnerability scanning results in Microsoft Cloud for Defender.

## View image vulnerability scanning results

### Ensure the Agentless Container vulnerability assessments extension is enabled

1. In the Azure portal, navigate to the **Microsoft Defender for Cloud**. Under **Management**, select **Environment Settings** page.
1. Select your Azure subscription, then select **Settings**.
1. Ensure the **Agentless Container vulnerability assessments** extension is set to **On**.

      :::image type="content" source="media/image-vulnerability-assessment/agentless-container-vulnerability-assessment.png" alt-text="Screenshot of selecting agentless discovery for Kubernetes and Container registries vulnerability assessments." lightbox="media/image-vulnerability-assessment/agentless-container-vulnerability-assessment.png":::

     If you doesn't see the setting, upgrade the Microsoft Defender for Cloud to [Defender CSPM plan](tutorial-enable-cspm-plan.md), [Defender for Containers plan](tutorial-enable-containers-azure.md) or [Defender for Container Registries plan](defender-for-container-registries-introduction.md).
1. Select **Continue**.
1. Select **Save**.

### Find vulnerability assessment results

1. In the Azure portal, navigate to the **Microsoft Defender for Cloud**.
1. Under **General**, select **Recommendations**.
1. Search for recommendation titled **Azure registry container images should have vulnerability findings resolved**. The following is an example of the recommendation:

    :::image type="content" source="media/image-vulnerability-assessment/acr-vulnerability-example.png" alt-text="Screenshot that the registry container images related recommendations." lightbox="media/image-vulnerability-assessment/acr-vulnerability-example.png":::

## Guidance on addressing registry images vulnerability

It is recommended to rebuild the images using the latest base images and packages, push them again to the container registry,  and then wait for the new scan results.

If the vulnerabilities still be detected in the Microsoft Cloud for Defender, you need to work with the package developer to fix them.

## Why some vulnerabilities seen in third-party tools are not detected by Microsoft Defender for Cloud

The detection of vulnerabilities can vary depending on security tools and the conditions they use for assessment. For example, certain parameters and conditions that third-party tools rely on may not be included in Microsoft Defender for Cloud's vulnerability assessments. Conversely, the parameters used by Microsoft Defender for Cloud's Azure Container Registry (ACR) vulnerability assessments may not be covered by some third-party tools. This difference in detection criteria can lead to discrepancies between the vulnerabilities identified by different tools.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
