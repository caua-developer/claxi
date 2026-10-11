package br.com.claxi.api.auth.internal.dto;

public record LoginResponse(
                String accessToken,
                String refreshToken) {

}
