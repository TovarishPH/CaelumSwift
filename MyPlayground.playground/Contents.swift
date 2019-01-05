//: Playground - noun: a place where people can play

//Interpolacao de String
let nome: String = "Juka Tarro"
let idade: Int = 61
print("Se \(nome) estivesse vivo, teria \(idade) anos.")

//Tupla - mutiplos valores em um unico elemento
let httpError400 = (400, "Not Found")

//uso por decomposicao
let (statusCode, statusMessage) = httpError400
print("Error code: \(statusCode)")
print("Error code: \(statusMessage)")

// por posicao
print("Error code: \(httpError400.0)")
print("Error code: \(httpError400.1)")

//Uso de Classe
class MyClass {
    func mostrarNoConsole(texto: String){
        print(texto)
    }
}

let myclass = MyClass()
myclass.mostrarNoConsole(texto: "Texto da Myclass")

//Optional
//Recurso da Swift para minimizar a ocorrencia de erros por valores nulos
let possivelNumero = "123"
//var numeroConvertido = Int(possivelNumero)

//var numeroCalculado = numeroConvertido + 10

//Recurso: Optional Bindind
if var numeroConvertido = Int(possivelNumero){
    //se a conversao der certo, aplica a soma
    numeroConvertido += 10
} else {
    print("O numero nao e valido")
}

//For with Arrays
var contatos:Array<String> = ["Batman", "Robin", "Alfred"]
contatos.append("Coringa")
contatos.remove(at: 2)

for contato in contatos{
    print(contato)
}