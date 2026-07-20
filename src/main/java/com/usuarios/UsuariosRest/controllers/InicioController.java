package com.usuarios.UsuariosRest.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Year;

@RestController
public class InicioController {

    @GetMapping("/")
    public String inicio() {
        return "API de usuarios funcionando - Version 1.0 - " + Year.now().getValue();
    }
}
