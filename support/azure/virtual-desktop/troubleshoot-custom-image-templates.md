---
title: Troubleshoot custom image templates in Azure Virtual Desktop
description: Troubleshoot custom image templates in Azure Virtual Desktop.
ms.topic: troubleshooting
ms.reviewer: daknappe
ms.date: 01/21/2025
ms.custom: pcy:wincomm-user-experience
---
# Troubleshoot custom image templates in Azure Virtual Desktop

Custom image templates in Azure Virtual Desktop enable you to easily create a custom image that you can use when deploying session host virtual machines (VMs). This article helps troubleshoot some issues you might encounter.

## General troubleshooting when creating an image

Azure Image Builder uses Hashicorp Packer to create images. Packer outputs all log entries to a file called **customization.log**. By default, this file is located in a resource group that Azure Image Builder created automatically with the naming convention `IT_<ResourceGroupName>_<TemplateName>_<GUID>`. You can override this naming by specifying your own name in the template creation phase.

In this resource group is a storage account with a blob container called **packerlogs**. In the container is a folder named with a GUID in which you find the log file. Entries for built-in scripts you use to customize your image begin `Starting AVD AIB Customization: {<Script name>}: {<Timestamp>}`, to help you locate any errors related to the scripts.

For more information about how to interpret Azure Image Builder logs, see [Troubleshoot Azure VM Image Builder](/azure/virtual-machines/linux/image-builder-troubleshoot).

> [!IMPORTANT]
> Microsoft Support doesn't handle issues for any customer-created scripts, or any scripts or templates copied from a Microsoft repository and modified. You're welcome to collaborate and improve these tools in our [GitHub repository](https://github.com/Azure/RDS-Templates/issues), where you can open an issue. For more information, see [Why do we not support customer or third-party scripts?](https://techcommunity.microsoft.com/t5/ask-the-performance-team/help-my-powershell-script-isn-t-working-can-you-fix-it/ba-p/755797)

## Resource group must be empty

If you specify your own resource group for Azure Image Builder to use, it needs to be empty before the image build starts. This means that if you want to reuse an existing resource group for this purpose, you'll just need to delete all the resources within it. Alternatively, if you need to keep these items, you can specify another new resource group on the build properties tab of the template creation.

## Script is unavailable

If you see the message:

> Resource \<URI\> is unavailable. Please check the file exists, and that Image Builder can access it.

Check the Uniform Resource Identifier (URI) for your script. This needs to be a publicly available location, such as GitHub or a web service.

## Azure Compute Gallery VM image definition generation mismatch

If you see the message:

> Validation failed: Error with Hyper-V Version validation (cross-generation for multiple Hyper-V Versions is not supported). The provided SIG: \<Resource ID\> has a different Hyper-V Generation \<version\> than source image \<version\>.

Make sure that the generation of your source image is the same as the generation you specified for your Azure Compute Gallery VM image definition.

The generation for the source image is shown when you select the image you want to use. You can check the generation of the VM image definition in the Azure portal, Azure CLI using the [az sig image-definition list](/cli/azure/sig/image-definition#az-sig-image-definition-list) reference command, or PowerShell using the [Get-AzGalleryImageDefinition](/powershell/module/az.compute/get-azgalleryimagedefinition) cmdlet.

## PrivateLinkService Network Policy isn't disabled for the given subnet

If you receive the error message stating "PrivateLinkService Network Policy is not disabled for the given subnet," you need to disable the private service policy on the subnet. For more information, see [Disable private service policy on the subnet](/azure/virtual-machines/windows/image-builder-vnet#disable-private-service-policy-on-the-subnet).

## Issues installing or enabling other languages on Windows 10 images

Other languages can be added by custom image templates, which use the [Install-Language PowerShell cmdlet](/powershell/module/languagepackmanagement/install-language). If you have issues installing or enabling other languages on Windows 10 Enterprise and Windows 10 Enterprise multi-session images, ensure that:

- You haven't disabled installing language packs by group policy on your image. The policy setting can be found at the following locations:

  - **Computer Configuration** > **Administrative Templates** > **Control Panel** > **Regional and Language Options** > **Restrict Language Pack and Language Feature Installation**

  - **User Configuration** > **Administrative Templates** > **Control Panel** > **Regional and Language Options** > **Restrict Language Pack and Language Feature Installation**

- Your session hosts can connect to Windows Update to download languages and the latest cumulative updates.

## Can't progress from the source image tab in the Azure portal

When you create a custom image template in the Azure portal, you might not be able to progress from the **Source image** tab if you select the **Azure Compute Gallery** as the **Source type**. A red **X** appears next to the tab name. As a workaround, select **Previous** to return to the **Basics** tab, and then select **Next** to return to the **Source image** tab. You should now be able to progress to the next tab, and a green check mark appears next to the tab name.

## Authorization error occurred during the Azure Container Groups operation

Custom image templates require the `Microsoft.ContainerInstance` resource provider registered on your subscription due to the dependency on Azure Image Builder. If you receive the error:

> The client '\<GUID\>' with object id '\<GUID\>' does not have authorization to perform action 'Microsoft.ContainerInstance/register/action' over scope '/subscriptions/\<subscription ID\>' or the scope is invalid.

You need to register the `Microsoft.ContainerInstance` resource provider on your subscription. Once you register the resource provider, try the action again. For more information on how to check their registration status and how to register them if needed, see [Azure resource providers and types](/azure/virtual-desktop/../azure-resource-manager/management/resource-providers-and-types).
