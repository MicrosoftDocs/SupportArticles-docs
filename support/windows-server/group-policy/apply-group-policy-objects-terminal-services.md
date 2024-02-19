---
title: Group Policy objects to Terminal Services
description: Explains how to apply Group Policy objects to Terminal Services servers without adversely affecting other servers on the network.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applocker-or-software-restriction-policies, csstroubleshoot
---
# How to apply Group Policy objects to Terminal Services servers

This article describes how to apply Group Policy objects to Terminal Services servers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 260370

## Summary

Microsoft Windows Server 2003 Terminal Services servers and Microsoft Windows 2000 Terminal Services servers are installed for users in Application Server mode. When the Terminal Services servers are in an Active Directory domain, the domain administrator implements Group Policy objects (GPOs) to the Terminal Services server to control the user environment. This article describes the recommended process of applying GPOs to Terminal Services without adversely affecting other servers on the network.

## More information

There are two methods for applying GPOs to Terminal Services without adversely affecting other servers on the network.

### Method 1

Put the Terminal Server computers into their own organizational unit (OU). This configuration permits relevant computer configuration settings to be put in GPOs that apply only to Terminal Server computers. This configuration does not affect the user experience on workstations or on other servers and lets you create a tightly controlled Terminal Server experience for users. This OU should not contain users or other computers so that domain administrators can fine-tune the Terminal Services experience. The OU can also be delegated for control to subordinate groups such as server operators or individual users.

To create a new OU for the Terminal Services servers, follow these steps:

1. Click Start, point to Programs, point to Administrative Tools, and then click **Active Directory Users and Computers**.
2. Expand the left pane.
3. Click **`domainname.xxx`**.
4. On the Action menu, click New, and then click Organizational Unit.
5. In the Name box, type a name for the Terminal Services server.
6. Click OK.

    The new Terminal Services OU now appears in the list in the left pane and contains no default objects. The Terminal Services servers reside in either the Computers OU or the Domain Controllers OU.  
7. Locate and then click the Terminal Services server or servers, click Action, and then click Move.
8. In the Move dialog box, click the new Terminal Services server or servers, and then click OK.
9. Click the new Terminal Services OU to verify that the move has successfully occurred.  

To create a Terminal Services Group Policy object, follow these steps:

1. Click the new Terminal Services OU.
2. On the Action menu, click Properties.
3. Click the Group Policy tab.
4. Click New to create the New Group Policy object.
5. Click Edit to modify the Group Policy.
    >[!NOTE]
    >Most of the relevant settings are under Computer Configuration , Security Settings , or Local Policies . For example, under User Rights Assignment in the list on the right, you find **Log on Locally**. This setting is required for logging on to a session on Terminal Services. You also find **Access this computer from the network**. This setting is required to connect to the server outside a Terminal Services session. This is also where you can prevent users from being able to shut down the system. The Security Options folder is where many of the restrictions should be made and where there are similar settings to the NTConfig.pol file in Windows NT 4.0 Server and Terminal Server Edition. Settings for the user part of the policy should not be applied here because the users have not been put into this OU with the Terminal Services server. This article is written for computer policy implementation.  

6. When modifications are completed, close the Group Policy editor, and then click Close to close OU Properties.

### Method 2

Use the Group Policy loopback feature to apply User Configuration GPO settings to users only when they log on to the Terminal Servers. When GPO Loopback processing is enabled for the computers in an OU that contains only Terminal Servers, those computers apply the User Configuration settings from the set of GPOs that apply to that OU. Additionally, those computers apply the User Configuration settings from GPOs that are linked to or inherited by the OU that contains the user's account.

This implementation is described in the following Knowledge Base article:  
[231287](https://support.microsoft.com/help/231287) Loopback processing of Group Policy  

When it is possible, Terminal Services should be installed on member servers instead of on domain controllers because the users need Log on Locally user rights. When the Logon Locally right is assigned to domain controllers, it is assigned to every domain controller in the domain because of the shared Active Directory database. By default, member servers are granted Log on Locally user rights in the Local Security Policy when Terminal Services is installed in Application Server mode.

For additional information, click the following article number to view the article in the Microsoft Knowledge Base:

[186529](https://support.microsoft.com/help/186529) Local policy does not permit you to log on interactively  

The computer account of the terminal server should be added to the security properties of the GPO being created for the loopback. To do it, follow these steps:  

1. Select the GPO that is created for the loopback, and then click **Properties**.
2. Click the **Security** tab, and then click **Add**.
3. In the **Select Users, Computers, or Groups** box, select the computer account, and then click **OK**.
4. Click the computer account from the **Group or user names** box.
5. In the **Permissions for computer name** box, click to select the **Read** and **Apply Group Policy** check boxes in the **Allow** column.
6. Click OK two times to close and save the policy settings.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
