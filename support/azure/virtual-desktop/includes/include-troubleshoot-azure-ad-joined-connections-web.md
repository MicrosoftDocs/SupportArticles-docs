---
author: dknappettmsft
ms.author: daknappe
ms.topic: include
ms.date: 11/21/2022
---

### Sign in failed. Please check your username and password and try again

If you come across the following error when using the web client:

> Oops, we couldn't connect to *NAME*. Sign in failed. Please check your username and password and try again.

Ensure that you [enabled connections from other clients](/azure/virtual-desktop/deploy-azure-ad-joined-vm#connect-using-the-other-clients).

### We couldn't connect to the remote PC because of a security error

If you come across an error:

> Oops, we couldn't connect to *NAME*. We couldn't connect to the remote PC because of a security error. If this keeps happening, ask your admin or tech support for help.

You have Conditional Access policies restricting access. Follow the instructions in [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms) to enforce Microsoft Entra multifactor authentication for your Microsoft Entra joined VMs.
