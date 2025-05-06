---
title: Cannot establish trust relationship for the SSL/TLS secure channel
description: Provides a resolution for the error in Power Automate for desktop, stating that you can't establish a trust relationship for the SSL/TLS secure channel.
ms.reviewer: nimoutzo
ms.date: 05/05/2025
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Cannot establish trust relationship for the SSL/TLS secure channel

This article provides a resolution for the error in Power Automate for desktop, stating that you can't establish a trust relationship for the SSL/TLS secure channel.

_Applies to:_ &nbsp; Power Automate  

## Symptoms
- An action in Power Automate for desktop, such as 'Invoke web service' or 'Get password from CyberArk', fails at runtime with the following error:
  - "System.Net.Http.HttpRequestException: An error occurred while sending the request. ---> System.Net.WebException: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel."
- In some cases, it is observed that a tool to inspect network traffic (e.g., Fiddler) may be installed on the computer.

## Applies to
PAD v2.35 or higher

## Cause
Power Automate for desktop (PAD) checks whether "https" certificates are revoked or invalid. If a certificate in the chain is revoked or invalid, an error message appears. 

Companies that use package inspection to audit their network infrastructure may not allow users to sign in, as their Certificate Revocation List (CRL) may not have been defined or is unreachable. 

If Fiddler or a similar tool is installed, it may also install a self-signed certificate whose revocation status is "Unknown". Therefore, the error message is displayed if the relevant registry key is set to "Comprehensive".

## Workaround
To allow users with invalid certificates to use that action, follow the instructions [here.](https://learn.microsoft.com/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-check-for-revoked-certificates)
