import UIKit

var str = "Hello, playground"

//Swift 标准库提供了名为 sorted(by:) 的方法，它会基于你提供的排序闭包表达式的判断结果对数组中的值（类型确定）进行排序。一旦它完成排序过程，sorted(by:) 方法会返回一个与旧数组类型大小相同类型的新数组，该数组的元素有着正确的排序顺序。原数组不会被 sorted(by:) 方法修改。
//下面的闭包表达式示例使用 sorted(by:) 方法对一个 String 类型的数组进行字母逆序排序。以下是初始数组：

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]


//sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数需要返回 true，反之返回 false。
//该例子对一个 String 类型的数组进行排序，因此排序闭包函数类型需为 (String, String) -> Bool。
//提供排序闭包函数的一种方式是撰写一个符合其类型要求的普通函数，并将其作为 sorted(by:) 方法的参数传入：

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]


//闭包表达式语法有如下的一般形式：
//{ (parameters) -> return type in
//    statements
//}


//闭包表达式参数 可以是 in-out 参数，但不能设定默认值。如果你命名了可变参数，也可以使用此可变参数。元组也可以作为参数和返回值。
//下面的例子展示了之前 backward(_:_:) 函数对应的闭包表达式版本的代码：

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//需要注意的是内联闭包参数和返回值类型声明与 backward(_:_:) 函数类型声明相同。在这两种方式中，都写成了 (s1: String, s2: String) -> Bool。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。
//闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
//由于这个闭包的函数体部分如此短，以至于可以将其改写成一行代码：

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )


//因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )


//Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。
//如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：

reversedNames = names.sorted(by: { $0 > $1 } )


//实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断找到系统自带的那个字符串函数的实现：
reversedNames = names.sorted(by: >)


//如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，将这个闭包替换成为尾随闭包的形式很有用。尾随闭包是一个书写在函数圆括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}


reversedNames = names.sorted() { $0 > $1 }

//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：

reversedNames = names.sorted { $0 > $1 }



let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]


let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings 常量被推断为字符串类型数组，即 [String]
// 其值为 ["OneSix", "FiveEight", "FiveOneZero"]



//举个例子，这有一个叫做 makeIncrementer 的函数，其包含了一个叫做 incrementer 的嵌套函数。嵌套函数 incrementer() 从上下文中捕获了两个值，runningTotal 和 amount。捕获这些值之后，makeIncrementer 将 incrementer 作为闭包返回。每次调用 incrementer 时，其会以 amount 作为增量增加 runningTotal 的值。
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

//incrementer() 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量。这是因为它从外围函数捕获了 runningTotal 和 amount 变量的引用。捕获引用保证了 runningTotal 和 amount 变量在调用完 makeIncrementer 后不会消失，并且保证了在下一次执行 incrementer 函数时，runningTotal 依旧存在。
//注意
//为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。
//Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// 返回的值为10
incrementByTen()
// 返回的值为20
incrementByTen()
// 返回的值为30


//如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// 返回的值为7

//再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量，该变量和 incrementBySeven 中捕获的变量没有任何联系：
incrementByTen()
// 返回的值为40



//上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
//无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
//这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// 返回的值为50

//当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
//someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误。
//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// 打印出“200”

completionHandlers.first?()
print(instance.x)
// 打印出“100”


//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
//我们经常会调用采用自动闭包的函数，但是很少去实现这样的函数。举个例子来说，assert(condition:message:file:line:) 函数接受自动闭包作为它的 condition 参数和 message 参数；它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。
//自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出“5”

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出“5”

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出“4”


//尽管在闭包的代码中，customersInLine的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数。
//将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// 打印出“Now serving Alex!”

//上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// 打印“Now serving Ewa!”


//注意
//过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
//如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的 逃逸闭包。

// customersInLine i= ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// 打印“Collected 2 closures.”
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// 打印“Now serving Barry!”
// 打印“Now serving Daniella!”

//在上面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。


