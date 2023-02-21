//
//  UserNotificationDelegate.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import Foundation
import UserNotifications
import UIKit

class UserNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {


    // Window
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    // Hemos realizado las funciones en AppDelegate porque es el primer archivo que se ejecuta en la aplicación.
    func registerForPushNotifications() {
        // Pedimos permiso para enviar notificaciones
        /*
         .badge: para mostrar el número de notificaciones no leídas
         .sound: para reproducir un sonido cuando llegue una notificación
         .alert: para mostrar una alerta con el contenido de la notificación
         .cardPlay: para que las notificaciones salgan en el cardPlay del coche
         .provisional: para publicar notificaciones sin interrupción del usuario. Las notificaciones no piden
         permiso pero llegan de forma silenciosa.
         .providesAppNotificationSettings: La app tiene su propia interfaz par la configuración de las notificaciones,
         para que el usuario pueda configurar las notificaciones de la app.
         .criticalAlert: para mostrar una notificación de emergencia en la pantalla de bloqueo.
         */
        UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
                    print("Permiso concedido: \(granted)")
                    guard granted else {
                        return
                    }
                    self?.getNotificationSettings()
                }
    }

    // Va a estar para cuando el usuario cambie la configuración de las notificaciones.
    private func getNotificationSettings() {
        // Comprobamos los ajustes de las notificaciones
        // Nos muestra toro lo que tenemos configurado en el dispositivo gracias a getNotificationSettings, que es una función de UNUserNotificationCenter.
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Ajustes de notificación: \(settings)")
            // Comprobamos si el usuario ha dado permiso, registramos el dispositivo para recibir notificaciones
            guard settings.authorizationStatus == .authorized else {
                return
            } // Si no está autorizado, no hacemos nada
            // Registramos el dispositivo para recibir notificaciones en segundo plano en el servidor de Apple (APNS)
            DispatchQueue.main.async {
                // El dispositivo le está pidiendo al APNS que lo registre. Cuando el APNS le responda, se ejecutará la función
                // application(_:didRegisterForRemoteNotificationsWithDeviceToken:). (más abajo)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    // Cuando el usuario interactúa con la notificación (no le ha funcionado a Alfonso)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        // Definir las acciones disponibles para la categoría de notificación
        let responderAction = UNTextInputNotificationAction(
                identifier: "reply",
                title: "Responder",
                options: [.authenticationRequired],
                textInputButtonTitle: "Enviar",
                textInputPlaceholder: "Escribe aquí tu respuesta"
        )

        let cancelarAction = UNNotificationAction(
                identifier: "cancel",
                title: "Cancelar",
                options: [.destructive]
        )

        // Definir la categoría de notificación
        let category = UNNotificationCategory(
                identifier: "NEW_MESSAGE",
                actions: [responderAction, cancelarAction],
                intentIdentifiers: [],
                options: [.customDismissAction]
        )


        // Entregar la notificación al centro de notificaciones
        UNUserNotificationCenter.current().setNotificationCategories([category])

        // Comprobamos si la notificación es de tipo respuesta
        switch response.actionIdentifier {
                // ----- Al pulsar en la notificación, se abre la conversación correspondiente -----
        case UNNotificationDefaultActionIdentifier:
            openChat(response: response)
        case "reply":
            // El usuario ha seleccionado el botón "Responder"
            if let textResponse = response as? UNTextInputNotificationResponse {
                // Obtener la respuesta del usuario
                let userResponse = textResponse.userText
                // Enviar la respuesta del usuario
                openChat(response: response, textResponse: textResponse.userText)
            }
        case "cancel":
            print("El usuario ha seleccionado el botón Cancelar")
            // El usuario ha seleccionado el botón "Cancelar"
            break
        default:
            break
        }

        completionHandler()
    }

    func openChat(response: UNNotificationResponse, textResponse: String? = nil) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        let userInfo = response.notification.request.content.userInfo
        // Estamos recibiendo una notificación en segundo plano
        guard let chatJson = userInfo["chat"] as? [String: Any] else {
            return
        }
        // Mapeamos
        let dataMapper = DataMapper()
        let chat = dataMapper.mapChatDataToChat(chat: chatJson)

        // Abrimos la vista de la conversación correspondiente
        sceneDelegate.tabBarController.selectedIndex = 1
        sceneDelegate.window?.rootViewController = sceneDelegate.tabBarController
        sceneDelegate.chatsNavController.popToRootViewController(animated: false)
        sceneDelegate.listOfChatsRouter.showChat(chatId: chat.id)

        if let textResponse = textResponse {
            // Enviar la respuesta del usuario
            sceneDelegate.listOfChatsRouter.sendReply(chatId: chat.id, message: textResponse)
        }
    }
}
