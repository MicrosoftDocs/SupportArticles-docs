---
title: How to use Internet Free/Busy
description: This article discusses how to use the Internet Free/Busy feature in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: SCOTTGR
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# How to use the Internet Free/Busy feature in Outlook

_Original KB number:_ &nbsp; 291621

## Summary

Internet Free/Busy (IFB) is a feature of Microsoft Outlook that allows you to see when others are free or busy so that you can efficiently schedule meetings. Outlook users have the option to publish their free/busy information to a user-specified Uniform Resource Locator (URL) file server. You can share this URL file server with all users or limit it to a specific set of users.

An Internet Engineering Task Force (IETF) standard called iCal, is the basis for IFB. IFB uses a part of the iCal standard called iCalendar, an emerging standard for the format and storage of schedule information. iCalendar defines a structure for representing free/busy information in a standardized way.

This article discusses the following information:

- [How to publish free/busy information to the Internet](#how-to-publish-freebusy-information-to-the-internet)
- [How to view other people's free/busy information on the Internet](#how-to-view-other-peoples-freebusy-information-on-the-internet)
- [How to set the global free/busy search path for all contacts](#how-to-set-the-global-freebusy-search-path-for-all-contacts)
- [How to set the free/busy search path for a specific contact](#how-to-set-the-freebusy-search-path-for-a-specific-contact)
- [How to plan a meeting using Internet free/busy information](#how-to-plan-a-meeting-using-internet-freebusy-information)

## How to Publish free/busy information to the Internet

For Microsoft Outlook 2010 or later versions:

1. Select the **File** tab, and then select **Options**.
2. In the left pane, select **Calendar**, and then select the **Free/busy Options** button.
3. Select the **Permissions** tab, and then select **Other Free/busy**.
4. Select to select the **Publish at My Location** check box under the **Internet Free/busy** section, and then type the fully qualified path of the server on which you will publish your free/busy information. You can use any valid URL format, such as http://... , file://\\\\... , or ftp://... . Free/busy files have the .vfb file name extension. The following is an example of a valid URL format:

   `ftp://Myserver/Freebusy/Myname.vfb`

    > [!NOTE]
    > If the FTP server requires authentication and Outlook is installed on Windows Vista or Windows 7, you must use the following format:

    ftp://*username:password*@Ftpservername/Freebus/Myname.vfb

    Where *username:password* is your user name and password.

For Microsoft Outlook 2007 and Microsoft Office Outlook 2003:

1. On the **Tools** menu, select **Options**.
2. On the **Preferences** tab, select **Calendar Options**.
3. Select **Free/Busy Options**.
4. In **Publish at My Location**, type the fully qualified path to the server on which you will publish your free/busy information. You can use any valid URL format, such as: http://... , file://\\\\... , or ftp://... . The following is an example of a valid format:

    `ftp://Myserver/Freebusy/Myname.vfb`

    Free/busy files have an extension of .vfb.

    > [!NOTE]
    > If the FTP server requires authentication and you are using Outlook 2007 on Windows Vista or Windows 7, you must use the following format:

    ftp://*username:password*@Ftpservername/Freebus/Myname.vfb

    Where *username:password* is your user name and password.

5. Select **OK** three times to close all dialog boxes.

If your FTP servers require authentication and Outlook is installed on Windows XP, you must follow these steps to configure the FTP site:

For Outlook 2010:

1. Start Outlook 2010, and then on select the **File** tab.
2. Select **Open**, and then select **Outlook data files**.
3. In the **Look in** list, select **Add/Modify FTP Locations**.
4. In the **Add/Modify FTP Locations** dialog box, type the address of your FTP site in the **Name of FTP Site** box. The format for the address is ftp.**site_name**.com, where the address is the FTP site address. Notice that ftp:// is not required.
5. Under **Log on as**, select **User**, and then enter your user name.
6. Under **Password**, type the password.
7. Select **Add** to add the site to your list of FTP sites. When you configure this option, the logon information for publishing to the site is retained.
8. Select **OK** to close the **Add/Modify FTP Locations** dialog box.
9. Select **Cancel** to close the **Open Outlook Data File** dialog box.
10. On the **Tools** menu, select **Options**.
11. On the **Preferences** tab, select **Calendar Options**, and then select **Free/Busy Options**.
12. Select to select the **Publish at My Location** check box, and then type the fully qualified path of the server on which you will publish your free/busy information. You can use any valid URL format, such as http://... , file://\\\\... , or ftp://... . Free/busy files have the .vfb file name extension. The following is an example of a valid URL format:

   `ftp://Myserver/Freebusy/Myname.vfb`

For Outlook 2007 and Outlook 2003:

1. Start Outlook.
2. On the **File** menu, select **Open**, and then select **Outlook Data File**.
3. In the **Look in** box, select **Add/Modify FTP Locations**.

4. In the **Add/Modify FTP Locations** dialog box, type the address of your FTP site in the **Name of FTP Site** box. The format for the address is `ftp.site.com`, where the address is the FTP site address. Note that ftp:// is not required.
5. Under **Log on as**, select User, and then enter the user name.
6. Under Password, type the password.
7. Select **Add** to add the site to your list of FTP sites. Configuring this option retains the logon information for publishing to the site.
8. Select **OK** to close the **Add/Modify FTP Locations** dialog box.
9. Select **Cancel** to close the **Open Outlook Data File** dialog box.
10. On the **Tools** menu, select **Options**.
11. On the **Preferences** tab, select **Calendar Options**, and then select **Free/Busy Options**.
12. Select the **Publish at My Location** check box, and then type the fully qualified path of the server on which you will publish your free/busy information. You can use any valid URL format, such as http://... , file://\\\\... , or ftp://... . Free/busy files have the .vfb file name extension. The following is an example of a valid URL format:

   `ftp://Myserver/Freebusy/Myname.vfb`

## How to view other people's free/busy information on the Internet

You can view the free/busy information for any of your contacts that publish this data on the Internet. If all of your contacts store this information on the same free/busy server, you can set the search path for this information globally for all contacts. Or, if the location of this information varies by contact, you can set the search path specifically for each contact.

## How to set the global free/busy search path for all contacts

For Microsoft Outlook 2010 or later versions:

1. Select the **File** tab, and then select **Options**.
2. On the left pane, select **Calendar**.
3. Select the **Free/Busy Options** button, select the **Permissions** tab, and then select **Other Free/busy**.
4. Under the **Internet Free/busy** section, in the **Search locations** box, type the fully qualified path of the location that you want to search for the free/busy information. You can use any valid URL format, such as: http://... , file://\\\\... , or ftp://... .

   Outlook supports %NAME% and %SERVER% substitutions.

   The following is an example of how to use these substitutions:

   `ftp://%SERVER%/Freebusy/%NAME%.vfb`

    In a Simple Mail Transfer Protocol (SMTP) address, Outlook replaces %NAME% with all the characters before the at (@) symbol and replaces %SERVER% with all the characters following the @ symbol.

5. Select **OK** to exit.

For Outlook 2007:

1. On the **Tools** menu, select **Options**.
2. On the **Preferences** tab, select **Calendar Options**.
3. Select **Free/Busy Options**, select the **Permissions** tab and then select **Other Free/busy**.
4. Under the **Internet Free/busy** section, in the **Search locations** box, type the fully qualified path to the location that you want to search for the free/busy information. You can use any valid URL format, such as: http://... , file://\\\\... , or ftp://... .

    Outlook supports %NAME% and %SERVER% substitutions.

    The following is an example of using these substitutions:

    `ftp://%SERVER%/Freebusy/%NAME%.vfb`

    In a Simple Mail Transfer Protocol (SMTP) address, Outlook replaces %NAME% with all the characters before the at (@) symbol and replaces %SERVER% with all the characters following the @ symbol.

5. Select **Ok** to exit.

For Outlook 2003:

1. On the **Tools** menu, select **Options**.
2. On the **Preferences** tab, select **Calendar Options**.
3. Select **Free/Busy Options**.
4. Select **Publish and search using Microsoft Office Internet Free/Busy Service**.
5. In the **Search locations** box, type the fully qualified path to the location that you want to search for the free/busy information. You can use any valid URL format, such as: http://... , file://\\\\... , or ftp://... .

    Outlook supports %NAME% and %SERVER% substitutions.

    The following is an example of using these substitutions:

    `ftp://%SERVER%/Freebusy/%NAME%.vfb`

    In a Simple Mail Transfer Protocol (SMTP) address, Outlook replaces %NAME% with all the characters before the at (@) symbol and replaces %SERVER% with all the characters following the @ symbol.

6. Select **OK** three times to close all dialog boxes.

## How to set the free/busy search path for a specific contact

For Microsoft Outlook 2013 or later versions:

1. In the **Home** tab, under **Current View**, select **Business Card**.
2. Double-click to open a Contact.
3. In the **Contact** tab, under **Show**, select **Details**.
4. Under the text that reads Internet Free-Busy, in the **Address** box, type the fully qualified path of the location that you want to search for this Contact's free/busy information. You can use any valid URL format, such as the following: http://... , file://\\\\... , or ftp://... .

    The following is an example of a valid format:

    `ftp://Contactserver/Freebusy/Contactname.vfb`

    Internet free/busy information displays on the **Scheduling** tab of appointments and meetings.

For Outlook 2010, 2007 and 2003:

1. In the Contacts folder, double-click to open a Contact.
2. Select the **Details** tab.
3. Under the text that reads Internet Free-Busy in the **Address** box, type the fully qualified path of the location that you want to search for this Contact's free/busy information. You can use any valid URL format, such as the following: http://... , file://\\\\... , or ftp://... .

    The following is an example of a valid format:

    `ftp://Contactserver/Freebusy/Contactname.vfb`

    Internet free/busy information displays on the **Scheduling** tab of appointments and meetings.

## How to plan a meeting using Internet free/busy information

1. In the Calendar folder, select**New Meeting Request** on the **Actions** menu.
2. On the **Scheduling** tab, type the name of each attendee in the **All Attendees** box.

Outlook follows the URL path (as previously specified) for the individuals that you invite and automatically inserts their free/busy information in the planner.

Outlook publishes and retrieves free/busy information every 15 minutes by default. You can manually override this time increment by pointing to **Send And Receive** on the **Tools** menu, and then selecting Free/Busy Information. This updates the free/busy information immediately.

Web Publishing Wizard 1.6 version works with Microsoft Windows 2000 in some cases, depending on your network configuration. However, it is untested and not supported.
