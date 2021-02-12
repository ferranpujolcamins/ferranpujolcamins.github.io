---
layout: post
title:  "Is the visitor pattern still relevant?"
excludeFromMenu: false
---

In this post I'll talk about the [visitor pattern](https://en.wikipedia.org/wiki/Visitor_pattern) and I will try to answer the question: *is it still relevant?* To find the answer, I'll explore sum and existential types: what they are and what they are useful for (spoiler alert: you already know them, just with a different name).

Although I focus on C++, most of the reasoning can be easily transported to other languages.


## The problem

According to the [gang of four book](https://en.wikipedia.org/wiki/Design_Patterns), the visitor pattern allows you to:
    
> Represent an operation to be performed on the elements of an object structure [...] without changing the classes of elements on which it operates.

If we only consider what's explicitly stated in this definition, one could say that the visitor pattern just consists in iterating
on a data structure and process each element with a function<sup>[[a]](#footnote-a)</sup>.

However, when we talk about the visitor pattern there's two implicit assumptions:
1. Our data structure contains heterogeneous objects that share a common interface.
2. Our function needs to know the specific runtime type of each object in the structure.

In other words, we face an additional problem: how can our function know the specific runtime type of an object under an interface?
This is an orthogonal problem to that of how to traverse a data structure, yet, in the visitor pattern both are intermixed<sup>[[b]](#footnote-b)</sup>.

### The naive solution

So we want to know the specific runtime type of an object under an interface. How can we do that?

The naive solution to this problem is to add a virtual method to the base class of our objects for each operation that needs to
know what is the specific runtime type of our objects. This is problematic because for each such operation
we need to add a new method to **each** subclass of our base class. This breaks the [open-closed principle](https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle): we need to modify
our classes each time we want to add an external operation that works on them, so our classes can't be closed for modification.
It also breaks the [dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle), since our classes need to depend on every concrete operation.

Another tempting approach is to use `dynamic_cast`. As we'll see on the next section, the visitor pattern forces us to add one virtual method to our class hierarchy. Although this is not too bad, with `dynamic_cast` we can do even better: we don't need to modify our class hierarchy at all.
The main drawback of `dynamic_cast` is performance: it's slower than the two virtual calls we need for the visitor pattern. The usage of `dynamic_cast` instead of the visitor pattern is highly despised on the internet. However, in my opinion, if performance is not an issue it's a perfectly valid solution.

You can read in more detail about the problems and tradeoffs of these naive solutions and also about the visitor pattern in general in [this thorough article](https://gieseanw.wordpress.com/2018/12/29/stop-reimplementing-the-virtual-table-and-start-using-double-dispatch/) by Andy G.

## Double dispatch to the rescue

As we hinted in the previous section, the less expensive (but still safe) way to determine the runtime type of an object is to use virtual calls.
Following this idea, we see that if an object of A wants to know the runtime type of an object B, A has to call a virtual method on object B.
The question is, how do we send the type information back to A? Easy, we just call a method of A from B:

```c++
#include <memory>
#include <iostream>
#include <vector>

class B;
class C;
class Operation;

class AbstractClass {
  public:
    virtual ~AbstractClass() = default;
    virtual int accept(Operation* operation) = 0;
};

class Operation {
  public:
    int computeSomethingWith(AbstractClass* object) {
        // We ask `object` to call us back so we can discover its type.
        // We get back the result value we computed in the corresponding Operation::accept method.
        return object->accept(this);
    }

    int accept(B* b) {
        // Compute something when `object` is of type B
        return 0;
    }

    int accept(C* b) {
        // Compute something when `object` is of type C
        return 1;
    }
};

class B: public AbstractClass {
    int accept(Operation* operation) override {
        // When an Operation visits us, we visit it back.
        // Since here we now `this` is of type `B*`,
        // The call to accept is statically resolved to the appropriate overload.
        // From the call to accept we get back the result of the computation
        // that Operation has performed, we have to return it back.
        return operation->accept(this);
    }
};

class C: public AbstractClass {
    int accept(Operation* operation) override {
        return operation->accept(this);
    }
};

int main() {
    
    std::unique_ptr<AbstractClass> b = std::make_unique<B>();
    std::unique_ptr<AbstractClass> c = std::make_unique<C>();
    
    Operation operation;

    // Prints 0 1
    std::cout << operation.computeSomethingWith(b.get()) << ' '
            << operation.computeSomethingWith(c.get()) << std::endl;
            return 0;
}
```

This technique is called *single* (dynamic) *dispatch*, because we use one virtual call to `AbstractClass::accept` to determine the runtime type of our object. `Operation` is usually also called the *Visitor*.

If we wanted to add another operation, we would need to add a new method `int accept(OtherOperation* operation)` method to our class hierarchy, which is exactly what we want to avoid. To fix this, the trick is to abstract over the operations (or visitors) so we only need to add one accept method to our class hierarchy no matter how many operations we have:

```c++
#include <memory>
#include <iostream>
#include <vector>

class B;
class C;
class Operation;

class AbstractVisitor {
  public:
    virtual ~AbstractVisitor() = default;
    virtual void accept(B* b) = 0;
    virtual void accept(C* c) = 0;
};

class AbstractClass {
  public:
    virtual ~AbstractClass() = default;
    
    virtual void accept(AbstractVisitor* visitor) = 0;
};

class Operation1: public AbstractVisitor {
  public:
    int computeSomethingWith(AbstractClass* object) {
        // We ask `object` to call us back so we can discover its type.
        // We get back the result value we computed in the corresponding A::accept method.
        object->accept(this);
        return result;
    }

    void accept(B* b) {
        // Compute something when `object` is of type B
        result = 0;
    }

    void accept(C* b) {
        // Compute something when `object` is of type C
        result = 1;
    }
    
  private:
    int result;
};

class Operation2: public AbstractVisitor {
  public:
    char computeSomethingWith(AbstractClass* object) {
        // We ask `object` to call us back so we can discover its type.
        // We get back the result value we computed in the corresponding A::accept method.
        object->accept(this);
        return result;
    }

    void accept(B* b) {
        // Compute something when `object` is of type B
        result = 'b';
    }

    void accept(C* b) {
        // Compute something when `object` is of type C
        result = 'c';
    }
    
  private:
    char result;
};

class B: public AbstractClass {
    void accept(AbstractVisitor* visitor) override {
        // When an Operation visits us, we visit it back.
        // Since here we now `this` is of type `B*`,
        // The call to accept is statically resolved to the appropriate overload.
        // From the call to accept we get back the result of the computation
        // that Operation has performed, we need to return it back.
        visitor->accept(this);
    }
};

class C: public AbstractClass {
    void accept(AbstractVisitor* visitor) override {
        visitor->accept(this);
    }
};

int main() {
    
    std::unique_ptr<AbstractClass> b = std::make_unique<B>();
    std::unique_ptr<AbstractClass> c = std::make_unique<C>();
    
    Operation1 operation1;
    Operation2 operation2;

    // Prints 0 1
    //        b c
    std::cout << operation1.computeSomethingWith(b.get()) << ' '
            << operation1.computeSomethingWith(c.get()) << std::endl
            << operation2.computeSomethingWith(b.get()) << ' '
            << operation2.computeSomethingWith(c.get()) << std::endl;
            return 0;
}
```
Different operations might need to compute different result values of different type for each visited element. Thus, the `AbstractVisitor::accept` methods can't return int anymore. Furthermore, we can't make `AbstractVisitor` a template class because it has virtual methods.
This is the reason we need to store the result value in a field of the visitor instance this time.

This technique is called [*double* (dynamic) *dispatch*](https://en.wikipedia.org/wiki/Double_dispatch): we have the virtual call from the visitor to the element, and a virtual call back from the element to the visitor.

When you add to the mix a way to traverse a data structure with this double dispatch technique you get what's usually called *the visitor pattern*.

The question here is: why would you want to know the specific runtime type of an object under an interface? Isn't the whole point of dynamic polymorphism to forget about specific types and focus on the abstraction? To answer this question, let's talk about *sum types* and *existential types*.

## Sum and Existential types

*[Sum types](https://en.wikipedia.org/wiki/Tagged_union)* are data types that hold one single value at a time, out of a predefined finite list of values (or *cases*). Also, with each case, a value of a predefined type is stores. Think of an enum, but each enum case has predefined type, and along the enum case, an instance of the appropriate type is stored. For example, in Rust we can write:
```rust
enum TwoIntsOrStringOrNothing {
        AnInt(isize, isize), // The `AnInt` case holds two integers, or equivalently, holds a value of the tuple type (isize, isize)
        AString(String), // The `AString` case holds a String
        Nothing // A case can have no associated data
    }
```

*Existential types* (or just *existential* for short) are like sum types, but there's no predefined list of what values they can hold. You can think of existential types as an infinite sum of types<sup>[[1]](#ref-quantified-types-as-products-and-sums)</sup>, i.e. an enum that can hold one case at a time, out of an infinite collection of possible types!

An existential it's not very useful if we don't limit the types it can hold: if we have a value of an unknown type, which could be any type, what can we do with it? Can we call the method `foo()` in this type? We don't know. Can this type be copied? We don't know, because it could be any type. This is why existentials are usually limited to hold values of types that conform to a certain interface. Thus, we can have an existential that holds "printable types", so at least we know we can get a string representing the value it holds. For example, in Rust we can write:
```rust
// Define a trait (or interface)
trait Printable {
    fn stringify(&self) -> String;
}

// A function that takes an existential type whose values must be Printable
fn print(a: Box<dyn Printable>) {
    // We can call stringify, because we know that values of our existential implement at least this interface,
    // alttough we can't know the concrete type we are working with.
    println!("{}", a.stringify());
}

```

Note that even though we have limited what concrete types an existential can hold, the number is still infinite, because you can't know how many types conforming to the interface a user of your library will write.

Since we know all the possible types a sum type can hold, the compiler just needs to allocate as much memory as the biggest type needs (plus a little more to store what case we are in). This means that sum types can be allocated on the stack. On the other hand, since we don't know what types an existential will hold, we can't put an upper bound on its memory footprint. Thus, the value that an existential types holds is usually allocated on the heap. And I say usually, because in Rust there are several kinds of existential types, some of which can be allocated on the stack<sup>[[2]](#ref-existential-type-in-rust)</sup>.


The definition of existential types might have rung a bell with you. In fact existential types are in some sense similar to [subtype polymorphism](https://en.wikipedia.org/wiki/Polymorphism_(computer_science)#Subtyping)<sup>[[3]](#ref-oop-vs-type-classes)</sup>: with subtype polymorphism, whenever I have a variable of type `BaseClass*` I can store any instance of **any** subclass of `BaseClass*`. Likewise, with existential types, whenever I have a variable of type "Existential of `SomeInterface`", I can store any object of **any** type that implements `SomeInterface`.


### When to use Sum types over Existential types?

Why would anyone use sum types? At first glance they seem like a weaker version of existential types: while I can hold values of an infinite collection of types in an existential, with a sum type I can only hold values of a finite predefined collection of types. It turns out, that this characteristic of sum types it's actually their strength<sup>[[c]](#footnote-c)</sup>. Sum types allow us to model a fixed finite number of possibilities and treat each one of them **specifically**. Most compilers either issue a warning or error when trying to build a program if a function that reads a value of a sum type doesn't cover all its cases, which helps catching mistakes at build time.

On the other hand, existentials allow us to be completely oblivious to concrete types, as long as they implement some interface. Thus, we are forced to treat types **uniformly**.

Sum types allow us to model choice, or the existence of several known possibilities. Existential types allow us to abstract over the details (what concrete implementation of an interface we are using).

### This sounds interesting. What does this look on C++?

As we discussed above, C++ has subtype polymorphism (a pointer to a base class can hold an object of any subclass), which is equivalent to existential types.

C++ didn't use to have **safe** support for sum types: enums can't have associated data, and using unions is asking for trouble<sup>[[4]](#ref-the-joys-and-pains-of-unrestricted-unions)</sup>.

### And what does all this have to do with the visitor pattern?

So in C++ we didn't have safe sum types. What could you do when you wanted to model choice or a finite set of possibilities?
Well, you (ab)used existentials (i.e. subtype polymorphism, i.e. an abstract class with a subclass for each case). As we said in the previous section, one of the reasons you would want to use a sum type is to treat each one of its cases specifically. In this case, this translates to determine the concrete runtime type of an object pointed by a base class pointer. Does this problem sound familiar? This is exactly the problem that led us to [visitor pattern](#double-dispatch-to-the-rescue)!

It turns out that the visitor pattern was develop to cope with the lack of support for sum types in classic OOP languages like Java and C++.

### Modern C++

As you might have guessed by my usage of the past tense in the previous section, nowadays C++ has support for safe sum types! Since C++17 we have `std::variant`. Thanks to the [`visit`](https://en.cppreference.com/w/cpp/utility/variant/visit) function (and some obscure template meta-programming) we can handle each case of a variant like this:

```c++
std::variant<int, long, double, std::string> v = ...;

std::visit(overloaded {
            [](double arg) { std::cout << std::fixed << arg << ' '; },
            [](const std::string& arg) { std::cout << std::quoted(arg) << ' '; },
            [](auto arg) { std::cout << arg << ' '; }, // "default" case
        }, v);
```

However, this solution is far from perfect. It's not totally straightforward (template meta-programming, remember?). For example, if you forget to add a lambda for a case, the compiler spits a long error that apparently doesn't have anything to do with a missing case.

Nonetheless, from my point of view, as of C++17, the answer to the question
> Is the visitor pattern still relevant?

is **no**. 

99% of times, there's no reason to use the visitor pattern (other than dealing with legacy code)<sup>[[d]](#footnote-d)</sup>.


## Final thoughts

The visitor pattern is one of the 23 classic design patterns described in the [gang of four book](https://en.wikipedia.org/wiki/Design_Patterns). Design patterns offer known solutions to design problems following classic object oriented principles. They are reusable in different situations and help us identify and separate design complexity from complexity in our domain. Design patterns improve communication since they are known solutions that developers can identify and recognize.

However, as we've seen with the visitor pattern, they can become obsolete. Programming languages evolve, our collective knowledge as developers does too. New tools, techniques, ideas and paradigms appear. And all these things can make endemic problems and challenges disappear, and with them, the solutions that were designed to spare us from their pain.

Therefore, we must not blindly use design patterns (or any other established doctrine). We must periodically re-visit and challenge our ideas, study them under new perspectives. We have to listen to new ideas, discuss them and be truly and honestly open to have our mind changed. But, most importantly, we must always do this respectfully, and acknowledging that there are as many valid point of views, as people in this planet.

## Notes

<ol class="nestedList spacedList letterList">
    <li id="footnote-a" class="ref">
        Maybe the data structure has more than one sensible way
        in which it can be iterated, or maybe we need to abstract over the specific structure we are iterating on.
        In these situations the <a href="https://en.wikipedia.org/wiki/Iterator_pattern">iterator pattern</a> comes in handy.
    </li>
    <li id="footnote-b" class="ref">
        These two problems were intermixed probably because for some data structures you need to know the runtime type of an object
        in order to know what is the next object you should visit. For example, consider the following binary tree representation: 
        <pre><code>// Abstract class
class Tree {};
class Empty: public Tree {};
class Branch: public Tree {
    Tree* leftBranch;
    Tree* rightBranch;
};</code></pre>
        When writing an iterator, given an object of type <code>Tree*</code> we need to know whether it's an instance of <code>Empty</code>
        or an instance of <code>Branch</code> in order to know what are (if any) the next elements of the tree that we have to visit.
    </li>
    <li id="footnote-c" class="ref">
        Plus they can be stack-allocated, remember!
    </li>
    <li id="footnote-d" class="ref">
        <a href="https://en.wikipedia.org/wiki/Serialization">Serialization</a> is an example where the visitor pattern can be useful.
        When writing serialization code, you want to be able to work with any <code>Serializable</code> type, thus you use existential types.
        However, you might not want to force every <code>Serializable</code> subclass to contain their serialization code. Maybe you want
        one single function elsewhere that takes a <code>Serializable*</code>, checks what specific case we are dealing with (like you would do with a sum type) and calls the appropriate serialization code. This way the serialization code is as decoupled from your classes as possible.
        You don't really want to write a sum type, because it could be a huge sum type that you have to change every time you make a class
        serializable. Also, you are not modeling a finite choice, it really make sense to use existentials. But you need to know the specific type under the abstraction. Thus, in this situation the visitor pattern is the way to go.
    </li>
</ol>

## References

<ol class="nestedList">
    <li id="ref-quantified-types-as-products-and-sums" class="ref">
        <a href="https://en.wikibooks.org/wiki/Haskell/Existentially_quantified_types#Quantified_Types_as_Products_and_Sums">Quantified types as products and sums</a> <small>(en.wikibooks.org/wiki/Haskell)</small>
    </li>
    <li id="ref-existential-type-in-rust" class="ref">
        <a href="https://varkor.github.io/blog/2018/07/03/existential-types-in-rust.html">Existential types in Rust</a> <small>(varkor.github.io)</small>
    </li>
    <li id="ref-oop-vs-type-classes" class="ref">
        <a href="https://wiki.haskell.org/OOP_vs_type_classes#OO_class_always_corresponds_to_a_haskell_class_.2B_a_related_haskell_existential_.28John_Meacham.29">OOP vs type classes</a> <small>(wiki.haskell.org)</small>
    </li>
    <li id="ref-the-joys-and-pains-of-unrestricted-unions" class="ref">
        <a href="https://faouellet.github.io/unrestricted-unions/">The joys and pains of unrestricted unions</a> <small>(faouellet.github.io)</small>
    </li>
</ol>

## Further reading

- [The visitor pattern is essentially the same thing as Church encoding](https://www.haskellforall.com/2021/01/the-visitor-pattern-is-essentially-same.html) <small>(haskellforall.com)</small>
- [Visitor as a sum type](https://blog.ploeh.dk/2018/06/25/visitor-as-a-sum-type/) <small>(blog.ploeh.dk)</small>
- [Simple Algebraic Data Types](https://bartoszmilewski.com/2015/01/13/simple-algebraic-data-types/) <small>(bartoszmilewski.com)</small>
- [Sum Types Are Coming: What You Should Know](https://chadaustin.me/2015/07/sum-types/) <small>(chadaustin.me)</small>
- [Why are Haskell algebraic data types “closed”?](https://stackoverflow.com/questions/870919/why-are-haskell-algebraic-data-types-closed) 
<small>(stackoverflow.com)</small>
