---
title: File copy operation overwritten content in write-sharing mode
description: File content is overwritten if the file is locked by the LockFileEx function in write-sharing mode (FILE_SHARE_WRITE).
ms.date: 09/08/2020
ms.reviewer: soshogoh
ms.technology: windows-dev-apps-system-services-dev
---
# File copy operation deletes file content if the file is locked with FILE_SHARE_WRITE

## Symptoms

Assume that you lock a file by using the `LockFileEx` function in a Windows environment while the destination file is open in write-sharing mode (`FILE_SHARE_WRITE`). In this scenario, the file content is overwritten by other processes.

The following example describes how this scenario might occur.

From process A, you open the destination file in write-sharing mode, and then lock the file by using the `LockFileEx` function. If you copy and overwrite the same file from File Explorer, you receive an error message. If you select **Cancel** and then exit, the size of the destination file remains the same. However, the file content is replaced with **0x00**.

The error message reads as follows:

> An unexpected error is keeping you from copying the file. If you continue to receive this error. You can use the error code to search for help with this problem.  
Error 0x80070021:  
The process cannot access the file because another process has locked a portion of the file.

Sample code for process A:

```c++
int wmain
(
    int argc,
    TCHAR* argv[]
)
{
    HANDLE fh, h;
    BOOL ret;
    OVERLAPPED mOv= { 0 };

    if (argc < 2) {
        printf("Usage: LockFile Filename\n");
        return 1;
    }
    fh =CreateFileW(argv[1],
                    GENERIC_READ | READ_CONTROL,
                    FILE_SHARE_READ | FILE_SHARE_WRITE,
                    NULL,
                    OPEN_EXISTING,
                    FILE_ATTRIBUTE_NORMAL,
                    NULL);
    if (fh == INVALID_HANDLE_VALUE) {
        printf("CreateFileW failed with error: 0x%0x\n", GetLastError());
        goto Exit;
    }
    ret = LockFileEx(fh, LOCKFILE_FAIL_IMMEDIATELY, 0, 0xffffffff, 0xffffffff, &mOv);
    if (!ret) {
        printf("LockFileEx failed with erro: 0x%0x\n", GetLastError());
        CloseHandle(fh);
        goto Exit;
    }
    getchar();
Exit:
    return 0;
}
```

## Cause

This issue is caused by limitations in the implementation of the Windows file system. When the `LockFileEx` function is used, the lock is a Read/Write lock in the byte range that is specified in the third and fourth arguments.

In File Explorer, the "file overwrite" copy process uses the `CreateFile` and `CopyFileEx` function, and internally reduces or changes the file size by the `NtSetFileInformation` function. The byte-range locking functionality of the `LockFileEx` function cannot lock the file when the `NtSetFileInformation` function changes the file size. Therefore, the data can be changed by setting write-sharing mode.

## Workaround

To work around this issue, you can protect the data writing operation in a file by not specifying write-sharing mode (`FILE_SHARE_WRITE`) when you open the file by using the `CreateFile` function.
