//
//  StructClassActor.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/16.
//


/*
REF: https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=9
 
 VALUE Types:
  - Struct, Enu, String, Int, etc
  - Stored in Stack
  - Faster
  - Thread Safe
  - When you assign or pass value a new copy of data is created
 
 REFERENCE Types:
  - Class, Func, Actor
  - Stored in Heap
  - Slower , but synchronized
  - not Thread safe
  - when you assign or pass reference type a new reference to original instance will be created
 
  STACK:
  - Stored Value type
  - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fase
  - Each thread has it's own stack!
 
  HEAP:
  - Stores Reference Types
  - Shared across threads!
  -
 
  STRUCT:
  - Based on Values
  - Can me mutated
  - Stored in the stack
 
  Class:
  - Based on References (instances)
  - Stored in Heap!
  - Inherit from other classes
 
  Actors:
  - Same as Class but thread safe
  -
 
 
 When to use!???
 
 Struct: Data Models, Views
 Classes: Observable이 class에서만 되는 이유는 mutating을 항상 만들어주지 않기 위해서 이다. ViewModels
 Actors: shared DataManager 혹은 data store하는 경우,
 
 */

import SwiftUI

struct StructClassActor: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                runTest()
            }
    }
}

struct StructClassActor_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActor()
    }
}

extension StructClassActor {
    
    private func runTest() {
        print("TEST STARTED")
        structTest1()
        print("--------------")
        classTest1()
        print("--------------")
        actorTest1()
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting title!")
        print("objectA: ", objectA.title)
        
        // objectB의 title을 바꿀때에는 struct를 mutating 하는 것임
        // mutating 하게 되면 objectB를 모두 다 바꿔 끼는 것임 title만 바꾸는게 아님
        print("Pass the VALUES of objectA to objectB")
        var objectB = objectA
        print("objectB: ", objectB.title)
        
        objectB.title = "Second title"
        print("ObjectB title changed!")
        print("objectA: ", objectA.title)
        print("objectB: ", objectB.title)
    }
    
    private func classTest1() {
        // class의 경우에 대입하게 되면, REFERENCE가 넘어가서 동기적으로 모든 객체가 바뀜
        // 반면 struct의 경우에 VALUE이기 때문에 sync하지 않음 (때문에 passing value하는 것이 더 빠름)
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        // objectB를 let으로 해도 에러가 나지 않는 이유는 objectA를 그대로 받기 때문임
        print("Pass the REFERENCE of objectA to objectB")
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second title"
        print("ObjeectB title changed")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func actorTest1() {
        Task {
            print("actorTest1")
            let objectA = MyActor(title: "Starting title!")
            // 다른 thread가 끝나기를 기다려 주어야 한다. 동일한 Heap을 접근할 수 있기 때문.
            await print("ObjectA: ", objectA.title)
            
            print("Pass the REFERENCE of objectA to objectB")
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            
            // actor의 바깥에서 value를 직접 바꾸려고 하는 것은 못하게 되어있음
            // objectB.title = "111"
            await objectB.updateTitle(newTitle: "Second Title")
            print("ObjeectB title changed")
            
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }
    }
    
}

struct MyStruct {
    var title: String
}

// Immutable struct

struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    // 하단의 mutating도 struct를 다 바꿔버리는 것임
    mutating func updateTitle(newTitle: String) {
        self.title = newTitle
    }
}

extension StructClassActor {
    
    private func structTest2() {
        print("structTest2")
        
        // 하단의 Struct를 갈아끼우는 것음 정확히 동일한 동작을 하게 된다.
        // 모든 object들을 갈아 끼우는 것임
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title2"
        print("Struct1: ", struct1.title)
        
        var struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: ", struct3.title)
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
    }
}

class MyClass {
    var title: String
    
    // class는 init을 만들어 주어야 한다.
    init(title: String) {
        self.title = title
    }
    
    // mutating은 VALUE일때(struct) 사용이 가능하다.
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
}

actor MyActor {
    var title: String
    
    // class는 init을 만들어 주어야 한다.
    init(title: String) {
        self.title = title
    }
    
    // mutating은 VALUE일때(struct) 사용이 가능하다.
    func updateTitle(newTitle: String) {
        self.title = newTitle
    }
}


extension StructClassActor {
    
    private func classTest2() {
        print("classTest2")
        
        let class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        let class2 = MyClass(title: "Title1")
        print("Class2: ", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("Class2: ", class2.title)
    }
}
