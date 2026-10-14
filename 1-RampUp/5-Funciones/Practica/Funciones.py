import math

def dias_semana(dia):
    match dia:
        case 1:
            return "Lunes"
        case 2:
            return "Martes"
        case 3:
            return "Miércoles"
        case 4:
            return "Jueves"
        case 5:
            return "Viernes"
        case 6:
            return "Sábado"
        case 7:
            return "Domingo"
        case _:
            return "No coincide con un número de la semana correcto"

def piramide_invertida(numero):
    texto = ""
    vueltas = numero + 1
    for i in range (1, (numero) +1):
        texto += "\n"
        vueltas -= 1
        for j in range(1, vueltas + 1):  
            texto += " " + (str(j))
    return texto

def comparar(num_1, num_2):
    if num_1 > num_2:
        return "El primer número es mayor al segundo"
    elif num_1 < num_2:
        return "El primer número es menor al segundo"
    else:
        return "Ambos números son iguales"


def contar_letras(texto, letra):
    contador = 0
    for i in texto:
        if i.lower() == letra.lower():
            contador += 1
    return contador


def pasar_diccionario(string):
    diccionario = {}
    for i, j in enumerate(string):
       diccionario[j] = i
    return diccionario


def anadir_eliminar(lista, comando, elemento):
    try:
        if not isinstance(lista, list) or comando.lower().strip() != "add" or comando.lower().strip != "remove":
            print("Algun argumento es incorrecto")
            if comando.lower().strip() == "add":
                lista.append(elemento)
            else:
                lista.remove(elemento)
        return lista
    except Exception:
        print("Parece que hay algún error")

def frase(palabras):
    texto = ""
    for palabra in palabras:
        texto += palabra + " "
    return texto

def Fibonacci(numero):
    
    if numero <= 1:
        return numero
    
    return Fibonacci(numero - 1) + Fibonacci(numero - 2)

def area_cuadrado(lado):
    return lado** 2

def area_triangulo(base, altura):
    return (base * altura) / 2

def area_circulo(radio):
    area = math.pi * (radio ** 2)
    return float(area)

