---
title: ATL service with _ATL_NO_COM_SUPPORT not start
description: An ATL service created with the ATL Project Wizard will not start as a service.
ms.date: 04/24/2020
ms.prod-support-area-path: 
ms.reviewer: shorne, scotbren
---
# ATL service with _ATL_NO_COM_SUPPORT defined will not start

This article helps you resolve the problem that Active Template Library (ATL) Project Wizard will not start as a service after you create a default ATL service project.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2480736

## Symptoms

After creating a default ATL service project using the ATL Project Wizard, you register the service with the `/Service` command line parameter and then try to start the service with `net start`. The service starts and then immediately exits with the following message:

> The service could not be started

```console
c:\>net start ATLService
The ATLService service is starting........
The ATLService service could not be started.

The service did not report an error.
```

## Cause

The ATL service base class libraries do not call the Win32 method `SetServiceStatus`(SERVICE_RUNNING) if there are no ATL Component Object Model (COM) objects implemented in the service.

## Resolution

The ATL service is primarily designed as a service host for COM objects so the expectation is that the developer will be adding COM objects to the service.

However, it is possible to use ATL without COM. For instance, there is an `_ATL_NO_COM_SUPPORT` macro, which you can define which will turn off most of the support for registering and implementing COM objects in the ATL library.

Due to a bug in the service base classes, if `_ATL_NO_COM_SUPPORT` is defined, the `SetServiceStatus`(SERVICE_RUNNING) call is not made and the service will start and then immediately exit.

You can work around this bug by overriding the `PreMessageLoop` function in your `CAtlServiceModule` derived class and calling `SetServiceStatus`:

```cpp
HRESULT PreMessageLoop(int nShowCmd)
{
    SetServiceStatus(SERVICE_RUNNING);
    return __super::PreMessageLoop(nShowCmd);
}
```

> [!NOTE]
> This `PreMessageLoop` override is only relevant for ATL Services that have `_ATL_NO_COM_SUPPORT` defined.

## More information

1. Create a new ATL Project with the project wizard.
2. Name the project *ATLService* and in the **Application Settings**, select the **Service** option.
3. Open the *stdafx.h* file and before any header `#include` statements, define `_ATL_NO_COM_SUPPORT`:

    ```cpp
    #define _ATL_NO_COM_SUPPORT
    ```

4. Build the project.
5. From a console window, register the service:

    ```console
    ATLService /service  
    ```

6. Start the service:

    ```console
    c:\>net start ATLService
    The ATLService service is starting.
    The ATLService service could not be started.

    The service did not report an error.
    ```

7. Add the workaround code and rebuild the service. You may need to re-register the service as well.
8. Start the service again:

    ```console
    c:\>net start ATLService
    The ATLService service is starting.
    The ATLService service was started successfully.
    ```
