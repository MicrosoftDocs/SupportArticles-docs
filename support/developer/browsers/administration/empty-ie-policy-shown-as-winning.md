---
title: An empty policy as winning in Internet Explorer
description: Due to a problem with Internet Explorer policy management extensions, the resetting of IEM content in a group policy object does not prevent tools such as RSOP from identifying it as the winning IEM policy.
ms.date: 06/09/2020
ms.reviewer: joelba
---
# Policy reporting tools indicate empty Internet Explorer Maintenance policy as winning

[!INCLUDE [](../../../includes/browsers-important.md)]

This article discusses information about manually deleting extensions in Group Policy after you delete the client's IEM settings.

_Original product version:_ &nbsp; Internet Explorer, Windows Server 2008 and later versions  
_Original KB number:_ &nbsp; 2722241

## Symptoms

After using the Internet Explorer Maintenance (IEM) context-menu option to Reset browser settings, a group policy object may be reported as the source of winning Internet Explorer Maintenance content even though the IEM settings have been removed.

## Cause

The policy reporting tools identify the applicability of Internet Explorer Maintenance settings by the existence of their Client Side Extensions (CSE). The Reset browser settings option removes the IEM content but doesn't direct the policy editor to remove the extensions.

## Resolution

To work around this issue, administrators can leverage one of the two following options:

1. Manually edit the affected group policy object and remove the Internet Explorer Maintenance **gPCUserExtensionNames** entries.

    - On Windows Server 2008 and later versions, you can modify the attributes using the following steps:
      - Open the **Group Policy Editor**, Select the affected group policy object.
      - Select the **Details** tab, Document the **Unique ID**.

    - Open the **Active Directory Users and Computers** snap-in.
      - Select the **Domain Name** > **System** > **Policies**.
      - Locate and Select the **group policy object Unique ID** obtained from above.
      - Right-click the **policy object** and choose **Properties**.

    - Click on the **Attribute Editor** tab
      - Locate and Select the entry for **gPCUserExtensionNames**.
      - Click **Edit**, Copy all of the entries listed.
      - Paste the entries into a new Notepad text file.

    - Remove the following client extensions from the Notepad content, if they exist:
      - **{A2E30F80-D7DE-11d2-BBDE-00C04F86AE3B] // Internet Explorer Maintenance policy processing**
      - **{FC715823-C5FB-11D1-9EEF-00A0C90347FF} // Internet Explorer Maintenance Extension protocol**

    - Copy the edited list from Notepad
      - Paste the updated extension list back into the **gPCUserExtensionNames** value field.
      - Click **OK** to exit the **Attribute Editor**.

      For environments prior to Windows Server 2008, use Active Directory Service Interfaces Editor(ADSI Edit) to remove the extensions manually.

2. Create a new replacement group policy object, which contains all of the former non-IEM settings and unlink or disable the old policy.

## More information

For more information about extension list in Group Policy, see
[Group Policy Client Side Extension List](/archive/blogs/mempson/group-policy-client-side-extension-list).
