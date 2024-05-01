---
title: Race conditions and deadlocks
description: This article describes that Visual Basic offers the ability to use threads in Visual Basic applications for the first time. Threads introduce debugging issues such as race conditions and deadlocks.
ms.date: 04/13/2020
ms.reviewer: heikkiri, zakramer
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
---
# Race conditions and deadlocks

Visual Basic .NET or Visual Basic offers the ability to use threads in Visual Basic applications for the first time. Threads introduce debugging issues such as race conditions and deadlocks. This article explores these two issues.

_Original product version:_ &nbsp; Visual Basic, Visual Basic .NET  
_Original KB number:_ &nbsp; 317723

## When race conditions occur

A race condition occurs when two threads access a shared variable at the same time. The first thread reads the variable, and the second thread reads the same value from the variable. Then the first thread and second thread perform their operations on the value, and they race to see which thread can write the value last to the shared variable. The value of the thread that writes its value last is preserved, because the thread is writing over the value that the previous thread wrote.

## Details and examples for a race condition

Each thread is allocated a predefined period of time to execute on a processor. When the time that is allocated for the thread expires, the thread's context is saved until its next turn on the processor, and the processor begins the execution of the next thread.

## How can a one-line command cause a race condition

Examine the following example to see how a race condition occurs. There are two threads, and both are updating a shared variable called *total* (which is represented as `dword ptr ds:[031B49DCh]` in the assembly code).

- *Thread 1*

    ```vb
    Total = Total + val1
    ```

- *Thread 2*

    ```vb
    Total = Total - val2
    ```

Assembly code (with line numbers) from the compilation of the preceding Visual Basic code:

- *Thread 1*

    ```x86asm
    1. mov eax,dword ptr ds:[031B49DCh]
    2. add eax,edi
    3. jno 00000033
    4. xor ecx,ecx
    5. call 7611097F
    6. mov dword ptr ds:[031B49DCh],eax
    ```

- *Thread 2*

    ```x86asm
    1. mov eax,dword ptr ds:[031B49DCh]
    2. sub eax,edi
    3. jno 00000033
    4. xor ecx,ecx
    5. call 76110BE7
    6. mov dword ptr ds:[031B49DCh],eax
    ```

By looking at the assembly code, you can see how many operations the processor is performing at the lower level to execute a simple addition calculation. A thread may be able to execute all or part of its assembly code during its time on the processor. Now look at how a race condition occurs from this code.

`Total` is 100, `val1` is 50, and `val2` is 15. *Thread 1* gets an opportunity to execute but only completes steps 1 through 3. This means that *Thread 1* read the variable and completed the addition. *Thread 1* is now just waiting to write out its new value of 150. After *Thread 1* is stopped, *Thread 2* gets to execute completely. This means that it has written the value that it calculated (85) out to the variable `Total`. Finally, *Thread 1* regains control and finishes execution. It writes out its value (150). Therefore, when *Thread 1* is finished, the value of `Total` is now 150 instead of 85.

You can see how this might be a major problem. If this is a banking program, the customer would have money in their account that should not be present.

This error is random, because it is possible for *Thread 1* to complete its execution before it's time on the processor expires, and then *Thread 2* can begin its execution. If these events occur, the problem does not occur. Thread execution is nondeterministic, therefore you cannot control the time or order of execution. Also note that the threads may execute differently in runtime versus debug mode. Also, you can see that if you execute each thread in series, the error does not occur. This randomness makes these errors much harder to track down and debug.

To prevent the race conditions from occurring, you can lock shared variables, so that only one thread at a time has access to the shared variable. Do this sparingly, because if a variable is locked in *Thread 1* and *Thread 2* also needs the variable, *Thread 2*'s execution stops while *Thread 2* waits for *Thread 1* to release the variable. (For more information, see `SyncLock` in the [References](#references) section of this article.)

### Symptoms for a race condition

The most common symptom of a race condition is unpredictable values of variables that are shared between multiple threads. This results from the unpredictability of the order in which the threads execute. Sometime one thread wins, and sometime the other thread wins. At other times, execution works correctly. Also, if each thread is executed separately, the variable value behaves correctly.

## When deadlocks occur

A deadlock occurs when two threads each lock a different variable at the same time and then try to lock the variable that the other thread already locked. As a result, each thread stops executing and waits for the other thread to release the variable. Because each thread is holding the variable that the other thread wants, nothing occurs, and the threads remain deadlocked.

## Details and examples for deadlocks

The following code has two objects, `LeftVal` and `RightVal`:

- *Thread 1*

    ```vb
    SyncLock LeftVal
        SyncLock RightVal
            'Perform operations on LeftVal and RightVal that require read and write.
        End SyncLock
    End SyncLock
    ```

- *Thread 2*

    ```vb
    SyncLock RightVal
        SyncLock LeftVal
            'Perform operations on RightVal and LeftVal that require read and write.
        End SyncLock
    End SyncLock
    ```

A deadlock occurs when *Thread 1* is permitted to lock `LeftVal`. The processor stops *Thread 1*'s execution and begins the execution of *Thread 2*. *Thread 2* locks `RightVal` and then tries to lock `LeftVal`. Because `LeftVal` is locked, *Thread 2* stops and waits for `LeftVal` to be released. Because *Thread 2* is stopped, *Thread 1* is permitted to continue executing. *Thread 1* tries to lock `RightVal` but cannot, because *Thread 2* has locked it. As a result, *Thread 1* starts to wait until RightVal becomes available. Each thread waits for the other thread, because each thread has locked the variable that the other thread is waiting on, and neither thread is unlocking the variable that it is holding.

A deadlock does not always occur. If *Thread 1* executes both locks before the processor stops it, *Thread 1* can perform its operations and then unlock the shared variable. After *Thread 1* unlocks the variable, *Thread 2* can proceed with its execution, as expected.

This error seems obvious when these snippets of code are placed side by side, but in practice, the code may appear in separate modules or areas of your code. This is a hard error to track down because, from this same code, both correct execution and incorrect execution can occur.

### Symptoms for deadlocks

A common symptom of deadlock is that the program or group of threads stops responding. This is also known as a hang. At least two threads are waiting for a variable that the other thread locked. The threads do not proceed, because neither thread will release its variable until it gets the other variable. The whole program can hang if the program is waiting on one or both of those threads to complete execution.

### What is a thread

Processes are used to separate the different applications that are executing at a specified time on a single computer. The operating system does not execute processes, but threads do. A thread is a unit of execution. The operating system allocates processor time to a thread for the execution of the thread's tasks. A single process can contain multiple threads of execution. Each thread maintains its own exception handlers, scheduling priorities, and a set of structures that the operating system uses to save the thread's context if the thread cannot complete its execution during the time that it was assigned to the processor. The context is held until the next time that the thread receives processor time. The context includes all the information that the thread requires to seamlessly continue its execution. This information includes the thread's set of processor registers and the call stack inside the address space of the host process.

## References

For more information, search Visual Studio Help for the following keywords:

- `SyncLock`. Allows an object to be locked. If another thread tries to lock that same object, it is blocked until the first thread releases. Use `SyncLock` carefully, because problems can result from the misuse of SyncLock. For example, this command can prevent race conditions but cause deadlocks.

- `InterLocked`. Allows a select set of thread-safe operations on basic numeric variables.

For more information, see [Threads and Threading](/dotnet/standard/threading/threads-and-threading).
