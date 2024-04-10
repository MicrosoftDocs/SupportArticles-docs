---
title: Disconnects HTTP bindings for WCF services
description: This article provides workarounds for the issue that causes a Windows Server 2012 R2-based server to drop an underlying TCP connection.
ms.date: 08/24/2020
ms.reviewer: pupanda, meerak, amymcel
---
# HTTP.SYS forcibly disconnects HTTP bindings for WCF self-hosted services

This article helps you resolve the issue that causes a Windows Server 2012 R2-based server to drop an underlying TCP connection.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 3137046

## Symptoms

On a self-hosted Windows Communication Foundation (WCF) service on a server that's running Windows Server 2012 R2 and that uses HTTP-based bindings (such as `basicHttpBinding`), the server intermittently drops the underlying TCP connection. When this problem occurs, you can see it in the *HTTP.SYS* logs that are typically found in the `C:\WINDOWS\System32\LogFiles\HTTPERR` folder. The log files should have an entry that cites `Timer_MinBytesPerSecond` as the reason. This problem does not occur in Windows Server 2008 R2.

The log entry resembles the following:

```console
#Fields: date time c-ip c-port s-ip s-port cs-version cs-method cs-uri sc-status s-siteid s-reason s-queuename
date time 10.145.136.58 41079 10.171.70.136 8888 HTTP/1.1 POST /MySelfHostedService/TestService1 - - Timer_MinBytesPerSecond -
date time 10.145.136.58 41106 10.171.70.136 8888 HTTP/1.1 POST /MySelfHostedService/TestService1 - - Timer_MinBytesPerSecond -
date time 10.145.136.58 40995 10.171.70.136 8888 HTTP/1.1 POST /MySelfHostedService/TestService1 - - Timer_MinBytesPerSecond -
date time 10.145.136.58 41022 10.171.70.136 8888 HTTP/1.1 POST /MySelfHostedService/TestService1 - - Timer_MinBytesPerSecond -
```

In the WCF traces, the service fails during a Receive bytes operation with `System.Net.HttpListenerException`, as in the following example:

```xml
<Exception>
   <ExceptionType>System.ServiceModel.CommunicationException, System.ServiceModel, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089</ExceptionType>
   <Message>The I/O operation has been aborted because of either a thread exit or an application request</Message>
   <StackTrace>
      at System.ServiceModel.Channels.HttpRequestContext.ListenerHttpContext.ListenerContextHttpInput.ListenerContextInputStream.EndRead(IAsyncResult result)
      at System.ServiceModel.Channels.HttpInput.ParseMessageAsyncResult.OnRead(IAsyncResult result)
      at System.Runtime.Fx.AsyncThunk.UnhandledExceptionFrame(IAsyncResult result)
      at System.Net.LazyAsyncResult.Complete(IntPtr userToken)
      at System.Net.HttpRequestStream.HttpRequestStreamAsyncResult.IOCompleted(HttpRequestStreamAsyncResult asyncResult, UInt32 errorCode, UInt32 numBytes)
      at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
      at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
      at System.Threading._IOCompletionCallback.PerformIOCompletionCallback(UInt32 errorCode, UInt32 numBytes, NativeOverlapped* pOVERLAP)
   </StackTrace>
   <ExceptionString>System.ServiceModel.CommunicationException: The I/O operation has been aborted because of either a thread exit or an application request ---&gt; System.Net.HttpListenerException: The I/O operation has been aborted because of either a thread exit or an application request
      at System.Net.HttpRequestStream.EndRead(IAsyncResult asyncResult)
      at System.ServiceModel.Channels.DetectEofStream.EndRead(IAsyncResult result)
      at System.ServiceModel.Channels.HttpRequestContext.ListenerHttpContext.ListenerContextHttpInput.ListenerContextInputStream.EndRead(IAsyncResult result)
      --- End of inner exception stack trace ---
   </ExceptionString>
   <InnerException>
      <ExceptionType>System.Net.HttpListenerException, System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089</ExceptionType>
      <Message>The I/O operation has been aborted because of either a thread exit or an application request</Message>
      <StackTrace>
         at System.Net.HttpRequestStream.EndRead(IAsyncResult asyncResult)
         at System.ServiceModel.Channels.DetectEofStream.EndRead(IAsyncResult result)
         at System.ServiceModel.Channels.HttpRequestContext.ListenerHttpContext.ListenerContextHttpInput.ListenerContextInputStream.EndRead(IAsyncResult result)
      </StackTrace>
      <ExceptionString>System.Net.HttpListenerException (0x80004005): The I/O operation has been aborted because of either a thread exit or an application request
         at System.Net.HttpRequestStream.EndRead(IAsyncResult asyncResult)
         at System.ServiceModel.Channels.DetectEofStream.EndRead(IAsyncResult result)
         at System.ServiceModel.Channels.HttpRequestContext.ListenerHttpContext.ListenerContextHttpInput.ListenerContextInputStream.EndRead(IAsyncResult result)
      </ExceptionString>
      <NativeErrorCode>3E3</NativeErrorCode>
   </InnerException>
</Exception>
```

