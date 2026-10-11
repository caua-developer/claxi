package br.com.claxi.api.shared.domain;

import java.util.Locale;
import java.util.regex.Pattern;

public final class Email {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9_+.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private final String value;

    public Email(String value) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException("Email não pode ser vazio");
        }

        String normalized = value.trim().toLowerCase(Locale.ROOT);

        if (normalized.chars().anyMatch(Character::isWhitespace)
                || !EMAIL_PATTERN.matcher(normalized).matches()) {
            throw new IllegalArgumentException("Email inválido");
        }

        this.value = normalized;
    }

    public String getValue() {
        return value;
    }
}