package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

import lombok.Getter;

@Getter
public class Session {
    private UUID id;
    private UUID userId;
    private UUID organizationId;
    private String ipAddress;
    private String userAgent;
    private OffsetDateTime lastUsedAt;
    private OffsetDateTime revokedAt;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private OffsetDateTime expiresAt;

    public Session(
            UUID id,
            UUID userId,
            UUID organizationId,
            String ipAddress,
            String userAgent,
            OffsetDateTime lastUsedAt,
            OffsetDateTime revokedAt,
            OffsetDateTime createdAt,
            OffsetDateTime updatedAt,
            OffsetDateTime expiresAt) {
        this.id = id;
        this.userId = userId;
        this.organizationId = organizationId;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
        this.lastUsedAt = lastUsedAt;
        this.revokedAt = revokedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.expiresAt = expiresAt;
    }
}
