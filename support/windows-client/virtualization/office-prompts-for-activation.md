---
title: Office prompts for activation in Azure
description: Describes an issue when Microsoft Office applications prompt for reactivation when they are installed on Windows-based virtual machines in Azure.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Office prompts for activation in Azure

This article provides a solution to an issue where Microsoft Office applications prompt for reactivation when they are installed on Windows-based virtual machines in Azure.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2998147

## Symptoms

Office applications prompt for reactivation when they are installed on Windows-based virtual machines in Azure.

## Cause

Azure automatically activates Microsoft Windows Servers by using an internal KMS (key management system) infrastructure within the Azure datacenters. Only virtual computers that are running in Azure can connect to and activate by using these KMS servers. The KMS servers let you activate Windows Server 2008 R2 and later versions. However, they do not include the Microsoft Office KMS activation packs.

As virtual machines migrate to new hosts during regular maintenance and certain administrative functions such as resizing or starting from the Stopped Deallocated state, Microsoft Office may prompt for reactivation if you are not using KMS, and instead you are using MAK (multiple activation keys). Over time, the operating system will detect multiple hardware changes, eventually causing Microsoft Office to require reactivation for this configuration.

## Resolution

Microsoft Office is only permitted to be hosted in Azure under specific Service Provider agreements. Therefore, the Azure hosted KMS servers will not activate Microsoft Office applications automatically.

For environments that do have the correct licensing to host Microsoft Office, the recommended configuration is to leverage [Active Directory Based Activation](https://technet.microsoft.com/library/dn385361%28v=office.15%29.aspx)  (if deploying Office 2013). If you are not deploying Office 2013 or cannot use Active Directory Based Activation, another option is to install a KMS host within the same virtual network as the hosted virtual machines in Azure or enable access to an on-premise KMS host through a site-to-site tunnel. See the [Office 2013 Volume Activation](https://technet.microsoft.com/library/ee624357%28v=office.15%29.aspx)  guide for KMS configuration. 

## More information

For more information about licensing software in Azure, reference the [Virtual Machine Volume Licensing FAQ](https://azure.microsoft.com/pricing/licensing-faq/) 

For more information about how to apply for service provider licensing, reference the [Volume Licensing Product Reference](https://www.microsoftvolumelicensing.com/documentsearch.aspx?mode=3&documenttypeid=2)
