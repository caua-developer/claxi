package br.com.claxi.api.auth.internal;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.claxi.api.auth.internal.dto.LoginRequest;
import br.com.claxi.api.auth.internal.dto.LoginResponse;
import br.com.claxi.api.auth.internal.dto.RegisterRequest;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;
    private final GoogleAuthService googleAuthService;

    public AuthController(AuthService authService, GoogleAuthService googleAuthService) {
        this.authService = authService;
        this.googleAuthService = googleAuthService;
    }

    @PostMapping("/register")
    public ResponseEntity<Void> register(@Valid @RequestBody RegisterRequest request) {
        authService.register(request);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<LoginResponse> refreshToken(@RequestParam String refreshToken) {
        return ResponseEntity.ok(authService.refresh(refreshToken));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout() {
        authService.logout();
        return ResponseEntity.noContent().build();
    }

    // Google OAuth Endpoints
    @PostMapping("/google/login")
    public ResponseEntity<LoginResponse> loginWithGoogle(@RequestBody Map<String, String> request) {
        String token = request.get("token");
        return ResponseEntity.ok(googleAuthService.authenticateWithGoogle(token));
    }

    @PostMapping("/google/register")
    public ResponseEntity<LoginResponse> registerWithGoogle(@RequestBody Map<String, String> request) {
        String token = request.get("token");
        return ResponseEntity.ok(googleAuthService.authenticateWithGoogle(token));
    }
}