---
title: License attributes aren't updated after installing 2019 license server
description: Provides a workaround for the issue in which the users license attributes (msTS*) aren't updated in Active Directory (AD).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, feshehad, v-lianna
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# License attributes aren't updated after installing 2019 license server

_Original KB number:_ &nbsp; 4547091

Assume that you deploy a domain controller, a Remote Desktop Session Host (RDSH) server, and a Remote Desktop Services license server in Windows Server 2019. In this scenario, the users license attributes (msTS\*) aren't updated in Active Directory (AD).

It is a recent change in Windows Server 2019. The RDSH server will update the license attributes in AD with a user account. By default, the user account isn't delegated with the write permission (Read and write Terminal Server license server) to update license attributes in AD.

## Delegate the license server permission to SELF object in AD

To work around this issue, delegate control for the organizational unit (OU) containing the users in AD. Here's how to do it:

1. Right-click the OU containing the users and select **Delegate Control…** in AD.

    :::image type="content" source="media/license-attributes-not-updated-rdsh-server/delegate-control.png" alt-text="Delegate control for the organizational unit containing the users in AD":::

2. In the **Delegation of Control Wizard**, select **SELF (NT AUTHORITY\SELF)** > **Next**.

    :::image type="content" source="media/license-attributes-not-updated-rdsh-server/nt-authority-self.png" alt-text="Select SELF in the Delegation of Control Wizard.":::

3. Select **Create a custom task to delegate** > **Next**.

    :::image type="content" source="media/license-attributes-not-updated-rdsh-server/create-a-custom-task-to-delegate.png" alt-text="Select create a custom task to delegate.":::

4. Select **Only the following objects in the folder**, check **User objects**, and select **Next**.

    :::image type="content" source="media/license-attributes-not-updated-rdsh-server/only-the-following-objects-in-the-folder.png" alt-text="Select only the following objects in the folder.":::

5. Check **General** and **Read and Write Terminal Server License server**, and then select **Next** > **Finish**.

    :::image type="content" source="media/license-attributes-not-updated-rdsh-server/read-write-terminal-server-license-server.png" alt-text="Check General and Read and Write Terminal Server License server.":::
