---
title: Registry keys for smart card PIN caching options are no longer available in Windows 10
description: Describes the changes in Windows 10 regarding the registry keys for smart card PIN caching options.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-jesits, monaha
ms.custom: sap:smart-card-logon, csstroubleshoot
ms.subservice: user-profiles
---
# Registry keys for smart card PIN caching options are no longer available in Windows 10

This article describes the changes in Windows 10 regarding the registry keys for smart card PIN caching options.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4516455

## Symptoms

In Windows 10, you find that the following registry settings no longer work:

- `HKEY_LOCAL_MACHINE\SOFTWARE\GSC\Policies\PIN\Authentication\Allow`
- `HKEY_LOCAL_MACHINE\SOFTWARE\GSC\Policies\PIN\Authentication\Minutes`

> [!Note]
> These settings are described in more detail in [KB 2589130](https://support.microsoft.com/help/2589130/frequent-requests-to-enter-the-smart-card-pin-after-you-install-kb-228).

## Status

This behavior is by design.

## More information

Smart card PIN caching behavior depends on the minidriver of the smart card reader. The minidriver should implement the  PIN_CACHE_POLICY policy. At the time of PIN operation, the behavior of Smart Card BaseCSP is based on the cache policy parameters that are passed to it by the smart card minidriver.

Smart card minidriver vendors can control this behavior in their respective Smart Card Cryptographic Service Provider (CSP) or Key Storage Provider (KSP) products.

For more information, see [PIN_CACHE_POLICY_TYPE](/windows-hardware/drivers/smartcard/card-pin-operations#-pin_cache_policy_type) and [PIN_CACHE_POLICY](/windows-hardware/drivers/smartcard/card-pin-operations#-pin_cache_policy).

If the smart card implements a Personal Identity Verification (PIV) card, a third-party minidriver is not required. This is because the minidriver for PIV is included in Windows.

We have a fixed PIN caching policy for the default minidriver for a PIV card. This policy is defined as follows:

- If the container is the digital signature container (according to the PIV specification), we forcibly assign a no-pin-caching policy.
- For any other container, we forcibly assign the standard PIN policy (PIN caching is enabled).

The registry locations that are mentioned in the "Symptoms" section are relevant only to the third-party minidriver that's affected by the issue that's described in KB 2589130. These registry locations are not used for all PIV cards. The affected PIV minidriver was used in 2011. Therefore, these registry settings aren't provided by Microsoft.
