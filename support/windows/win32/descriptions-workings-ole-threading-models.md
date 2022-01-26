---
title: Descriptions and workings of OLE threading models
description: This article describes OLE threading models.
ms.date: 10/13/2020
ms.custom: sap:Component development
ms.technology: windows-dev-apps-component-dev
---
# Descriptions and workings of OLE threading models

This article describes OLE threading models.

_Original product version:_ &nbsp; OLE threading models  
_Original KB number:_ &nbsp; 150777

## Summary

COM objects can be used in multiple threads of a process. The terms "Single- threaded Apartment" (STA) and "Multi-threaded Apartment" (MTA) are used to create a conceptual framework for describing the relationship between objects and threads, the concurrency relationships among objects, the means by which method calls are delivered to an object, and the rules for passing interface pointers among threads. Components and their clients choose between the following two apartment models presently supported by COM:

1. Single-threaded Apartment model (STA): One or more threads in a process use COM and calls to COM objects are synchronized by COM. Interfaces are marshaled between threads. A degenerate case of the single-threaded apartment model, where only one thread in a given process uses COM, is called the single-threading model. Previous have sometimes referred to the STA model simply as the "apartment model."

2. Multi-threaded Apartment model (MTA): One or more threads use COM and calls to COM objects associated with the MTA are made directly by all threads associated with the MTA without any interposition of system code between caller and object. Because multiple simultaneous clients may be calling objects more or less simultaneously (simultaneously on multi-processor systems), objects must synchronize their internal state by themselves. Interfaces are not marshaled between threads. Previous have sometimes referred to this model as the "free-threaded model."

3. Both the STA model and the MTA model can be used in the same process. This is sometimes referred to as a "mixed-model" process.

The MTA is introduced in NT 4.0 and is available in Windows 95 with DCOM95. The STA model exists in Windows NT 3.51 and Windows 95 as well as NT 4.0 and Windows 95 with DCOM95.

## Overview

The threading models in COM provide the mechanism for components that use different threading architectures to work together. They also provide synchronization services to components that require them. For example, a particular object may be designed to be called only by a single thread and may not synchronize concurrent calls from clients. If such an object is called concurrently by multiple threads, it crashes or causes errors. COM provides the mechanisms for dealing with this interoperability of threading architectures.

Even thread-aware components often need synchronization services. For example, components that have a graphical user interface (GUI), such as OLE/ActiveX controls, in-place active embeddings, and ActiveX documents, require synchronization and serialization of COM calls and window messages. COM provides these synchronization services so these components can be written without complex synchronization code.

An "apartment" has several inter-related aspects. First, it is a logical construct for thinking about concurrency, such as how threads relate to a set of COM objects. Second, it is a set of rules programmers must obey to receive the concurrency behavior they expect from COM environment. Finally, it is system-supplied code that helps programmers manage thread concurrency with respect to COM objects.

The term "apartment" comes from a metaphor in which a process is conceived as a discrete entity, such as a "building" that is subdivided into a set of related but different "locales" called "apartments." An apartment is a "logical container" that creates an association between objects and, in some cases, threads. Threads are not apartments, although there may be a single thread logically associated with an apartment in the STA model. Objects are not apartments, although every object is associated with one and only one apartment. But apartments are more than just a logical construct; their rules describe the behavior of the COM system. If the rules of the apartment models are not followed, COM objects will not function properly.

## More details

A Single-threaded apartment (STA) is a set of COM objects associated with a particular thread. These objects are associated with the apartment by being created by the thread or, more precisely, being first exposed to the COM system (typically by marshaling) on the thread. AN STA is considered a place where an object or a proxy "lives." If the object or proxy needs to be accessed by another apartment (in the same or a different process), its interface pointer must be marshaled to that apartment where a new proxy is created. If the rules of the apartment model are followed, no direct calls from other threads in the same process are allowed on that object; that would violate the rule that all objects within a given apartment run on a single thread. The rule exists because most code running in an STA will fail to function properly if run on additional threads.

The thread associated with an STA must call `CoInitialize` or `CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)` and must retrieve and dispatch window messages for the associated objects to receive incoming calls. COM dispatches and synchronizes calls to objects in an STA using window messages, as described later in this article.

