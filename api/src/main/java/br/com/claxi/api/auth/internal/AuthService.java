package br.com.claxi.api.auth.internal;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import br.com.claxi.api.auth.internal.domain.Account;
import br.com.claxi.api.auth.internal.domain.User;
import br.com.claxi.api.auth.internal.dto.LoginRequest;
import br.com.claxi.api.auth.internal.dto.LoginResponse;
import br.com.claxi.api.auth.internal.dto.RegisterRequest;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final AuthRepository authRepository;
    private final PasswordEncoder passwordEncoder;

    public void register(RegisterRequest request) {
        User existingUser = authRepository.findUserByEmail(request.email());
        if (existingUser != null) {
            throw new RuntimeException("User already exists");
        }

        User user = User.register(request.name(), request.email());

        String encodedPassword = passwordEncoder.encode(request.password());
        Account account = Account.password(user.getId(), encodedPassword);

        authRepository.createUser(user);
        authRepository.createAccount(account);
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
