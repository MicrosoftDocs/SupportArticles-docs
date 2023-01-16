---
title: Asynchronous disk I/O appears synchronous
description: This article describes a problem where asynchronous disk I/O appears as synchronous on Windows.
ms.date: 03/13/2020
ms.custom: sap:System services development
ms.reviewer: allend
ms.technology: windows-dev-apps-system-services-dev
---
# Asynchronous disk I/O appears as synchronous on Windows

This article helps you resolve the problem where the default behavior for I/O is synchronous, but it appears as asynchronous.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 156932

## Summary

File I/O on Microsoft Windows can be synchronous or asynchronous. The default behavior for I/O is synchronous, where an I/O function is called and returns when the I/O is complete. Asynchronous I/O allows an I/O function to return execution back to the caller immediately, but the I/O is not assumed to be complete until some future time. The operating system notifies the caller when the I/O is complete. Instead, the caller can determine the status of the outstanding I/O operation by using services of the operating system.

The advantage of asynchronous I/O is that the caller has time to do other work or issue more requests while the I/O operation is being completed. The term Overlapped I/O is frequently used for Asynchronous I/O and Non-overlapped I/O for Synchronous I/O. This article uses the terms Asynchronous and Synchronous for I/O operations. This article assumes the reader has familiarity with the File I/O functions such as `CreateFile`, `ReadFile`, `WriteFile`.

Frequently, asynchronous I/O operations behave just as synchronous I/O. Certain conditions that this article discusses in the later sections, which makes the I/O operations complete synchronously. The caller has no time for background work because the I/O functions do not return until the I/O is complete.

Several functions are related to synchronous and asynchronous I/O. This article uses `ReadFile` and `WriteFile` as examples. Good alternatives would be `ReadFileEx` and `WriteFileEx`. Although this article discusses only disk I/O specifically, many of the principles can be applied to other types of I/O, such as serial I/O or network I/O.

## Set up asynchronous I/O

The `FILE_FLAG_OVERLAPPED` flag must be specified in `CreateFile` when the file is opened. This flag allows I/O operations on the file to be done asynchronously. Here is an example:

```cpp
HANDLE hFile;

hFile = CreateFile(szFileName,
                      GENERIC_READ,
                      0,
                      NULL,
                      OPEN_EXISTING,
                      FILE_FLAG_NORMAL | FILE_FLAG_OVERLAPPED,
                      NULL);

if (hFile == INVALID_HANDLE_VALUE)
      ErrorOpeningFile();
```

Be careful when you code for asynchronous I/O because the system reserves the right to make an operation synchronous if it needs to. So it is best if you write the program to correctly handle an I/O operation that may be completed either synchronously or asynchronously. The sample code demonstrates this consideration.

There are many things a program can do while waiting for asynchronous operations to complete, such as queuing additional operations, or doing background work. For example, the following code properly handles overlapped and non-overlapped completion of a read operation. It does nothing more than wait for the outstanding I/O to complete:

```cpp
if (!ReadFile(hFile,
               pDataBuf,
               dwSizeOfBuffer,
               &NumberOfBytesRead,
               &osReadOperation )
{
   if (GetLastError() != ERROR_IO_PENDING)
   {
      // Some other error occurred while reading the file.
      ErrorReadingFile();
      ExitProcess(0);
   }
   else
      // Operation has been queued and
      // will complete in the future.
      fOverlapped = TRUE;
}
else
   // Operation has completed immediately.
   fOverlapped = FALSE;

if (fOverlapped)
{
   // Wait for the operation to complete before continuing.
   // You could do some background work if you wanted to.
   if (GetOverlappedResult( hFile,
                           &osReadOperation,
                           &NumberOfBytesTransferred,
                           TRUE))
      ReadHasCompleted(NumberOfBytesTransferred);
   else
      // Operation has completed, but it failed.
      ErrorReadingFile();
}
else
   ReadHasCompleted(NumberOfBytesRead);
```

> [!NOTE]
> `&NumberOfBytesRead` passed into `ReadFile` is different from `&NumberOfBytesTransferred` passed into `GetOverlappedResult`. If an operation has been made asynchronous, then `GetOverlappedResult` is used to determine the actual number of bytes transferred in the operation after it has completed. The `&NumberOfBytesRead` passed into `ReadFile` is meaningless.

