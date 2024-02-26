---
title: Changes to GPO permissions through AGPM aren't saved
description: Describes an issue that blocks you from changing Group Policy object permissions in Advanced Group Policy Management (AGPM). A workaround is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lindakup, arrenc, ajayps, dnats, herbertm
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Changes to Group Policy object permissions through AGPM are ignored

This article provides a workaround for an issue where changes to Group Policy object permissions that's controlled in Advanced Group Policy Management (AGPM) aren't saved as expected.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3174540

## Symptoms

To change permissions on a Group Policy object that's controlled in AGPM, you first check out the policy in AGPM, and then you edit the permissions on the **Security** tab of the policy object. For example, you add the Read only permission to Authenticated Users. However, after you check in the policy to save your changes, and then you view the **Security** tab on the policy, you see that your changes are not saved as expected.

## Cause

This behavior is by design in AGPM 4.0 Service Pack 3 (SP3) and earlier versions. To add permissions to newly created Group Policy objects, we recommend to that you use the **Production Delegation** tab in AGPM.

## Workaround

To work around this issue, follow these steps:

1. Install the [Microsoft Desktop Optimization Pack March 2017 Servicing Release](https://www.microsoft.com/download/details.aspx?id=54967) on the AGPM server.
2. Set the following registry key and values on the AGPM server.

    - Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Agpm`
    - Value name: OverrideRemovePermissionsWithoutReadAndApply
    - Value type: String REG_SZ
    - Value data: 1

3. Restart the AGPM server.

If OverrideRemovePermissionsWithoutReadandApply is set to **1**, read permissions are saved after the policy is checked in to AGPM, but write permissions are removed.

If OverrideRemovePermissionsWithoutReadAndApply is not set or is set to any value other than **1**, AGPM behaves in the way that's described in the [Symptoms](#symptoms) section.

## References

- [Step-by-Step Guide for Microsoft Advanced Group Policy Management 4.0](/microsoft-desktop-optimization-pack/agpm/step-by-step-guide-for-microsoft-advanced-group-policy-management-40)
- [Overview Series: Advanced Group Policy Management](/previous-versions/windows/it-pro/windows-vista/cc749396(v=ws.10))
- [Operations guide for Microsoft AGPM 4.0](/microsoft-desktop-optimization-pack/agpm/operations-guide-for-microsoft-advanced-group-policy-management-40)
