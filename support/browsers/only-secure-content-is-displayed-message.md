---
title: Display non-secure content in Internet Explorer
description: When you access a website that contains non-secure content or mixed content, you receive a **only secure content is displayed** notification. 
ms.date: 06/09/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Only secure content is displayed notification in Internet Explorer 9 or later versions

This article provides information about resolving issues with web pages that only display secure content.

_Original product version:_ &nbsp; Internet Explorer 9 or later versions  
_Original KB number:_ &nbsp; 2625928

## Symptoms

When viewing a website in Internet Explorer 9 or later, you receive the following message:

> Only secure content is displayed.

## Cause

This message means that there may be both secure and non-secure content on the page. Secure and non-secure content, or mixed content, means that a webpage is trying to display elements using both secure (HTTPS/SSL) and non-secure (HTTP) web server connections. It often happens with online stores or financial sites that display images, banners, or scripts that are coming from a server that isn't secured. The risk of displaying mixed content is that a non-secure webpage or script might be able to access information from the secure content.

## Resolution

> [!IMPORTANT]
> Internet Explorer blocks non-secure content by default and is set to prompt you when this is happening. Changing this setting may make your computer vulnerable to viral, fraudulent, or malicious attacks. Microsoft does not recommend that you attempt to change this setting. Modify this setting at your own risk.

### Windows 10

To Disable/Enable/Prompt the **Only secure content is displayed** message:

1. Open Internet Explorer from the Start screen.
2. On the **Tool** menu, select **Internet Options**.
3. Select the **Security** tab, and then select **Custom level**.
4. In the **Settings** box, scroll down to the **Miscellaneous** section, and under Display mixed content choose from the following options:

    **Disable**, will not display non-secure items.  
    **Enable**, will always display non-secure items without asking.  
    **Prompt**, will prompt you when a webpage is using non-secure content.

### Windows 8

To Disable/Enable/Prompt the **Only secure content is displayed** message:

1. From the start screen, type **Internet Options**.
2. Tap or select the **Settings option** below the Search box, and then tap or select **Internet Options**.
3. Tap or select the **Security** tab, and then tap or select the **Custom Level**.
4. In the **Settings** box, scroll down to the **Miscellaneous** section, and under Display mixed content choose from the following options:

    **Disable**, won't display non-secure items.  
    **Enable**, will always display non-secure items without asking.  
    **Prompt**, will prompt you when a webpage is using non-secure content.

### Windows 7 and Windows Vista

To Disable/Enable/Prompt the **Only secure content is displayed** message:

1. Start Internet Explorer.
2. On the **Tool** menu, select **Internet Options**.
3. Select the **Security** tab, and then select **Custom level**.
4. In the **Settings** box, scroll down to the **Miscellaneous** section, and under Display mixed content choose from the following options:

    **Disable**, won't display non-secure items.  
    **Enable**, will always display non-secure items without asking.  
    **Prompt**, will prompt you when a webpage is using non-secure content.  

## More information

To learn more about the risks of allowing mixed content, see [Protecting Consumers from Malicious Mixed Content](/archive/blogs/ie/internet-explorer-9-security-part-4-protecting-consumers-from-malicious-mixed-content).