## Cause

Starting with Windows Server 2012 R2, the kernel driver that handles HTTP requests (http.sys) was changed in terms of how it handles the `Timer_MinBytesPerSecond` property. By default, Http.sys considers any speed rate of less than 150 bytes per second as a potential low speed connection attack, and it drops the TCP connection to release the resource. This problem does not occur in Windows Server 2008 R2 because the threshold for a slow connection in Windows Server 2012 R2 is much more restrictive.

## Workaround

To work around this feature, set the `minSendBytesPerSecond` to value **0xFFFFFFFF** (maximum 32-bits unsigned integer value), which is **4,294,967,295** in decimal. This specific value disables the lower speed rate connection feature.

Use one of the following methods to set the `minSendBytesPerSecond` to value **0xFFFFFFFF**.

- Method 1: Use a configuration file

    ```xml
    <system.net>
       <settings>
          <httpListener>
             <timeouts minSendBytesPerSecond="4294967295" />
          </httpListener>
       </settings>
    </system.net>
    ```

- Method 2: Set programmatically

    Change the property explicitly in code, as in the following example:

    ```csharp
    System.Net.HttpListenerTimeoutManager.MinSendBytesPerSecond = 4294967295
    ```

The programming option can be made into a custom `serviceBehavior` if a code change in the service is not an option. That is, a behavior can be integrated with an existing service by dropping a DLL and changing the configuration, as in the following example:

1. Open your solution in Visual Studio, and add a new Class Library project. Name it `BehaviorProject`.
2. Create a class named `HttpListenerBehavior`.
3. Update it with the following source code:

    ```csharp
    namespace BehaviorProject
    {
        public class HttpListenerBehavior : BehaviorExtensionElement, IServiceBehavior
        {
            public override Type BehaviorType
            {
                get { return this.GetType(); }
            }
            protected override object CreateBehavior()
            {
                return new HttpListenerBehavior();
            }
            public void AddBindingParameters(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase, System.Collections.ObjectModel.Collection<ServiceEndpoint> endpoints, BindingParameterCollection bindingParameters)
            {
                return;
            }
            public void ApplyDispatchBehavior(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
            {
                UpdateSystemNetConfiguration();
            }
            private void UpdateSystemNetConfiguration()
            {
                ConfigurationProperty minSendBytesPerSecond;
                minSendBytesPerSecond = new ConfigurationProperty("minSendBytesPerSecond",
                typeof(long), (long)uint.MaxValue, null, null, ConfigurationPropertyOptions.None);
                ConfigurationPropertyCollection properties;
                HttpListenerTimeoutsElement timeOuts = new HttpListenerTimeoutsElement();
                properties = GetMember(timeOuts, "properties") as ConfigurationPropertyCollection;
                if (properties != null)
                {
                    properties.Remove("minSendBytesPerSecond");
                    SetMember(timeOuts, "minSendBytesPerSecond", minSendBytesPerSecond);
                    properties.Add(minSendBytesPerSecond);
                }
            }
            public void Validate(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
            {
                return;
            }
            public static object GetMember(object Source, string Field)
            {
                string[] fields = Field.Split('.');
                object curr = Source;
                BindingFlags bindingFlags = BindingFlags.Static | BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public;

                bool succeeded = false;

                foreach (string field in fields)
                {
                    Type t = curr.GetType();
                    succeeded = false;
                    FieldInfo fInfo = t.GetField(field, bindingFlags);
                    if (fInfo != null)
                    {
                        curr = fInfo.GetValue(curr);
                        succeeded = true;
                        continue;
                    }
                    PropertyInfo pInfo = t.GetProperty(field, bindingFlags);
                    if (pInfo != null)
                    {
                        curr = pInfo.GetValue(curr, null);
                        succeeded = true;
                        continue;
                    }
                    throw new System.IndexOutOfRangeException();
                }
                if (succeeded) return curr;
                throw new System.ArgumentNullException();
            }

            public static void SetMember(object Source, string Field, object Value)
            {
                string[] fields = Field.Split('.');
                object curr = Source;
                BindingFlags bindingFlags = BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.Public;

                bool succeeded = false;
                int i = 0;
                foreach (string field in fields)
                {
                    i++;
                    Type t = curr.GetType();
                    succeeded = false;
                    FieldInfo fInfo = t.GetField(field, bindingFlags);
                    if (fInfo != null)
                    {
                        if (i == fields.Length)
                        fInfo.SetValue(curr, Value);
                        curr = fInfo.GetValue(curr);
                        succeeded = true;
                        continue;
                    }
                    PropertyInfo pInfo = t.GetProperty(field, bindingFlags);
                    if (pInfo != null)
                    {
                        if (i == fields.Length)
                        fInfo.SetValue(curr, Value);
                        curr = pInfo.GetValue(curr, null);
                        succeeded = true;
                        continue;
                    }
                    throw new System.IndexOutOfRangeException();
                }
                if (succeeded) return;
                throw new System.ArgumentNullException();
            }
        }
    }
    ```

