---
title: Group Policy objects to Remote Desktop Services
description: Explains how to apply Group Policy objects to Remote Desktop Services servers without adversely affecting other servers on the network.
ms.date: 12/09/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shamilprem, santoshk, herbertm
ms.custom: sap:Group Policy\Applocker or software restriction policies, csstroubleshoot
---
# How to apply Group Policy objects to Remote Desktop Services servers

This article describes how to apply Group Policy objects to Remote Desktop Services (RDS) servers.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 260370

## Summary

When the Remote Desktop Services servers are in an Active Directory domain, the domain administrator implements Group Policy objects (GPOs) to the Remote Desktop Services server to control the user environment. This article describes the recommended process of applying GPOs to Remote Desktop Services without adversely affecting other servers on the network.

There are different approaches to applying GPOs to Remote Desktop Services, depending on whether the settings are for computers or users.

## Computer policy settings

Put the Remote Desktop Services computers into their own organizational unit (OU). This configuration permits relevant computer configuration settings to be put in GPOs that apply only to Remote Desktop Services computers. This configuration doesn't affect the user experience on workstations or on other servers and lets you create a tightly controlled Remote Desktop Services experience for users. This OU shouldn't contain users or other computers so that domain administrators can fine-tune the Remote Desktop Services experience. The OU can also be delegated for control to subordinate groups such as server operators or individual users.

Consider the following options for the location of the new OU:

- Place the new OU as a child OU where the RDS servers are located. This ensures the current group policies are applied as before. This option works best when most or all of the RDS server computer accounts are in this parent OU.
- Alternatively, if it better fits your administration model, create the new OU as a sibling OU of the current OU that contains most or all of the RDS server computer objects. In this case, you will need to link all policies of the existing OUs to the new OU as well.

For more information, see [Linking GPOs to Active Directory Containers](/previous-versions/windows/desktop/Policy/linking-gpos-to-active-directory-containers).

To create a new OU for the Remote Desktop Services servers, follow these steps:

1. Sign in to a domain controller (DC) or a machine with the Remote Server Administration Tools (RSAT) installed.
2. Open the Start menu and enter **Active Directory Users and Computers**. Select **Active Directory Users and Computers** to open it.
3. In the **Active Directory Users and Computers** console, navigate to the domain or container where you want to create the new OU.
4. Right-click the domain or container. Select **New** > **Organizational Unit**.
5. In the **New Object - Organizational Unit** dialog, enter **Remote Desktop Services servers** as the name of the new OU.
6. Select **OK** to create the OU.  

To create a Remote Desktop Services Group Policy object, follow these steps:

1. Open the Start menu and enter **Group Policy Management**. Select **Group Policy Management** to open it.
2. In the **Group Policy Management** console, navigate to your domain.
3. Right-click the **Group Policy Objects** container and select **New**.
4. Enter a name for the new GPO, such as **Remote Desktop Services servers Policy**.
5. Select **OK** to create the GPO.
6. Right-click the newly created GPO and select **Edit** to open the **Group Policy Management Editor**, where you can configure the policy settings as needed.
7. In the **Group Policy Management** console, navigate to the **Remote Desktop Services servers** OU.
8. Right-click the **Remote Desktop Services servers** OU and select **Link an Existing GPO**.
9. In the **Select GPO** dialog, select **Remote Desktop Services servers Policy** from the list.
10. Select **OK** to link the GPO to the OU.

> [!NOTE]
> Most of the relevant settings are under **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies**. For example, under **User Rights Assignment** in the list on the right, you find **Log on locally**. This setting is required for logging on to a session on Remote Desktop Services. You also find **Access this computer from the network**. This setting is required to connect to the server outside a Remote Desktop Services session. This is also where you can prevent users from being able to shut down the system. Settings for the user part of the policy shouldn't be applied here because the users have not been put into this OU with the Remote Desktop Services server. This article is written for computer policy implementation.  
When modifications are completed, close the Group Policy Management Editor, and then select **Close** to close **OU Properties**.

## User policy settings

Use the Group Policy loopback feature to apply User Configuration GPO settings to users only when they log on to the Remote Desktop Services servers. When GPO Loopback processing is enabled for the computers in an OU that contains only Remote Desktop Services servers, those computers apply the User Configuration GPO settings from the set of GPOs that apply to that OU. When you use the [loopback policy setting](/windows-server/identity/ad-ds/manage/group-policy/group-policy-processing#loopback-processing-mode) in Merge mode, the computer first applies the User Configuration GPO settings from the GPOs linked to or inherited by the OU containing the user's account, followed by processing the user part of the computer policies.

This implementation is described in [Loopback processing of Group Policy](loopback-processing-of-group-policy.md).

We strongly recommend against using Remote Desktop Services on DCs for the following reasons:

- The deployment would require non-domain admins to log on to DCs, conflicting with the security sensitivity of DCs. Only domain admins should have the "Log on locally" right on DCs.
- If users work on DCs as RDS servers, a security vulnerability elevating an attacker to LocalSystem would instantly grant the attacker access to the whole forest.

For more information, see [Local policy doesn't permit you to log on interactively](../remote/local-policy-not-permit-log-on-interactively.md).

The computer account of the Remote Desktop Services server should be added to the security properties of the GPO being created for the loopback. To do it, follow these steps:  

1. Select the GPO that is created for the loopback, and then select **Properties**.
2. Select the **Security** tab, and then select **Add**.
3. In the **Select Users, Computers, or Groups** box, select the computer account, and then select **OK**.
4. Select the computer account from the **Group or user names** box.
5. In the **Permissions for computer name** box, select the **Read** and **Apply Group Policy** checkboxes in the **Allow** column.
6. Select **OK** two times to close and save the policy settings.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
