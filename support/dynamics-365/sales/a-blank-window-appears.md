---
title: A blank window appears
description: Provides a solution to an issue where a blank window appears when you try to sign into Yammer within Microsoft Dynamics CRM Online.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# A blank window appears when you attempt to sign into Yammer within Microsoft Dynamics CRM Online

This article provides a solution to an issue where a blank window appears when you try to sign into Yammer within Microsoft Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2816199

## Symptoms

A blank window appears when you sign into Yammer within Microsoft Dynamics CRM Online. It occurs when you attempt to sign in with Internet Explorer.

## Cause

The Yammer website and Microsoft Dynamics CRM Online website aren't in the same security zone in your Internet Explorer settings. Internet Explorer provides different security zones such as Internet, Trusted Sites, Local Intranet, and Restricted Sites.

## Resolution

Make sure [Yammer](https://www.yammer.com) and your Microsoft Dynamics CRM Online URL are in the same security zone in Internet Explorer.

Internet Explorer 8: You can view the security zone for the current site in the bottom status bar of the browser.

Internet Explorer 9 and 10: You can select the **File** menu and then select **Properties** to view the Zone information.

> [!NOTE]
> If the Menu Bar isn't enabled in Internet Explorer 9 or 10, you will need to enable it to see the **File** menu. Simply right-click the top of the browser window and then click to enable the Menu Bar if it isn't already selected.

Verify that the Zone info for both the Microsoft Dynamics CRM Online website and Yammer are the same. If both sites aren't in the same zone, you need to manually add the URL to the same zone. To add both URLs to the Trusted Sites zone, complete these steps:

1. Select the **Tools** menu in Internet Explorer, and then select **Internet Options**.
2. Select the **Security** tab, and then select **Trusted Sites**.
3. Select the **Sites** button.
4. Add your Microsoft Dynamics CRM Online URL and then select **Add**.
5. Add the [Yammer URL](https://www.yammer.com) and then select **Add**.
6. Select **Close** and then select **OK**.
