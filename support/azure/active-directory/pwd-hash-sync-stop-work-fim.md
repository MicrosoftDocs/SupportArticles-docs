---
title: Password hash synchronization stops working after you update Microsoft Entra credentials in FIM
description: Describes a problem that prevents password hash synchronization from working in an Azure environment. Occurs after you update your global administrator credentials in Forefront Identity Manager (FIM).
ms.date: 05/28/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
---
# Password hash synchronization stops working after updating Microsoft Entra credentials in FIM

This article describes an issue in which password hash synchronization stops working in an Azure environment. This occurs after you update your global administrator credentials in Microsoft Forefront Identity Manager (FIM).

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2962509

## Symptoms

After you update your global administrator credentials in FIM for directory synchronization, password hash synchronization stops working. Additionally, one of the following events may be logged in the Application log in Event Viewer:

| Event ID| Source| Level| Description |
|---|---|---|---|
|115|Directory Synchronization|Information|Error Description: Access to Windows Azure Active Directory has been denied. Contact Technical Support. |
|0|Directory Synchronization|Error|The user name or password is incorrect. Verify your user name, and then type your password again.|
|655|Directory Synchronization|Error|The user name or password is incorrect. Verify your user name, and then type your password again.|
|6900|FIMSynchronizationService|Error|The server encountered an unexpected error while processing a password change notification:<br/>"The user name or password is incorrect. Verify your user name, and then type your password again.|
  
## Resolution

To resolve this issue, run the Azure Active Directory Sync tool Configuration Wizard. For more information about how to do this, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).

## More information

Alternatively, you can restart the Forefront Identity Manager Synchronization Service. To do this, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Services**.
2. In the list of services, right-click **Forefront Identity Manager Synchronization Service**, and then click **Stop**.
3. Right-click **Forefront Identity Manager Synchronization Service**, and then click **Start**.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