On the other hand, if an operation is completed immediately, then `&NumberOfBytesRead` passed into `ReadFile` is valid for the number of bytes read. In this case, ignore the `OVERLAPPED` structure passed into `ReadFile`; do not use it with `GetOverlappedResult` or `WaitForSingleObject`.

Another caveat with asynchronous operation is that you must not use an `OVERLAPPED` structure until its pending operation has completed. In other words, if you have three outstanding I/O operations, you must use three `OVERLAPPED` structures. If you reuse an `OVERLAPPED` structure, you will receive unpredictable results in the I/O operations and you may experience data corruption. Additionally, you must correctly initialize it so no left-over data affects the new operation before you can use an `OVERLAPPED` structure for the first time or before you reuse it after an earlier operation has completed.

The same type of restriction applies to the data buffer used in an operation. A data buffer must not be read or written until its corresponding I/O operation has completed; reading or writing the buffer may cause errors and corrupted data.

## Asynchronous I/O still appears to be synchronous

If you followed the instructions earlier in this article, however, all your I/O operations are still typically complete synchronously in the order issued, and none of the `ReadFile` operations returns **FALSE** with `GetLastError()` returning `ERROR_IO_PENDING`, which means you have no time for any background work. Why does this occur?

There are a number of reasons why I/O operations complete synchronously even if you have coded for asynchronous operation.

### Compression

One obstruction to asynchronous operation is New Technology File System (NTFS) compression. The file system driver will not access compressed files asynchronously; instead all operations are made synchronous. This obstruction doesn't apply to files that are compressed with utilities similar to COMPRESS or PKZIP.

### NTFS encryption

Similar to compression, file encryption causes the system driver to convert asynchronous I/O to synchronous. If the files are decrypted, the I/O requests will be asynchronous.

### Extend a file

Another reason that I/O operations are completed synchronously is the operations themselves. On Windows, any write operation to a file that extends its length will be synchronous.

> [!NOTE]
> Applications can make the previously mentioned write operation asynchronous by changing the Valid Data Length of the file by using the `SetFileValidData` function, and then issuing a `WriteFile`.

Using `SetFileValidData` (which is available on Windows XP and later versions), applications can efficiently extend files without incurring a performance penalty for zero-filling them.

Because the NTFS file system doesn't zero-fill the data up to the valid data length (VDL) that is defined by `SetFileValidData`, this function has security implications where the file may be assigned clusters that were previously occupied by other files. Therefore, `SetFileValidData` requires that the caller has the new `SeManageVolumePrivilege` enabled (by default, this is assigned only to administrators). Microsoft recommends that independent software vendors (ISVs) carefully consider the implications of using such function.

### Cache

Most I/O drivers (disk, communications, and others) have special case code where, if an I/O request can be completed immediately, the operation will be completed and the `ReadFile` or `WriteFile` function will return **TRUE**. In all ways, these types of operations appear to be synchronous. For a disk device, typically, an I/O request can be completed immediately when the data is cached in memory.

### Data is not in cache

However, the cache scheme can work against you if the data is not in the cache. The Windows cache is implemented internally using file mappings. The memory manager in Windows doesn't provide an asynchronous page fault mechanism to manage the file mappings used by the cache manager. The cache manager can verify whether the requested page is in memory, so if you issue an asynchronous cached read and the pages are not in memory, the file system driver assumes that you do not want your thread blocked and the request will be handled by a limited pool of worker threads. Control is returned to your program after your `ReadFile` call with the read still pending.

This works fine for a small number of requests, but because the pool of worker threads is limited (currently three on a 16-MB system), there will still be only a few requests queued to the disk driver at a particular time. If you issue numerous I/O operations for data that is not in the cache, the cache manager and memory manager become saturated and your requests are made synchronous.

