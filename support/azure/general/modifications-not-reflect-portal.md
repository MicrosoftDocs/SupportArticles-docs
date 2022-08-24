---
title: Modifications to the configuration mode of an Azure Automation Configuration Node aren't reflected in the portal
description: When a DSC Node is registered for the first time, the Configuration Mode appears correctly in the Azure portal. But if a change is made to Configuration Mode on the DSC Node, the Configuration Mode is not updated in the Azure portal.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: automation
ms.reviewer: pfreitas
---
# Modifications to the configuration mode of an Azure Automation Configuration Node aren't reflected in the portal

_Original product version:_ &nbsp; Azure Automation  
_Original KB number:_ &nbsp; 3185622

## Symptoms

With Azure Automation Desired State Configuration (DSC), when a Node Configuration is registered for the first time, the configuration mode is displayed correctly in the Azure portal. However, if a subsequent change is made to the configuration mode for the Node Configuration, the configuration mode is not updated as expected in the Azure portal.

## More information

The configuration mode can be changed by either of the following methods:

- By reregistering an AzureVM DSC Node from the portal and using a new value for the configuration mode
- By reregistering an on-premises DSC Node from a modified DscOnboardingMetaconfig file

Either method modifies the configuration mode in the DscLocalConfigurationManager file on the DSC Node. However, in the Azure portal, the configuration mode is still marked as "Unknown." If the DSC Node and all configurations are removed from the Automation account before you reregister the DSC Node, the configuration mode is still displayed as "Unknown" in the Azure portal. There is no workaround for this behavior.

This is known issue that affects only how the configuration mode is displayed in the Azure portal. The DSC Node still functions correctly per the settings in DscLocalConfigurationManager.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
