---
title: XMLHttpRequest cannot correctly send FormData
description: Describes an issue in which XMLHttpRequest cannot correctly send FormData containing empty file elements in Microsoft Edge for Windows 10, version 1809.
ms.date: 03/26/2020
ms.reviewer: DEV_Triage, yuhara
---
# XMLHttpRequest cannot correctly send FormData that has an empty file element in Microsoft Edge

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the workaround to solve the issue that `FormData` that contains an empty file element cannot be sent correctly by `XMLHttpRequest` in Microsoft Edge for Windows 10, version 1809.

_Original product version:_ &nbsp; Microsoft Edge, Windows 10  
_Original KB number:_ &nbsp; 4490157

## Symptoms

When the `XMLHttpRequest` (`jQuery.ajax()`) method is sent, it cannot correctly send a `FormData` object that contains an empty file element in Microsoft Edge for Windows 10, version 1809.

For example, you set a file that contains one file element only and all the other file elements blank as in the following code example:

```javascript
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-1.12.4.js"
            integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU="
            crossorigin="anonymous"></script>
    </head>
    <body>
        <form action="/AjaxUploadSample/Home/FileUpload" enctype="multipart/form-data" method="post">
            <input name="files" id="files" type="file" value=""><br>
            <input name="files" id="files" type="file" value=""><br>
            <input name="files" id="files" type="file" value=""><br>
            <button id="btn" type="button">Async Upload</button>
        </form>
        <hr>
        <p id="message" style="white-space:pre;"></p>
        <script>
            $(document).ready(function () {
                $("#btn").on("click", function () {
                    var _form = $(this).closest("form")[0];
                    $.ajax({
                        type: "post",
                        url: _form.action,
                        processData: false,
                        contentType: false,
                        data: new FormData(_form),
                        success: function (data, textStatus, jqXHR) {
                            $("#message").text(data.Message);
                        }
                    });
                });
            });
        </script>
    </body>
</html>
```

When you click **Async Upload**, the set file is not recognized correctly.

## Cause

This issue occurs when the implementation of `FormData` is changed in Microsoft Edge for Windows 10, version 1809.

## Workaround

To work around this issue, insert the following code before `$.ajax()` is called and explicitly skip empty entries.

```javascript
// Workaround
var _data = new FormData(_form);
if (_data.entries)
{
    var data = new FormData();
    for (var p of _data)
    {
        if (p[1])
        {
            // p[1] is the value of form entry
            data.append(p[0], p[1]);
        }
    } _data = data;
}
$.ajax(
{
    type: 'post',
    url: _form.action,
    processData: false,
    contentType: false,
    data: _data,
    success: function (data, textStatus, jqXHR)
    {
        $('#message').text(data.Message);
    }
});
```
