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

Crear dos archivos a parte del main.dart:
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
<img width="213" height="338" alt="image" src="https://github.com/user-attachments/assets/a172e04a-7663-4cb0-bec5-7bcfa3e4da66" />



# Diseño de la aplicación 

Prueba en el navegador
<img width="1572" height="649" alt="image" src="https://github.com/user-attachments/assets/3734b60e-9003-41a1-b362-6a5c2025100d" />

<img width="1454" height="567" alt="image" src="https://github.com/user-attachments/assets/18b92fd3-0c6b-4161-b15a-358267d5dc8a" />

Prueba en el emulador android

<img width="324" height="743" alt="image" src="https://github.com/user-attachments/assets/accc7d1a-57a7-4b79-ad29-a43d0b580aa0" />
<img width="320" height="707" alt="image" src="https://github.com/user-attachments/assets/98e010e5-edd0-416f-8706-7d75e375c9de" />
<img width="313" height="687" alt="image" src="https://github.com/user-attachments/assets/dc0d340e-9ed6-4d20-b106-94aa3dbd21f9" />
<img width="323" height="671" alt="image" src="https://github.com/user-attachments/assets/e1c12432-5a05-4f2c-846d-ee9e4b171b13" />








