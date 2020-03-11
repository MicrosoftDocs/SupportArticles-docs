---
title: Operation aborted if visiting a web page in IE 
description: Describes a problem that occurs in Internet Explorer. You receive an "Operation aborted" error message when you visit a web page.
ms.date: 03/08/2020
ms.prod-support-area-path: Internet Explorer
---
# "Operation aborted" error when you visit a Web page in Internet Explorer

This article discusses the "Operation aborted" error message that occurs when you visit a Web page in Internet Explorer 7. And also provides more information for developers to make simple changes to their Web sites that will make them fully compatible with Internet Explorer 7.

_Original product version:_ &nbsp; Internet Explorer 7  
_Original KB number:_ &nbsp; 927917

## Symptoms

When you visit a Web page in Internet Explorer, you receive the following error message:

> Internet Explorer cannot open the Internet site http://\<**Web site**>.com. Operation aborted.

## Cause

Internet Explorer 7 cannot display a particular element on a Web page on that Web site.

## Resolution

The easiest way for you to fix the problem is to upgrade to Internet Explorer 8. This problem no longer occurs in Internet Explorer 8.

You can also contact the Web site owners and tell them that you cannot view their Web site in Internet Explorer 7. If the Web site developers are interested, the [More Information for developers](#more-information-for-developers) section explains how Web developers can make simple changes to their Web sites that will make them fully compatible with Internet Explorer 7. In the meantime, you will be unable to view this Web site, so upgrading to Internet Explorer 8 may be the better option for you.

## More information for developers

This problem occurs because a child container HTML element contains script that tries to modify the parent container element of the child container. The script tries to modify the parent container element by using either the innerHTML method or the appendChild method.

For example, this problem may occur if a DIV element is a child container in a BODY element, and a SCRIPT block in the DIV element tries to modify the BODY element that is a parent container for the DIV element.

Users may also receive this error message if a Web page in a Trusted Sites Zone sends an HTTP 302 redirect to a page in the Internet Zone. With protected mode, Internet Explorer 7 and later versions that are running on Windows Vista or a later operating system prevent redirects from Web pages that run at medium integrity to Web pages that run at low integrity for security reasons. In these scenarios, users may receive a similar "Operation Aborted" error message. To resolve this issue, make sure that HTTP 302 redirects are for pages within the same zone. For example, make sure that a redirect is from one Trusted Sites Zone page to another Trusted Sites Zone page. Or, make sure that both the source and the destination of the redirect don't involve a change in Internet Explorer's protected mode status.

### Workaround 1

To work around this problem, write script blocks that modify only closed containers or that modify only the script's immediate container element. To do this, you can use a placeholder to close the target container, or you can move the script block into the container that you want to modify.

### Workaround 2

You can turn off friendly HTTP error messages in Internet Explorer. This workaround still lets the error message appear. However, Internet Explorer does not move away from the page after the error occurs. This workaround works only for Internet Explorer 6. To do this, follow these steps:

1. On the **Tools** menu, click **Internet Options**.

2. On the **Advanced** tab, click to clear the **Show friendly HTTP error messages** check box under the **Browsing** section, and then click **OK**.

3. Close the browser.

### Workaround 3

You can disable Active Scripting in Internet Explorer. This workaround avoids the error condition by preventing any script from running. But, the drawback of this workaround is that the page does not show changes that result from earlier successful dynamic changes to the page. Also, all pages in the same security zone do not have Active Scripting enabled until the feature is re-enabled.

For Internet Explorer 7, use one of the following methods:

#### Method 1

Add the individual site to Restricted Sites where scripting is disabled by default.

> [!NOTE]
> This method affects not only scripting but also many other areas of the page, including ActiveX controls, that are disabled or set to prompt for this zone.

To do this, follow these steps:

1. On the **Tools** menu, click **Internet Options**.

2. On the **Security** tab, select the **Restricted Sites** zone.

3. Click **Sites**, click **Add**, and then click **OK**.

#### Method 2

Set the Active Scripting to Prompt or to Disabled when you view an affected site for the zone in which the site loads.

> [!NOTE]
> This setting affects all the sites in the zone and should be set back to Enabled when you browse other sites. Determine what zone the site is loaded under by viewing the lower-right corner of the Status Bar.

1. On the **Tools** menu, click **Internet Options**.

2. On the **Security** tab, select the zone the site loads under.

3. Scroll down to the **Scripting** section, and set the Active Scripting to **Disabled - prevents scripts** or to **Prompt - prompts user to run or not to run scripts**.

4. Click **OK**.

> [!NOTE]
> Method 1 and method 2 for Internet Explorer 7 may make the site unusable. Only disable scripts if the issue occurs frequently on the same site. If you change the **Scripting** setting, make sure that you reset the setting back to **Enabled** afterward so that other sites in that zone are not affected. If you cannot disable scripting, use Workaround 1, or upgrade to Internet Explorer 8.

### Example 1

In this example, the DIV element is a child container element. The SCRIPT block inside the DIV element tries to modify the BODY element. The BODY element is the unclosed parent container of the DIV element.

```html
<html>
  <body>
     <div>
    <script type="textJavascript">  
       document.body.innerHTML+="sample text";
    </script>
     </div>
  </body>
</html>
```

To resolve this problem, use one of the following methods:

#### Method 1: Modify the parent element

Move the SCRIPT block into the scope of the BODY element. This is the container that the script is trying to modify.

```html
<html>
  <body>
    <div>
    </div>
    <script type="text/Javascript">
        document.body.innerHTML+="sample text";
    </script>
  </body>
</html>
```

#### Method 2: Modify a closed container element

Add a closed container as a placeholder in the parent container element. Then, modify the new closed container with a script block.

```html
<html>
  <body>
    <div id="targetContainer">
   </div>
   <div>
   <script type="text/Javascript">
      document.getElementById('targetContainer').innerHTML+="sample text";
   </script>
   </div>
  </body>
</html>
```

### Example 2

In this example, a SCRIPT block that is inside a deeply nested TD container element tries to modify a parent container BODY element by using the appendChild method.

```html
<html>
  <body>
    <table>
     <tr>
      <td>
       <script type="text/Javascript">
                       var d = document.createElement('div');
                       document.body.appendChild(d);
       </script>
      </td>
     </tr>
    </table>
  </body>  
</html>
```

To resolve this problem, move the SCRIPT block into the BODY element.

```html
<html>  
  <body>
   <table>
       <tr>
         <td>
        </td>
       </tr>
   </table>
    <script type="text/Javascript">
                     var d = document.createElement('div');
                     document.body.appendChild(d);
    </script>
 </body>
</html>
```
