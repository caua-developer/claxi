package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

import br.com.claxi.api.shared.domain.Email;

public class User {
    private final UUID id;
    private final String name;
    private final Email email;
    private final boolean emailVerified;
    private final String image;
    private final AuditTimestamps audit;

    public User(
            UUID id,
            String name,
            String email,
            boolean emailVerified,
            String image,
            AuditTimestamps audit) {
        this.id = id;
        this.name = name;
        this.email = new Email(email);
        this.emailVerified = emailVerified;
        this.image = image;
        this.audit = audit;
    }

    public static User register(String name, String email) {
        return new User(UUID.randomUUID(), name, email, false, "", AuditTimestamps.now());
    }

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email.getValue();
    }

    public boolean isEmailVerified() {
        return emailVerified;
    }

    public String getImage() {
        return image;
    }

    public OffsetDateTime getCreatedAt() {
        return audit.createdAt();
    }

    public OffsetDateTime getUpdatedAt() {
        return audit.updatedAt();
    }
}
