//
//  ViewController.swift
//  ReproductorMP3
//
//  Created by Carlos Buitrago on 8/04/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate {
    
    let arr: [String] = ["- - - -","Desde el Día en Que Te Fuiste","Tú Tienes Razón ft. Silvestre Dangond","What A Wonderful World"]
    var flag = false
    var numero  = 0
    private var reproductor: AVAudioPlayer!
    
    @IBOutlet weak var caratula: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titulo.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numero = arr.count-1
        return arr.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (arr[row] != "- - - -"){
            reproducir(arr[row])
        }
        else{
            titulo.text = ""
            if flag{
                if reproductor.playing{
                    reproductor.stop()
                    reproductor.currentTime = 0.0
                }
            }
            flag = false
            caratula.image = UIImage(named: "Blanco.jpg")
        }
    }
    func reproducir(dato: String){
        flag = true
        let sonidoURL = NSBundle.mainBundle().URLForResource(dato, withExtension: "mp3")
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
        }
        catch{
            print("Error cargar archivo de sonido")
        }
        reproductor.play()
        titulo.text = dato
        caratula.image = UIImage(named: dato+".jpg")
    }
    @IBAction func Tocar() {
        if flag{
            if !reproductor.playing{
                reproductor.play()
            }
        }
    }
    @IBAction func Pausar() {
        if flag{
            if  reproductor.playing{
                reproductor.pause()
            }
        }
    }
    @IBAction func Detener() {
        if flag{
            if reproductor.playing{
                reproductor.stop()
                reproductor.currentTime = 0.0
            }
        }
    }
    @IBAction func volumen(sender: UISlider) {
        reproductor.volume = sender.value
    }
    @IBAction func shuffle() {
        let randon = Int(arc4random_uniform(UInt32(numero)) + 1)
        reproducir(arr[randon])
        flag = true
    }

}

