---
title: Could not read the application certificate when creating connection with CyberArk credential
description: Solves an error that occurs when you create a desktop flow connection using a CyberArk credential in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 11/17/2024
ms.author: quseleba 
author: QuentinSele
---
# "Could not read the application certificate" error when you create a connection using a CyberArk credential

This article provides the causes and resolutions for the errors that you receive when creating a desktop flow connection using a CyberArk credential in Power Automate for desktop.

## Symptoms

When you [create a desktop flow connection using a CyberArk credential](/power-automate/desktop-flows/desktop-flow-connections#option-1-select-credential) in Power Automate for desktop, you receive the following error message:

> Details: Connection failed: [Machine \<Machine ID>]. Connection failed: Could not read the application certificate. Try to delete and recreate the application.. Correlation id: \<Correlation ID>.

## Cause

The error message occurs because the credential used in the connection can't be authenticated on the target machine you selected.

## Resolution

If you use [Power Automate for desktop installer version](/power-platform/released-versions/power-automate-desktop#all-power-automate-desktop-versions) earlier than 2.50, you can upgrade to version 2.50 or later. After the upgrade, when you create a desktop flow connection using a CyberArk credential, you might see an error message with specific details on what went wrong. The details will give you enough information to solve the problem.

Check the following sections for some specific error messages and their resolutions:

## "The configuration for the cyberArk store is incorrect. Validate all connection information."

This error occurs because the CyberArk store is misconfigured, and a valid request can't be made for CyberArk.

To solve this issue, make sure that the configuration settings in Power Automate match those in CyberArk, including the server address and the application ID. For example, the hostname of the CyberArk server should follow the `https://hostname.com` or `https://hostname.com:443` format. For more information, see [Create a CyberArk credential](/power-automate/desktop-flows/create-cyberark-credential#create-a-cyberark-credential-1).

## "Could not contact the CyberArk vault. Verify connectivity to the server and validate all connection information."

This error occurs due to issues with network connectivity between your machine and the CyberArk server.

To solve this issue:

- Confirm that your machine can communicate with the CyberArk server.
- Ensure that the server certificate is trusted by installing it in the [Trusted Root Certification Authorities Certificate Store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store).
- Ensure that your proxy or firewall settings don't block Power Automate service users from connecting to the server. For more information, see [Configure Power Automate for desktop proxy settings](/power-automate/desktop-flows/how-to/proxy-settings).

## "The CyberArk object was not found, or the used application does not have the permission to retrieve it."

This error occurs because the object name doesn't match a CyberArk secret that the configured application can retrieve.

To solve this issue,

1. Use the [Get accounts API](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/getaccounts.htm?tocpath=Developer%7CREST%20APIs%7CAccounts%7C_____1) to get a list of all the accounts in the Vault.
1. If no account name matches the object name, update the object name with an existing account, or confirm with your CyberArk team that the application has access to the CyberArk safe that contains the object.

## "The CyberArk server was unable to verify the certificate, please confirm that the CyberArk server is correctly configured for SSL authentication."

This issue occurs because the CyberArk Central Credential Provider (CCP) might not be correctly set up or configured.

To solve this issue, see [CCP Error APPAP330E Failed to verify application authentication data: Could not obtain client certificate details](https://community.cyberark.com/s/article/CCP-Error-APPAP330E-Failed-to-verify-application-authentication-data-Could-not-obtain-client-certificate-details).

## "Could not read the application certificate. Try to delete and recreate the application."

This error message means that the CyberArk certificate can't be processed correctly. The application certificate might be missing, corrupted, or incorrectly installed.

This message often appears incorrectly for most errors with Power Automate for desktop versions before 2.50. If you're using a version earlier than 2.50, try an upgrade.

Otherwise, [delete](https://docs.cyberark.com/identity/latest/en/content/applications/appsadminportal/appremove.htm) and [re-create](https://docs.cyberark.com/credential-providers/13.0/en/content/common/adding-applications.htm) the application in CyberArk as suggested in the error message. Ensure that you correctly enter the **Application ID**, **Safe**, **Folder**, and **Object** details when [setting up the connection](/power-automate/desktop-flows/create-cyberark-credential#create-a-cyberark-credential-1).

## Other troubleshooting steps

If you still don't have enough information to mitigate the issue, here are some steps you can take to troubleshoot the issue:

1. Try using a dedicated action to get a secret from CyberArk in Power Automate for desktop with a local run to validate your configuration.
1. Try using a browser to get the secret from the target machine with one of the following methods:

    - Install the client certificate required for the application on the machine in the user store.
    - Use the following URI in your browser, and select the appropriate certificate to authenticate:

      `https://<hostname>/AIMWebService/api/Accounts?AppId=<appid>&Query=Safe=<safe>;Object=<object>`

1. If you receive a warning message indicating that the server certificate isn't trusted with one of the methods in step 2, make sure you install the server certificate in the [Trusted Root Certification Authorities Certificate Store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store).

1. Try [changing the Power Automate for desktop service user](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) to a user who has successfully retrieved the secret with one of the methods in step 2.

## More information

- [Create a CyberArk credential](/power-automate/desktop-flows/create-cyberark-credential)
- [Configure Power Automate for desktop proxy settings](/power-automate/desktop-flows/how-to/proxy-settings)
- [Power Automate IP address configuration](/power-automate/ip-address-configuration)
- [Change the on-premises Service account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account)
- [\<Bypasslist> element (network settings)](/dotnet/framework/configure-apps/file-schema/network/bypasslist-element-network-settings)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
