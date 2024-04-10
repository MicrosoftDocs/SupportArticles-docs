---
title: Some websites can't be accessed
description: Discusses that Internet Explorer crashes or hangs when you try to access some websites. Provides several methods to try to resolve the problem.
ms.date: 06/09/2020
ms.reviewer: 
---
# Cannot access some websites in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides methods to solve the issue that Internet Explorer can't access certain websites and provides solutions.

_Original product version:_ &nbsp; Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 967897

To resolve this problem, try the following methods in the order in which they're given.

## Manually enter the shortcut

Try to open a problem website by manually entering the shortcut (web address) instead of clicking the link for that site:

1. Right-click the link for the website, and then click **Copy shortcut**.
2. Paste the shortcut into the Address bar of Internet Explorer.
3. Press Enter.

## Use the troubleshooter

If none of the previous methods resolve the problem, try to run the Network and Internet Troubleshooter. Right-click the network icon in the notification area, select Troubleshoot problems, and then select Internet Connections. The Troubleshooter might ask you some questions or reset some common settings during this process. If running the Network and Internet Troubleshooter doesn't resolve the problem, look for your specific problem in the following list.

### I can access some websites, but not all of them

1. Windows 8.1 and Windows 10

    - Swipe in from the right edge of the screen (if you're using a mouse, press the Windows + C keys), and then tap or click **Search**. Enter *Internet options* in the search box, and then tap or click **Settings**.
    - In the search results, tap or click **Internet Options**. Tap or click the **Advanced** tab and then tap or click **Reset**.

      > [!NOTE]
      > Select the **Delete personal settings** check box if you would also like to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.

    - In the **Reset Internet Explorer Settings** window tap or click **Reset**.

      > [!NOTE]
      > To delete all personal settings, tap or click the checkbox for **Delete personal settings**.

    - Close and then restart Internet Explorer for the changes to take effect.

2. Windows XP, Windows Vista, and Windows 7

    - Exit all programs, including Internet Explorer.
    - If you use Windows XP, click **Start** > **Run**. Type *inetcpl.cpl* in the Open box, and then press Enter.  
        If you use Windows 7 or Windows Vista, click the **Start** button. Type *inetcpl.cpl* in the Search box, and then press Enter. The **Internet Options** dialog box appears.
    - Select the **Advanced** tab.
    - Under **Reset Internet Explorer settings**, click **Reset**. Then click **Reset** again.  
        Select the **Delete personal settings** check box if you also want to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.
    - When Internet Explorer finishes resetting the settings, click **Close** in the **Reset Internet Explorer Settings** dialog box.
    - Start Internet Explorer again.

If you still can't access some websites, get help from the [Microsoft Community online](https://answers.microsoft.com/).

For more information about How to reset settings in Internet Explorer, see [video](https://www.microsoft.com/videoplayer/embed/c989d6d8-f8f9-4cb5-a2f1-da6a7e89f18b).

### I can't access my bank and email websites or other secure websites

When you connect to a secure website, Internet Explorer uses an encrypted channel that uses Secure Sockets Layer (SSL) technology to encrypt transactions. Corrupted information in the SSL can cause websites not to load correctly. Clearing the SLL state may resolve this problem. To do it, follow these steps for your version of Windows.

1. Windows 8.1 and Windows 10

    - Swipe in from the right edge of the screen (if you're using a mouse, press Windows logo key+C keys), and then tap or click **Search**. Enter *Internet options* in the search box, and then tap or click **Settings**.
    - In the search results, tap or click **Internet Options**. Tap or click the **Content** tab, and then tap or click **Clear** SSL state.

2. Windows Vista and Windows 7

    - Click the **Start** button, type *Internet Explorer* in the search box. In the list of results, click Internet Explorer.
    - In Internet Explorer, click **Tools**, and then click **Internet Options**.
    - Click the **Content** tab, and then click **Clear** SSL state.

If clearing the SSL state doesn't resolve the problem, the date and time settings on your PC might be incorrect. Some secure sites require that the date and time on your PC match the date and time of the website. To check the date and time, follow these steps for your version of Windows.

1. Windows 8.1 and Windows 10

    - Swipe in from the right edge of the screen (if you're using a mouse, press the Windows + C keys), and then tap or click **Search**. Enter *date and time* in the search box, and then tap or click **Settings**.
    - In the search results, tap or click **Date and Time**, and then tap or click **Change date and time**.
    - In the **Date and Time Setting** window, set the current date and time.
    - Click **OK**, click **Apply**, and then click **OK**.

2. Windows Vista and Windows 7

    - In **Control Panel**, open **Date and Time**. To do it, click the **Start** button, type *date and time* in the **Start** Search box, and then click **Date and Time** in the Programs list.
    - Click **Change date and time**.
    - In the **Date and Time Settings** dialog box, set the date and time to the correct values.
    - Click **OK** two times.

If the date and time settings on your PC were correct, some incompatible or defective Internet Explorer add-ons might be interfering with the website. You might be able to resolve this problem if you turn off these add-ons. To automatically disable a list of known incompatible add-ons, run the Internet Explorer Add-on Fix it. When you are asked whether you want to run or save the file, click Run, and then follow the steps in the wizard.

If the Add-on Fix it doesn't resolve this problem, changes were made to your installation of Internet Explorer might be preventing you from viewing some websites. You can reset Internet Explorer to its original settings to remove any changes without deleting your favorites or feeds. To automatically reset the Internet Explorer settings, run the following Reset Internet Explorer Settings Fix it. When you are asked whether you want to run or save the file, click Run, and then follow these steps in the wizard.

1. Windows 8.1 and Windows 10

    - Disable add-ons

        - Swipe in from the right edge of the screen (if you're using a mouse, press the Windows + C keys), and then tap or click **Search**. Enter *Internet options* in the search box, and then tap or click **Settings**.
        - In the search results, tap or click **Internet Options**. Tap or click the **Programs** tab, then tap or click **Manage add-ons**.
        - In the **Manage add-ons** window, tap or click the dropdown under **Show**, then tap or click **All add-ons**.
        - Tap or click each add-on, and then tap or click **Disable**. When you are finished, tap or click **OK**.

    - Reset Internet Explorer to its original settings

        - Swipe in from the right edge of the screen (if you're using a mouse, press the Windows + C keys), and then tap or click **Search**. Enter *Internet options* in the search box, and then tap or click **Settings**.
        - In the search results, tap or click **Internet Options**. Tap or click the **Advanced** tab and then tap or click **Reset...**.
        > [!NOTE]
        > Select the **Delete personal settings** check box if you would also like to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.
        - In the Reset Internet Explorer Settings window tap or click **Reset**.
        > [!NOTE]
        > To delete all personal settings, tap or click the checkbox for **Delete personal settings**.
        - Close and then restart Internet Explorer for the changes to take effect.

If you still can't access secure websites, get help from the [Microsoft Community online](https://answers.microsoft.com/).

### I can't access any websites

If you can't view any websites, you are probably disconnected from the Internet. Try to run the Network and Internet Troubleshooter. Right-click the network icon in the notification area, select Troubleshoot problems, and then select Internet Connections. The Troubleshooter might ask you some questions or reset some common settings during this process.

If the date and time settings on your PC were correct, some incompatible or defective Internet Explorer add-ons might be interfering with the website. You might be able to resolve this problem if you turn off these add-ons. To automatically disable a list of known incompatible add-ons, run the Internet Explorer Add-on Fix it. When you are asked whether you want to run or save the file, click Run, and then follow these steps in the wizard for your version of Windows.

1. Windows 8.1 and Windows 10

    - Swipe in from the right edge of the screen (if you're using a mouse, press the Windows + C keys), and then tap or click **Search**. Enter Troubleshooting in the search box, and then tap or click **Settings**.
    - Tap or click **Troubleshooting** in the search results pane.
    - In the Troubleshooting window, tap or click **View all**.
    - Tap or click **Internet Explorer Performance**, and in the Internet Explorer Performance window, tap or click **Next**.
    - Follow the onscreen instructions to run the **Troubleshooter**.

If the Add-on Fix it doesn't resolve this problem, it's possible that changes were made to your installation of Internet Explorer that is preventing you from viewing some websites. You can reset Internet Explorer to its original settings to remove any changes without deleting your favorites or feeds. To automatically reset the Internet Explorer settings, run the following Reset Internet Explorer Settings Fix it. When you are asked whether you want to run or save the file, click Run, and then follow the steps in the wizard.

If you still can't access websites, get help from the [Microsoft Community online](https://answers.microsoft.com/).

## References

If you still can't access some websites after you follow the steps in this article, you can try the following resources for more support.

- Help from Microsoft Community online: [Microsoft Community](https://answers.microsoft.com).
- More Microsoft online articles: [Perform a search to find more online articles about this specific error](/search).
