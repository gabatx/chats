<?php
echo "Servidor: conectado" . PHP_EOL;

// -----------------------------
// Recibimos los datos del POST
// -----------------------------

// Obtenemos los datos JSON del cuerpo de la solicitud
// file_get_contents: Lee un fichero completo en una cadena (string)
$json = file_get_contents('php://input'); // php://input es un stream que permite leer los datos de la solicitud

// Decodificamos los datos JSON en un objeto PHP
$data = json_decode($json);

// ---------------------
// Preparamos los datos
// ---------------------

// Accedemos a los objetos Message, User y Chat
$message = $data->message;
$user = $data->userFront;
$userBack = $data->userBack;
$chat = $data->chat;
$deviceToken = $userBack->tokenID;  // Token Device

//Parámetros de conexión con el servidor APNS
$pem_file   = 'fullcert.pem'; // Ruta del certificado .pem
$pem_secret = "estech2019"; // Contraseña del certificado .pem
$apns_topic = 'es.escuelaestech.Chats'; // Bundle ID


// ------------------------------------------------------------------------------------
// Procesamos los datos como sea necesario... (base de datos, conexión a la API, etc.)
// ------------------------------------------------------------------------------------
// En este caso simulamos la respuesta de la API que nos devuelve los datos del usuario que envía el mensaje, el que recibe, el mensaje y los datos del chat
// Crear un array con cada usuario, el que envía el mensaje y el que recibe para enviarlo mediante el payload a lal servidor APNS y que la aplicación Swift pueda procesarlo.

/**
 * @param $user
 * @return array
 */
function createUser($user): array
{
    return [
        'id'               => $user->id ?? 0,
        'tokenID'          => $user->tokenID ?? '',
        'username'         => $user->username ?? '',
        'name'             => $user->name ?? '',
        'surname'          => $user->surname ?? '',
        'password'         => $user->password ?? '',
        'email'            => $user->email ?? '',
        'registrationDate' => $user->registrationDate ?? 0,
        'lastLoginDate'    => $user->lastLoginDate ?? 0,
    ];
}
$userData = createUser($user);
$userBackData = createUser($userBack);

// Crear un array con los datos del mensaje
$messageData = [
    'id' => $message->id ?? 0,
    'conversationId' => $message->conversationId ?? 0,
    'senderUserId' => $message->senderUserId ?? 0,
    'messageContent' => $message->messageContent ?? '',
    'messageTimestamp' => $message->messageTimestamp ?? 0,
    'readStatus' => $message->readStatus ?? 0
];

// Creamos un array con los datos del chat
$chatData = [
    'id' => $chat->id ?? 0,
    'conversationName' => $chat->conversationName ?? '',
    'participantIds' => $chat->participantIds ?? [],
    'startDate' => $chat->startDate ?? 0,
];


// ----------------------
// Preparamos el payload
// ----------------------

// TOKEN PUSH :
echo 'SSOO iOS' . PHP_EOL;
// Creamos el payload
$payload = [
    'aps' => [
        'content-available' => 1, // Para que la aplicación se active en segundo plano
        'alert' => [
            'title' => $user->name . ' ' . $user->surname, // Título de la notificación
            'body' => $message->messageContent,
        ],
        'badge' => 1,
        'sound' => 'default',
        'category' => 'NEW_MESSAGE', // Identificador de la categoría. Debe coincidir con el identificador de la categoría que hemos creado en la aplicación Swift para que funcione. Este identificador se utiliza para identificar la acción que se debe realizar cuando el usuario toca la notificación. Se puede utilizar para abrir la aplicación, abrir una pantalla concreta, etc. Está definido en la aplicación Swift en el método userNotificationCenter(_:didReceive:withCompletionHandler:)
    ],
    'message' => $messageData,
    'user' => $userData,
    'userBack' => $userBackData,
    'chat' => $chatData
];
$payload = json_encode($payload);



// -----------------------------
// Lo enviamos al servidor APNS
// -----------------------------

//URL producción
//      $url = "https://api.push.apple.com/3/device/$deviceToken";
//URL testing
$url = "https://api.development.push.apple.com/3/device/$deviceToken";

// ABRIR CONEXIÓN CON EL SERVIDOR APNS :
$ch = curl_init($url); // Inicializar conexión
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); // No verificar certificado
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2); // No verificar host
curl_setopt($ch, CURLOPT_POSTFIELDS, $payload); // Enviar alerta
curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0); // Versión HTTP
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'apns-topic: ' . $apns_topic,
    'apns-priority: 10',
    'apns-push-type: alert',
    'Content-Type: application/json',
    'Content-Length: ' . strlen($payload)
)); // Headers
curl_setopt($ch, CURLOPT_SSLCERT, $pem_file); // Certificado
curl_setopt($ch, CURLOPT_SSLCERTPASSWD, $pem_secret); // Contraseña del certificado
$response = curl_exec($ch); // Ejecutar conexión
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE); // Código de respuesta
var_dump($response); // Respuesta
var_dump($httpcode); // Código de respuesta

// CERRAR CONEXIÓN CON EL SERVIDOR APNS :
curl_close($ch); // Cerrar conexión

// Crear una respuesta JSON y enviarla de vuelta a la aplicación Swift
$response = array("success" => true);
echo json_encode($response);