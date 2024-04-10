---
title: OutOfMemoryException in .NET Framework 4.6.1
description: This article describes a problem that causes a managed application that targets the .NET Framework 4.6.1 to throw an out-of-memory exception from the CLR.
ms.date: 05/06/2020
---
# An out-of-memory exception in a managed application that's running on the 64-bit .NET Framework

This article helps you resolve the out-of-memory exception when you have a managed application that targets the 64-bit Microsoft .NET Framework 4.6.1.

_Original product version:_ &nbsp; .NET Framework 4.6.1  
_Original KB number:_ &nbsp; 3152158

## Symptoms

You have a managed application that targets the 64-bit .NET Framework 4.6.1. This application throws an out-of-memory exception from the Common Language Runtime (CLR) with the following specific message:

> OutOfMemoryException: "Insufficient memory within specified address space range to continue the execution of the program."

## Cause

This out-of-memory exception is propagated by the CLR when the code manager subsystem can't allocate memory within a specific address space range for jump stubs. (These jump stubs correspond to the method that calls among Dynamic-link libraries (DLLs) that are located 2 GB or more apart in the address space.) There must be space within a 2-GB radius of the calling method to store the jump stub for a 64-bit method call. There's no safe way for an application to recover from this specific error. So the state of the application after it meets this error is unknown and it should be considered corrupted. The only way to recover is to restart the application.

## Workaround

To work around this issue, use one of the following setting methods:

- Implement a machine-wide setting by adding the following registry key:

  - Location: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework`  
  - Type: DWORD
  - Name: NGenReserveForjumpStubs
  - Value: 00000005

- Implement an application-level setting by adding the following section to your application config file:

    ```xml
    <configuration>
        <runtime>
            <NGenReserveForJumpStubs value="5" />
        </runtime>
    </configuration>
    ```

    > [!NOTE]
    > `NGenReserveForJumpStubs` causes the CLR to reserve a percentage of the address space for jump stubs near each loaded NGen image. We recommend you use a value of 5 or greater if you're experiencing this `OutOfMemoryException`.

## Information for developers

- The .NET Framework encodes method calls as relative 32-bit jumps for performance reasons. On a 64-bit system, caller and callee can be further apart than 2 GB (in address space). Because it exceeds the address range of a signed 32-bit offset, .NET will create a jump stub within 2 GB of the caller. This jump stub can then make the long jump to anywhere in the 64-bit address space.

- The JIT and NGen mitigations work slightly differently. Both of them reserve extra address space up front, but the point where this reservation is made differs between the two.
- `NGenReserveForJumpStubs` is a percentage of virtual NGen image size ([percentReserveForJumpStubs](https://github.com/dotnet/coreclr/blob/master/src/vm/pefile.cpp#l1690)).

- A typical jump stub is 12 bytes. For more information, see [JUMP_ALLOCATE_SIZE](https://github.com/dotnet/coreclr/blob/a8192fbc7064ed96cfeb8872bcb6479c217f7b5f/src/vm/amd64/cgencpu.h#l49).

- The memory is allocated and reserved close to the address where the NGen image was loaded (the exact algorithm is [EEJitManager::EnsureJumpStubReserve](https://github.com/dotnet/coreclr/blob/a8192fbc7064ed96cfeb8872bcb6479c217f7b5f/src/vm/codeman.cpp#l1892). The memory is committed when there's a need to allocate a jump stub, and when there's no other suitable address space available.

- The previously mentioned mitigation doesn't modify the content of NGen images. The NGen images have the same disk footprint both with and without mitigation.

- There's currently no good way to detect when the application is getting close to the limit. You can monitor for the `OutOfMemoryException` to determine whether the reserved space is sufficient.

- You may receive the `OutOfMemoryException` even if there's much unused memory because this specific error is related to the availability of memory within a 2-GB address range radius of the caller.

- Don't change the default value of `CodeHeapReserveForJumpStubs`, because it may not be related to the issue described above. We haven't seen case where the actual application would have to adjust this setting as a workaround.
- Setting `NGenReserveForJumpStubs` to a higher value may lead to reduced performance and the risk of exposing other subtle issues.

## Information for IT users

- This issue may also occur on other versions of the .NET Framework. However, the workaround is currently applicable only to the .NET Framework 4.6.1.
- It's a rare issue that only affects large workloads that have a particular execution pattern. More than 99 percent of all workloads will ever experience this issue.
- After the application throws an `OutOfMemoryException`, the only recommended way to recover is to restart the application.
