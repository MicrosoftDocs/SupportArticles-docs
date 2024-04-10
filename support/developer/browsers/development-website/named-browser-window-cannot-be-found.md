---
title: A named window can't be found in Internet Explorer
description: A window name cannot be found when Internet Explorer is started by using Terminal Services RemoteApp.
ms.date: 06/09/2020
ms.reviewer: 
---
# Named browser windows cannot be found when Internet Explorer is started as a published application

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem that you can't find the named browser window when Internet Explorer starts as a published application.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2833316

## Symptoms

Consider the following scenario:

- User Account Control (UAC) is turned off.
- Internet Explorer is not started from the user desktop shell environment (Explorer.exe). This scenario is often encountered when Internet Explorer is started in one of the following ways:

  - Through Terminal Services RemoteApp
  - As the named application on the **Remote Desktop Connection** (mstsc.exe) Programs tab
  - Through third-party remote session services such as those that are provided by Citrix

- You use a webpage that programmatically sets the window name, and then you open a new window from this page.
In this scenario, a blank window is created, and the initial page remains unmodified. However, you expect the initial page to be changed.

The following HTML markup example demonstrates this scenario. The original script names the window. Then, when the page loads, the script creates a new window. The script in the new window automatically tries to insert the **success** text string into the page from which the new window was created by using the original window's name.

- main.html

  ```html
  <!DOCTYPE html>
  <html>
      <head>
          <script type="text/javascript">
              function initScr() {
              self.name = "MainWindow"
              var ret = (window.open("second.html", "_blank"));
              }
          </script>
      </head>
      <body onload="initScr()">
          main window
          <div id="mydiv">
              original content
          </div>
      </body>
  </html>
  ```

- second.html

  ```html
  <!DOCTYPE html>
  <html>
      <head>
          <script type="text/javascript">
              function initScr() {
              var ret = (window.open("", "MainWindow"));
              var el = ret.document.getElementById("mydiv");
              el.innerHTML = "success";
              }
          </script>
      </head>
      <body onload="initScr()">
          second window
      </body>
  </html>
  ```

## Resolution

### Resolution 1

To resolve this issue, we recommend that you enable UAC. Because the issue occurs on terminal servers, and because Internet Explorer is executed as a shell, you should have UAC enabled for security reasons.

For more information about when UAC should be turned off in Windows Server, see [Disabling User Account Control (UAC) on Windows Server](https://support.microsoft.com/help/2526083).

### Resolution 2

To resolve this issue, you can also start with a temporary page that opens the first window and then either close the temporary page or minimize it. However, if you close the page, the temporary page may not close automatically and may require user intervention to enable it to close.

In the example script that is mentioned in the [Symptoms](#symptoms) section, take the following action:

In **main.html**, comment out the line that contains **self.name**, and then create a new page to open the original first window (**main.html**) and close or minimize the new page.

- temp.html

  ```html
  <!DOCTYPE html>
  <html>
      <body>
          <script language="javascript">
              window.open("main.html", "MainWindow");
              window.close();
          </script>
      </body>
  </html>
  ```

Instead of starting with **main.html**, you now start with the new page (**temp.html**).

## More information

This issue can also occur when Internet Explorer is launched by using an Administrator account. By default, members of the local Administrators security group are unaffected by UAC controls and operating constraints.
