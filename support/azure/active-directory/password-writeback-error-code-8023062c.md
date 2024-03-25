---
title: Server can't make an insecure setting of passwords or requires 128-bit TLS/SSL
description: 'Error: 8023062C: The password could not be set because the server is not configured for insecure setting of passwords, or a 128 bit TLS or SSL connection is required.'
ms.date: 02/11/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: entra-id
ms.subservice: users
keywords:
#Customer intent: As a Microsoft Entra administrator, I want to configure the Microsoft Entra Connect Synchronization Service Manager so that users must have the appropriate encryption level to reset or change a password.
---
# Troubleshoot error code 8023062C: Insecure password reset or change

This article describes how to troubleshoot a password writeback error that occurs when Microsoft Entra Connect tries to make a password change or reset in an insecure configuration. This situation occurs specifically when Microsoft Entra Connect tries to do a password change or reset without having a 128-bit Transport Layer Security (TLS) or Secure Sockets Layer (SSL) connection.

## Symptoms

When a user or administrator tries to change or reset a password in Microsoft Entra ID, password writeback to the on-premises directory fails and returns an "8023062C (0x8023062c)" error code and the following error message:

> The password could not be set because the server is not configured for insecure setting of passwords, or a 128 bit TLS or SSL connection is required.

## Cause

[Microsoft Entra Connect](/azure/active-directory/hybrid/how-to-connect-install-roadmap) has been configured not to require that Lightweight Directory Access Protocol (LDAP) traffic be signed and encrypted.

## Solution

Make sure that the **Sign and Encrypt LDAP Traffic** setting is enabled in three places within Synchronization Service Manager by following these steps:

1. Open the Synchronization Service Manager. To do this, open the **Start** menu, go to the **Microsoft Entra Connect** group, and then select **Synchronization Service**.

1. Select the **Connectors** tab, and then select the applicable Active Directory connector. In the **Actions** pane, select **Properties**.

1. On the left side of the **Properties** dialog box, select **Connect to Active Directory Forest**, and then select the **Options** button. In the **Connection Options** dialog box, turn on **Sign and Encrypt LDAP Traffic**, and then select **OK**.

1. On the left side of the **Properties** dialog box, select **Configure Directory Partitions**. Then, in the **Configure Directory Partitions** pane, select a directory partition from the list.

1. In the **Domain controller connection settings** group, select the **Options** button. In the **Connection Options** dialog box, turn on **Sign and Encrypt LDAP Traffic**, and then select **OK**.

1. In the **Credentials** group, check whether the **Alternate credentials for this directory partition** option is selected. If that option isn't selected, go to step 8. Otherwise, select the **Set Credentials** button, and then select **Options** in the **Credentials** dialog box.

1. In the **Connection Options** dialog box, turn on **Sign and Encrypt LDAP Traffic**, and then select **OK** two times to return to the **Properties** dialog box.

1. Select **OK** to save the changes and return to Synchronization Service Manager.

1. Select **Start**, enter *services.msc*, and then select the **Services** snap-in. Select **Microsoft Azure AD Sync** from the list of services, and then select the **Restart Service** icon.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
