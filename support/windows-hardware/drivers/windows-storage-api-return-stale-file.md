---
title: Windows.Storage APIs can return stale file
description: This article describes a problem that Windows.Storage APIs can return stale file or stream sizes after a file on an MTP 2.0 device is updated.
ms.date: 09/01/2020
ms.subservice: storage-driver
---
# Windows.Storage APIs can return stale file or stream sizes after a file on an MTP 2.0 device is updated

This article introduces a problem that Windows.Storage APIs can return stale file or stream sizes after a file on an MTP 2.0 device is updated.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2736948

## Summary

An app that uses the Windows.Storage.Streams.DataWriter API to update contents on an existing file on a Media Transfer Protocol (MTP) 2.0 portable device may get out-of-date results if it subsequently uses the same StorageFile to query for the file size. This affects scenarios that increase the size of the file by writing more data to the file than the original file size. Other affected scenarios include cases where app tries to use the size to seek to the end of the modified file to append data. The size will remain stale even after a new stream is retrieved using `StorageFile.OpenAsync` on the same StorageFile object.

## More information

The following JavaScript sample code demonstrates how the problem of stale sizes can happen. In example below, `file` is an existing file on the device that the code is opening the file to append data to it (therefore increasing the file size).

```javascript
file.openAsync(Windows.Storage.FileAccessMode.readWrite).done(function (stream) { // <=== file is a 0 sized file on the device
    console.log("Size before initial write: " + stream.size);
    var writer = new Windows.Storage.Streams.DataWriter(stream);
    writer.writeString("1234"); // <=== appending data to the end of the file. The data will be appended correctly.
    writer.storeAsync().done(function (bytesWritten) {
        writer.flushAsync().done(function () {
            console.log("Size after initial write: " + stream.size); // <=== Size will be stale. Expected the size to return 4 but 0 will be returned
            writer.close();
        });
    });
});
```

> [!NOTE]
> The above example only applies to MTP 2.0 devices that support MTP streams. `Windows.Storage.Streams.DataWriter` will fail if the device is an MTP 1.0 device or MTP 2.0 device that does not support streams because neither support writing to an existing file on the device. MTP 2.0 is a new revision of the MTP standard, most MTP devices currently in the market are still MTP 1.0 devices.

The following two examples demonstrate how the above code can be modified to work around the problem of reading stale sizes on the same StorageFile object after appending data to it. The gist of both workarounds involve getting a new StorageFile object after the file was written using `StorageFolder.GetFileAsync`(filename).

Your app will need two additional pieces of information for both workarounds:

- Pre-requisite 1: folder is a parent folder for the existing file.
- Pre-requisite 2: filename is used to reacquire the file after updates.

Two workarounds:

- First workaround reacquires the StorageFile object and then reopens a read stream to get the file size:

    ```javascript
    var filename = 'EmptyFile.txt'; // name of the existing file we are trying to update
        folder.getFileAsync(filename).done(function (file) { // <== folder is the parent folder of the file we are trying to update (EmptyFile.txt)
        file.openAsync(Windows.Storage.FileAccessMode.readWrite).done(function (stream) {
            console.log("Size before initial write: " + stream.size);
            var writer = new Windows.Storage.Streams.DataWriter(stream);
            writer.writeString("1234"); // Note: to reproduce the issue, this needs to write more bytes than the existing file size
            writer.storeAsync().then(function (bytesWritten) {
                writer.flushAsync().then(function () {
                    writer.close();
                    /// Begin workaround 1: re-acquire the file after it was written
                    // This workaround tries to follow the same pattern as the original code by acquiring a stream.
                    // Note however there are other ways to get the size, such as reading the file's basic properties
                    // This is demonstrated in the second workaround.
                    folder.getFileAsync(filename).done(function (file) {
                        file.openAsync(Windows.Storage.FileAccessMode.read).done(function (stream) {
                        console.log("Size after initial write: " + stream.size); // <=== new StorageFile object for the same file returns the correct size
                        });
                    });
                /// End workaround 1
                });
            });
        });
    });
    ```

- The second workaround uses `StorageFile.getBasicPropertiesAsync` to get the size instead of reopening the file:

    ```javascript
    var filename = 'EmptyFile.txt'; // name of the existing file we are trying to update
    folder.getFileAsync(filename).done(function (file) { // <=== folder is the parent folder for the file we are trying to update (EmptyFile.txt)
        file.openAsync(Windows.Storage.FileAccessMode.readWrite).done(function (stream) {
            console.log("Size before initial write: " + stream.size);
            var writer = new Windows.Storage.Streams.DataWriter(stream);
            writer.writeString("1234"); // Note: to reproduce the issue, this needs to write more bytes than the existing file size
            writer.storeAsync().then(function (bytesWritten) {
                writer.flushAsync().then(function () {
                    writer.close();
                    /// Begin workaround 2: re-acquire the file after it was written
                    folder.getFileAsync(filename).done(function (file) {
                        file.getBasicPropertiesAsync().done(function (props) {
                            console.log("Size after initial write: " + props.size); // <=== new StorageFile object for the same file returns the correct size
                        });
                    });
                /// End workaround 2
                });
            });
        });
    });
    ```
