class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def saludar(self):
        print("Hola, mi nombre es " + self.nombre + " y tengo " + str(self.edad) + " años.")

    def sumar_edad(self, años):
        self.edad += años
        print("Ahora tengo " + str(self.edad) + " años.")


persona1 = Persona("Juan", 30)
persona1.nombre = "Carlos"
persona1.saludar()

if persona1.nombre == "Carlos":
    print("El nombre ha sido cambiado a Carlos.")
    print("La edad actual es: " + str(persona1.edad) + " años.")
else:
    print("El nombre no ha sido cambiado.")

lista1 = [1, 2, 3, 4, "5"]

for x in lista1:
    if type(x) == str:
        print(x)