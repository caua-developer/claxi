package br.com.claxi.api.auth.internal.dto;

public record RegisterRequest(
        String name,
        String email,
        String password) {
}
