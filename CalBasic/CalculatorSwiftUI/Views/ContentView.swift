//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Dhanush Arun on 7/29/21.
//
import SwiftUI
import ExpressionParser

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

struct ContentView: View {
    //expresion
    @State var expression = "0"
    @State var mathValue:Decimal = 0
    @State var DisplayExpression = "0"
    
    //error
    @State var division_error = false
    @State var InvalidExpression: Bool = false
    
    //for huge answers
    @State var ExponentAnswer = false
    @State var Infinity = false
    @State var ExponentAnswerString = ""
    
    //future version
    @State var ExpressionHistory = [String: String]()
    
    
    //Size and spacing for UI elements
    @State var ButtonTextSize:CGFloat = 30
    
    @State var ExpressionTextSize:CGFloat = 30
    
    @State var MinScaleFactor = 0.01
    
    @State var Spacing:CGFloat = 20
    
    @State var ButtonSize:CGFloat = ExpressionParser.WhichiPhone()
    
        
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: Spacing) {
                Spacer()
                
                HStack {
                    Text(DisplayExpression)
                        .minimumScaleFactor(CGFloat(MinScaleFactor))
                        .lineLimit(1)
                        .font(.system(size: ExpressionTextSize))
                        .foregroundColor(.white)
                    
                    
                }
                
                
                if division_error{
                    Text("Division by zero error")
                        .font(.system(size: ExpressionTextSize))
                        .foregroundColor(.red)
                    
                
                }
                
                else{
                    
                    if InvalidExpression{
                        Text("\(String(describing: "Invalid expression"))")
                            .font(.system(size: ExpressionTextSize))
                            .foregroundColor(.red)
                        
                    }
                    
                    else if ExponentAnswer{
                        Text(ExponentAnswerString)
                            .font(.system(size: ExpressionTextSize))
                            .foregroundColor(.blue)
                            
                    }
                    
                    else if Infinity{
                        Text("Infinity")
                            .font(.system(size: CGFloat(ExpressionTextSize)))
                            .foregroundColor(.red)
                            
                    }
                    
                    else{   
                            Text("= \(String(describing: mathValue))")
                                .font(.system(size: ExpressionTextSize))
                                .foregroundColor(.white)
                                .minimumScaleFactor(CGFloat(MinScaleFactor))
                        
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        
                        if expression == "0" || expression == ""{
                            expression = "0"
                            DisplayExpression = expression
                            
                        }
                        
                        else if expression.count == 1{
                            expression = "0"
                            DisplayExpression = expression
                            
                        }
                        
                        else{
                            expression.remove(at: expression.index(before: expression.endIndex))
                            DisplayExpression = expression
                            DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                            DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                            
                        }
                        
                        print(ExpressionParser.WhichiPhone())
                        
                        mathValue = 0
                        division_error = false
                        InvalidExpression = false
                        ExponentAnswer = false
                        Infinity = false
                        
                        print(ButtonSize)
                        
                        }) {
                        Text("C")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.red)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        expression = "0"
                        DisplayExpression = expression
                        mathValue = 0
                        division_error = false
                        InvalidExpression = false
                        ExponentAnswer = false
                        Infinity = false
                        
                        }) {
                        Text("AC")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.red)
                            .cornerRadius(8)
                            
                            
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
            
                
                
                HStack(spacing: 8) {
                    
                    
                    Button(action: {
                        
                        if expression == "0"{
                            expression = ""
                            DisplayExpression = expression
                            
                        }
                        
                        expression.append("%")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        
                        
                    }) {
                    Text("%")
                        .bold()
                        .font(.system(size: ButtonTextSize))
                        .frame(width: ButtonSize, height: ButtonSize)
                        .foregroundColor(Color.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                        
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if expression == "0"{
                            expression = ""
                            DisplayExpression = expression
                            
                        }
                        
                        
                        expression.append("(")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                    }) {
                    Text("(")
                        .bold()
                        .font(.system(size: ButtonTextSize))
                        .frame(width: ButtonSize, height: ButtonSize)
                        .foregroundColor(Color.black)
                        .background(Color.orange)
                        .background(Color.orange)
                        .cornerRadius(8)
                        
                    }
                    .buttonBorderShape(.capsule)
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            DisplayExpression = expression
                            
                        }
                        
                        expression.append(")")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                    }) {
                    Text(")")
                        .bold()
                        .font(.system(size: ButtonTextSize))
                        .frame(width: ButtonSize, height: ButtonSize)
                        .foregroundColor(Color.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                        
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        
                        if expression == "0"{
                            expression = ""
                            DisplayExpression = expression
                            
                        }
                        
                        expression.append("^")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                    }) {
                    Text("^")
                        .bold()
                        .font(.system(size: ButtonTextSize))
                        .frame(width: ButtonSize, height: ButtonSize)
                        .foregroundColor(Color.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                        
                    }
                    
                    
                }
                
                
                HStack {
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            DisplayExpression = expression
                            
                        }
                        
                        expression.append("1")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("1")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("2")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("2")
                                .bold()
                                .font(.system(size: ButtonTextSize))
                                .frame(width: ButtonSize, height: ButtonSize)
                                .foregroundColor(Color.black)
                                .background(Color.gray)
                                .cornerRadius(8)
                                
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("3")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("3")
                                .bold()
                                .font(.system(size: ButtonTextSize))
                                .frame(width: ButtonSize, height: ButtonSize)
                                .foregroundColor(Color.black)
                                .background(Color.gray)
                                .cornerRadius(8)
                                
    
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("+")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("+")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.orange)
                            .cornerRadius(8)
                           
                    }
                    
                }
                
                HStack {
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("4")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("4")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                           
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        
                        expression.append("5")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("5")
                                .bold()
                                .font(.system(size: ButtonTextSize))
                                .frame(width: ButtonSize, height: ButtonSize)
                                .foregroundColor(Color.black)
                                .background(Color.gray)
                                .cornerRadius(8)
                                
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("6")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("6")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("-")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("-")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.orange)
                            .cornerRadius(8)
                            
                    }
                    
                }
                
                HStack {
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("7")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("7")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("8")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("8")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("9")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("9")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("*")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        
                        }) {
                        Text("x")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.orange)
                            .cornerRadius(8)
                            
                    }
                    
                }
                
                HStack {
                    
                    Button(action: {
                        
                        if expression != "0"{
                            expression.append("0")
                            
                        }
                        
                        
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("0")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding(.horizontal, 1)
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if expression[expression.index(expression.startIndex, offsetBy: expression.count - 1)].isNumber == false{
                            expression.append("0")
                            
                        }
                        
                        expression.append(".")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        
                        if expression.count == 1{
                            expression.removeAll()
                            expression.append("0")
                            expression.append(".")
                            
                        }
                        
                        else if expression.count >= 2{
                            //get current and previous index
                            let CurrentIndex = expression.index(expression.startIndex, offsetBy: expression.count - 1)
                            let PreviousIndex = expression.index(expression.startIndex, offsetBy: expression.count - 2)
                            
                            
                            // if the previous index is a operator then append a zero and decimal
                            if expression[PreviousIndex].description.isOperator{
                                expression.remove(at: CurrentIndex)
                                
                                expression.append("0")
                                expression.append(".")
                                
                            }
                            
                            
                        }
                        
                        }) {
                        Text(".")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        //check if divided by zero is in the equation
                        if expression.contains("/0"){
                            self.division_error = true
                            ExpressionHistory[DisplayExpression] = "Error"
                            
                        }
                        
                        else if ExpressionParser.AllOperators(expression: expression){
                            InvalidExpression = true
                            
                        }
                        
                        else{
                            if expression.count > 0 {
                                if expression.contains("-"){
                                    expression = ExpressionParser.SimplifyMinus(expression: expression)
                                    DisplayExpression = expression
                                    DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                                    DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                                    
                                }
                                
                                if expression.contains("(") && expression.contains(")"){
                                    if expression.count - 1 > 0{
                                        var index = expression.index(expression.startIndex, offsetBy: 0)
                                        
                                        for i in 0...expression.count - 1{
                                            index = expression.index(expression.startIndex, offsetBy: i)
                                            
                                            if i > 0{
                                                let previous_index = expression.index(expression.startIndex, offsetBy: i - 1)
                                                
                                                if expression[index] == "("{
                                                    if expression[previous_index].description.isNumber == true || expression[previous_index] == "-" || expression[previous_index] == ")"{
                                                        expression = ExpressionParser.ParenthesisMultiply(Expression: expression)
                                                        break
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            //Check if expression is valid or not
                            if expression[expression.startIndex] == "+"{
                                expression.remove(at: expression.startIndex)
                                
                            }
                            
                            if expression == "0."{
                                expression = "0"
                                
                            }
                            
                            else if expression.contains("."){
                                
                                
                            }
                            
                            print("expression before checking: ", expression)
                            let expression_check: Bool = ExpressionParser.expression_validity(expression: expression)
                            print("is expression correct?: ", expression_check)
                            
                            
                            if expression_check{
                                print("expression before adding spaces: ", expression)
                                let expression_space: String = ExpressionParser.add_spaces(expression: expression)
                                print("with spaces", expression_space)
                                let expression_initialize = ExpressionParser.Conversion(expressions: expression_space)
                                let inToPost:[String] = expression_initialize.inToPost()
                                print(inToPost)
                                
                                if expression_initialize.postEvaluate(postExpression: inToPost).contains("e"){
                                    ExponentAnswer = true
                                    ExponentAnswerString = expression_initialize.postEvaluate(postExpression: inToPost)
                                    
                                }
                                
                                else if expression_initialize.postEvaluate(postExpression: inToPost).contains("inf"){
                                    Infinity = true
                                    
                                }
                                
                                else {
                                    let answer = Decimal(string: expression_initialize.postEvaluate(postExpression: inToPost))!
                                    print(expression_initialize.postEvaluate(postExpression: inToPost))
                                    mathValue = answer
                                    
                                    
                                    //for future versions add commas
                                    /*
                                    var example = "\(mathValue)"
                                    example = Int(example)!.withCommas()
                                    print(example)
                                    */
                                    
                                }
                                
                                
                                
                                //Make ExpressionHistory for future versions
                                ExpressionHistory[DisplayExpression] = "\(mathValue)"
                                
                                
                            }
                            
                            else{
                                print("Error")
                                InvalidExpression = true
                                ExpressionHistory[DisplayExpression] = "Error"
                                
                            }
                            
                        }
                        
                        
                    }) {
                        Text("=")
                            .bold()
                            .font(.system(size: ButtonTextSize))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.blue)
                            .cornerRadius(8)
                        
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        if expression == "0"{
                            expression = ""
                            
                        }
                        
                        expression.append("/")
                        DisplayExpression = expression
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "*", with: "x")
                        DisplayExpression = DisplayExpression.replacingOccurrences(of: "/", with: "÷")
                        
                        }) {
                        Text("÷")
                            .bold()
                            .font(.system(size: 33))
                            .frame(width: ButtonSize, height: ButtonSize)
                            .foregroundColor(Color.black)
                            .background(Color.orange)
                            .cornerRadius(8)
                            
                    }
                    
                }
            
            }
        
        
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
