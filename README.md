# Consumo de API's con flutter


Esta apk consume dos APIS: 
- La API de ejemplo que muestra los pokemon con sus características.
- La segunda API consume una API de razas de gatos de la siguiente página https://api.thecatapi.com/v1/breeds que permite buscar un gato por su raza y muestra su foto y sus características.

- La app permite buscar razas de gatos y muestra:

Foto de cada raza

Nombre

Origen

Inteligencia (con barra)

Temperamento

Descripción

Esperanza de vida

## Pasos para la configuración

### Creación de la estructura del proyecto

Crear dos archivos:
1. cat_api.dart: Consumirá la API de gatos para mostrarlos por su raza.
2. pokemon_api.dart: Consumirá la API de pokemones y los mostrará. 
3. main.dart: Contiene un menú de opciones que permite al usuario elegir que API quiere consumir. Esta es la pantalla principal de la aplicación.
   <img width="190" height="76" alt="image" src="https://github.com/user-attachments/assets/c5dad0ea-e80b-434a-b8f9-c58f871b08f3" />

Para consumir la API de gatos se necesita una API Key pública que se genera con el siguiente enlace:
https://thecatapi.com/ 

#### Pasos del proyecto:

1.- Se creó un proyecto Flutter o una pantalla adicional.
2.- Se agregó el paquete http.
3.- Se consumió el endpoint de Cat API:
4.- Se procesó el JSON y se generó una lista de razas.
5.- Se agregó buscador local usando TextField.
6.-Se mostraron los resultados en un GridView.
7.-Se implementó una pantalla de detalle con imagen grande y características.
8.-Se probó en navegador y en emulador Android.
9.-Se generó la APK final con Flutter.
10.-Se subió todo el código al repositorio GitHub con screenshots.


# Diseño de la aplicación 

## Pantalla principal
![captura](img.jpg)


