---
title: Logon type has not been granted with error code -1073741477
description: Solves the Logon type hasn't been granted error that occurs when you run a desktop flow or create a connection in Power Automate.
ms.reviewer: guco, johndund
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 08/20/2024
---
# "Logon type has not been granted" error when running a desktop flow or creating a connection

This article provides a resolution for the `-1073741477` error code that occurs when you run a desktop flow or create a desktop flow connection in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5021230

## Symptoms

When you run a desktop flow or [create a desktop flow connection](/power-automate/desktop-flows/desktop-flow-connections), you receive the following error message:

```json
{
    "error":{
        "code": "-1073741477",
        "message": "A user has requested a type of logon (for example, interactive or network) that has not been granted. An administrator has control over who can logon interactively and through the network."
    }    
}
```

## Cause

On the impacted machine, a local security policy might not allow (or might deny) the logon of the account (or a group that contains this account) used in your connection.

> [!NOTE]
> "Deny" permissions take precedence over "Allow" permissions unless specific exceptions are configured at the domain controller level.

## Resolution

To resolve the issue, ensure that the user account or group used in the connection has logon permissions, and isn't on the denied accounts list.

1. Sign in to the impacted machine preferably as an administrator.
2. Go to **Local Security Policy**.
3. Navigate to **Security Settings** > **Local Policies** > **User Rights Assignment**.

   :::image type="content" source="media/logon-type-has-ot-been-granted/user-rights-assignment.png" alt-text="Screenshot of the User Rights Assignment policy settings.":::

4. Right-click the **Allow log on locally** policy and select **Properties**.
5. Check if the group (the account belongs to) or the account itself is on the list. If not, add it to the list using **Add User or Group**.

    :::image type="content" source="media/logon-type-has-ot-been-granted/allow-log-on-locally-properties.png" alt-text="Screenshot of the group or the user account that is added to the Allow log on locally Properties.":::

6. Perform steps 4 to 5 for the following policies as well:

    - **Access this computer from the network**
    - **Allow log on through Remote Desktop Services**

7. For the following policies, check the **Properties** to verify that the group (the account belongs to) or the account itself isn't on the denied accounts list.

    - **Deny access to this computer from the network**
    - **Deny log on locally**
    - **Deny log on through Remote Desktop Services**

## More information

- [Desktop flow invalid credentials error when you use a Microsoft Entra account](troubleshoot-ui-flow-invalid-credentials-error-using-aad-account.md)
- [Invalid credentials error when running desktop flows in Power Automate for desktop](invalid-credentials-errors-running-desktop-flows.md)
