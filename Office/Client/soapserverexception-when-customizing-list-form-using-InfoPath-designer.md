---
title: SoapServerException error when customizing list form (SPO and SP-onprem) using InfoPath designer
description: Describes how to add a button to a Word document and assign its Click event at run-time
author: v-todmc
manager: joselr
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-todmc
---

# SoapServerException error when customizing list form (SPO and SP-onprem) using InfoPath designer

## Symptoms
When you click on the “customize InfoPath” option in a Sharepoint list, you receive the following error:

> AP response indicates that an error occurred on the server: Exception of type &#8216;Microsoft.SharePoint.SoapServer.SoapServerException&#8216; was thrown. [detail][errorstring xmlns=&#8220;http://schemas.microsoft.com/sharepoint/soap/&#8221;] List does not exist. The page you selected contains a list that does not exist. It may have been deleted by another user. [/errorstring][errorcode xmlns=&#8220;http://schemas.microsoft.com/sharepoint/soap/&#8221;]0x82000006[/errorcode][/detail]

## Cause
This is a known issue on Windows 10 related to the update listed in KB [4489886](https://support.microsoft.com/en-us/help/4489886/windows-10-update-kb4489886), and is documented under the section "Known issues in this update".

## Workarounds

### Workaround 1:
Enable Protected Mode for local intranet and trusted sites in Internet Explorer:

1. Go to **Tools** > **Internet options** > **Security**.
2. Within **Select a zone to view or change security settings**, select **Local intranet** and then select **Enable Protected Mode**. 
3. Select **Trusted sites** and then select **Enable Protected Mode**.
4. Select **OK**.

### Workaround 2:
1.	Go to **List setting**.
2.	Select **Form setting**.
3.	Select **Customize** in InfoPath.

### Workaround 3:
Open the list form from the InfoPath Designer client application.

 
## More information
Microsoft is researching this problem and will post more information in this article when the information becomes available. 
