---
title: Can't register a Mac client
description: Fixes an issue in which a Mac client fails to register in System Center Configuration Manager SP1.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Mac client registration fails in System Center 2012 Configuration Manager SP1

This article helps you fix an issue in which you can't register a Mac client in System Center 2012 Configuration Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; System Center 2012 Configuration Manager SP1  
_Original KB number:_ &nbsp; 2806021

## Symptoms

When you try to register a Mac client in System Center 2012 Configuration Manager SP1, the registration process fails. When you check the MP_RegistrationManager log in this situation, you see the following error:

> The certificate chain processed correctly but terminated in a root certificate not trusted per ConfigMgr CTL.

## Cause

This behavior occurs if Internet Information Services (IIS) client authentication validation has passed, but the root of the client certificate that's used by the Mac client to register is not in the management point's trusted root certification authority (CA) list.

## Resolution

To resolve this issue, update the **Trusted Root Certification Authorities** list on the **Client Computer Communication** tab in the **Site Properties** dialog box to include the issuer of the public key infrastructure (PKI) certificate. System Center 2012 Configuration Manager SP1 uses this list of trusted certificate authorities as the basis for its trusted issuer list. For example, if Mac clients have PKI certificates that are issued by the corporate root _CA1_, add or import _CA1_ to the list as one of the trusted issuers.

This issue is also documented at [Planning for Security in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg712284(v=technet.10)?redirectedfrom=MSDN).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
