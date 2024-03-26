---
title: Mapping and syncing network drives that connect to SharePoint Online
description: Describes how to troubleshoot mapped network drives that connect to SharePoint Online.
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Lists and Libraries\Map a network drive
  - CSSTroubleshoot
  - CI 117634
ms.author: luche
ms.reviewer: prbalusu
appliesto: 
  - SharePoint Online
---

# Troubleshoot mapped network drives that connect to SharePoint Online

> [!NOTE]
> Mapping a network drive uses WebDav, an older technology which is slower and less reliable than [syncing SharePoint files with the new OneDrive sync client](https://support.office.com/article/6de9ede8-5b6e-4503-80b2-6190f3354a88). The OneDrive sync client provides [Files On-Demand](https://support.office.com/article/0e6860d3-d9f3-4971-b321-7092438fb38e), which allows you to access all your files in OneDrive without using local storage space. 

## Troubleshoot mapped network drive error messages

When you browse to a mapped network drive, you may receive one of the following error messages:

   > \\\Path is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.

   > Access Denied. Before opening files in this location, you must first add the web site to your trusted site list, browse to the web site, and select the option to login automatically'

> [!NOTE]
> For Internet Explorer 10 with Windows 8 or Windows 7, install the hotfix to resolve this problem. See the article [Error when you open a SharePoint Document Library in Windows Explorer or map a network drive to the library after you install Internet Explorer 10](https://support.microsoft.com/help/2846960) for more information.

### Authenticate to Microsoft 365

Make sure that you're authenticated to Microsoft 365. To do this, sign in to the SharePoint Online site by using your Microsoft 365 work or school account credentials, and make sure that you select the **Stay signed in** option as seen in the following screen shot:

:::image type="content" source="media/troubleshoot-mapped-network-drives/stay-signed-in.png" alt-text="Screenshot of the stay signed in page.":::

> [!NOTE]
> After you map a network drive to SharePoint Online, you must occasionally connect to the SharePoint Online site by using Internet Explorer and select the **Stay signed in** option. This prevents the session that's used by the mapped network drive from expiring. A mapped network drive that's connected to SharePoint Online is only supported when these steps are performed within Internet Explorer.

If you previously didn't check the **Stay signed in** option and then browse to a SharePoint Online site or the Microsoft 365 portal and you're already signed in, you must first sign out, and then sign in again by using the **Stay signed in** option. To do this, follow these steps:

1. In the Microsoft 365 ribbon, select the drop-down arrow next to your user name.

1. Select **Sign out**.

1. Close all browser windows.

1. Browse to the Microsoft 365 portal.

1. Select the **Stay signed in** option, enter your Microsoft 365 work or school account credentials, and then select **Sign in** (if it's necessary).

1. Open a document library in Explorer View.

1. Try to access the mapped network drive.

### Add your SharePoint Online sites to trusted sites

Make sure that the SharePoint Online URLs have been added to your Trusted sites zone in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.

1. Depending on your version of Internet Explorer, take one of the following actions:

    - Select the **Tools** menu, and then select **Internet options**.
    - Select the gear icon, and then select **Internet options**.

    :::image type="content" source="media/troubleshoot-mapped-network-drives/internet-options.png" alt-text="Screenshot of the Tool menu. Internet options entry is selected.":::

1. Select the **Security** tab, select **Trusted sites**, and then select **Sites**.

    :::image type="content" source="media/troubleshoot-mapped-network-drives/trusted-sites.png" alt-text="Screenshot of the Security tab in Internet Options, showing the Trusted sites zone.":::

1. In the **Add this website to the zone** box, type the URL for the SharePoint Online site that you want to add to the Trusted sites zone, and then select **Add**. For example, type https://**contoso**.sharepoint.com. (Here, the placeholder **contoso** represents the domain that you use for your organization.) Repeat this step for any additional sites that you want to add to this zone.

   > [!NOTE]
   > We recommend that you also add the following Microsoft 365 URLs to the Trusted sites zone:
   >
   > - https://*.microsoftonline.com
   > - https://*.microsoft.com

    :::image type="content" source="media/troubleshoot-mapped-network-drives/add-websites.png" alt-text="Screenshot of the Trusted sites dialog box. You can add and remove websites from this zone." border="false":::

1. After you have added each site to the **Websites** list, select **Close**, and then select **OK**.

### Check the status of the WebClient service

To keep the connection after you restart the computer, make sure that the WebClient service is running. (Be aware that the cookie will eventually time out.) To do this, follow these steps:

1. Follow the appropriate step for your operating system:

    - For Windows 8, select **Start**, type **services.msc**, and then press **Enter**.

    - For Windows 7, Windows XP, and Windows Vista, select **Start**, select **Run**, type **services.msc**, and then press **Enter**.

1. In the list of services, locate the WebClient service, and then make sure that its status in the **Status** column is set to **Started**. If it isn't set to **Started**, double-select the **WebClientservice**, select **Start**, and then select **OK**.

Make sure that the latest Windows updates are applied. If all the latest updates are applied, and the issue persists, make sure that the WebClient service is running.

> [!NOTE]
> If the **Startup Type** for the **WebClient** service is set to **Disabled**, the map network drive functionality won't work correctly and you'll be unable to start the service. To enable the service, within the **WebClient Properties** dialog box select the drop-down dialog for the **Startup type: setting** and then select either **Manual** or **Automatic**. The choice of **Automatic** is necessary for persistent drive mappings. After you complete this step, select **Apply**, select **Start** to start the service, and then select **OK**.

### Troubleshoot slower-than-expected mapped network drive performance on Windows 8-based or Windows Server 2012-based computers

When you browse to a SharePoint Online document library through a mapped network drive, you may experience an issue in which the enumeration of the files and directories is slower than expected. A hotfix was released to resolve this issue.

## More information

- For more info about how to work with the WebClient service, see [Prompt for Credentials When Accessing FQDN Sites From a Windows Vista or Windows 7 Computer](https://support.microsoft.com/help/943280)

- For more info about how to work with site library files in File Explorer, see [Ways to work with site library files in File Explorer](https://support.office.live.com/article/751148de-f579-42f9-bc8c-fcd80ccf0f53).

- For more information about Microsoft 365 URLs, see [URLs and IP address ranges for Microsoft 365 operated by 21Vianet](/office365/enterprise/urls-and-ip-address-ranges-21vianet).

- [Authentication issues or failures occur when you try to use a network drive that's mapped to a SharePoint library](/sharepoint/troubleshoot/administration/authentication-errors-tls12-support#network-drive-mapped-to-a-sharepoint-library)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
