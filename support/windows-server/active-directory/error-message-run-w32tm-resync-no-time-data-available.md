---
title: Error message when you run the w32tm /resync command
description: Describes a problem that occurs if a Group Policy object for a Windows Time Service object is configured incorrectly.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, karanr
ms.custom: sap:windows-time-service, csstroubleshoot
---
# Error message when you run the "w32tm /resync" command to synchronize Windows Server 2003 or Windows SBS to an external time source: "The computer did not resync because no time data was available"

This article provides a solution to an error that occurs when you run the `w32tm /resync` command to synchronize Windows Server 2003 or Windows SBS to an external time source.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 929276

## Symptoms

When you run the `w32tm /resync` command to synchronize Microsoft Windows Server 2003 or Microsoft Windows Small Business Server 2003 (Windows SBS) to an external time source, you receive the following error message:
> The computer did not resync because no time data was available.

If you run the `w32tm /config /syncfromflags:manual` command or the `w32tm /config /manualpeerlist:peerlist` command to determine whether Windows is configured correctly, the commands complete successfully.

## Cause

This problem occurs if a Group Policy object for a Windows Time Service object is configured incorrectly.

## Resolution

To resolve this problem, examine the Group Policies that set the Windows Time Service Group Policy objects to their default values or to a value of **Not Configured**. Examine Group Policies on the computer and in the organization. Set these Windows Time Service Group Policy objects to use a value of **Not Configured**. To do this, follow these steps:

1. Open the container that contains the Group Policy object that you want to modify. To do this, follow these steps.

    For a domain object

   1. On a domain controller, click **Start**, click **Run**, type *dsa.msc*, and then click **OK**.
   2. In the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in, right-click the container that contains the Group Policy object, and then click **Properties**. For example, right-click the container that represents the domain or the organizational unit, and then click **Properties**.

      > [!NOTE]
      > If the server that has this problem is a domain controller, examine the Group Policy objects in the **Domain Controllers** container.
   3. In the **ContainerName Properties** dialog box, click the **Group Policy** tab.
   4. Click the Group Policy object that you want to modify, and then click **Edit**. For example, if you are examining the Group Policy objects in the **Domain Controllers** container, click **Default Domain Controllers Policy**, and then click **Edit**.

    For a local computer object

    Click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.
2. In the **Group Policy Object Editor** MMC snap-in, expand **Computer Configuration**, expand **Administrative Templates**, expand **System**, and then click **Windows Time Service**.
3. In the right pane, right-click **Global Configuration Settings**, and then click **Properties**.
4. In the **Global Configuration Settings Properties** dialog box, click **Not Configured**, and then click **OK**.
5. Expand **Windows Time Service**, click **Time Providers**, and then set all the objects in this node to **Not Configured**. To do this, follow these steps:
   1. In the right pane, double-click **Enable Windows NTP Client**, click **Not Configured**, and then click **OK**.
   2. In the right pane, double-click **Configure Windows NTP Client**, click **Not Configured**, and then click **OK**.
   3. In the right pane, double-click **Enable Windows NTP Server**, click **Not Configured**, and then click **OK**.
6. Exit **Group Policy Object Editor**, and then click **OK** to exit the **ContainerName Properties** dialog box.
7. Update Group Policy on the server that has this problem. To do this, follow these steps:
   1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
   2. At the command prompt, type `gpupdate /force` , and then press ENTER.

## More Information

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
[816042](configure-authoritative-time-server.md) How to configure an authoritative time server in Windows Server 2003
