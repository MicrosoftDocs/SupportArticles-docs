---
title: Wrong calculation of the scrollHeight
description: This article describes the ScrollHeight property calculation error that causes a scrollbar to appear on the webpage.
ms.date: 06/09/2020
ms.reviewer: adamki
---
# The scrollHeight property may return incorrect values in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides an example to call the Scroll height property to set the height of the web page.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2684777

## Symptoms

The `scrollHeight` property of an iframe may return a value smaller than expected. Using this value to resize the iframe's height may cause the vertical scrollbar to appear thereby making the contents taller.

## Cause

Microsoft has confirmed there is a problem with the `scrollHeight` property calculation.

## Workaround

Add additional padding to the height. This will resolve most situations if the scrollbar appearing is unwanted. Alternately, switch to Internet Explorer 9's standards document mode since the problem does not occur in that mode.

## More information

It is not exactly known all of the conditions required for this problem to appear. In some situations, the problem only appears at other zoom levels besides 100%.

Below is an example where the **scrollHeight** is not large enough to use as the **pixelHeight** even though the **padding**, **margin**, and **border** are all **0px** in the iframe's `html` and `body` element. When the iframe is larger than the content, it gives a **scrollHeight** of **491** even though **491** is not enough to prevent the scrollbars from appearing. This particular example only reproduces in Internet Explorer 8 standards mode. Other examples may reproduce for Internet Explorer 9 and later versions standards mode and/or Quirks mode.

- test.htm

```html
<!doctype>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=8"/>
    </head>
    <body>
        <button onclick="Test()">Set iframe's pixelHeight to scrollHeight</button><br/>
        <div id="myDiv" style="position: absolute; left: 200px; border: 2px solid black; height: 50px; width: 300px"></div>
        <iframe style="width: 182px; height: 491px; border: 1px solid green;" id=myiframe src="iframe.htm" frameBorder=0></iframe>
        <script language="javascript">
            function Test()
            {
            var obj = document.getElementById("myiframe");
            obj.style.pixelHeight = obj.contentWindow.document.body.scrollHeight;
            var result = obj.contentWindow.document.body.scrollHeight;
            document.getElementById("myDiv").innerHTML = "iframe scrollHeight = " + result + "<br/>";
            }
        </script>
    </body>
</html>
```

- iframe.htm

```html
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html>
    <head>
        <style>
            body {
            font-family: verdana, arial, helvetica, sans-serif;
            font-size: 70%;
            padding: 0px; margin: 0px; border: 0px;
            }
            html { padding: 0px; margin: 0px; border: 0px; }
        </style>
    </head>
    <body>
        <div>
            <table>
                <tbody>
                    <tr>
                        <td>
                            <p>1st row in p tags</p>
                        </td>
                    </tr>
                    <tr>
                        <td>2nd row</td>
                    </tr>
                    <tr>
                        <td>
                            3rd row of text
                            <div>
                                <hr>
                                Text below the hr that wraps to next line<br>
                                This line of text is lone enough to go to four lines and at seventy five percent zoom will cause the problem<br>
                                <hr>
                                abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf abcdedf
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
```

If the iframe's height is set based on this property in the onresize event handler, you need to be careful to avoid an infinite stream of onresize calls since you may be toggling the height of the iframe between a height with no scrollbars and a height with scrollbars. Adding the padding or using flags should prevent the infinite recursion.
