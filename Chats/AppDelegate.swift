//
//  AppDelegate.swift
//  Chats
//
//  Created by Escuela dete = UserNotificationDelegate() Tecnologias Aplicadas on 13/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userNotificationDelegate: UserNotificationDelegate?

    // Esta es la primera función que se ejecuta en la aplicación
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Aplicamos el delegado de las notificaciones
        userNotificationDelegate = UserNotificationDelegate(window: window)
        UNUserNotificationCenter.current().delegate = userNotificationDelegate

        // Vemos si estamos logueados (con la sesión abierta)
        // código...

        // Si la sesión no está abierta (no hay un login realizado) nos conectamos a la Api nos traemos nuestro usuario.
        // Podemos saber cual es nuestro usuario mediante el email y la contraseña
        // Al traérnoslo actualizamos nuestro userFrontId
        // código...

        // Pedimos que nos den el token. Comprobamos que el token descargado es el mismo que el de nuestro usuario.
        // si no lo es lo actualizamos en local y en la Api. Se encarga didRegisterForRemoteNotificationsWithDeviceToken

        userNotificationDelegate?.registerForPushNotifications()

        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Se llama cuando se está creando una nueva sesión de escena.
        // Utiliza este método para seleccionar una configuración con la que crear la nueva escena.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Se llama cuando el usuario descarta una sesión de escena.
        // Si alguna sesión fue descartada mientras la aplicación no estaba corriendo, esto será llamado poco después de application:didFinishLaunchingWithOptions.
        // Usa este método para liberar cualquier recurso que fuera específico de las escenas descartadas, ya que no volverán.
    }

    // Esta función se ejecuta cuando el APNS responde a la petición de registro del dispositivo.
    // didRegisterForRemoteNotificationsWithDeviceToken: Significa "se ha registrado el dispositivo para recibir notificaciones con el token del dispositivo"
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // El APNS nos devuelve un token que es un identificador único para el dispositivo.
        // Este token es un array de bytes, lo convertimos a un string.
        let tokenParts = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined() // Que las junte pero sin separador
        print("Token de notificación: \(token)")

        UserDefault.token = token
        UserDefault.userFrontId =  UserDefault.users.firstIndex(where: { $0.tokenID == token }) ?? 0

        // Ahora este token habría que hacer algo con el, como enviarlo a la Api para registrar el dispositivo en la base de datos.

        // let validateToken = ValidateToken()
        // validateToken.validateToken(idToken: token)

    }

    // Si se produce un error al tratar de registrar el dispositivo para recibir notificaciones, se ejecuta esta función.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error al registrar el dispositivo para recibir notificaciones: \(error)")
    }


    // Para poder mostrar una notificación cuando la app está abierta debemos poner esta función:
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        // Estamos recibiendo una notificación en segundo plano
        guard let aps = userInfo["aps"] as? [String: Any],
              let alert = aps["alert"] as? [String: Any],
              let body = alert["body"] as? String,
              let badge = aps["badge"] as? Int,
              let messageJson = userInfo["message"] as? [String: Any],
              let userFrontJson = userInfo["user"] as? [String: Any],
              let userBackJson = userInfo["userBack"] as? [String: Any],
              let chatJson = userInfo["chat"] as? [String: Any] else {
            return
        }

        UserDefault.badges += badge
        print("badge:", badge)
        print("UserDefault.badges:", UserDefault.badges)

        // Mapeamos a objetos
        let dataMapper = DataMapper()
        let user = dataMapper.mapUserDataToUser(user: userFrontJson)
        let userBack = dataMapper.mapUserDataToUser(user: userBackJson)
        let message = dataMapper.mapMessageDataToMessage(message: messageJson)
        let chat = dataMapper.mapChatDataToChat(chat: chatJson)

        // -------------- Insertar mensaje ---------
        print("body:", body)
        sceneDelegate.chatRouter.insertMessageNotification(chatId: chat.id, contentMessage: body, usuarioId: user.id)

        // Modificar el badge:
        // Si la notificación tiene un badge, lo ponemos en el icono de la app
        if let pushBadgeNumber = aps["badge"] as? Int {
            NotificationCenter.default.post(Notification(name: Notification.Name("badgeChange"), object: pushBadgeNumber))
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = UserDefault.badges // Siempre saldrá el número que le indiquemos. Si le ponemos pushBadgeNumber el efecto no se ve
            }
        }
        completionHandler(.newData) // Indicamos que se ha recibido una notificación
    }
}
