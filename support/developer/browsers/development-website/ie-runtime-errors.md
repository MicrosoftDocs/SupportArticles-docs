---
title: Runtime errors in Internet Explorer
description: This article provides the solution to solve the runtime errors that occur in Internet Explorer.
ms.date: 03/08/2020
ms.reviewer: v-jomcc, ericlaw
---
# How to fix runtime errors in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

A runtime error is a software or hardware problem that prevents Internet Explorer from working correctly. Runtime errors can be caused when a website uses HTML code that's incompatible with the web browser functionality.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 822521

## Which runtime error do you need to fix

The solution to runtime error messages in Internet Explorer is different depending on the type of runtime error that you receive.

This article provides a resolution only for the following error message:

> Error  
> A Runtime Error has occurred.  
> Do you wish to Debug?  
> Line: line number  
> Error: nature of script error

:::image type="content" source="media/ie-runtime-errors/runtime-error-message-box.png" alt-text="Screenshot of the Runtime Error message box." border="false":::

:::image type="content" source="media/ie-runtime-errors/webpage-error-message-box.png" alt-text="Screenshot of the Webpage Error message box, stating Do you want to debug this webpage." border="false":::

## Resolution

Because this type of error message doesn't apply to you, you can prevent it from appearing. To do so, follow these steps in Internet Explorer:

1. Select the **Tools** button, and then select **Internet Options**. Or, press ALT+T, and then press O.

2. In the **Internet Options** dialog box, select the **Advanced** tab.

3. Select the **Disable script debugging (Internet Explorer)** and **Disable script debugging (Other)** check boxes. Then clear the **Display a notification about every script error** check box.

   :::image type="content" source="media/ie-runtime-errors/internet-options-browsing-settings.png" alt-text="Screenshot of the Internet Options window. Under Advance tab, the three check boxes are set." border="false":::

4. Select **OK** to close the **Internet Options** dialog box.

## Test the resolution

To see whether the problem is fixed, open or refresh the Web site that caused the error.

- If the Web site displays and works correctly, and if the runtime error message doesn't reappear, then you're finished. You may still receive a notification about the Web page error in the Internet Explorer status bar. However, you can just ignore the Web page error. If this computer has multiple users, you might also need to sign in as another user and repeat these steps for other users.

- If the Web site still doesn't display or work correctly, the problem may be with the Web site itself. But to test it, either you must have access to another computer, or your computer must be set up for multiple users. If you have access to another computer, try to view the page from that other computer. If your computer is set up for multiple users, sign in as another user, and then try to view the page again.

If the Web site still doesn't display or work correctly, the problem is likely with the Web page itself. So you might want to contact the owner of the Web page to ask them to fix the problem.
