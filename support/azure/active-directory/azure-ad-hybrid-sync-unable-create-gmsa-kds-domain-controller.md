---
title: Microsoft Entra Hybrid Sync Agent Installation Issues - Unable to create gMSA because KDS may not be running on domain controller
description: This troubleshooting guide focuses on when you repeatedly can't install the service account. It unblocks you to install the Microsoft Entra Connect Provisioning Agent.
ms.date: 10/13/2021
ms.service: active-directory
ms.subservice: hybrid
---

# Microsoft Entra Hybrid Sync Agent Installation Issues - Unable to create gMSA because KDS may not be running on domain controller

This troubleshooting guide focuses on when you can't install the service account after many retries. This situation blocks you from installing the Microsoft Entra Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required: [Prerequisites for Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/how-to-prerequisites).

## Unable to create gMSA because KDS may not be running on domain controller

While installing Cloud Provisioning Agent, you may get the following error:

> Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually.


To locate the 9001 and 9002 EventIDs, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Security - Netlogon**.

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/2-event-9001.png" alt-text="Screenshot of the Event 9001 window. You can't use the account as an M S A locally, because the machine doesn't support all account encryption types." border="true" lightbox="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/2-event-9001.png":::

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/3-event-9002.png" alt-text="Screenshot of the Event 9002 window. Netlogon couldn't add the account as a managed service account (M S A) to the local machine." border="true":::

Use the following command to retrieve the server settings for the [supported encryption types](/windows/security/threat-protection/security-policy-settings/network-security-configure-encryption-types-allowed-for-kerberos):

```console
C:\windows\system32>reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters
    SupportedEncryptionTypes    REG_DWORD    0x7ffffff8
```

Within the command, the DWORD *0x7ffffff8* represents *AES128_HMAC_SHA1 AES256_HMAC_SHA1*.

In the Active Directory Users and Computers snap-in (*dsa.msc*), open the **provAgentgMSA** properties of the domain controller:

1. Select the **Attribute Editor** tab.
1. Choose the **msDS-SupportedEncryptionTypes** attribute, and select **Edit**.

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/4-provagentgmsa-properties-integer-attribute-editor.png" alt-text="Screenshot of the provisioning agent g M S A properties dialog box, Attribute Editor tab. The Integer Attribute Editor dialog box is on top." border="true":::

Verify that there's a mismatch between the encryption types that the server offers and that the accounts accept.

To resolve the issue, remove the RC4 from the **provAgentgMSA** account by running the following command in a domain controller:

```console
Set-ADServiceAccount -Identity provAgentgMSA -KerberosEncryptionType AES128,AES256
```

Next, reboot the Provisioning agent server and reinstall the agent.

For more information on this issue, see [Cannot install service account. The provided context did not match the target.](/archive/blogs/joelvickery/cannot-install-service-account-the-provided-context-did-not-match-the-target)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
