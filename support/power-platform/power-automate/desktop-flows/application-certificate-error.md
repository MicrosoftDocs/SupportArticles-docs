---
title: Could not read the application certificate when creating connection with CyberArk credential
description: Solves an error that occurs when you create a desktop flow connection using a CyberArk credential in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 10/29/2024
ms.author: quseleba 
author: QuentinSele
---
# "Could not read the application certificate" error when you create a connection using a CyberArk credential

This article provides a solution to the "Could not read the application certificate" error that occurs when you create a connection with a CyberArk credential in Power Automate.

## Symptoms

When you [create a desktop flow connection using a CyberArk credential](/power-automate/desktop-flows/desktop-flow-connections#option-1-select-credential) in Power Automate, you receive the following error message:

> Details: Connection failed: [Machine \<Machine ID>]. Connection failed: Could not read the application certificate. Try to delete and recreate the application.. Correlation id: \<Correlation ID>.

## Cause

The error message occurs because the credential used in the connection can't authenticate on the target machine you selected.

## Resolution

> [!TIP]
> To see an error message with specific details on what went wrong, first ensure you have Power Automate version 2.50 or higher installed. This method often provides enough information to solve the problem.

Here are some specific error codes and their resolutions:

- [The configuration for the cyberArk store is incorrect](#the-configuration-for-the-cyberark-store-is-incorrect)
- [Could not contact the CyberArk vault](#could-not-contact-the-cyberark-vault)
- [CyberArk object was not found or the used application does not have the permission to retrieve it](#the-cyberark-object-was-not-found-or-the-used-application-does-not-have-the-permission-to-retrieve-it)
- [The CyberArk server was unable to verify the certificate](#the-cyberark-server-was-unable-to-verify-the-certificate)
- [Could not read the application certificate](#could-not-read-the-application-certificate)

### The configuration for the cyberArk store is incorrect

> The configuration for the cyberArk store is incorrect. Validate all connection information.

#### Cause

The store is misconfigured and a valid request can't be crafted for CyberArk.

#### Resolution

Make sure the hostname for the CyberArk server follow the `https://hostname.com` or `https://hostname.com:443` format.

### Could not contact the CyberArk vault

> Could not contact the CyberArk vault. Verify connectivity to the server and validate all connection information.

#### Cause

This error occurs due to a network issue that occurs when you contact the CyberArk server.

#### Resolution

To solve this issue,

- Ensure that the connectivity to the server is available.
- Ensure that the server certificate is trusted by installing it in the [Trusted Root Certification Authorities Certificate Store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store).
- Ensure that your proxy or firewall settings don't block the connection to the server for the Power Automate service user.

### The CyberArk object was not found or the used application does not have the permission to retrieve it

> The CyberArk object was not found, or the used application does not have the permission to retrieve it.

#### Cause

The object name doesn't match a CyberArk secret that the configured application can retrieve.

#### Resolution

To solve this issue, change the object name or confirm with your CyberArk team that the application has access to the CyberArk safe that contains the object.

### The CyberArk server was unable to verify the certificate

> The CyberArk server was unable to verify the certificate, please confirm that the CyberArk server is correctly configured for SSL authentication.

#### Cause

This issue occurs due to an "APPAP330E" error that occurs when you connect or communicate with the CyberArk server.

#### Resolution

To solve this issue, see [CCP Error APPAP330E Failed to verify application authentication data: Could not obtain client certificate details](https://community.cyberark.com/s/article/CCP-Error-APPAP330E-Failed-to-verify-application-authentication-data-Could-not-obtain-client-certificate-details).

### Could not read the application certificate

> Could not read the application certificate. Try to delete and recreate the application.

#### Cause

This error message means that the CyberArk certificate can't be processed correctly. This warning often appears incorrectly for most errors with Power Automate for desktop versions before 2.50.

#### Resolution

If you use a version earlier than 2.50, try an upgrade. Otherwise, re-create the application on the target machine.

## Other troubleshooting steps

If you still don't have enough information to mitigate the issue by using the preceding resolutions, here are some steps you can take to troubleshoot the issue:

1. Try using a dedicated action to get a secret from CyberArk in Power Automate for desktop with a local run to validate your configuration.
1. Try using a browser to get the secret from the target machine with one the following methods:

    - Install the client certificate required for the application on the machine in the user store.
    - Use the following URI in your browser, and select the appropriate certificate to authenticate:

      `https://<hostname>/AIMWebService/api/Accounts?AppId=<appid>&Query=Safe=<safe>;Object=<object>`

1. If you receive a warning message indicating that the server certificate isn't trusted with one of the above methods, make sure you install the server certificate in the Trusted Root Certification Authorities Certificate Store.

1. Try changing the Power Automate for desktop service user to a user that has been successful in retrieving the secret with one of the above methods.

## More information

- [Proxy settings](/power-automate/desktop-flows/how-to/proxy-settings)
- [IP address configuration](/power-automate/ip-address-configuration)
- [Change the on-premises account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account)
- [Bypasslist element network settings](/dotnet/framework/configure-apps/file-schema/network/bypasslist-element-network-settings)
