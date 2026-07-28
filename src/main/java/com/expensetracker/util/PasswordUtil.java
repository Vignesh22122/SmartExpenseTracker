package com.expensetracker.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final int SALT_LENGTH = 16;
    private static final int ITERATIONS = 210_000;
    private static final int KEY_LENGTH = 256;

    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";

    private PasswordUtil() {
    }

    // Used for all NEW passwords.
    public static String hashPassword(String password) {

        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty.");
        }

        try {
            byte[] salt = new byte[SALT_LENGTH];
            new SecureRandom().nextBytes(salt);

            byte[] hash = generateHash(password, salt, ITERATIONS);

            return ITERATIONS + ":"
                    + Base64.getEncoder().encodeToString(salt)
                    + ":"
                    + Base64.getEncoder().encodeToString(hash);

        } catch (Exception e) {
            throw new IllegalStateException("Unable to hash password.", e);
        }
    }

    // Supports both PBKDF2 and legacy SHA-256 passwords.
    public static boolean verifyPassword(String password, String storedPassword) {

        if (password == null || storedPassword == null || storedPassword.isBlank()) {
            return false;
        }

        // New PBKDF2 format:
        // iterations:salt:hash
        if (isPBKDF2Hash(storedPassword)) {
            return verifyPBKDF2(password, storedPassword);
        }

        // Old SHA-256 hashes are 64 hexadecimal characters.
        if (isLegacySHA256Hash(storedPassword)) {
            return verifyLegacySHA256(password, storedPassword);
        }

        return false;
    }

    public static boolean isLegacySHA256Hash(String storedPassword) {

        if (storedPassword == null) {
            return false;
        }

        return storedPassword.matches("(?i)^[0-9a-f]{64}$");
    }

    public static boolean isPBKDF2Hash(String storedPassword) {

        if (storedPassword == null) {
            return false;
        }

        String[] parts = storedPassword.split(":");

        if (parts.length != 3) {
            return false;
        }

        try {
            Integer.parseInt(parts[0]);
            Base64.getDecoder().decode(parts[1]);
            Base64.getDecoder().decode(parts[2]);

            return true;

        } catch (Exception e) {
            return false;
        }
    }

    private static boolean verifyPBKDF2(String password, String storedPassword) {

        try {
            String[] parts = storedPassword.split(":");

            int iterations = Integer.parseInt(parts[0]);

            byte[] salt = Base64.getDecoder().decode(parts[1]);
            byte[] expectedHash = Base64.getDecoder().decode(parts[2]);

            byte[] actualHash = generateHash(password, salt, iterations);

            return MessageDigest.isEqual(expectedHash, actualHash);

        } catch (Exception e) {
            return false;
        }
    }

    private static boolean verifyLegacySHA256(String password, String storedHash) {

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            byte[] hash = digest.digest(
                    password.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }

            return MessageDigest.isEqual(
                    hexString.toString().getBytes(StandardCharsets.UTF_8),
                    storedHash.toLowerCase().getBytes(StandardCharsets.UTF_8));

        } catch (Exception e) {
            return false;
        }
    }

    private static byte[] generateHash(
            String password,
            byte[] salt,
            int iterations) throws Exception {

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                iterations,
                KEY_LENGTH);

        try {
            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(ALGORITHM);

            return factory.generateSecret(spec).getEncoded();

        } finally {
            spec.clearPassword();
        }
    }
}