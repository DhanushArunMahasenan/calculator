//
//  MathParser.swift
//  MyMathFramework
//
//  Created by Dhanush Arun on 2/1/22.
//

import Foundation
import SwiftUI


public func getModelName() -> String {
        var machineSwiftString : String = ""
    
        #if targetEnvironment(simulator)
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    machineSwiftString = dir
            }
    
        #else
            var size : size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            //machineSwiftString = String(cString: machine)!
    
        #endif
        return machineSwiftString
}

//Check what iPhone
public func WhichiPhone() -> CGFloat{
    print(getModelName())
    
    //iphone 8
    if getModelName() == "iPhone10,1" || getModelName() == "iPhone10,4" || getModelName() == "iPhone8,4" || getModelName() == "iPhone12,8" || getModelName() == "iPhone14,6"{
        print(getModelName())
        return 64
        
    }
    
    if getModelName() == "iPhone13,1" || getModelName() == "iPhone14,4"{
        return 64
        
    }
    
    //other bigger iPhones
    return 70
    
}



class Stack {
    
    var selfvalue: [String] = []
    var peek: String {
        get {
            if selfvalue.count != 0 {
                return selfvalue[selfvalue.count-1]
            } else {
                return ""
            }
        }
    }
    var empty: Bool {
        get {
            return selfvalue.count == 0
        }
    }
    
    func push(value: String) {
        selfvalue.append(value)
    }
    
    func pop() -> String {
        var temp = String()
        if selfvalue.count != 0 {
            temp = selfvalue[selfvalue.count-1]
            selfvalue.remove(at: selfvalue.count-1)
        } else if selfvalue.count == 0 {
            temp = ""
        }
        return temp
    }
    
}


extension String {
    
    var precedence: Int {
        get {
            switch self {
                case "+":
                    return 2
                
                case "-":
                    return 2
                
                case "*":
                    return 1
                
                case "/":
                    return 1
                
                case "%":
                    return 1
                
                case "^":
                    return 0
                
                default:
                    return 100
                
            }
        }
    }
    
    public var isOperator: Bool {
        get {
            return ("+-*/^%" as NSString).contains(self)
        }
    }
    
    public var isNumber: Bool {
        get {
            return !isOperator && self != "(" && self != ")"
        }
    }
    
}

public class Conversion {
    var expression: String = ""
    var components = [String]()
    var pos = 0
    
    
    public init(expressions: String) {
        self.expression = expressions
        self.components = expression.components(separatedBy: " ")
    }
     
    
    //infix to postfix
    public func inToPost() -> [String] {
        if expression == ""{
            return [""]
            
        }
        
        let operator_stack = Stack()
        var output = [String]()
        var pos = 0
        var element:String
        
        while pos <= components.count - 1{
            element = String(components[components.index(components.startIndex, offsetBy: pos)])
            pos += 1
            
            if element.isOperator{
                if operator_stack.peek.precedence > element.precedence{
                    operator_stack.push(value: element)
                    
                }
                
                else{
                    output.append(operator_stack.pop())
                    operator_stack.push(value: element)
                    
                }
                
            }
            
            else if element.isNumber{
                output.append(element)
                
            }
            
           if element == "("{
                operator_stack.push(value: element)
               
               //if there is a open bracket then iterate through the expression till you find a closing bracket
                while element != ")"{
                    element = String(components[components.index(components.startIndex, offsetBy: pos)])
                    
                    if element.isOperator{
                        if operator_stack.peek.precedence > element.precedence{
                            operator_stack.push(value: element)
                            
                        }
                        
                        else{
                            output.append(operator_stack.pop())
                            operator_stack.push(value: element)
                            
                        }
                        
                    }
                    
                    if element.isNumber{
                        output.append(element)
                        
                    }
                    pos += 1
                }
                    var temp = operator_stack.pop()
                    
                    while temp != "("{
                        if temp != "("{
                            output.append(temp)
                            temp = operator_stack.pop()
                            
                    }
                        
                }
            

          }
        }
        
        while operator_stack.empty != true{
            output.append(operator_stack.pop())
            
        }
        
        return output
         
    }
    
