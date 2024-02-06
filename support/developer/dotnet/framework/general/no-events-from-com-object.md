---
title: No events received from COM when .NET app loses focus
description: When the .NET Compact Framework application loses focus, no further events are received from the COM object, even after the application receives focus once again. Provides workarounds.
ms.date: 05/12/2020
---
# .NET CF application calls Unadvise on COM connection point when form loses focus

This article helps you work around the problem where no events are received from the Component Object Model (COM) object when the .NET Compact Framework application that creates a COM object and connects to its source connection point loses focus.

_Original product version:_ &nbsp; Microsoft .NET Compact Framework 3.5  
_Original KB number:_ &nbsp; 2300221

## Symptom

A .NET Compact Framework application creates a COM object and connects to its source connection point. The .NET object now successfully receives events that are sent by the COM object. However, when the .NET Compact Framework application loses focus, no further events are received from the COM object, even after the application receives focus once again.

## Cause

When the application loses focus, the .NET Compact Framework erroneously calls the `Unadvise` method in the COM object's `IConnectionPoint` interface.

## Resolution

There are two possible workarounds:

- This issue only occurs on .NET Compact Framework 3.5. Applications will continue to behave as expected on .NET Compact Framework 2.0. This is a possible workaround if feasible.
- Instead of relying on the built-in support for COM connection points in .NET Compact Framework, one can write the code to manually connect and disconnect to the source interface exposed by the COM object. Sample code to accomplish this is provided below.

Follows is a brief sample of how one might manually connect to a source interface exposed by a COM object without using the .NET facility to do this.

Assume we've imported a COM object called *EventGeneratorLib*. First define the interface that's exposed as the source interface by the COM object. In this example, the interface is inherited from `IDispatch` and contains a single method.

```csharp
[ComImport, Guid("<GUID of COM object's source interface>"), InterfaceType(ComInterfaceType.InterfaceIsIDispatch)]
public interface _ISampleEvents
{
    [DispId(1)]
    void FireEvent();
}
```

Now define a class to implement the interface.

```csharp
[ComVisible(true), ClassInterface(ClassInterfaceType.None)]
public class SampleEvents : IDisposable, _ISampleEvents
{
    // COM object
    private EventGeneratorLib.EventGenerator _oEventGenerator;

    private bool _disposed = false;
    private IConnectionPoint _cp = null;
    private int _dwCookie = 0;

    public SampleEvents()
    {
        // Instantiate the COM object
        _oEventGenerator = new EventGeneratorLib.EventGenerator();

        // Set up callback
        if (_oEventGenerator != null)
        {
            // Query the object for an IConnectionPointContainer interface
            IConnectionPointContainer cpc = (IConnectionPointContainer)_oEventGenerator;

            IConnectionPoint cp = null;

            Guid cpGuid = new Guid("<GUID of source interface as defined by COM object>");
            int dwCookie = 0;

            // Find the connection point
            cpc.FindConnectionPoint(ref cpGuid, out cp);

            // Call advise to start receiving events from the COM object
            cp.Advise((_ISampleEvents)this, out dwCookie);

            // Save the cookie and the ConnectionPoint interface pointer
            _dwCookie = dwCookie;
            _cp = cp;
        }
    }

    ~SampleEvents()
    {
    Dispose(false);
    }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
        return;
    }

    private void Dispose(bool disposing)
    {
        // Check to see if Dispose has already been called.
        if (!this._disposed)
        {
            if (disposing)
            {
                // No code required here
            }

            // See if we created the COM object
            if (_oEventGenerator != null)
            {
                // Tear down the connection point
                if (_cp != null)
                {
                    _cp.Unadvise(_dwCookie);
                    _cp = null;
                }
                Marshal.ReleaseComObject(_oEventGenerator);
                 _oEventGenerator = null;
            }
        }
    _disposed = true;
    }

    #region _ISampleEvents Members

    // This is the definition of the interface that the COM object
    // calls back into.
    void _ISampleEvents.FireEvent()
    {
        // Do something here with event from COM object
    }
    #endregion
}

```

The above code is only provided as a sample. Error handling has been omitted for brevity.
