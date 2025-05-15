---
title: Could Not Establish Trust Relationship for the SSL or TLS Secure Channel
description: Provides a workaround to allow users with invalid certificates to use certain actions in Power Automate for desktop.
ms.reviewer: nimoutzo
ms.date: 05/15/2025
ms.custom: sap:Desktop flows\PAD Runtime - Action execution (not browser or UI)
---
# "Could not establish trust relationship for the SSL/TLS secure channel" error

This article provides a workaround for resolving the "Could not establish trust relationship for the SSL/TLS secure channel" error in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate for desktop version 2.35 or later  

## Symptoms

Actions in Power Automate for desktop, like [Invoke web service](/power-automate/desktop-flows/actions-reference/web#invokewebservicebase), or [Get password from CyberArk](/power-automate/desktop-flows/actions-reference/cyberark#getpasswordbase), might fail during runtime with the following error:

> System.Net.Http.HttpRequestException: An error occurred while sending the request. ---> System.Net.WebException: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.

In some cases, the issue might occur when a network traffic inspection tool, such as Fiddler, is installed on the computer.

## Cause

Power Automate for desktop validates the status of HTTPS certificates to check their validity, including whether they're revoked or invalid. This error might occur under the following conditions:

1. A certificate in the chain has been revoked or marked as invalid.

2. Companies that use package inspection to audit their network infrastructure might not allow users to sign in, as their Certificate Revocation List (CRL) might not have been defined or is unreachable.

3. Tools like Fiddler might install a self-signed certificate on the system with an Unknown revocation status. In such cases, if the [CertificateRevocationCheck](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-check-for-revoked-certificates) registry key is set to **Comprehensive**, Power Automate for desktop will reject the certificate and the error will be generated.

## Workaround

Administrators can allow users with invalid certificates to use these actions by following the steps in [Configure Power Automate for desktop to check for revoked certificates](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-check-for-revoked-certificates).
