---
title: Group Policy objects to Terminal Services
description: Explains how to apply Group Policy objects to Terminal Services servers without adversely affecting other servers on the network.
ms.date: 11/13/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shamilprem
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

1. __Log in__ to a domain controller or a machine with the __Remote Server Administration Tools (RSAT)__ installed.

1. __Open__ the __Start Menu__ and type __"Active Directory Users and Computers"__. Click on it to open.

1. In the __Active Directory Users and Computers__ console, navigate to the domain or container where you want to create the new OU.

1. __Right-click__ on the domain or container.

1. Select __New__ > __Organizational Unit__.

1. In the __New Object - Organizational Unit__ dialog box, enter __"Terminal Servers"__ as the name.

1. Click __OK__ to create the OU.  

To create a Terminal Services Group Policy object, follow these steps:

1. __Open__ the __Start Menu__ and type __"Group Policy Management"__. Click on it to open.

1. In the __Group Policy Management__ console, navigate to your domain.

1. __Right-click__ on the __Group Policy Objects__ container and select __New__.

1. Enter a name for the new GPO, such as __"Terminal Servers Policy"__.

1. Click __OK__ to create the GPO.

1. __Right-click__ on the newly created GPO and select __Edit__.

1. This will open the __Group Policy Management Editor__ where you can configure the policy settings as needed.

1. In the __Group Policy Management__ console, navigate to the __"Terminal Servers"__ OU.

1. __Right-click__ on the __"Terminal Servers"__ OU and select __Link an Existing GPO__.

1. In the __Select GPO__ dialog box, choose __"Terminal Servers Policy"__ from the list.

1. Click __OK__ to link the GPO to the OU.

> [!NOTE]
> Most of the relevant settings are under Computer Configuration , Security Settings , or Local Policies . For example, under User Rights Assignment in the list on the right, you find **Log on Locally**. This setting is required for logging on to a session on Terminal Services. You also find **Access this computer from the network**. This setting is required to connect to the server outside a Terminal Services session. This is also where you can prevent users from being able to shut down the system. Settings for the user part of the policy should not be applied here because the users have not been put into this OU with the Terminal Services server. This article is written for computer policy implementation.  
When modifications are completed, close the Group Policy Management editor, and then click Close to close OU Properties.

### Method 2

Use the Group Policy loopback feature to apply User Configuration GPO settings to users only when they log on to the Terminal Servers. When GPO Loopback processing is enabled for the computers in an OU that contains only Terminal Servers, those computers apply the User Configuration settings from the set of GPOs that apply to that OU. Additionally, those computers apply the User Configuration settings from GPOs that are linked to or inherited by the OU that contains the user's account.

This implementation is described in the following article:  
[Loopback processing of Group Policy](/troubleshoot/windows-server/group-policy/loopback-processing-of-group-policy) 

When it is possible, Terminal Services should be installed on member servers instead of on domain controllers because the users need Log on Locally user rights. When the Logon Locally right is assigned to domain controllers, it is assigned to every domain controller in the domain because of the shared Active Directory database. By default, member servers are granted Log on Locally user rights in the Local Security Policy.

For additional information, click the following article number to view the article:

[Local policy doesn't permit you to log on interactively](/troubleshoot/windows-server/remote/local-policy-not-permit-log-on-interactively)

The computer account of the terminal server should be added to the security properties of the GPO being created for the loopback. To do it, follow these steps:  

1. Select the GPO that is created for the loopback, and then click **Properties**.
2. Click the **Security** tab, and then click **Add**.
3. In the **Select Users, Computers, or Groups** box, select the computer account, and then click **OK**.
4. Click the computer account from the **Group or user names** box.
5. In the **Permissions for computer name** box, click to select the **Read** and **Apply Group Policy** check boxes in the **Allow** column.
6. Click OK two times to close and save the policy settings.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
