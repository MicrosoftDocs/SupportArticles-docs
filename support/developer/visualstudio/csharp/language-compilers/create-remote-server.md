---
title: Create a remote server by using Visual C#
description: This article illustrates how to create a remote server that another application can access by using Visual C#.
ms.date: 04/22/2020
ms.reviewer: ARTHURYA
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to create a remote server

This article helps you create a remote server where another application can access by using Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 307445

## Summary

This article illustrates how to create a remote server that another application can access. The application that accesses this server can be located on the same computer, on a different computer, or on a different network. The remote server is broken into two parts: the server object and the server application. The server object is the object that the client communicates with, and the server application is used to register the server object with the .NET Remoting run-time framework.

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Runtime.Remoting`
- `System.Runtime.Remoting.Channels`
- `System.Runtime.Remoting.Channels.Tcp`

## Requirements

This article assumes that you are familiar with the following topics:

- Visual Studio .NET or Visual Studio
- Visual C# .NET or Visual C#
- Networking

## Creating the remote server object

The first step in creating the server application is to create a server object. The server object is what the client application instantiates and communicates with on the server computer. The client application does this through a proxy object that is created on the client. In this sample, the server object resides in a Class Library (DLL) and is called *myRemoteClass*.

1. Create a new Class Library application in Visual C# .NET. Name the project *ServerClass*. Class1 is created by default.
2. In Solution Explorer, rename the *Class1.cs* code file to *ServerClass.cs*.
3. Open *ServerClass.cs* and rename *Class1* to *myRemoteClass*. You also need to rename the default constructor for the class to so that it matches the class name. *myRemoteClass* should inherit from the `MarshalByRefObject` class. Your class should now appear as follows:

    ```csharp
    public class myRemoteClass: MarshalByRefObject
    {
        public myRemoteClass()
        {
          // TO DO: Add constructor logic here.
        }
    }
    ```

4. Add a public method to *myRemoteClass* that takes a string, displays a message to the console with a value of the string, and returns **True** if the string is not empty.

   ```csharp
   public bool SetString(String sTemp)
   {
        try
        {
            Console.WriteLine("This string '{0}' has a length of {1}", sTemp, sTemp.Length);
            return sTemp != "";
        }
        catch
        {
            return false;
        }
   }
   ```

5. Build the project to create the *ServerClass.dll* assembly.
6. Save and close the project.

## Create the remote server application

After you have created the server object that the client will communicate with, you must register this object with the Remoting framework. When you register the object, you must also start the server and have the server listen on a port for clients to connect to that port. To do this, you need a project type that outputs an executable file.

The reason to include the server object in a separate project is so that you can easily reference the server object from the client project. If you include it in this project you cannot reference it, because references can only be set to DLL files.

1. Create a new Console Application in Visual C# .NET to start the remote server. *Class1* is created by default.
2. In Solution Explorer, rename the *Class1.cs* file to *RemoteServer.cs*.
3. Add a reference to the `System.Runtime.Remoting` namespace.
4. Add a reference to the *ServerClass.dll* assembly that you created in the previous section.
5. Use the `using` statement on the `Remoting`, `Remoting.Channels`, and `Remoting.Channels.TCP` namespaces so that you aren't required to qualify declarations in those namespaces later in your code. You must use the `using` statement prior to any other declarations.

    ```csharp
    using System.Runtime.Remoting;
    using System.Runtime.Remoting.Channels;
    using System.Runtime.Remoting.Channels.Tcp;
    ```

6. Declare the appropriate variable. Declare and initialize a `TcpChannel` object that listens for clients to connect on a certain port, which is port 8085 in this example. Use the `RegisterChannel` method to register the channel with the channel services. Add the following declaration code in the `Main` procedure of `Class1`:

    ```csharp
    TcpChannel chan = new TcpChannel(8085);
    ChannelServices.RegisterChannel(chan);
    ```

7. Call the `RegisterWellKnownType` method of the `RemotingConfiguration` object to register the `ServerClass` object with the Remoting framework, and specify the following parameters:

    - The full type name of the object that is being registered (which is *ServerClass.myRemoteClass* in this example), followed by the assembly name *ServerClass*. Specify both the name of the namespace as well as the class name here. Because you didn't specify a namespace in the previous section, the default root namespace is used.

    - Name the endpoint where the object is to be published as *RemoteTest*. Clients need to know this name in order to connect to the object.

    - Use the `SingleCall` object mode to specify the final parameter. The object mode specifies the lifetime of the object when it is activated on the server. In the case of `SingleCall` objects, a new instance of the class is created for each call that a client makes, even if the same client calls the same method more than once. On the other hand, `Singleton` objects are created only once, and all clients communicate with the same object.

        ```csharp
        RemotingConfiguration.RegisterWellKnownServiceType(
        System.Type.GetType("ServerClass.myRemoteClass, ServerClass"),
        "RemoteTest",
        WellKnownObjectMode.SingleCall);
        ```

8. Use the `ReadLine` method of the `Console` object to keep the server application running.

    ```csharp
    System.Console.WriteLine("Hit <enter> to exit...");
    System.Console.ReadLine();
    ```

9. Build your project.
10. Save and close the project.

## References

- [TcpChannel Class](/dotnet/api/system.runtime.remoting.channels.tcp.tcpchannel)

- [RemotingConfiguration.RegisterWellKnownServiceType Method](/dotnet/api/system.runtime.remoting.remotingconfiguration.registerwellknownservicetype)

For an overview of .NET Remoting, see the .NET Framework Developer's Guide documentation.