The "main STA" is the thread that calls `CoInitialize` or `CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)` first within a given process. The main STA of a process must remain alive until all COM work is completed because some in-proc objects are always loaded in the main STA, as described later in this article.

Windows NT 4.0 and DCOM95 introduce a new type of apartment called the multi-threaded apartment (MTA). An MTA is a set of COM objects associated with a set of threads in the process such that any thread can call any object implementation directly without the interposition of system code. Interface pointers to any object in the MTA may be passed among the threads associated with the MTA without having to be marshaled. All threads in the process that call `CoInitializeEx(NULL, COINIT_MULTITHREADED)` are associated with the MTA. Unlike the STA described above, the threads in an MTA do not need to retrieve and dispatch window messages for the associated objects to receive incoming calls. COM does not synchronize calls to objects in an MTA. Objects in an MTA must protect their internal state from corruption by the interaction of multiple simultaneous threads and they cannot make any assumptions about the content of Thread-Local Storage remaining constant between different method invocations.

A process can have any number of STAs, but, at most, can have one MTA. The MTA consists of one or more threads. STAs have one thread each. A thread belongs, at most, to one apartment. Objects belong to one and only one apartment. Interface pointers should always be marshaled between apartments (although the result of marshaling may be a direct pointer rather than a proxy). See information below on `CoCreateFreeThreadedMarshaler`.

A process chooses one of the threading models provided by COM. An STA model process has one or more STAs and does not have an MTA. An MTA model process has one MTA with one or more threads and does not have any STAs. A mixed- model process has one MTA and any number of STAs.

## Single-threaded apartment model

The thread of an STA must call `CoInitialize` or `CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)` and must retrieve and dispatch window messages because COM uses window messages to synchronize and dispatch the delivery of calls to an object in this model. See the REFERENCES section below for more information.

Server that Supports STA Model:

