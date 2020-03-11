---
title: Cannot close IE window via window.setTimeout(window.close,1)
description: Describes a problem that occurs where you cannot use the window.setTimeout(window.close,1) method to close an Internet Explorer window.
ms.date: 03/08/2020
ms.prod-support-area-path: Internet Explorer
---
# The window.setTimeout(window.close,1) method cannot close an IE window

This article provides the workaround to solve the problem that you cannot close an Internet Explorer window by using the window.setTimeout(window.close,1) method.

_Original product version:_ &nbsp; Internet Explorer, Windows XP Service Pack 2  
_Original KB number:_ &nbsp; 884768

## Symptoms

When you click a hyperlink that is designed to close a Microsoft Internet Explorer window, the Internet Explorer window does not close. This problem occurs in Microsoft Windows XP Service Pack 2.

## Cause

The hyperlink uses the window.setTimeout(window.close,1) method to close the Internet Explorer window.

## Workaround

To work around this problem, use the window.setTimeout("window.close()", 1) method or the window.close() method to close the Internet Explorer window. You can use the following code sample to demonstrate the workaround.

```html
<html>
<body>
<script>
function TimeoutCloseWindow2()
{
window.setTimeout("window.close()", 1);
}
function DirectCloseWindow()
{
window.close();
}
</script>
<p>
<a href="javascript:TimeoutCloseWindow2();">Workaround 1: Click here to try to close the window by using window.setTimeout("window.close()", 1)</a>
</p>
<p>
<a href="javascript:DirectCloseWindow();">Workaround 2: Click here to try to close the window by using window.close()</a>
</p>
</body>
</html>
```

## Steps to reproduce the problem

1. Click **Start**, click **Run**, type Notepad, and then click **OK**.

2. Put the following code sample in Notepad.

   ```html
   <html>
   <body>
   <script>
   function TimeoutCloseWindow()
   {
   window.setTimeout(window.close, 1);
   }
   </script>
   <a href="javascript:TimeoutCloseWindow();">Click here to try to close the window by using window.setTimeout(window.close, 1)</a>
   </body>
   </html>
   ```

3. Save the file as Repro.html.

4. Use Internet Explorer to open the Repro.html file.

   > [!NOTE]
   > If Internet Explorer displays the following message, click the message, and then click **Allow Blocked Content**.
   >
   > To help protect your security, Internet Explorer has restricted this file from showing active content that could access your computer. Click here for options.

5. Click the **Click here to attempt to close window using window.setTimeout(window.close, 1)** hyperlink.

   You expect the Internet Explorer window to close. However, the Internet Explorer window does not close.
