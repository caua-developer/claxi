package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

public class Account {
    public enum Provider {
        GOOGLE,
        PASSWORD
    }

    private final UUID id;
    private final UUID userId;
    private final String accountId;
    private final Provider provider;
    private final OAuthTokens oauthTokens;
    private final String password;
    private final AuditTimestamps audit;

    public Account(
            UUID id,
            UUID userId,
            String accountId,
            Provider provider,
            OAuthTokens oauthTokens,
            String password,
            AuditTimestamps audit) {
        if (provider == Provider.PASSWORD && (password == null || password.isBlank())) {
            throw new IllegalArgumentException("Password accounts require a password hash");
        }

        if (provider == Provider.GOOGLE && oauthTokens == null) {
            throw new IllegalArgumentException("Google accounts require OAuth tokens");
        }

        this.id = id;
        this.userId = userId;
        this.accountId = accountId;
        this.provider = provider;
        this.oauthTokens = oauthTokens;
        this.password = password;
        this.audit = audit;
    }

    public static Account password(UUID userId, String hashedPassword) {
        return new Account(UUID.randomUUID(), userId, "", Provider.PASSWORD, null, hashedPassword, AuditTimestamps.now());
    }

    public UUID getId() {
        return id;
    }

    public UUID getUserId() {
        return userId;
    }

    public String getAccountId() {
        return accountId;
    }

    public String getProviderId() {
        return provider.name();
    }

    public String getAccessToken() {
        return oauthTokens == null ? null : oauthTokens.accessToken();
    }

    public String getRefreshToken() {
        return oauthTokens == null ? null : oauthTokens.refreshToken();
    }

    public OffsetDateTime getAccessTokenExpiresAt() {
        return oauthTokens == null ? null : oauthTokens.accessTokenExpiresAt();
    }

    public OffsetDateTime getRefreshTokenExpiresAt() {
        return oauthTokens == null ? null : oauthTokens.refreshTokenExpiresAt();
    }

    public String getScope() {
        return oauthTokens == null ? null : oauthTokens.scope();
    }

    public String getIdToken() {
        return oauthTokens == null ? null : oauthTokens.idToken();
    }

    public String getPassword() {
        return password;
    }

    public OffsetDateTime getCreatedAt() {
        return audit.createdAt();
    }

    public OffsetDateTime getUpdatedAt() {
        return audit.updatedAt();
    }
}
