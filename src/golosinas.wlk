/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
class Golosina{
	var peso
	method peso() = peso
}

class Bombon inherits Golosina{
	method precio() { return 5 }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}


class Alfajor inherits Golosina{
	method precio() { return 12 }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo inherits Golosina{
	var property sabor
	method precio() { return 12 }
	method mordisco() { peso = peso - 1 }
	method sabor() { return sabor }
	method libreGluten() { return true }
}


class Chupetin inherits Golosina{
	method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea inherits Golosina{
	method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	
	method pesoInicial(unPeso) { peso = unPeso }
	method precio() { return peso * 0.50 }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina{
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	override method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}

class BombonDuro inherits Bombon{
		override method mordisco(){
			peso = 0.max(peso -1)
		}
		
		method dureza(){
			if (peso >12){
				return 3
			} else if (peso < 8){
				return 1
			} else {
				return 2
			}
		}
}

class CarameloRelleno inherits Caramelo{
	override method mordisco(){
		self.peso() - 1
		sabor = chocolate
	}
	override method precio(){
		return super() + 1   // super llama al mismo metodo
	}
}

class ObleasCrujientes inherits Oblea {
	
	var mordiscos = 0
	override method mordisco(){
		if (mordiscos <= 3){
			mordiscos += 1
			 super() + 3
		} else {
			 super()
		}
	}
}

class ChocolatinVIP inherits Chocolatin {
	
	method humedad() = heladeraDeMariano.humedad()
	override method peso()= super()*(1 + self.humedad())
}

class CholatinPremium inherits ChocolatinVIP {
	
	override method humedad() = super() / 2
}


object heladeraDeMariano {
	var property humedad = 0 
}












