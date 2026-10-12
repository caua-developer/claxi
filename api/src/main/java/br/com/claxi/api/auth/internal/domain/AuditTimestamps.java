package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;

public record AuditTimestamps(OffsetDateTime createdAt, OffsetDateTime updatedAt) {

    public static AuditTimestamps now() {
        OffsetDateTime now = OffsetDateTime.now();
        return new AuditTimestamps(now, now);
    }
}