    public func postEvaluate(postExpression: [String]) -> String {
        let Calculations = Stack()
        var answer: String = ""
        var num1: String
        var num2: String
        
        if postExpression == [""]{
            return ""
            
        }
        
        if postExpression.count == 1 && postExpression[0].isNumber{
            return postExpression[0]
            
        }
        
        //Read from input array --for loop
    
        //if number -> push to Calculations stack
        //if operator -> pop twice from Calculations stack
        
        //do computation - push to the stack
        
        for i in 0...postExpression.count - 1{
            if postExpression[i].isNumber{
                Calculations.push(value: postExpression[i])
                
            }
            
            else if postExpression[i].isOperator{
                num1 = Calculations.pop()
                num2 = Calculations.pop()
                
                answer = String(describing: compute(num1: num1, num2: num2, operators: postExpression[i]))
                
                Calculations.push(value: answer)
                
            }
            
        }
        
        
        let scale: Int16 = 3
        let behavior = NSDecimalNumberHandler(roundingMode: .plain, scale: scale, raiseOnExactness: true, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        if answer.contains("inf") == false && answer.contains("e") == false{
            answer = String(describing: NSDecimalNumber(decimal: Decimal(string: answer)!).rounding(accordingToBehavior: behavior))
            
        }
        
        return answer
    }
    
    func compute(num1: String, num2: String, operators: String) -> Double{
        var answer: Double = 0
        
        if  operators == "+"{
            answer = Double(exactly: Double(num1)! + Double(num2)!)!
            
        }
    
        if  operators == "-"{
            answer = Double(exactly: Double(num2)! - Double(num1)!)!
            
        }
        
        if operators == "*"{
            answer = Double(exactly: Double(num1)! * Double(num2)!)!
            
        }
        
        if operators == "/"{
            answer = Double(exactly: Double(num2)! / Double(num1)!)!
            
        }
        
        if operators == "^"{
            answer = Double(pow(Double(num2)!, Double(num1)!))
            
        }
        
        if operators == "%"{
            answer = Double(Double(num2)!.truncatingRemainder(dividingBy: Double(num1)!))
            
        }
        
        
        return answer
        
    }
}


public func AllOperators(expression: String) -> Bool{
    for i in 0...expression.count - 1{
        if expression[expression.index(expression.startIndex, offsetBy: i)].description.isOperator == false{
            return false
            
        }
            
        
    }
    
    return true
}


func checkParentheses(expression: String) -> Bool {
    var index = expression.index(expression.startIndex, offsetBy: 0)
    
    //Check if the expression is only parentheses
    for element in 0...expression.count - 1{
        index = expression.index(expression.startIndex, offsetBy: element)
        
        if expression[index] != "(" || expression[index] != ")"{
            break
            
        }
        
        if element == expression.count - 1{
            return false
            
        }
        
    }
    
    if expression.contains("(") == false && expression.contains(")") == false{
        return true
        
    }
    
    var parenthesis_expression = ""
    
    for i in 0...expression.count - 1{
        if expression[expression.index(expression.startIndex, offsetBy: i)] == "(" ||  expression[expression.index(expression.startIndex, offsetBy: i)] == ")"{
            parenthesis_expression.append(expression[expression.index(expression.startIndex, offsetBy: i)])
            
        }
        
    }
    
    
    let pairs: [Character: Character] = ["(": ")"]
    var stack: [Character] = []
    
    for char in parenthesis_expression {
        if let match = pairs[char] {
            stack.append(match)
        } else if stack.last == char {
            stack.popLast()
        } else {
            return false
        }
    }

    return stack.isEmpty
    
}

/*
func CheckOperatorParenthesis(expression: String) -> Bool{
    for i in 0...expression.count - 1{
        var index = expression.index(expression.startIndex, offsetBy: i)
        
        if expression[index].description.isOperator{
            if i > 0 {
                if expression[expression.index(expression.startIndex, offsetBy: i - 1)].isNumber == false{
                    return false
                    
                }
                
            }
            
        }
        
    }
    
    return true
    
}
 */

func CheckParenthesisEmpty(expression: String) -> String{
    var EditedExpression = ""
    var i = 0
    
    
    //go through expression
    //if there is a opening and closed parenthesis next to eachother then don't append it
    while i < expression.count - 1{
        var index = expression.index(expression.startIndex, offsetBy: i)
        
        
        
    }
    
    
    return EditedExpression
}

func decimal_check(expression: String) -> Bool{
    //var numbers: [String] = []
    
    //check for consecutive decimals
    for element in 0...expression.count - 2{
        let index = expression.index(expression.startIndex, offsetBy: element)
        let next_index = expression.index(expression.startIndex, offsetBy: element + 1)
        
        if expression[index] == "." && expression[next_index] == "."{
            return false
            
        }
        
    }
    
    
    //check if there is more than one decimal after a operator
    for i in 0...expression.count - 1{
        let element = expression[expression.index(expression.startIndex, offsetBy: i)]
        var decimal_count = 0
        
        if element.description.isOperator{
            var operator_index = expression.count - 1
            
            for z in i+1...expression.count - 1{
                if expression[expression.index(expression.startIndex, offsetBy: z)].description.isOperator{
                    operator_index = z
                    
                }
                
            }
            
            for j in i...operator_index{
                if expression[expression.index(expression.startIndex, offsetBy: j)] == "."{
                    decimal_count += 1
                    
                }
                
            }
            
            if decimal_count >= 2{
                return false
                
            }
            
            
            decimal_count = 0
            print(decimal_count)
            
        }
        
    }
    
    //check if there is a decimal right after a operator
    for y in 0...expression.count - 1{
        if expression[expression.index(expression.startIndex, offsetBy: y)].description.isOperator{
            if y == expression.count - 1{
                return false
                
            }
            
            else if expression[expression.index(expression.startIndex, offsetBy: y + 1)] == "."{
                return false
                
            }
            
        }
        
    }
    
    //check if there is atleast one number after the decimal point
    for a in 0...expression.count - 1{
        if expression[expression.index(expression.startIndex, offsetBy: a)] == "."{
            if a == expression.count - 1{
                return false
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: a + 1)].isNumber == false{
                return false
                
            }
            
        }
        
    }
    
    
    
