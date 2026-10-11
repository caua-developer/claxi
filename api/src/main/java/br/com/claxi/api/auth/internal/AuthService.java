package br.com.claxi.api.auth.internal;

import br.com.claxi.api.auth.internal.dto.LoginRequest;
import br.com.claxi.api.auth.internal.dto.LoginResponse;
import br.com.claxi.api.auth.internal.dto.RegisterRequest;

public class AuthService {
    public void register(RegisterRequest request) {

    }

    public LoginResponse login(LoginRequest request) {
        return null;
    }

    public void logout() {

    }

    public LoginResponse refresh(String refreshToken) {
        return null;
    }
}