4. Build the library application.
5. Copy the generated DLL to your application folder.
6. Open the application configuration file, locate the `<system.serviceModel>` tag, and add the following custom behavior:

    ```xml
    <extensions>
       <behaviorExtensions>
          <add name="httpListenerBehavior" type="BehaviorProject.HttpListenerBehavior, BehaviorProject, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"/>
       </behaviorExtensions>
    </extensions>
    <behaviors>
       <serviceBehaviors>
          <!-- if the serviceBehavior used by the service is named, add to the appropriate named behavior --> 
          <behavior name="customBehavior">
             <!-- The behavior is referenced by the following in line. Visual Studio will mark this line with a red underline because it is not in the config schema. It can be ignored. Notice that the other behaviors (like serviceMetadata) does not need to be added if they are not currently present --> 
             <httpListenerBehavior />
             <serviceMetadata httpGetEnabled="true"/>
             <serviceDebug includeExceptionDetailInFaults="true"/>
          </behavior>
       </serviceBehaviors>
    </behaviors>
    ```

## More information

To determine whether the changes were effective, use one of the following methods.

- Method 1

    1. Capture a memory dump file after the serviceHost is opened.
    2. Dump the object of type `System.Net.HttpListenerTimeoutManager`, and read the `minSendBytesPerSecond` property.

        ```console
        0:000> !DumpObj /d 02694a64
        Name: System.Net.HttpListenerTimeoutManager
        MethodTable: 7308b070
        EEClass: 72ec5238
        Size: 20(0x14) bytes
        File: C:\Windows\Microsoft.Net\assembly\GAC_MSIL\System\v4.0_4.0.0.0__b77a5c561934e089\System.dll
        Fields:
        MT Field Offset Type VT Attr Value Name
        73092254 4001605 4 ....Net.HttpListener 0 instance 026932f0 listener
        73c755d4 4001606 8 System.Int32[] 0 instance 02694a78 timeouts
        73c7ef20 4001607 c System.UInt32 1 instance 4294967295 minSendBytesPerSecond <-----------------
        ```

        > [!NOTE]
        > The value for `minSendBytesPerSecond` is **4294967295**.

- Method 2

    1. In Administrator mode, open cmd.exe, and run the following command from a command prompt (after the serviceHost is opened):

        `netsh http show servicestate view="session" >%temp%\netshOutput.txt`

    2. Run the following command to open the *netshOutput.txt* file. It will open in Notepad.

        `start %temp%\netshOutput.txt`

    3. Search for the service application port number (such as 8888), and then view your session. This is the step to verify that the minimum send rate (bytes/sec) is overridden with the **4294967295** value.
    4. You should see an entry that resembles the following:

        ```console
        Server session ID: FE00000320000021
        Version: 2.0
        State: Active
        Properties:
        Max bandwidth: 4294967295
        Timeouts:
        Entity body timeout (secs): 120
        Drain entity body timeout (secs): 120
        Request queue timeout (secs): 120
        Idle connection timeout (secs): 120
        Header wait timeout (secs): 120
        Minimum send rate (bytes/sec): 150
        URL groups:
        URL group ID: FD00000340000001
        State: Active
        Request queue name: Request queue is unnamed.
        Properties:
        Max bandwidth: inherited
        Max connections: inherited
        Timeouts:
        Entity body timeout (secs): 0
        Drain entity body timeout (secs): 0
        Request queue timeout (secs): 0
        Idle connection timeout (secs): 0
        Header wait timeout (secs): 0
        Minimum send rate (bytes/sec): 4294967295 <-------------------
        Number of registered URLs: 1
        Registered URLs:
        HTTP://+:8888/TESTSERVICE1/
        ```

For more information, see the [HttpListenerTimeoutManager.MinSendBytesPerSecond Property](/dotnet/api/system.net.httplistenertimeoutmanager.minsendbytespersecond).
