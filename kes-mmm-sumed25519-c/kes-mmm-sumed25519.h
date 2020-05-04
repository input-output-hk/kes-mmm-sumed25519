/**
 * Key Evolving Signature (KES) using MMM Sum scheme with ED25519 signatures
 *
 * Copyright 2020, Input Output HK Ltd
 * Licensed with: MIT OR Apache-2.0
 */

#ifndef KES_SUMED25519_LIBC_
#define KES_SUMED25519_LIBC_

/* Generated with cbindgen:0.14.1 */

/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */

#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#define OUROBOROS_KES_PUBLIC_KEY_SIZE 32

#define OUROBOROS_KES_SECRET_KEY_SIZE 836

#define OUROBOROS_KES_SIGNATURE_SIZE 484

#define OUROBOROS_KES_TOTAL_UPDATE 4096

#define OUROBOROS_KES_TOTAL_UPDATE_LOG 12

bool ouroboros_kes_publickey_verify(const uint8_t *public_ptr,
                                    const uint8_t *message_ptr,
                                    uintptr_t message_size,
                                    const uint8_t *signature_ptr);

void ouroboros_kes_secretkey_generate(const uint8_t *seed,
                                      uint8_t *secret_ptr,
                                      uint8_t *public_ptr);

void ouroboros_kes_secretkey_sign(const uint8_t *secret_ptr,
                                  const uint8_t *message_ptr,
                                  uintptr_t message_size,
                                  uint8_t *signature_ptr);

uint32_t ouroboros_kes_secretkey_t(const uint8_t *secret_ptr);

void ouroboros_kes_secretkey_update(uint8_t *secret_ptr);

#endif /* KES_SUMED25519_LIBC_ */