    return true
}

public func expression_validity(expression: String) -> Bool{
    var operator_count = 0
    
    //print("here:", CheckParenthesisEmpty(expression: expression))
    
    if checkParentheses(expression: expression) == false{
        print("1234")
        return false
        
    }
    
    /*
    if CheckOperatorParenthesis(expression: expression) == false{
        print("5678")
        return false
        
    }
     */
    
    
    if expression[expression.startIndex].description.isOperator && expression[expression.startIndex] != "-"{
        print("910")
        return false
        
    }
    
    if expression.suffix(1).description.isOperator{
        print("911")
        return false
        
    }
    
    //check if there are more than two operators that are consecutive
    for i in 0...expression.count - 1{
        if i < expression.count - 1{
            if expression[expression.index(expression.startIndex, offsetBy: i)].description.isNumber && expression[expression.index(expression.startIndex, offsetBy: i + 1)] == "("{
                print(912)
                return false
            
        }
            
            
        }
        
        if expression[expression.index(expression.startIndex, offsetBy: i)].description.isOperator && expression[expression.index(expression.startIndex, offsetBy: i + 1)].description.isOperator && expression[expression.index(expression.startIndex, offsetBy: i + 1)] != "-"{
            print(913)
            return false
            
        }
        
        if expression[expression.index(expression.startIndex, offsetBy: i)].description.isOperator{
            
            for j in i...expression.count - 1{
                if expression[expression.index(expression.startIndex, offsetBy: j)].description.isOperator{
                    operator_count += 1
                    
                }
                
                if operator_count > 2{
                    print(914)
                    return false
                    
                }
                
                operator_count = 0
                
            }
            
        }
        
    }
    
    //Check if decimal is correct
    if expression.contains("."){
        if decimal_check(expression: expression) == false{
            print(920)
            return false
            
        }
        
    }
    
    
    return true
}