The behavior of the cache manager can also be influenced based on whether you access a file sequentially or randomly. Benefits of the cache are seen most when accessing files sequentially. The `FILE_FLAG_SEQUENTIAL_SCAN` flag in the `CreateFile` call will optimize the cache for this type of access. However, if you access files in a random fashion, use the `FILE_FLAG_RANDOM_ACCESS` flag in `CreateFile` to instruct the cache manager to optimize its behavior for random access.

### Don't use the cache

The `FILE_FLAG_NO_BUFFERING` flag has the most effect on the behavior of the file system for asynchronous operation. It is the best way to guarantee that I/O requests are asynchronous. It instructs the file system to not use any cache mechanism at all.

> [!NOTE]
> There are some restrictions to using this flag that has to do with the data buffer alignment and the device's sector size. For more information, see the function reference in the documentation for the CreateFile function about using this flag properly.

## Real world test results

The followings are some test results from the sample code. The magnitude of the numbers is not important here and varies from computer to computer, but the relationship of the numbers compared to each other illuminates the general effect of the flags on performance.

You can expect to see results similar to one of the following:

- Test 1

    ```console
    Asynchronous, unbuffered I/O:  asynchio /f*.dat /n
    Operations completed out of the order in which they were requested.
       500 requests queued in 0.224264 second.
       500 requests completed in 4.982481 seconds.
    ```

   This test demonstrates that the previously mentioned program issued 500 I/O requests quickly and had much time to do other work or issue more requests.

- Test 2

    ```console
    Synchronous, unbuffered I/O: asynchio /f*.dat /s /n
        Operations completed in the order issued.
        500 requests queued and completed in 4.495806 seconds.
    ```

    This test demonstrates that this program spent 4.495880 seconds calling ReadFile to complete its operations, but the test 1 spent only 0.224264 second to issue the same requests. In test 2, there was no extra time for the program to do any background work.

- Test 3

    ```console
    Asynchronous, buffered I/O: asynchio /f*.dat
        Operations completed in the order issued.
        500 requests issued and completed in 0.251670 second.
    ```

   This test demonstrates the synchronous nature of the cache. All reads were issued and completed in 0.251670 second. In other words, asynchronous requests were completed synchronously. This test also demonstrates the high performance of the cache manager when data is in the cache.

- Test 4

    ```console
    Synchronous, buffered I/O: asynchio /f*.dat /s
        Operations completed in the order issued.
        500 requests and completed in 0.217011 seconds.
    ```

    This test demonstrates the same results as in test 3. Synchronous reads from the cache complete a little faster than asynchronous reads from the cache. This test also demonstrates the high performance of the cache manager when data is in the cache.

## Conclusion

You can decide which method is best because it all depends on the type, size, and number of operations that your program performs.

The default file access without specifying any special flags to `CreateFile` is a synchronous and cached operation.

> [!NOTE]
> You do get some automatic asynchronous behavior in this mode because the file system driver does predictive asynchronous read-ahead and asynchronous lazy writing of modified data. Although this behavior does not make the application's I/O asynchronous, it is the ideal case for the vast majority of simple applications.

On the other hand, if your application is not simple, you may have to do some profiling and performance monitoring to determine the best method, similar to the tests illustrated earlier in this article. Profiling the time spent in the `ReadFile` or `WriteFile` function and then comparing this time to how long it takes for actual I/O operations to complete is useful. If the majority of the time is spent in actually issuing the I/O, then your I/O is being completed synchronously. However, if the time spent issuing I/O requests is relatively small compared to the time it takes for the I/O operations to complete, then your operations are being treated asynchronously. The sample code mentioned earlier in this article uses the `QueryPerformanceCounter` function to do its own internal profiling.

Performance monitoring can help determine how efficiently your program is using the disk and the cache. Tracking any of the performance counters for the Cache object will indicate the performance of the cache manager. Tracking the performance counters for the Physical Disk or Logical Disk objects will indicate the performance of the disk systems.

There are several utilities that are helpful in performance monitoring. `PerfMon` and `DiskPerf` are especially useful. For the system to collect data on the performance of the disk systems, you must first issue the `DiskPerf` command. After you issue the command, you must restart the system to start the data collection.

## References

[Synchronous and Asynchronous I/O](/windows/win32/fileio/synchronous-and-asynchronous-i-o)
