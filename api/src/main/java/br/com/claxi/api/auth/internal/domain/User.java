package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

import br.com.claxi.api.shared.domain.Email;
import lombok.Getter;

@Getter
public class User {
    private UUID id;
    private String name;
    private Email email;
    private boolean emailVerified;
    private String image;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;

    public User(
            UUID id,
            String name,
            Email email,
            boolean emailVerified,
            String image,
            OffsetDateTime createdAt,
            OffsetDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.emailVerified = emailVerified;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getEmail() {
        return this.email.getValue();
    }
}
