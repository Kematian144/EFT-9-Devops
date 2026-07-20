package com.usuarios.UsuariosRest.services;

import com.usuarios.UsuariosRest.models.UsuarioModel;
import com.usuarios.UsuariosRest.repositories.IUsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {

    private final IUsuarioRepository usuarioRepository;

    public UsuarioService(IUsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    // Obtiene todos los usuarios guardados.
    public List<UsuarioModel> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    // Busca un usuario por su identificador.
    public Optional<UsuarioModel> buscarPorId(Long id) {
        return usuarioRepository.findById(id);
    }

    // Guarda un usuario nuevo.
    public UsuarioModel guardarUsuario(UsuarioModel usuario) {
        usuario.setId(null);
        return usuarioRepository.save(usuario);
    }

    // Modifica los datos si el usuario existe.
    public Optional<UsuarioModel> actualizarUsuario(Long id, UsuarioModel datosNuevos) {
        return usuarioRepository.findById(id).map(usuario -> {
            usuario.setFirstName(datosNuevos.getFirstName());
            usuario.setLastName(datosNuevos.getLastName());
            usuario.setEmail(datosNuevos.getEmail());
            return usuarioRepository.save(usuario);
        });
    }

    // Elimina el usuario y avisa si fue encontrado.
    public boolean eliminarUsuario(Long id) {
        if (!usuarioRepository.existsById(id)) {
            return false;
        }

        usuarioRepository.deleteById(id);
        return true;
    }
}
