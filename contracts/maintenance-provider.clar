;; Maintenance Provider Verification Contract
;; Manages verification and registration of maintenance service providers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_PROVIDER_EXISTS (err u101))
(define-constant ERR_PROVIDER_NOT_FOUND (err u102))
(define-constant ERR_INVALID_STATUS (err u103))

;; Provider status constants
(define-constant STATUS_PENDING u0)
(define-constant STATUS_VERIFIED u1)
(define-constant STATUS_SUSPENDED u2)

;; Data structures
(define-map providers
  { provider-id: principal }
  {
    name: (string-ascii 100),
    specialization: (string-ascii 50),
    status: uint,
    verification-date: uint,
    rating: uint
  }
)

(define-map provider-certifications
  { provider-id: principal, cert-type: (string-ascii 50) }
  {
    cert-number: (string-ascii 100),
    expiry-date: uint,
    issuer: (string-ascii 100)
  }
)

(define-data-var next-provider-id uint u1)

;; Register a new maintenance provider
(define-public (register-provider (name (string-ascii 100)) (specialization (string-ascii 50)))
  (let ((provider-id tx-sender))
    (asserts! (is-none (map-get? providers { provider-id: provider-id })) ERR_PROVIDER_EXISTS)
    (map-set providers
      { provider-id: provider-id }
      {
        name: name,
        specialization: specialization,
        status: STATUS_PENDING,
        verification-date: u0,
        rating: u0
      }
    )
    (ok provider-id)
  )
)

;; Verify a provider (only contract owner)
(define-public (verify-provider (provider-id principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-some (map-get? providers { provider-id: provider-id })) ERR_PROVIDER_NOT_FOUND)
    (map-set providers
      { provider-id: provider-id }
      (merge (unwrap-panic (map-get? providers { provider-id: provider-id }))
        { status: STATUS_VERIFIED, verification-date: block-height }
      )
    )
    (ok true)
  )
)

;; Add certification for a provider
(define-public (add-certification
  (provider-id principal)
  (cert-type (string-ascii 50))
  (cert-number (string-ascii 100))
  (expiry-date uint)
  (issuer (string-ascii 100))
)
  (begin
    (asserts! (is-some (map-get? providers { provider-id: provider-id })) ERR_PROVIDER_NOT_FOUND)
    (map-set provider-certifications
      { provider-id: provider-id, cert-type: cert-type }
      {
        cert-number: cert-number,
        expiry-date: expiry-date,
        issuer: issuer
      }
    )
    (ok true)
  )
)

;; Get provider details
(define-read-only (get-provider (provider-id principal))
  (map-get? providers { provider-id: provider-id })
)

;; Check if provider is verified
(define-read-only (is-provider-verified (provider-id principal))
  (match (map-get? providers { provider-id: provider-id })
    provider (is-eq (get status provider) STATUS_VERIFIED)
    false
  )
)