In the STA model, calls to an object are synchronized by COM in the same manner as window messages posted to a window are synchronized. Calls are delivered using window messages to the thread that created the object. Consequently, the object's thread must call `Get`/`PeekMessage` and `DispatchMessage` to receive calls. COM creates a hidden window associated with each STA. A call to an object from outside the STA is transferred by COM runtime to the object's thread using a window message posted to this hidden window. When the thread associated with the object's STA retrieves and dispatches the message, the window procedure for the hidden window, also implemented by COM, receives it. The window procedure is used by the COM runtime to "hook" the thread associated with the STA because the COM runtime is on both sides of the call from the COM-owned thread to the STA's thread. The COM runtime (now running in the STA's thread) calls "up" via a COM-supplied stub into the corresponding interface method of the object. The execution path returning from the method call reverses the "up" call; the call returns down to the stub and the COM runtime, which passes control back to the COM runtime thread via a window message, which then returns through the COM channel to the original caller.

When multiple clients call an STA object, the calls are automatically queued in the message queue by the transfer of control mechanism used in the STA. The object receives a call each time its STA retrieves and dispatches messages. Because the calls are synchronized by COM in this manner, and because the calls are always delivered on the single thread associated with the object's STA, the object's interface implementations do not need to provide synchronization.

> [!NOTE]
> The object can be re-entered if an interface method implementation retrieves and dispatches messages while processing a method call, causing another call to be delivered to the object by the same STA. A common way in which this occurs is if an STA object makes an out-going (cross-apartment/cross-process) call using COM. This is identical to the manner in which a window procedure can be re-entered if it retrieves and dispatches messages while processing a message. COM does not prevent re- entrance on the same thread but does prevent concurrent execution. It also provides a means by which COM-related reentrancy can be managed. See the REFERENCES section below for more information. The object is not re- entered if method implementations do not call out of its apartment or otherwise retrieve and dispatch messages.

Client Responsibilities in the STA Model:

Client code running in a process and/or thread that uses the STA model must marshal interfaces of an object between apartments by using `CoMarshalInterThreadInterfaceInStream` and `CoGetInterfaceAndReleaseStream`. For example, if Apartment 1 in the client has an interface pointer, and Apartment 2 requires use of it, Apartment 1 must marshal the interface using `CoMarshalInterThreadInterfaceInStream`. The stream object returned by this function is thread-safe and its interface pointer should be stored in a direct memory variable accessible by Apartment 2. Apartment 2 must pass this stream interface to `CoGetInterfaceAndReleaseStream` to unmarshal the interface on the underlying object and get back a pointer to a proxy through which it can access the object.

The main apartment of a given process should remain alive until the client has completed all COM work because some in-proc objects are loaded in the main-apartment. (More information is detailed below).

## Multi-threaded apartment model

An MTA is the collection of objects created or exposed by all the threads in the process that have called `CoInitializeEx(NULL, COINIT_MULTITHREADED)`.

> [!NOTE]
> Current implementations of COM allow a thread that does not explicitly initialize COM to be a part of the MTA. A thread that does not initialize COM is part of the MTA only if it starts using COM after at least one other thread in the process has previously called `CoInitializeEx(NULL, COINIT_MULTITHREADED)`. (It is even possible that COM itself may have initialized the MTA when no client thread has explicitly done so; for example, a thread associated with an STA calls `CoGetClassObject`/`CoCreateInstance[Ex]` on a CLSID that is marked "ThreadingModel=Free" and COM implicitly creates an MTA into which the class object is loaded.) See the information on threading model interoperability below.

However, this is a configuration that might cause problems, such as access violations, under certain circumstances. Therefore, it is recommended that each thread that needs to do COM work initialize COM by calling `CoInitializeEx` and then, on completion of COM work, call `CoUninitialize`. The cost of "unnecessarily" initializing an MTA is minimal.

MTA threads do not need to retrieve and dispatch messages because COM does not use window messages in this model to deliver calls to an object.

- Server that Supports the MTA Model:

    In the MTA model, calls to an object are not synchronized by COM. Multiple clients can concurrently call an object that supports this model on different threads, and the object must provide synchronization in its interface/method implementations using synchronization objects such as events, mutexes, semaphores, etc. MTA objects can receive concurrent calls from multiple out-of-process clients through a pool of COM-created threads belonging to the object's process. MTA objects can receive concurrent calls from multiple in-process clients on multiple threads associated with the MTA.

- Client Responsibilities in the MTA Model:

    Client code running in a process and/or thread that uses the MTA model does not have to marshal interface pointers of an object between itself and other MTA threads. Rather, one MTA thread can use an interface pointer obtained from another MTA thread as a direct memory pointer. When a client thread makes a call to an out-of-process object, it suspends until the call has completed. Calls may arrive on objects associated with the MTA while all application-created threads associated with the MTA are blocked on out- going calls. In this case and in general, incoming calls are delivered on threads provided by the COM runtime. Message filters (`IMessageFilter`) are not available for use in the MTA model.

## Mixed-threading models

A process that supports the mixed-threading model will use one MTA and one or more STAs. Interface pointers must be marshaled between all apartments but can be used without marshaling within the MTA. Calls to objects in an STA are synchronized by COM to run on only one thread while calls to objects in the MTA are not. However, calls from an STA to an MTA normally go through system-provided code and switch from the STA thread to an MTA thread before being delivered to the object.

> [!NOTE]
> See the SDK documentation on `CoCreateFreeThreadedMarshaler()` and the discussion of that API below for information on cases where direct pointers can be used, and how an STA thread can call directly into an object first associated with the MTA and, vice versa, from multiple apartments.

## Choosing the threading models

A component can choose to support the STA model, the MTA model, or a combination of the two by using the mixed-threading model. For example, an object that does extensive I/O can choose to support MTA to provide maximum response to clients by allowing interface calls to be made during I/O latency. Alternatively, an object that interacts with the user almost always chooses to support STA to synchronize incoming COM calls with its GUI operations. Supporting the STA model is easier because COM provides synchronization. Supporting the MTA model is more difficult because the object must implement synchronization, but response to clients is better because synchronization is used for smaller sections of code, rather than for the whole interface call as provided by COM.

The STA model is also used by Microsoft Transaction Server (MTS, previously code-named "Viper"), and thus DLL-based objects planning to run within the MTS environment should use the STA model. Objects implemented for the MTA model will normally work fine in an MTS environment. However, they will run less efficiently because they will be using unnecessary thread synchronization primitives.

## Marking the Supported-threading Model of In-Proc servers

A thread uses the MTA model if it calls `CoInitializeEx(NULL, COINIT_MULTITHREADED)` or uses COM without initializing it. A thread uses the STA model if it calls `CoInitialize` or `CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)`.

The `CoInitialize` APIs provide apartment control for client code and for objects that are packaged in.EXEs, because the COM runtime's startup code can initialize COM in the desired fashion.

However, an in-proc (DLL-based) COM server does not call `CoInitialize`/`CoInitializeEx` because those APIs will have been called by the time the DLL server is loaded. Therefore, a DLL server must use the registry to inform COM of the threading model it supports so that COM can ensure that the system operates in a way that is compatible with it. A named value of the component's CLSID\InprocServer32 key called `ThreadingModel` is used for this purpose as follows:

- `ThreadingModel` value not present: Supports single-threading model.
- `ThreadingModel=Apartment`: Supports STA model.
- `ThreadingModel=Both`: Supports STA and MTA model.
- `ThreadingModel=Free`: Supports only MTA.

> [!NOTE]
> `ThreadingModel` is a named value, not a subkey of InprocServer32 as incorrectly documented in some earlier versions of the Win32 documentation.

Threading models of in-proc servers are discussed later in this article. If an in-proc server provides many types of objects (each with its own unique CLSID), each type can have a different `ThreadingModel` value. In other words, the threading model is per CLSID, not per code package/DLL. However, the API entry points necessary to "bootstrap" and query all in-proc servers (`DLLGetClassObject()`, `DLLCanUnloadNow()`) must be thread-safe for any in-proc server that supports multiple threads (meaning a `ThreadingModel` value of Apartment, Both, or Free).

As previously stated, out-of-process servers do not mark themselves using the ThreadingModel value. Rather, they use `CoInitialize` or `CoInitializeEx`. DLL-based servers that expect to run out-of-process using the "surrogate" functionality of COM (such as the system-supplied surrogate DLLHOST.EXE) follow the rules for DLL-based servers; there are no special considerations in that case.

## When the client and object Use different threading models

Interaction between a client and an out-of-process object is straight forward even when different threading models are used because the client and object are in different processes and COM is involved in passing calls from the client to the object. Because COM is interposed between the client and the server, it provides the code for interoperation of the threading models. For example, if an STA object is called concurrently by multiple STA or MTA clients, COM synchronizes the calls by placing corresponding window messages in the server's message queue. The object's STA receives one call each time it retrieves and dispatches messages. All combinations of threading-model interoperability are allowed and fully supported between clients and out-of-process objects.

Interaction between a client and an in-proc object that uses different threading models is more complicated. Although the server is in-proc, COM must interpose itself between the client and the object in some cases. For example, an in-proc object designed to support the STA model may be called concurrently by multiple threads of a client. COM cannot allow the client threads to directly access the object's interface because the object is not designed for such concurrent access. Instead, COM must ensure that calls are synchronized and made only by the thread associated with the STA that "contains" the object. Despite the added complexity, all combinations of threading-model interoperability are allowed between clients and in-proc objects.

## Threading models in out-of-process (EXE-based) servers

Following are three categories of out-of-process servers, each of which can be used by any COM client regardless of the threading model used by that client:

1. STA Model Server:

   The server does COM work in one or more STAs. Incoming calls are synchronized by COM and delivered by the thread associated with the STA in which the object was created. Class-factory method calls are delivered by the thread associated with the STA that registered the class factory. The object and the class factory do not need to implement synchronization. However, the implementor must synchronize access to any global variables used by multiple STAs. The server must use `CoMarshalInterThreadInterfaceInStream` and `CoGetInterfaceAndReleaseStream` to marshal interface pointers, possibly from other servers, between STAs. The server optionally can implement `IMessageFilter` in each STA to control aspects of call delivery by COM. A degenerate case is the single-threading model server that does COM work in one STA.

2. MTA Model Server:

   The server does COM work in one or more threads, all of which belong to the MTA. Calls are not synchronized by COM. COM creates a pool of threads in the server process, and a client call is delivered by any of these threads. Threads do not need to retrieve and dispatch messages. The object and class factory must implement synchronization. The server does not need to marshal interface pointers between threads.

3. Mixed Model Server:

   See the section in this article titled "Mixed-threading model" for more information.

## Threading Models in Clients

There are three categories of clients:

1. STA model client:

   The client does COM work in threads associated with one or more STAs. The client must use `CoMarshalInterThreadInterfaceInStream` and `CoGetInterfaceAndReleaseStream` to marshal interface pointers between STAs. A degenerate case is the single-threading model client that does COM work in one STA. The client's thread enters a COM provided message loop when it makes an outgoing call. The client can use `IMessageFilter` to manage callbacks and processing of window messages while waiting on out-going calls and other concurrency issues.

2. MTA model client:

   The client does COM work in one or more threads, all of which belong to the MTA. The client does not need to marshal interface pointers between its threads. The client cannot use `IMessageFilter`. The client's threads suspend when they make a COM call to an out-of-process object and resumes when the call returns. Incoming calls arrive on COM-created and managed threads.

3. Mixed model client:

   See the section in this article titled "Mixed-threading model" for more information.

## Threading Models in In-proc (DLL-based) Servers

There are four categories of in-proc servers, each of which can be used by any COM client regardless of the threading model used by that client. However, in-proc servers must provide marshaling code for any custom (non- system-defined) interface they implement if they are to support threading model interoperability because that typically requires that COM marshal the interface between client apartments. The four categories are:

1. In-proc Server that supports single threading ("main" STA)- no `ThreadingModel` value:

   An object provided by this server expects to be accessed by the same client STA by which it was created. In addition, the server expects all its entry points, such as `DllGetClassObject` and `DllCanUnloadNow`, and global data to be accessed by the same thread (the one associated with the main STA). Servers that existed before the introduction of multi- threading in COM are in this category. These servers are not designed to be accessed by multiple threads so COM creates all objects provided by the server in the main STA of the process and calls to the objects are delivered by the thread associated with the main STA. Other client apartments gain access to the object through proxies. Calls from the other apartments go from the proxy to the stub in the main STA (inter- thread marshaling) and then to the object. This marshaling allows COM to synchronize calls to the object and calls are delivered by the STA in which the object was created. Inter-thread marshaling is slow relative to direct calling so it is recommended that these servers be rewritten to support multiple STAs (category 2).

2. In-proc Server that supports the single-threaded apartment model (multiple STAs) - marked with `ThreadingModel=Apartment`:

   An object provided by this server expects to be accessed by the same client STA by which it was created. Therefore, it is similar to an object provided by a single-threaded in-proc server. However, objects provided by this server can be created in multiple STAs of the process, so the server must design its entry points, such as `DllGetClassObject` and `DllCanUnloadNow`, and global data for multi-threaded use. For example, if two STAs of a process create two instances of the in-proc object simultaneously, `DllGetClassObject` may be called concurrently by both STAs. Similarly, `DllCanUnloadNow` must be written so the server is protected from being unloaded while code is still executing in the server.

   If the server provides only one instance of the class factory to create all the objects, the class factory implementation must also be designed for multi-threaded use because it is accessed by multiple client STAs. If the server creates a new instance of the class factory each time `DllGetClassObject` is called, the class factory does not need to be thread-safe. However, the implementor must synchronize access to any global variables.

   COM objects created by the class factory do not need to be thread-safe. However, access of global variables must be synchronized by the implementor. Once created by a thread, the object is always accessed through that thread and all calls to the object are synchronized by COM. Client apartments that are different than the STA in which the object was created must access the object through proxies. These proxies are created when the client marshals the interface between its apartments.

   Any client that creates an STA object through its class factory gets a direct pointer to the object. This is different than single-threaded in-proc objects, where only the main STA of the client gets a direct pointer to the object and all other STAs that create the object gain access to the object through a proxy. Because inter-thread marshaling is slow relative to direct calling, speed can be improved by changing a single-threaded in-proc server to support multiple STAs.

3. In-proc Server that supports only MTA - marked with `ThreadingModel=Free`:

   An object provided by this server is safe for the MTA only. It implements its own synchronization and is accessed by multiple client threads at the same time. This server may have behavior that is incompatible with the STA model. (For example, by its use of the Windows message queue in a way that breaks the message pump of an STA.) Also, by marking the threading model of the object as "Free," the implementor of the object is stating the following: this object can be called from any client thread, but this object also can pass interface pointers directly (without marshaling) to any threads that it created and these threads can make calls through these pointers. Thus, if the client passes an interface pointer to a client-implemented object (such as a sink) to this object, it can elect to call back through this interface pointer from any thread that it created. If the client is an STA, a direct call from a thread, which is different from the thread that created the sink object will be in error (as demonstrated in 2 above). Hence COM always ensures that clients in threads associated with an STA gain access to this kind of in-proc object only through a proxy. Also, these objects should not aggregate with the free-threaded marshaler because that allows them to run directly on STA threads.

4. In-proc Server that supports apartment model and free-threading - marked with `ThreadingModel=Both`:

   An object provided by this server implements its own synchronization and is accessed concurrently by multiple client apartments. In addition, this object is created and used directly, instead of through a proxy, in STAs or the MTA of a client process. Because this object is used directly in STAs, the server must marshal interfaces of objects, possibly from other servers, between threads so its access to any object in a threading-appropriate way is guaranteed. Also, by marking the threading model of the object as "Both", the implementor of the object is stating the following: this object can be called from any client thread, but any callbacks from this object to the client will be done only on the apartment in which the object received the interface pointer to the callback object. COM allows such an object to be created directly in an STA as well as in an MTA of the client process.

   Because any apartment that creates such an object always gets a direct pointer rather than a proxy pointer, `ThreadingModel "Both"` objects provide performance improvements over `ThreadingModel "Free"` objects when loaded in an STA.

   Because a `ThreadingModel "Both"` object is also designed for MTA access (it is thread-safe internally), it can speed performance by aggregating with the marshaler provided by `CoCreateFreeThreadedMarshaler`. This system-supplied object is aggregated in to any calling objects and custom marshals direct pointers to the object into all apartments in the process. Clients in any apartment, whether an STA or MTA, may then access the object directly instead of through a proxy. For example, an STA model client creates the in-proc object in STA1 and marshals the object to STA2. If the object does not aggregate with the free-threaded marshaler, STA2 gains access to the object through a proxy. If it does, the free-threaded marshaler provides STA2 with a direct pointer to the object

   > [!NOTE]
   > Care must be taken when aggregating with the free-threaded marshaler. As an example, assume that an object that is marked as `ThreadingModel "Both"` (and also aggregating with the free-threaded marshaler) has a data member that is an interface pointer to another object whose `ThreadingModel` is "Apartment". Then assume that an STA creates the first object and during creation, the first object creates the second object. As per the rules discussed above, the first object is now holding a direct pointer to the second object. Now assume that the STA marshals the interface pointer to the first object to another apartment. Because the first object aggregates with the free- threaded marshaler, a direct pointer to the first object is given to the second apartment. If the second apartment then calls through this pointer, and if this call causes the first object to call through the interface pointer to the second object, then an error has occurred, because the second object is not meant to be directly called from the second apartment. If the first object is holding a pointer to a proxy to the second object rather than a direct pointer, this will cause a different error. System proxies are also COM objects that are associated with one and only one apartment. They keep track of their apartment in order to avoid certain circularities. So an object calling out on a proxy associated with a different apartment than the thread on which the object is running will receive the RPC_E_WRONG_THREAD return from the proxy and the call will fail.

## Threading Model Interoperability Between Clients and In-process Objects

All combinations of threading-model interoperability are allowed between clients and in-process objects.

COM allows all STA model clients to inter-operate with single-threading in-proc objects by creating and accessing the object in the client's main STA and marshaling it to the client STA that called `CoCreateInstance[Ex]`.

If an MTA in a client creates an STA model in-proc server, COM spins up a "host" STA in the client. This host STA creates the object and the interface pointer is marshaled back to the MTA. Similarly, when an STA creates an MTA in-proc server, COM spins up a host MTA in which the object is created and marshaled back to the STA. Interoperability between the single-threading model and MTA model is handled similarly because the single-threading model is just a degenerate case of the STA model.

Marshaling code must be provided for any custom interface that an in-proc server implements if it wants to support interoperability that requires COM to marshal the interface between client apartments. See the REFERENCES section below for more information.

## Relationship Between Threading Model and Class Factory Object Returned

A precise definition of in-proc servers being "loaded into" apartments is explained in the two following steps:

1. If the DLL that contains the in-proc server class has not previously been loaded (mapped into the process address space) by the operating system loader, that operation is performed, and COM obtains the address of the `DLLGetClassObject` function exported by the DLL. If the DLL has previously been loaded by a thread associated with any apartment, this stage is skipped.

2. COM uses the thread (or, in the case of the MTA, one of the threads) associated with the "loading" apartment to call the `DllGetClassObject` function exported by the DLL asking for the CLSID of the needed class. The factory object returned is then used to create instances of objects of the class.

   The second step (the calling of `DllGetClassObject` by COM) occurs each and every time a client calls `CoGetClassObject`/`CoCreateIntance[Ex]`, even from within the same apartment. In other words, `DllGetClassObject` may be called many times by a thread associated with the same apartment; it all depends on how many clients in that apartment are trying to get access to a class factory object for that class.

Authors of class implementations and, ultimately, the author of the DLL package of a given set of classes have complete freedom to decide what factory object to return in response to the `DllGetClassObject` function call. The author of the DLL package has the ultimate say because the code "behind" the single DLL-wide `DllGetClassObject()` entry point is what has the first and potentially final right to decide what to do. The three typical possibilities are:

1. `DllGetClassObject` returns a unique class factory object per calling thread (which means one class factory object per STA and potentially multiple class factories within the MTA).

2. `DllGetClassObject` always returns the same class factory object, regardless of the identity of the calling thread or the kind of apartment associated with the calling thread.

3. `DllGetClassObject` returns a unique class factory object per calling apartment (one per apartment in both STA and MTA).

There are other possibilities for the relationship between calls to `DllGetClassObject` and the class factory object returned (such as a new class factory object per call to `DllGetClassObject`) but they do not presently appear to be useful.

## Summary of Client and Object Threading Models for In-Proc Servers

The following table summarizes the interaction between different threading models when a client thread first calls `CoGetClassObject` on a class that is implemented as an in-proc server.

Kinds of clients/threads:

- client is running in a thread associated with the "main" STA (first thread to call `CoInitialize` or `CoInitializeEx` with `COINIT_APARTMENTTHREADED` flag)-call this STA0 (also called single- threading model).
- client is running in a thread associated with in any other STA [ASCII 150] call this STA*.
- client is running in a thread associated with in the MTA.

Kinds of DLL servers:

- Server has no `ThreadingModel` key--call this "None."
- Server is marked "Apartment"--call this "Apt."
- Server is marked "Free."
- Server is marked "Both."

When reading the table below, keep in the mind the definition made above of "loading" a server into an apartment.

```console
Client         Server                 Result
STA0           None                   Direct access; server loaded into STA0  
STA*           None                   Proxy access; server loaded into STA0.  
MTA            None                   Proxy access; server loaded into STA0; STA0 created automatically by COM if necessary;  
STA0           Apt                    Direct access; server loaded into STA0  
STA*           Apt                    Direct access; server loaded into STA*  
MTA            Apt                    Proxy access; server loaded into an STA created automatically by COM.
STA0           Free                   Proxy access; server is loaded into MTA MTA created automatically by COM if necessary.
STA*           Free                   Same as STA0->Free
MTA            Free                   Direct access
STA0           Both                   Direct access; server loaded into STA0
STA*           Both                   Direct access; server loaded into STA*
MTA            Both                   Direct access; server loaded into the MTA
```

## References

SDK documentation on the `CoRegisterMessageFilter()` and `IMessageFilter` interface.
