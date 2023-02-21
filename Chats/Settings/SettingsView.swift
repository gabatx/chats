//
//  SettingsView.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import UIKit

class SettingsView: UIViewController, SettingsUI {

    var presenter: SettingsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func insertValuesDefaultForm() {
        //
    }

    @IBAction func resetDataButton(_ sender: Any) {
        // Alert para confirmar que se quiere resetear la app
        let alert = UIAlertController(title: "Resetear datos", message: "¿Estás seguro de que quieres resetear la app?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            self.presenter?.resetData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func insertTestDataButton(_ sender: Any) {

        // Alert para confirmar que se quiere resetear la app
        let alert = UIAlertController(title: "Datos para testear", message: "¿Estás seguro de que quieres introducir datos de prueba?. Se borrarán los datos actuales", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            self.presenter?.insertTestData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
