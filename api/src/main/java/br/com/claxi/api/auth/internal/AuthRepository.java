package br.com.claxi.api.auth.internal;

import java.time.OffsetDateTime;
import java.util.UUID;

import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import br.com.claxi.api.auth.internal.domain.Account;
import br.com.claxi.api.auth.internal.domain.AuditTimestamps;
import br.com.claxi.api.auth.internal.domain.OAuthTokens;
import br.com.claxi.api.auth.internal.domain.User;

@Repository
public class AuthRepository {
    private final JdbcTemplate jdbcTemplate;

    public AuthRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<User> userMapper = (result, rowNum) -> new User(
            result.getObject("id", UUID.class),
            result.getString("name"),
            result.getString("email"),
            result.getBoolean("email_verified"),
            result.getString("image"),
            new AuditTimestamps(
                    result.getObject("created_at", OffsetDateTime.class),
                    result.getObject("updated_at", OffsetDateTime.class)));

    public User findUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        return jdbcTemplate.query(sql, userMapper, email).stream().findFirst().orElse(null);
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
        Account.Provider provider = Account.Provider.valueOf(result.getString("provider_id"));

        OAuthTokens oauthTokens = provider == Account.Provider.GOOGLE
                ? new OAuthTokens(
                        result.getString("access_token"),
                        result.getString("refresh_token"),
                        result.getObject("access_token_expires_at", OffsetDateTime.class),
                        result.getObject("refresh_token_expires_at", OffsetDateTime.class),
                        result.getString("id_token"),
                        result.getString("scope"))
                : null;

        return new Account(
                result.getObject("id", UUID.class),
                result.getObject("user_id", UUID.class),
                result.getString("account_id"),
                provider,
                oauthTokens,
                result.getString("password"),
                new AuditTimestamps(
                        result.getObject("created_at", OffsetDateTime.class),
                        result.getObject("updated_at", OffsetDateTime.class)));
    };

    public Account findAccountByUserAndProviderId(UUID userId, String providerId) {
        String sql = "SELECT * FROM accounts WHERE user_id = ? AND provider_id = ?";
        return jdbcTemplate.query(sql, accountMapper, userId, providerId).stream().findFirst().orElse(null);
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
