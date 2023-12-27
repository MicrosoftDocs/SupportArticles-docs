---
title: Make a class usable in a foreach statement
description: Describes how to make a Visual C# class usable in a foreach statement. Also describes a code sample to explain the methods.
ms.date: 04/14/2020
ms.reviewer: zakramer
ms.topic: how-to
---
# Make a Visual C# class usable in a foreach statement  

This article demonstrates how to use the `IEnumerable` and the `IEnumerator` interfaces to create a class that you can use in a `foreach` statement.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 322022

## IEnumerator interface

`IEnumerable` and `IEnumerator` are frequently used together. Although these interfaces are similar (and have similar names), they have different purposes.

The `IEnumerator` interface provides iterative capability for a collection that is internal to a class. `IEnumerator` requires that you implement three methods:

- The `MoveNext` method, which increments the collection index by 1 and returns a bool that indicates whether the end of the collection has been reached.
- The `Reset` method, which resets the collection index to its initial value of -1. This invalidates the enumerator.
- The `Current` method, which returns the current object at `position`.

    ```csharp
    public bool MoveNext()
    {
        position++;
        return (position < carlist.Length);
    }
    public void Reset()
    {
        position = -1;
    }
    public object Current
    {
        get { return carlist[position];}
    }
    ```

## IEnumerable interface

The `IEnumerable` interface provides support for the `foreach` iteration. `IEnumerable` requires that you implement the `GetEnumerator` method.

```csharp
public IEnumerator GetEnumerator()
{
    return (IEnumerator)this;
}
```

## When to use which interface

Initially, you might find it confusing to use these interfaces. The `IEnumerator` interface provides iteration over a collection-type object in a class. The `IEnumerable` interface permits enumeration by using a `foreach` loop. However, the `GetEnumerator` method of the `IEnumerable` interface returns an `IEnumerator` interface. So to implement `IEnumerable`, you must also implement `IEnumerator`. If you don't implement `IEnumerator`, you can't cast the return value from the `GetEnumerator` method of `IEnumerable` to the `IEnumerator` interface.

In summary, the use of `IEnumerable` requires that the class implement `IEnumerator`. If you want to provide support for `foreach`, implement both interfaces.

## Step-by-step example

The following example demonstrates how to use these interfaces. In this example, the `IEnumerator` and `IEnumerable` interfaces are used in a class named `cars`. The `cars` class has an internal array of `car` objects. Client applications can enumerate through this internal array by using a `foreach` construct because of the implementation of these two interfaces.

1. Follow these steps to create a new Console Application project in Visual C#:
    1. Start Microsoft Visual Studio .NET or Visual Studio.
    2. On the **File** menu, point to **New**, and then click **Project**.
    3. Click **Visual C# Projects** under **Project Types**, and then click **Console Application** under **Templates**.
    4. In the **Name** box, type **ConsoleEnum**.

2. Rename *Class1.cs* to *host.cs*, and then replace the code in *host.cs* with the following code:

   ```csharp
   using System;
   namespace ConsoleEnum
   {
      class host
      {
          [STAThread]
          static void Main(string[] args)
          {
              cars C = new cars();
              Console.WriteLine("\nInternal Collection (Unsorted - IEnumerable,Enumerator)\n");
              foreach(car c in C)
              Console.WriteLine(c.Make + "\t\t" + c.Year);
              Console.ReadLine();
          }
      }
   }
   ```

3. On the **Project** menu, click **Add Class**, and then type *car* in the **Name** box.

4. Replace the code in *car.cs* with the following code:

   ```csharp
   using System;
   using System.Collections;
   namespace ConsoleEnum
   {
      public class car
      {
          private int year;
          private string make;
          public car(string Make,int Year)
          {
              make=Make;
              year=Year;
          }
          public int Year
          {
              get  {return year;}
              set {year=value;}
          }
          public string Make
          {
              get {return make;}
              set {make=value;}
          }
      }//end class
   }//end namespace
   ```

5. On the **Project** menu, click **Add Class** to add another class to the project, and then type *cars* in the **Name** box.

6. Replace the code in *cars.cs* with the following code:

   ```csharp
   using System;
   using System.Collections;
   namespace ConsoleEnum
   {
       public class cars : IEnumerator,IEnumerable
       {
          private car[] carlist;
          int position = -1;
          //Create internal array in constructor.
          public cars()
          {
              carlist= new car[6]
              {
                  new car("Ford",1992),
                  new car("Fiat",1988),
                  new car("Buick",1932),
                  new car("Ford",1932),
                  new car("Dodge",1999),
                  new car("Honda",1977)
              };
          }
          //IEnumerator and IEnumerable require these methods.
          public IEnumerator GetEnumerator()
          {
              return (IEnumerator)this;
          }
          //IEnumerator
          public bool MoveNext()
          {
              position++;
              return (position < carlist.Length);
          }
          //IEnumerable
          public void Reset()
          {
              position = -1;
          }
          //IEnumerable
          public object Current
          {
              get { return carlist[position];}
          }
       }
     }
   ```

7. Run the project.

  The following output appears in the **Console** window:

  ```console
  Ford            1992
  Fiat            1988
  Buick           1932
  Ford            1932
  Dodge           1999
  Honda           1977
  ```

## Best practices

The example in this article is kept as simple as possible to better explain the use of these interfaces. To make the code more robust and to make sure the code uses the current best practice guidelines, modify the code as follows:

- Implement `IEnumerator` in a nested class so that you can create multiple enumerators.
- Provide exception handling for the `Current` method of `IEnumerator`. If the contents of the collection change, the `reset` method is called. As a result, the current enumerator is invalidated, and you receive an `IndexOutOfRangeException` exception. Other circumstances might also cause this exception. So implement a `Try...Catch` block to catch this exception and to raise an `InvalidOperationException` exception.

```csharp
using System;
using System.Collections;
namespace ConsoleEnum
{
    public class cars : IEnumerable
    {
        private car[] carlist;
  
        //Create internal array in constructor.
        public cars()
        {
            carlist= new car[6]
            {
                new car("Ford",1992),
                new car("Fiat",1988),
                new car("Buick",1932),
                new car("Ford",1932),
                new car("Dodge",1999),
                new car("Honda",1977)
            };
        }
        //private enumerator class
        private class  MyEnumerator:IEnumerator
        {
            public car[] carlist;
            int position = -1;

            //constructor
            public MyEnumerator(car[] list)
            {
                carlist=list;
            }
            private IEnumerator getEnumerator()
            {
                return (IEnumerator)this;
            }
            //IEnumerator
            public bool MoveNext()
            {
                position++;
                return (position < carlist.Length);
            }
            //IEnumerator
            public void Reset()
            {
                position = -1;
            }
            //IEnumerator
            public object Current
            {
                get
                {
                    try
                    {
                        return carlist[position];
                    }
                    catch (IndexOutOfRangeException)
                    {
                        throw new InvalidOperationException();
                    }
                }
            }
        }  //end nested class
      public IEnumerator GetEnumerator()
      {
          return new MyEnumerator(carlist);
      }
    }
}
```