public func ParenthesisMultiply(Expression: String) -> String{
    print("from here!: ", Expression)
    var EditedExpression = ""
    
    //set to 0 for count
    for element in 0...Expression.count - 1{
        let index = Expression.index(Expression.startIndex, offsetBy: element)
        var PreviousElement = Expression.index(Expression.startIndex, offsetBy: element)
        var NextElement = Expression.index(Expression.startIndex, offsetBy: element)
        
        if element >= 1{
            PreviousElement = Expression.index(Expression.startIndex, offsetBy: element - 1)
            
        }
        
        
        
        //Check if element is not a opening parenthesis
        
        if Expression[index] != "("{
            print(Expression[index])
            EditedExpression.append(Expression[index])
            
        }
        
        else if element == 0 && Expression[Expression.index(Expression.startIndex, offsetBy: element)] == "("{
            print(Expression[index])
            EditedExpression.append(Expression[index])
            
        }
        
        else {
            print(2)
            if element > 0{
                if Expression[PreviousElement].description.isNumber{
                    EditedExpression.append("*")
                    EditedExpression.append("(")
                    
                }
                
                else if Expression[Expression.index(Expression.startIndex, offsetBy: element - 1)] == ")" && Expression[index] == "("{
                    print("here")
                    EditedExpression.append("*")
                    EditedExpression.append("(")
                    
                }
                
                else if Expression[PreviousElement] == "*"{
                    EditedExpression.append("1")
                    EditedExpression.append("*")
                    EditedExpression.append("(")
                    
                }
                
                else if Expression[PreviousElement] == "-"{
                    EditedExpression.append("1")
                    EditedExpression.append("*")
                    EditedExpression.append("(")
                    
                }
                
                //for - (number) and (
                else if element + 1 < Expression.count - 1{
                    var NextElement = Expression.index(Expression.startIndex, offsetBy: element + 1)
                    
                    if Expression[PreviousElement] == "-" && Expression[index].isNumber && Expression[NextElement] == "("{
                        EditedExpression.append(Expression[PreviousElement])
                        EditedExpression.append(Expression[index])
                        EditedExpression.append(" ")
                        EditedExpression.append(Expression[NextElement])
                        
                    }
                    
                //for - and (
                    
            }
                
                 
                
            else {
                print(3)
                EditedExpression.append("(")
                
            }
                
        }
            
    }
        
        
    }
    
    print("yep yep: ", EditedExpression)
    return EditedExpression
}

public func SimplifyMinus(expression: String) -> String{
    var EditedExpression = ""
    var EditedExpression2 = ""
    var index = expression.index(expression.startIndex, offsetBy: 0)
    var next = expression.index(expression.startIndex, offsetBy: 0)
    var MinusCounter = 0
    var iterator = 0
    
    
    while iterator < expression.count{
        index = expression.index(expression.startIndex, offsetBy: iterator)
        
        if expression[index] == "-"{
            for j in iterator...expression.count - 1{
                if iterator < expression.count - 1{
                    next = expression.index(expression.startIndex, offsetBy: j)
                    
                    if expression[next] == "-"{
                        MinusCounter += 1
                        if j > iterator{
                            iterator += 1
                            
                        }
                        
                    }
                    
                    else {
                        break
                        
                    }
                    
                }
                
            }
            
            
            if MinusCounter % 2 == 0{
                if EditedExpression.last != "^" && EditedExpression.last != "%" && EditedExpression.last != "/" && EditedExpression.last != "*"{
                    EditedExpression.append("+")
                    
                }
                
                MinusCounter = 0
                
            }
            
            else {
                EditedExpression.append("-")
                MinusCounter = 0
                
            }
            
        }
        
        else {
            EditedExpression.append(expression[index])
            
        }
        
        iterator += 1
        
        
    }
    
    print("edited", EditedExpression)
    
    for z in 0...EditedExpression.count - 1{
        index = EditedExpression.index(EditedExpression.startIndex, offsetBy: z)
        
        
        if EditedExpression[index] == "+"{
            if z < EditedExpression.count - 1 {
                if EditedExpression[EditedExpression.index(EditedExpression.startIndex, offsetBy: z + 1)] == "-"{
                    EditedExpression2.append("+")
                    
                }
                
                else if EditedExpression[EditedExpression.index(EditedExpression.startIndex, offsetBy: z + 1)].isNumber{
                    EditedExpression2.append("+")
                    
                }
                
            }
            
        }
        
        else {
            EditedExpression2.append(EditedExpression[index])
            
        }
        
        
        
    }
     
    
    print(EditedExpression)
    print("Final", EditedExpression2)
    return EditedExpression2
}


