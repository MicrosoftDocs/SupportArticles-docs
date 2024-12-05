---
title: Group Policy objects to Terminal Services
description: Explains how to apply Group Policy objects to Terminal Services servers without adversely affecting other servers on the network.
ms.date: 12/05/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shamilprem, santoshk
ms.custom: sap:Group Policy\Applocker or software restriction policies, csstroubleshoot
---
# How to apply Group Policy objects to Terminal Services servers

This article describes how to apply Group Policy objects to Terminal Services servers.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 260370

## Summary

When the Terminal Services servers are in an Active Directory domain, the domain administrator implements Group Policy objects (GPOs) to the Terminal Services server to control the user environment. This article describes the recommended process of applying GPOs to Terminal Services without adversely affecting other servers on the network.

## More information

There are two methods for applying GPOs to Terminal Services without adversely affecting other servers on the network.

### Method 1

Put the Terminal Server computers into their own organizational unit (OU). This configuration permits relevant computer configuration settings to be put in GPOs that apply only to Terminal Server computers. This configuration does not affect the user experience on workstations or on other servers and lets you create a tightly controlled Terminal Server experience for users. This OU should not contain users or other computers so that domain administrators can fine-tune the Terminal Services experience. The OU can also be delegated for control to subordinate groups such as server operators or individual users.

To create a new OU for the Terminal Services servers, follow these steps:

1. Sign in to a domain controller or a machine with the Remote Server Administration Tools (RSAT) installed.
2. Open the Start menu and enter **Active Directory Users and Computers**. Select **Active Directory Users and Computers** to open it.
3. In the **Active Directory Users and Computers** console, navigate to the domain or container where you want to create the new OU.
4. Right-click the domain or container. Select **New** > **Organizational Unit**.
5. In the **New Object - Organizational Unit** dialog box, enter **Terminal Servers** as the name.
6. Select **OK** to create the OU.  

To create a Terminal Services Group Policy object, follow these steps:

1. Open the Start menu and enter **Group Policy Management**. Select **Group Policy Management** to open it.
2. In the **Group Policy Management** console, navigate to your domain.
3. Right-click the **Group Policy Objects** container and select **New**.
4. Enter a name for the new GPO, such as **Terminal Servers Policy**.
5. Select **OK** to create the GPO.
6. Right-click the newly created GPO and select **Edit** to open the **Group Policy Management Editor** where you can configure the policy settings as needed.
7. In the **Group Policy Management** console, navigate to the **Terminal Servers** OU.
8. Right-click the **Terminal Servers** OU and select **Link an Existing GPO**.
9. In the **Select GPO** dialog box, select **Terminal Servers Policy** from the list.
10. Select **OK** to link the GPO to the OU.

> [!NOTE]
> Most of the relevant settings are under **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies**. For example, under **User Rights Assignment** in the list on the right, you find **Log on locally**. This setting is required for logging on to a session on Terminal Services. You also find **Access this computer from the network**. This setting is required to connect to the server outside a Terminal Services session. This is also where you can prevent users from being able to shut down the system. Settings for the user part of the policy should not be applied here because the users have not been put into this OU with the Terminal Services server. This article is written for computer policy implementation.  
When modifications are completed, close the Group Policy Management editor, and then click Close to close OU Properties.

### Method 2

Use the Group Policy loopback feature to apply User Configuration GPO settings to users only when they log on to the Terminal Servers. When GPO Loopback processing is enabled for the computers in an OU that contains only Terminal Servers, those computers apply the User Configuration settings from the set of GPOs that apply to that OU. Additionally, those computers apply the User Configuration settings from GPOs that are linked to or inherited by the OU that contains the user's account.

This implementation is described in [Loopback processing of Group Policy](loopback-processing-of-group-policy.md).

When it is possible, Terminal Services should be installed on member servers instead of on domain controllers because the users need Log on Locally user rights. When the Logon Locally right is assigned to domain controllers, it is assigned to every domain controller in the domain because of the shared Active Directory database. By default, member servers are granted Log on Locally user rights in the Local Security Policy.

For more information, see [Local policy doesn't permit you to log on interactively](../remote/local-policy-not-permit-log-on-interactively.md).

The computer account of the terminal server should be added to the security properties of the GPO being created for the loopback. To do it, follow these steps:  

1. Select the GPO that is created for the loopback, and then select **Properties**.
2. Select the **Security** tab, and then select **Add**.
3. In the **Select Users, Computers, or Groups** box, select the computer account, and then select **OK**.
4. Select the computer account from the **Group or user names** box.
5. In the **Permissions for computer name** box, select the **Read** and **Apply Group Policy** check boxes in the **Allow** column.
6. Select **OK** two times to close and save the policy settings.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
