---
title: Connection using CyberArk credentials failed with "Could not read the application certificate".
description: Provides troubleshooting steps for error code that occurs during the creation a connection with CyberArk credential in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 10/29/2024
ms.author: quseleba 
author: QuentinSele
---
# Connection using CyberArk failed: Could not read the application certificate

This article provides a solution to the error “could not read the application certificate error” that occurs when you create a connection with a CyberArk credential in Power Automate.

## Symptoms

When you create a desktop flow connection using a CyberArk credential from the Power Automate portal, you receive the following error message:
Details: Connection failed: [Machine \<Machine ID>]. Connection failed: Could not read the application certificate. Try to delete and recreate the application.. Correlation id: \<Correlation ID>.

## Cause

The error messages occur because the credentials in the connection can't authenticate on the target machine you selected.

## Resolution

To see an error message with specific details on what went wrong, first ensure you have Power Automate version 2.50 or higher installed. Often, this method gives you enough information to solve the problem. The following table shows some specific error codes and the resolutions.

### Incorrect CyberArk Configuration

- The configuration for the cyberArk store is incorrect. Validate all connection information.
- *Cause*: The store is misconfigured, and we were unable to craft a valid request for CyberArk.
- *Resolution*: make sure the hostname for the CyberArk server is following this format: “https://hostname.com” or “https://hostname.com:443”

### Unable to contact CyberArk Vault

- Could not contact the CyberArk vault. Verify connectivity to the server and validate all connection information.
- *Cause*: There was a network issue when contacting the CyberArk server
- Resolution:
    1. Make sure connectivity is available toward the server
    1. Make sure the server certificate is trusted by installing it in the Trusted Root Certification Authorities Certificate Store.
    1. Make sure your proxy or firewall configuration doesn’t prevent connection toward the server for the Power Automate service User. 

### CyberArk object not found

- The CyberArk object was not found, or the used application does not have the permission to retrieve it.
- *Cause*: The object name did not match a secret that the configured application can retrieve
- *Resolution*: Either change the object name or make sure with your CyberArk team that the application has access to the safe containing this object.

### CyberArk server failing SSL Authentication

- The CyberArk server was unable to verify the certificate, please confirm that the CyberArk server is correctly configured for SSL authentication.
- *Cause*: We received the following error code when reaching out to CyberArk: “APPAP330E”
- *Resolution*: Follow this [article](https://community.cyberark.com/s/article/CCP-Error-APPAP330E-Failed-to-verify-application-authentication-data-Could-not-obtain-client-certificate-details) for the CyberArk server

### Incorrect certificate for Machine Application

- Could not read the application certificate. Try to delete and recreate the application.
- *Cause*: We were unable to process the CyberArk certificate correctly. Warning this message appears erroneously for most error with Power Automate for Desktop prior to versions 2.50
- *Resolution*: If you are below versions 2.50 Attempting an upgrade and retrying could provide more information for resolution. Otherwise re-create the application on the target machine

If you don't have enough information to correctly mitigate the issue from the above table here are some steps you can take to troubleshoot the issue.

1. Attempt to use the dedicated action to get a secret from CyberArk in Power Automate for Desktop with a local run to validate your configuration
1. Attempt to use a browser to get the secret from the target machine:
    - Install the client certificate required for the application on the machine in the user store.
    - Use the following Uri in your browser, and select the appropriate certificate to authenticate: https://\<hostname>/AIMWebService/api/Accounts?AppId=\<appid>&Query=Safe=\<safe>;Object=\<object>
1. If you get a warning indicating that the server certificate is not trusted with one of the above methods, make sure you install the server certificate in the Trusted Root Certification Authorities Certificate Store.
1. Attempt to change the Power Automate for Desktop Service user to a user that has been successful in retrieving the secret with one of the above methods.

### Addition links

1. [Proxy settings](/power-automate/desktop-flows/how-to/proxy-settings)
2. [IP address configuration](/power-automate/ip-address-configuration)
3. [Change the on-premise account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account)
4. [Bypasslist element network settings](/dotnet/framework/configure-apps/file-schema/network/bypasslist-element-network-settings)
