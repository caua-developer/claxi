package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;
import java.util.UUID;

import lombok.Getter;

@Getter
public class RefreshToken {
    private UUID id;
    private UUID sessionId;
    private String tokenHash;
    private OffsetDateTime revokedAt;
    private OffsetDateTime createdAt;
    private OffsetDateTime expiresAt;
}
