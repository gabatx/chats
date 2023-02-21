## Chats
Conversaciones móviles optimizadas con arquitectura Viper y notificaciones push

Características:

* Implementación de arquitectura en Viper para garantizar una estructura sólida y escalable en la aplicación de chat móvil.
* Integración de un Mapper personalizado para adaptar consultas a modelos y mostrar la información en celdas de manera eficiente.
* Uso de clases externas para la TableView que brinda flexibilidad en el diseño y funcionalidad de la interfaz de usuario.
* Presentación de mensajes recibidos a la izquierda y enviados a la derecha para una experiencia de chat intuitiva.
* Persistencia de mensajes en el dispositivo mediante UserDefaults, asegurando que los mensajes se mantengan disponibles incluso si la aplicación se cierra.
* Listado de personas que permite tener múltiples conversaciones simultáneas.
* Diseño cuidadoso de la interfaz de usuario para mejorar la experiencia del usuario.
* Opción para borrar mensajes mediante una pulsación larga en la conversación.

Notificaciones:

* Configuración de notificaciones push para recibir mensajes y mantener al usuario informado en tiempo real.
* Recepción y presentación automática de mensajes en la conversación cuando se recibe una notificación.
* Acceso inmediato a la conversación correspondiente al tocar la notificación si la aplicación no está abierta en ese momento.
* Uso de código PHP en el servidor para preparar y entregar mensajes a destinatarios, asegurando una comunicación fluida y eficiente.
* Emisión de badges para notificar al usuario de la existencia de mensajes sin leer en la aplicación.
* Posibilidad de enviar y responder mensajes directamente desde las notificaciones, mejorando la funcionalidad y comodidad del usuario.
