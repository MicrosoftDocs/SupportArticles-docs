---
title: Azure AD Hybrid Sync Agent Installation Issues - Unable to create gMSA because KDS may not be running on domain controller
description: This troubleshooting guide focuses on the situation where you're unable to install the service account after multiple retries, which may block you from successfully installing the Azure AD Connect Provisioning Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues - Unable to create gMSA because KDS may not be running on domain controller

This troubleshooting guide focuses on the situation where you're unable to install the service account after multiple retries, which may block you from successfully installing the Azure AD Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required: [Prerequisites for Azure AD Connect cloud sync](/azure/active-directory/cloud-sync/how-to-prerequisites)

## Unable to create gMSA because KDS may not be running on domain controller

While installing Cloud Provisioning Agent, you may encounter the following error:

> Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually.

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/1-agent-configuration-unable-create-gmsa.png" alt-text="Screenshot of the Microsoft Azure Active Directory Connect Provisioning Agent Configuration screen, including the error message Unable to create gMSA because KDS may not be running on domain controller. Please create/run KDS manually." border="true":::

To locate the 9001 and 9002 EventIDs, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Security - Netlogon**.

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/2-event-9001.png" alt-text="Screenshot of the Event 9001 window." border="true":::

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/3-event-9002.png" alt-text="Screenshot of the Event 9002 window." border="true":::

Use the following command to retrieve the server settings for the [supported encryption types](/windows/security/threat-protection/security-policy-settings/network-security-configure-encryption-types-allowed-for-kerberos)

```console
C:\windows\system32>reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters
    SupportedEncryptionTypes    REG_DWORD    0x7ffffff8
```

Within the command, the DWORD *0x7ffffff8* represents *AES128_HMAC_SHA1 AES256_HMAC_SHA1*.

Using 'DSA.MSC' to open the **provAgentgMSA** properties of the domain controller:

1. Select the **Attribute Editor** tab.
1. Locate the value for **msDS-SupportedEncryptionTypes**.

:::image type="content" source="media/azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller/4-provagentgmsa-properties-integer-attribute-editor.png" alt-text="Screenshot of the Agent gMSA Properties window open to the Attribute Editor tab, with the Integer Attribute Editor window on top of it." border="true":::

Verify that the encryption types offered by the server and the accepted by the account don't match.

To resolve the issue, remove the RC4 from the **provAgentgMSA** account by running the following command in a domain controller:

```console
Set-ADServiceAccount -Identity provAgentgMSA -KerberosEncryptionType AES128,AES256
```

Next, reboot the Provisioning agent server and re-install the agent.

For more information on this issue, see [Cannot install service account. The provided context did not match the target.](/archive/blogs/joelvickery/cannot-install-service-account-the-provided-context-did-not-match-the-target)
