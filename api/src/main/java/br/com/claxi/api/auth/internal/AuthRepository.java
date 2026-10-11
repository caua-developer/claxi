package br.com.claxi.api.auth.internal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import br.com.claxi.api.auth.internal.domain.Account;
import br.com.claxi.api.auth.internal.domain.User;
import br.com.claxi.api.shared.domain.Email;

@Repository
public class AuthRepository {
    private final JdbcTemplate jdbcTemplate;

    public AuthRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<User> userMapper = (result, rowNum) -> {
        User user = new User(
                result.getObject("id", java.util.UUID.class),
                result.getString("name"),
                new Email(result.getString("email")),
                result.getBoolean("email_verified"),
                result.getString("image"),
                result.getObject("created_at", java.time.OffsetDateTime.class),
                result.getObject("updated_at", java.time.OffsetDateTime.class));

        return user;
    };

    public User findUserByEmail(Email email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        return jdbcTemplate.queryForObject(sql, userMapper, email.getValue());
    }

    public void createUser(User user) {
        String sql = """
                    INSERT INTO users (id, name, email, email_verified, image, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        jdbcTemplate.update(
                sql,
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.isEmailVerified(),
                user.getImage(),
                user.getCreatedAt(),
                user.getUpdatedAt());
    }

    private final RowMapper<Account> accountMapper = (result, rowNum) -> {
        Account account = new Account(
                result.getObject("id", java.util.UUID.class),
                result.getObject("user_id", java.util.UUID.class),
                result.getString("account_id"),
                result.getString("provider_id"),
                result.getString("access_token"),
                result.getString("refresh_token"),
                result.getObject("access_token_expires_at", java.time.OffsetDateTime.class),
                result.getObject("refresh_token_expires_at", java.time.OffsetDateTime.class),
                result.getString("scope"),
                result.getString("id_token"),
                result.getString("password"),
                result.getObject("created_at", java.time.OffsetDateTime.class),
                result.getObject("updated_at", java.time.OffsetDateTime.class));

        return account;
    };

    public Account findAccountByUserAndProviderId(UUID userId, String providerId) {
        String sql = "SELECT * FROM accounts WHERE user_id = ? AND provider_id = ?";
        return jdbcTemplate.queryForObject(sql, accountMapper, userId, providerId);
    }

    public void createAccount(Account account) {
        String sql = """
                    INSERT INTO accounts (id, user_id, account_id, provider_id, access_token, refresh_token, access_token_expires_at, refresh_token_expires_at, scope, id_token, password, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        jdbcTemplate.update(
                sql,
                account.getId(),
                account.getUserId(),
                account.getAccountId(),
                account.getProviderId(),
                account.getAccessToken(),
                account.getRefreshToken(),
                account.getAccessTokenExpiresAt(),
                account.getRefreshTokenExpiresAt(),
                account.getScope(),
                account.getIdToken(),
                account.getPassword(),
                account.getCreatedAt(),
                account.getUpdatedAt());
    }
}
