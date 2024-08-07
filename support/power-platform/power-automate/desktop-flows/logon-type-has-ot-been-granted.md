---
title: Logon type has not been granted
description: Provides a resolution to the invalid credentials errors that might occur when you run a desktop flow in Power Automate.
ms.reviewer: guco, johndund
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 08/07/2024
---
# Logon type has not been granted

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5021230

## Symptoms

Desktop flow **execution** or **connection creation is failing with** the error status code **-1073741477** and message: A user has requested **a type of logon** (e.g., interactive or network) that **has not been granted**. An administrator has control over who may logon interactively and through the network.

## Cause

On the impacted machine(s), **the account used** in your connection (or a group including this account) **may not be allowed to logon** by a local security policy **or may be denied**.

## Note

**Deny permissions take precedence over the Allowed permissions** unless specific exceptions are configured at domain controller level.

## Resolution

**Logon to the** impacted **machine** (preferably **as an admin**)

- Go to **Local Security Policy**
- Navigate to **Security Settings** -> **Local Policies** -> **User Rights Assignment**

:::image type="content" source="media/logon-type-has-ot-been-granted/user-rights-assignment.png" alt-text="Screenshot of the User Rights Assignment policy settings.":::

For the following policies please verify that either the group (that the used account is a part of) or the user account itself is added to the list

- Access this computer **from Network**
- Allow log on **locally**
- Allow log on **through Remote Desktop Services**

:::image type="content" source="media/logon-type-has-ot-been-granted/allow-log-on-locally-properties.png" alt-text="Screenshot of the group or the user acocunt that's added to the Allow log on locally Properties.":::

For the following policies please verify that either the group (that the used account is a part of) or the used account itself is NOT in the list of denied accounts

- Deny access this computer **from Network**
- Deny log on **locally**
- Deny log on **through Remote Desktop Services**
