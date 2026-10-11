package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

import lombok.Getter;

@Getter
public class Account {
    private UUID id;
    private UUID userId;
    private String accountId;
    private String providerId;
    private String accessToken;
    private String refreshToken;
    private OffsetDateTime accessTokenExpiresAt;
    private OffsetDateTime refreshTokenExpiresAt;
    private String scope;
    private String idToken;
    private String password;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;

    public Account(
            UUID id,
            UUID userId,
            String accountId,
            String providerId,
            String accessToken,
            String refreshToken,
            OffsetDateTime accessTokenExpiresAt,
            OffsetDateTime refreshTokenExpiresAt,
            String scope,
            String idToken,
            String password,
            OffsetDateTime createdAt,
            OffsetDateTime updatedAt) {
        this.id = id;
        this.userId = userId;
        this.accountId = accountId;
        this.providerId = providerId;
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.accessTokenExpiresAt = accessTokenExpiresAt;
        this.refreshTokenExpiresAt = refreshTokenExpiresAt;
        this.scope = scope;
        this.idToken = idToken;
        this.password = password;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

}
