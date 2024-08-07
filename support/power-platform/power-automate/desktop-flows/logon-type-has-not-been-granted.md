---
title: Logon type has not been granted with error code -1073741477
description: Solves the Logon type has not been granted error that occurs when you run a desktop flow or create a connection in Power Automate.
ms.reviewer: guco, johndund
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 08/07/2024
---
# "Logon type has not been granted" error that occurs when running a desktop flow or creating a connection

This article provides a resolution for the `-1073741477` error code that occurs when you run a desktop flow or create a desktop flow connection in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5021230

## Symptoms

Desktop flow execution or [creating a desktop flow connection](/power-automate/desktop-flows/desktop-flow-connections) fails with the following error message:

```json
{
    "error":{
        "code": "-1073741477",
        "message": "A user has requested a type of logon (e.g., interactive or network) that has not been granted. An administrator has control over who may logon interactively and through the network."
    }    
}
```

## Cause

On the impacted machine, the account used in your connection (or a group including this account) might not be allowed to sign in by a local security policy or might be denied.

> [!NOTE]
> The "deny permissions" take precedence over the "allowed permissions" unless specific exceptions are configured at domain controller level.

## Resolution

1. Sign in to the impacted machine preferably as an administrator.
2. Go to **Local Security Policy**.
3. Navigate to **Security Settings** > **Local Policies** > **User Rights Assignment**.

   :::image type="content" source="media/logon-type-has-ot-been-granted/user-rights-assignment.png" alt-text="Screenshot of the User Rights Assignment policy settings.":::

4. For the following policies, verify that the group (that the used account is a part of) or the user account itself is added to the list.

    - **Access this computer from the network**
    - **Allow log on locally**
    - **Allow log on through Remote Desktop Services**

    :::image type="content" source="media/logon-type-has-ot-been-granted/allow-log-on-locally-properties.png" alt-text="Screenshot of the group or the user account that's added to the Allow log on locally Properties.":::

5. For the following policies, verify that the group (that the used account is a part of) or the used account itself isn't in the list of denied accounts.

    - **Deny access this computer from the network**
    - **Deny log on locally**
    - **Deny log on through Remote Desktop Services**