public func add_spaces(expression: String) -> String{
    var answer = ""
    var dont_append_number = -1
    var first_negative = false
    var division_minus = false
    var parenthesis_minus_append = false
    var times_minus = false
    var operator_minus = false
    var exponent_minus = false
    var modulo_minus = false
    var times_parentheses = false
    
    for index in 0...expression.count - 1{
        //check if the character is a operator
        if "+-*/^%".contains(expression[expression.index(expression.startIndex, offsetBy: index)]){
            //if the character is a minus and then next character is a number and the index is 0  then you have to append it as a negative number
            if index == 0 && expression[expression.index(expression.startIndex, offsetBy: index)] == "-" &&
                expression[expression.index(expression.startIndex, offsetBy: index + 1)].isNumber {
                dont_append_number = index + 1
                
                first_negative = true
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "-" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "("{
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "-" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                dont_append_number = index + 2
                
            }
            
            /*
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "*" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "("{
                times_parentheses = true
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                answer.append(" ")
                dont_append_number = index + 1
                
            }
             */
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "+" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                operator_minus = true
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                dont_append_number = index + 2
                
            }
             
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "^" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                exponent_minus = true
                
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "/" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                division_minus = true
                
            }
            
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "*" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                if times_parentheses == false{
                    answer.append(" ")
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                    answer.append(" ")
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                    times_minus = true
                    
                }
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "%" && expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                if modulo_minus == false{
                    answer.append(" ")
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                    answer.append(" ")
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 2)])
                    modulo_minus = true
                    
                }
                
            }
            
            if index > 0{
                if expression[expression.index(expression.startIndex, offsetBy: index - 1)] != "(" && expression[expression.index(expression.startIndex, offsetBy: index)] != "-"{
                    if times_minus == false{
                        if operator_minus == false{
                            if exponent_minus == false{
                                if division_minus == false{
                                    if times_parentheses == false{
                                        answer.append(" ")
                                        answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                                        answer.append(" ")
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }

                
                }
                
            }
            
            if expression[expression.index(expression.startIndex, offsetBy: index)] == "-"{
                if parenthesis_minus_append == false{
                    if first_negative == false{
                        if operator_minus == false{
                            if times_minus == false{
                                if exponent_minus == false{
                                    if division_minus == false{
                                        if modulo_minus == false{
                                            if ["(", ")"].contains(expression[expression.index(expression.startIndex, offsetBy: index + 1)]) == false{
                                                answer.append(" ")
                                                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                                                answer.append(" ")
                                                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                                                dont_append_number = index + 1
                                            
                                        }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                operator_minus = false
                parenthesis_minus_append = false
                times_parentheses = false
                modulo_minus = false
                
            }
            
            /*
            else {
                if operator_minus == false{
                    answer.append(" ")
                    print("The problem: ", expression[expression.index(expression.startIndex, offsetBy: index)])
                    answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                    answer.append(" ")
                    
                }
                
            
            }
             */
            
            
        }
        
        if expression[expression.index(expression.startIndex, offsetBy: index)] == "."{
            answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
            
        }
        
        //if the character is a bracket than add the appropriate spacing to the string
        if "(" == expression[expression.index(expression.startIndex, offsetBy: index)]{
            
            if expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "-"{
                parenthesis_minus_append = true
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                
            }
            
            
            else if expression[expression.index(expression.startIndex, offsetBy: index + 1)] == "*"{
                parenthesis_minus_append = true
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index + 1)])
                
            }
             
            
            
            else{
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(" ")
                
            }

            
        }
        
        if ")" == expression[expression.index(expression.startIndex, offsetBy: index)]{
            answer.append(" ")
            answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
            
        }
        
        if expression[expression.index(expression.startIndex, offsetBy: index)].isNumber{
            if first_negative == false{
                if index != dont_append_number{
                    if operator_minus == false{
                        if times_minus == false{
                            if exponent_minus == false{
                                if division_minus == false{
                                    if modulo_minus == false{
                                        answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            first_negative = false
            operator_minus = false
            times_minus = false
            modulo_minus = false
            
            /*
            if first_negative == false{
                print("number: ", expression[expression.index(expression.startIndex, offsetBy: index)])
                answer.append(expression[expression.index(expression.startIndex, offsetBy: index)])
                
            }
             */
            
        }
        
        
    }
        
    return answer
}
