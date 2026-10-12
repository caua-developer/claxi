package br.com.claxi.api.auth.internal.domain;

import java.time.OffsetDateTime;

public record OAuthTokens(
        String accessToken,
        String refreshToken,
        OffsetDateTime accessTokenExpiresAt,
        OffsetDateTime refreshTokenExpiresAt,
        String idToken,
        String scope) {
}
