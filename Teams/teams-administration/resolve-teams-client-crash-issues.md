---
title: Resolve Teams Client Crash Issues
description: Lists all possible causes for Teams client crash issues, and provides resolutions for them.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 3647
  - CSSTroubleshoot
ms.reviewer: shals
search.appverid: 
  - MET150
ms.date: 03/27/2025
---
# Resolve Teams "client crash" issues

> [!IMPORTANT]
> This article describes a Microsoft Teams feature that has been announced but hasn't yet been released. If you're an admin, you can check the release announcement in the Message Center (in the [Microsoft 365 admin center](https://portal.office.com/adminportal/home)). For more information, see [Teams client health](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478610) and [Monitor Teams client updates](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478609).

When a user in your organization uses the Teams app on their device, the app exits unexpectedly. This issue is categorized as a **Client crash** in the [Teams client health dashboard](/microsoftteams/teams-client-health).

As an administrator, you can check the **Insight** column on the **Issues** tab to find potential reasons why the Teams app stopped responding. This article lists all the insights for Teams "client crash" issues and provides resolutions for them. If the issue persists after you perform the resolution, contact [Microsoft Support](https://support.microsoft.com/contactus) for more assistance.

If your organization uses non-Microsoft antivirus or data loss prevention (DLP) applications, make sure that you include or approve the Teams desktop client, the executable that automatically starts the Teams app, and Microsoft Edge WebView2. For more information, see [Prevent antivirus and DLP tools from blocking or crashing Microsoft Teams](include-exclude-teams-from-antivirus-dlp.md)

## Media stack technology failure

To fix the issue, make sure that [antivirus and DLP tools](include-exclude-teams-from-antivirus-dlp.md) don't block Teams and WebView2 processes from accessing Teams services.

Additionally, [enable Windows Error Reporting (WER)](/troubleshoot/windows-client/system-management-components/windows-error-reporting-diagnostics-enablement-guidance) to help identify the root cause of the issue and report the issue to Microsoft.

We also recommend that you keep your audio and video drivers updated to ensure optimal performance and stability.

## WebView2 failure

To fix issues that are caused by WebView2 process failures, check the WebView2 process exit or error codes for more information. These codes indicate various problems, such as:

- External termination
- Invalid parameters
- Resource limits
- Sandbox or GPU issues
- System faults

The following sections list the WebView2 process exit and error codes, their symbolic names, and descriptions.

<details>

<summary><b>General process exit codes</b></summary>

| Exit code | Symbolic name | Description |
| --- | --- | --- |
| 1 | RESULT_CODE_KILLED | The process was forcibly terminated by the system or an external controller. |
| 2 | RESULT_CODE_HUNG | The process was unresponsive and was terminated to prevent further issues. |
| 3 | RESULT_CODE_KILLED_BAD_MESSAGE | The process was terminated because it received a malformed or unexpected interprocess communication (IPC) message. |
| 4 | RESULT_CODE_GPU_DEAD_ON_ARRIVAL | The GPU process failed immediately upon startup, usually because of driver issues or hardware incompatibility. |
| 5 | RESULT_CODE_INVALID_CMDLINE_URL | An invalid URL was passed on the command line, causing the process to fail. |
| 6 | RESULT_CODE_BAD_PROCESS_TYPE | The process was started by using an incorrect or unsupported process type. |
| 7 | RESULT_CODE_MISSING_DATA | Required startup or configuration data was missing, causing the process to exit. |
| 8 | RESULT_CODE_SHELL_INTEGRATION_FAILED | Integration with the system shell failed, possibly affecting features such as file associations or protocol handling. |
| 9 | RESULT_CODE_MACHINE_LEVEL_INSTALL_EXISTS | A conflicting machine-level installation was detected. This installation  might prevent a per-user instance from running. |
| 10 | RESULT_CODE_UNINSTALL_CHROME_ALIVE | An uninstallation was tried while the related browser (such as Chrome) was still running. |
| 11 | RESULT_CODE_UNINSTALL_USER_CANCEL | The user canceled the uninstall process. |
| 12 | RESULT_CODE_UNINSTALL_DELETE_PROFILE | The uninstall process included deletion of the user profile. |
| 13 | RESULT_CODE_UNSUPPORTED_PARAM | An unsupported parameter was provided to the process at startup. |
| 14 | RESULT_CODE_IMPORTER_HUNG | The importer process (such as bookmarks or settings) became unresponsive. |
| 15 | RESULT_CODE_RESPAWN_FAILED | Process restart (respawn) failed after termination. |
| 16 | RESULT_CODE_NORMAL_EXIT_EXP1 | The process exited normally under experimental condition variant 1. |
| 17 | RESULT_CODE_NORMAL_EXIT_EXP2 | The process exited normally under experimental condition variant 2. |
| 18 | RESULT_CODE_NORMAL_EXIT_EXP3 | The process exited normally under experimental condition variant 3. |
| 19 | RESULT_CODE_NORMAL_EXIT_EXP4 | The process exited normally under experimental condition variant 4. |
| 20 | RESULT_CODE_NORMAL_EXIT_CANCEL | The process exited normally after it received a cancel request. |
| 21 | RESULT_CODE_PROFILE_IN_USE | The user profile is already active in another process, blocking the new instance. |
| 22 | RESULT_CODE_PACK_EXTENSION_ERROR | An error occurred when trying to package a browser extension. |
| 23 | RESULT_CODE_UNINSTALL_EXTENSION_ERROR | An error occurred when uninstalling an extension. |
| 24 | RESULT_CODE_NORMAL_EXIT_PROCESS_NOTIFIED | The process exited normally after it received an external notification. |
| 26 | RESULT_CODE_INSTALL_FROM_WEBSTORE_ERROR_2 | Installation from the web store encountered a specific error condition. |
| 28 | RESULT_CODE_EULA_REFUSED | The process couldn't proceed because the End-User License Agreement (EULA) was refused. |
| 29 | RESULT_CODE_SXS_MIGRATION_FAILED_NOT_USED | A side-by-side migration failed. <br/><br/>**Note**: This code isn't currently in active use. |
| 30 | RESULT_CODE_ACTION_DISALLOWED_BY_POLICY | A policy restriction blocked the attempted action. |
| 31 | RESULT_CODE_INVALID_SANDBOX_STATE | The sandbox environment was in an invalid state, preventing secure execution. |
| 32 | RESULT_CODE_CLOUD_POLICY_ENROLLMENT_FAILED | Enrollment in cloud policy management failed. |
| 33 | RESULT_CODE_DOWNGRADE_AND_RELAUNCH | A version downgrade was detected, causing the process to restart. |
| 34 | RESULT_CODE_GPU_EXIT_ON_CONTEXT_LOST | The GPU process exited after losing the rendering context. |

</details>

<details>

<summary><b>POSIX signal errors</b></summary>

| Error code | Symbolic name | Description |
| --- | --- | --- |
| 131 | SIGQUIT | The process received a quit signal. This signal is usually initiated by the user. For example, the user pressed Ctrl+C. |
| 132 | SIGILL | The process encountered an illegal instruction. |
| 133 | SIGTRAP | A trace trap occurred. This signal is usually used for debugging purposes. |
| 134 | SIGABRT | The process aborted itself (such as by calling the abort() function), usually indicating a fatal error. |
| 135 | SIGBUS (7) | A bus error occurred, usually because of an unaligned memory access or an invalid address reference. |
| 136 | SIGFPE | A floating-point exception occurred. For example, division by zero in a floating-point operation. |
| 137 | SIGKILL | The process was forcibly terminated and had no chance to clean up. |
| 138 | SIGBUS (10) | A bus error occurred, usually indicating a memory access problem. |
| 139 | SIGSEGV | A segmentation fault occurred, usually caused by an illegal memory access. |
| 140 | SIGSYS | An invalid system call was tried. |

</details>

<details>

<summary><b>Sandbox, crashpad, and time-out errors</b></summary>

| Error code | Symbolic name | Description |
| --- | --- | --- |
| 258 | WAIT_TIMEOUT | When the process was waiting for a resource or event, the *wait* operation timed out. |
| 7006 | SBOX_FATAL_INTEGRITY | A fatal integrity check failed in the sandbox. |
| 7007 | SBOX_FATAL_DROPTOKEN | The sandbox encountered a critical failure when dropping a security token. |
| 7008 | SBOX_FATAL_FLUSHANDLES | A fatal error occurred when flushing handles in the sandbox. |
| 7009 | SBOX_FATAL_CACHEDISABLE | A fatal error occurred when caching was disabled in the sandbox. |
| 7010 | SBOX_FATAL_CLOSEHANDLES | A fatal error occurred when closing handles in the sandbox. |
| 7011 | SBOX_FATAL_MITIGATION | A mitigation in the sandbox triggered a fatal error. |
| 7012 | SBOX_FATAL_MEMORY_EXCEEDED | The process exceeded the memory allocation within the sandbox limit. |
| 7013 | SBOX_FATAL_WARMUP | The sandbox failed during the warm-up (initialization) phase. |
| -36861 | Crashpad_NotConnectedToHandler | Crashpad couldn't connect to the crash handler, which means that crash data couldn't be logged. |
| -36862 | Crashpad_FailedToCaptureProcess | Crashpad failed to capture process state for analysis. |
| -36863 | Crashpad_HandlerDidNotRespond | Crashpad handler didn't respond within the expected time. |
| -85436397 | Crashpad_SimulatedCrash | Crashpad intentionally simulated a crash for testing purposes. |

</details>

<details>

<summary><b>C++ and Windows runtime errors</b></summary>

| Error code | Symbolic name | Description |
| --- | --- | --- |
| -529697949 | CPP_EH_EXCEPTION | A C++ exception was thrown and caught by the exception-handling framework. |
| -533692099 | STATUS_GUARD_PAGE_VIOLATION | A protected page was violated, usually indicating a buffer overrun or memory corruption. |
| -536870904 | Out of Memory | The process ran out of available memory during execution. |
| 1066598273 | FACILITY_VISUALCPP/ERROR_PROC_NOT_FOUND | The required process wasn't found as reported by the Visual C++ runtime facility. |
| -1066598274 | FACILITY_VISUALCPP/ERROR_MOD_NOT_FOUND | The required module (DLL) wasn't found. |
| -1072103400 | STATUS_CURRENT_TRANSACTION_NOT_VALID | The status of the current transaction is invalid, preventing normal operations. |
| -1072365548 | STATUS_SXS_CORRUPT_ACTIVATION_STACK | The activation stack for the side-by-side assembly is corrupted. |
| -1072365552 | STATUS_SXS_INVALID_DEACTIVATION | An invalid deactivation of the side-by-side assembly was tried. |
| -1072365566 | STATUS_SXS_CANT_GEN_ACTCTX | Unable to generate activation context for side-by-side assembly. |
| -1073739514 | STATUS_VIRUS_INFECTED | The process was terminated because a virus or malware was detected. |
| -1073740004 | STATUS_INVALID_THREAD | An attempt was made to operate on an invalid thread. |
| -1073740016 | STATUS_CALLBACK_RETURNED_WHILE_IMPERSONATING | A callback function returned when the process was impersonating another user. This action is considered to be a security violation. |
| -1073740022 | STATUS_THREADPOOL_HANDLE_EXCEPTION | An exception occurred in a thread pool callback. |
| -1073740760 | STATUS_INVALID_IMAGE_HASH | The hash value of the loaded executable or DLL didn't match the expected value, indicating possible corruption or tampering. |
| -1073740767 | STATUS_VERIFIER_STOP | The application verifier detected a problem and forced a stop to protect system integrity. |
| -1073740768 | STATUS_ASSERTION_FAILURE | An internal assertion failed, indicating a programming logic error. |
| -1073740771 | STATUS_FATAL_USER_CALLBACK_EXCEPTION | A fatal exception was thrown inside a user callback function. |
| -1073740777 | STATUS_INVALID_CRUNTIME_PARAMETER | An invalid parameter was passed to a C runtime function. |
| -1073740782 | STATUS_DELAY_LOAD_FAILED | A delay-loaded DLL didn't load when its functionality was first required. |
| -1073740791 | STATUS_STACK_BUFFER_OVERRUN | A stack buffer overrun was detected. It's often a precursor to a memory corruption vulnerability. |
| -1073740940 | STATUS_HEAP_CORRUPTION | The structure of the heap is corrupted. This condition can cause unpredictable behavior. |
| -1073740959 | STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT | The default policy setting blocks access to the resource. |
| -1073741131 | STATUS_FLOAT_MULTIPLE_TRAPS | Multiple floating-point traps occurred simultaneously. |
| -1073741132 | STATUS_FLOAT_MULTIPLE_FAULTS | Multiple floating-point faults were detected. |
| -1073741205 | STATUS_DLL_INIT_FAILED_LOGOFF | DLL initialization failed during logoff. |
| -1073741212 | STATUS_RESOURCE_NOT_OWNED | The process tried to release a resource that it didn't own. |
| -1073741431 | STATUS_TOO_LATE | An operation was tried too late in the process lifecycle. |
| -1073741502 | STATUS_DLL_INIT_FAILED | DLL initialization failed at startup. |
| -1073741510 | STATUS_CONTROL_C_EXIT | The process exited in response to the Control-C (interrupt) signal. |
| -1073741511 | STATUS_ENTRYPOINT_NOT_FOUND | A required function entry point was missing from the DLL. |
| -1073741515 | STATUS_DLL_NOT_FOUND | A required DLL couldn't be found on the system. |
| -1073741523 | STATUS_COMMITMENT_LIMIT | The process exceeded the system's memory commitment limit. |
| -1073741558 | STATUS_PROCESS_IS_TERMINATING | The process is already in the terminating phase. |
| -1073741569 | STATUS_BAD_FUNCTION_TABLE | The function table for exception handling is corrupted or invalid. |
| -1073741571 | STATUS_STACK_OVERFLOW | The process's stack exceeded its allocated limit. |
| -1073741581 | STATUS_INVALID_PARAMETER_5 | The fifth parameter provided to the function is invalid. |
| -1073741595 | STATUS_INTERNAL_ERROR | A general internal error occurred within the process. |
| -1073741659 | STATUS_BAD_IMPERSONATION_LEVEL | An operation was tried by using an incorrect impersonation level. |
| -1073741662 | STATUS_MEDIA_WRITE_PROTECTED | The *write* operation failed because the media is write-protected. |
| -1073741670 | STATUS_INSUFFICIENT_RESOURCES | The system didn't have sufficient resources (such as memory and handles) to continue. |
| -1073741674 | STATUS_PRIVILEGED_INSTRUCTION | The process tried to run an instruction that's reserved for the operating system. |
| -1073741675 | STATUS_INTEGER_OVERFLOW | An arithmetic operation caused an integer overflow. |
| -1073741676 | STATUS_INTEGER_DIVIDE_BY_ZERO | An attempt was made to divide an integer by zero. |
| -1073741677 | STATUS_FLOAT_UNDERFLOW | A floating-point underflow occurred during computation. |
| -1073741678 | STATUS_FLOAT_STACK_CHECK | A floating-point stack integrity check failed. |
| -1073741679 | STATUS_FLOAT_OVERFLOW | A floating-point overflow occurred. |
| -1073741680 | STATUS_FLOAT_INVALID_OPERATION | An invalid operation was performed in a floating-point operation. |
| -1073741681 | STATUS_FLOAT_INEXACT_RESULT | A floating-point operation produced an inexact result that's acceptable but was noticed by the runtime. |
| -1073741682 | STATUS_FLOAT_DIVIDE_BY_ZERO | A floating-point division by zero occurred. |
| -1073741683 | STATUS_FLOAT_DENORMAL_OPERAND | A denormalized operand was encountered in a floating-point operation. |
| -1073741684 | STATUS_ARRAY_BOUNDS_EXCEEDED | An array bounds check failed, indicating an attempt to access memory outside the allocated range. |
| -1073741701 | STATUS_INVALID_IMAGE_FORMAT | The executable or DLL image is invalid or corrupted. |
| -1073741738 | STATUS_DELETE_PENDING | An attempt was made to perform an operation on a resource that's pending deletion. |
| -1073741744 | STATUS_EA_TOO_LARGE | The extended attributes of the file were too large to handle. |
| -1073741749 | STATUS_THREAD_IS_TERMINATING | A thread was terminating, causing some operations to fail. |
| -1073741756 | STATUS_QUOTA_EXCEEDED | A resource quota (for example, a memory or handle limit) was exceeded. |
| -1073741757 | STATUS_SHARING_VIOLATION | A sharing violation occurred, usually when a file or resource was already in use. |
| -1073741766 | STATUS_OBJECT_PATH_NOT_FOUND | The specified object path for a file or resource wasn't found. |
| -1073741772 | STATUS_OBJECT_NAME_NOT_FOUND | The specified object name didn't exist. |
| -1073741783 | STATUS_INVALID_UNWIND_TARGET | In exception handling, an invalid target was specified during stack unwinding. |
| -1073741784 | STATUS_BAD_STACK | The stack for the process is in an invalid or corrupt state. |
| -1073741785 | STATUS_UNWIND | An error occurred during stack unwinding after an exception occurred. |
| -1073741786 | STATUS_INVALID_DISPOSITION | An invalid exception disposition was encountered during error handling. |
| -1073741787 | STATUS_NONCONTINUABLE_EXCEPTION | An unrecoverable fatal exception was encountered. |
| -1073741788 | STATUS_OBJECT_TYPE_MISMATCH | An object's expected type didn't match during an operation. |
| -1073741790 | STATUS_ACCESS_DENIED | Access to a required resource was denied by the operating system. |
| -1073741794 | STATUS_INVALID_LOCK_SEQUENCE | A lock was acquired or released in an invalid sequence, causing termination. |
| -1073741795 | STATUS_ILLEGAL_INSTRUCTION | The process tried to execute an illegal or undefined instruction. |
| -1073741796 | STATUS_INVALID_SYSTEM_SERVICE | An invalid or unimplemented system service was requested. |
| -1073741800 | STATUS_CONFLICTING_ADDRESSES | A memory address conflict occurred between process allocations. |
| -1073741801 | STATUS_NO_MEMORY | The system couldn't allocate the required memory resources. |
| -1073741811 | STATUS_INVALID_PARAMETER | An invalid parameter was passed to a system call or function. |
| -1073741816 | STATUS_INVALID_HANDLE | An attempt was made to perform an operation by using an invalid or closed handle. |
| -1073741818 | STATUS_IN_PAGE_ERROR | A page-in operation failed, possibly because of an I/O error or data corruption on disk. |
| -1073741819 | STATUS_ACCESS_VIOLATION | A memory access violation occurred, causing a crash. |
| -1073741820 | STATUS_INFO_LENGTH_MISMATCH | The length of the information provided didn't match the expected size. |
| -1073741822 | STATUS_NOT_IMPLEMENTED | The requested functionality wasn't implemented on the current platform. |
| -1073741823 | STATUS_UNSUCCESSFUL | A generic failure occurred without a more specific error code. |
| -1073741829 | STATUS_SEGMENT_NOTIFICATION | A notification about memory segments was issued. It's usually an informational notification. |
| -1073741845 | STATUS_FATAL_APP_EXIT | A fatal error forced the application to exit immediately. |
| -2147483644 | STATUS_SINGLE_STEP | A single-step (debug) exception was triggered during execution. |
| -2147483645 | STATUS_BREAKPOINT | A breakpoint was encountered. Breakpoints are usually used during debugging. |
| -2147483646 | STATUS_DATATYPE_MISALIGNMENT | A data type misalignment was detected. This error can occur if memory isn't correctly aligned for the CPU architecture. |

</details>
