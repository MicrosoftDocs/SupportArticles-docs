---
title: Implement custom collections in Visual C#
description: Describes how to implement a custom collection in Visual C#. Also includes a code sample that illustrates the task.
ms.date: 04/13/2020
ms.reviewer: bobbym
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to implement custom collections  

This step-by-step article shows you how to implement a custom collection in Visual C#. The Microsoft .NET Framework base class libraries offer a formal definition of a collection `System.Collections.ICollection` interface.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 307484

## Implement the ICollection interface in a custom class

The `ICollection` interface inherits from the `IEnumerable` interface. The `ICollection` interface defines a `CopyTo` method and three read-only properties: `IsSynchronized`, `SyncRoot`, and `Count`. `ICollection` inherits the `GetEnumerator` method from the `IEnumerable` interface. A custom collection class should implement the `ICollection` interface.

To implement the `ICollection` interface, follow these steps:

1. In Visual C# .NET, create a Windows application.
2. In Solution Explorer, right-click the project name, point to **Add**, and then click **Add Class** to add a class module named *CustomCollection*.

3. Add the following sample code to the beginning of the class module to import the `System.Collection` namespace:

    ```csharp
    using System.Collections;
    ```

4. Replace any other code in the module with the following sample code:

    ```csharp
    public class CustomCollection : ICollection
    {
        private int[] intArr = {1,5,9};
        private int Ct;

        public CustomCollection()
        {
            Ct=3;
        }
    }
    ```

    For simplicity, the `CustomCollection` class holds an array with three integer items and a count variable.

5. Implement the `CopyTo` method, which takes an integer array and an index as parameters. This method copies the items in a collection to the array starting at the index that is passed. To implement this method, paste the following code after the public `CustomCollection` constructor:

    ```csharp
    void ICollection.CopyTo(Array myArr, int index)
    {
        foreach (int i in intArr)
        {
            myArr.SetValue(i,index);
            index = index+1;
        }
    }
    ```

6. Implement the `GetEnumerator` method, which is inherited by the `ICollection` interface from `IEnumerable`. The `GetEnumerator` method returns an `Enumerator` object that can iterate through a collection. Paste the following sample code after the `CopyTo` method:

    ```csharp
    IEnumerator IEnumerable.GetEnumerator()
    {
        return new Enumerator(intArr);
    }
    ```

7. To implement the three read-only properties, paste the following code after the `GetEnumerator` method:

    ```csharp
    // The IsSynchronized Boolean property returns True if the
    // collection is designed to be thread safe; otherwise, it returns False.
    bool ICollection.IsSynchronized
    {
        get
        {
            return false;
        }
    }

    // The SyncRoot property returns an object, which is used for synchronizing
    // the collection. This returns the instance of the object or returns the
    // SyncRoot of other collections if the collection contains other collections.
    object ICollection.SyncRoot
    {
        get
        {
            return this;
        }
    }

    // The Count read-only property returns the number
    // of items in the collection.
    int ICollection.Count
    {
        get
        {
            return Ct;
        }
    }
    ```

## Implement an Enumerator object for the GetEnumerator method

This section shows you how to create an `Enumerator` class that can iterate through `CustomCollection`.

1. Paste the following sample code after the end class statement in your class module:

    ```csharp
    public class Enumerator : IEnumerator
    {
        private int[] intArr;
        private int Cursor;
    }
    ```

    Declare the `intArr` private integer array to hold the elements of the `CustomCollection` class when the `GetEnumerator` method is called. The `Cursor` field member holds the current position while enumerating.

2. Add a constructor with `intArr` as a parameter and set the local `intArr` to this. Paste the following sample code after the member field's declaration:

    ```csharp
    public Enumerator(int[] intarr)
    {
        this.intArr = intarr;
        Cursor = -1;
    }
    ```

3. Implement the `Reset` and `MoveNext` methods. To do this, paste the following code after the constructor:

    ```csharp
    void IEnumerator.Reset()
    {
        Cursor = -1;
    }
    bool IEnumerator.MoveNext()
    {
        if (Cursor < intArr.Length)
            Cursor++;

        return(!(Cursor == intArr.Length));
    }
    ```

    `Reset` sets the `Cursor` to **-1** and `MoveNext` moves the `Cursor` to the next element. `MoveNext` returns **True** if successful.

4. Implement the `Current` read-only property that returns the item pointed by the `Cursor`. If the `Cursor` is **-1**, it generates an `InvalidOperationException`. Paste the following code after the `MoveNext` method:

    ```csharp
    object IEnumerator.Current
    {
        get
        {
            if((Cursor < 0) || (Cursor == intArr.Length))
                throw new InvalidOperationException();
            return intArr[Cursor];
        }
    }
    ```

## Using for each to iterate through the custom collection

1. In *Form1.cs*, on the **Design** tab, drag a button to the form.
2. Double-click the button and add the following sample code to the `Click` event of the button:

    ```csharp
    CustomCollection MyCol = new CustomCollection();

    foreach (object MyObj in MyCol)
        MessageBox.Show(MyObj.ToString());
    ```

3. Press F5 to run the application, and then click the button.

    > [!NOTE]
    > A message box displays the items in the custom collection.

How does this work? For each calls the `GetEnumerator` method to create the `Enumerator` object and calls the `MoveNext` method to set the `Cursor` to the first item. Then the current property is accessed to get the item in `MyObj`. This is repeated until `MoveNext` returns **False**.
