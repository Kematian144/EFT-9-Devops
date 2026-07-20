package com.usuarios.UsuariosRest.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "API de Usuarios",
                version = "1.0",
                description = "Servicio REST para administrar usuarios municipales"
        )
)
public class SwaggerConfig {
}
