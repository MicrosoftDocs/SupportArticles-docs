---
title: Fail to delete a record from a DNS zone
description: Explains that zone information on a DNS server can't be deleted. You must set full control permissions for DnsAdmins security group.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# Error when you try delete a record from a DNS zone: The record cannot be deleted

This article provides a workaround for an issue where you receive an error message when you try to delete a record from a DNS zone.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 837335

## Symptoms

As member of the DnsAdmins security group, you may not be able to delete zone information on a DNS server. If you try to delete a record, you may receive the following error message:

> The record cannot be deleted Access Denied

## Cause

This issue may occur if security permissions for the DnsAdmins security group aren't automatically added on the newly created Active Directory Integrated zones.

## Workaround

To work around this issue, manually add the DnsAdmins security group to the zone access control list (ACL) and grant Full Control.

To do so, use one of the following methods to assign Full Control to DnsAdmins security group.

### Method 1: Use the Dsacls.exe tool to assign Full Control permissions to the DNSAdmins group

1. Log on to your computer as administrator.
2. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
3. Type the following command, and then press ENTER:

    ```console
    dsacls "\\servername\CN=MicrosoftDNS, CN=System, DC=domain, dc=com" /G DNSADMINS:GA / I:T
    ```

For more information about the Dsacls tool, see [Dsacls](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771151(v=ws.11)).

### Method 2: Use ADSI Editor to assign Full Control permissions to the DNSAdmins group

1. Log on to your computer as administrator.
2. Click **Start**, click **Run**, type *adsiedit.msc*, and then click **OK**.
3. Expand **Domain NC**.

    This node contains a folder that begins with **DC=** and reflects the correct domain name, such as **DC=exampledomain DC=net.**
4. Expand **CN=System**, and then click **CN=MicrosoftDNS**.
5. In the right pane, right-click the folder where you want to change the permissions, and then click **Properties**.
6. In the **DomainComponent** properties dialog box, click the **Security** tab.
7. In the DnsAdmins **Permissions** list, click to select the **Full Control** check box for the **Allow** column, and then click **OK** two times.
8. On the **File** menu, click **Exit**.

### Method 3: Use DNS to assign Full Control permissions to the DnsAdmins group

1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **DNS**.
2. In the console tree, click the applicable zone.
3. On the **Action** menu, click **Properties**.
4. In the **Properties** dialog box for the zone, click **Security**, and then click **Add**.
5. In the **Select Users, Computers, or Groups** dialog box, type DnsAdmins, and then click **OK** in the **Enter the object names to select** text box.
6. In the **Permissions** list for DnsAdmins, click to select the **Full Control** check box for the **Allow** column.
7. Click **Advanced**, click **DnsAdmins**, and then click **Edit**.
8. In the **Apply onto** drop-down menu, click to select **This object and all child objects**.
9. Click **OK** three times.
10. On the **File** menu, click **Exit**.
