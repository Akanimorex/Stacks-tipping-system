;; Error codes for the contract
(define-constant ERR-NOT-REGISTERED u100) ;; Name not registered
(define-constant ERR-NAME-TAKEN u101)     ;; Name already taken
(define-constant ERR-INVALID-NAME u102)   ;; Name is empty or invalid
(define-constant ERR-INVALID-AMOUNT u103)  ;; Tip amount is zero or invalid

;; Map to store name-to-address mappings
(define-map name-to-address { name: (string-utf8 48) } principal)

;; Map to track total tips received per name
(define-map tips-received { name: (string-utf8 48) } uint)

;; Registers a unique name to the caller's address , returns (ok true) on success, or an error if the name is taken or invalid
(define-public (register-name (name (string-utf8 48)))
  (begin
    ;; Validate that the name is not empty
    (asserts! (> (len name) u0) (err ERR-INVALID-NAME))
    ;; Check if the name is already registered
    (if (is-some (map-get? name-to-address { name: name }))
        (err ERR-NAME-TAKEN)
        (begin
          (map-set name-to-address { name: name } tx-sender)
          ;; Emit event for off-chain tracking
          (print { event: "register", name: name, owner: tx-sender })
          (ok true)
        )
    )
  )
)

;; Sends a tip in STX to the address associated with a name
(define-public (tip (name (string-utf8 48)) (amount uint))
  (match (map-get? name-to-address { name: name })
    recipient
    (begin
      ;; Validate that the amount is greater than zero
      (asserts! (> amount u0) (err ERR-INVALID-AMOUNT))
      ;; Transfer STX to the recipient
      (try! (stx-transfer? amount tx-sender recipient))
      ;; Update total tips received
      (map-set tips-received { name: name } (+ (default-to u0 (map-get? tips-received { name: name })) amount))
      ;; Emit event for off-chain tracking
      (print { event: "tip", name: name, amount: amount, sender: tx-sender, recipient: recipient })
      (ok true)
    )
    (err ERR-NOT-REGISTERED)
  )
)

;; Retrieves the address associated with a name
(define-read-only (get-recipient-address (name (string-utf8 48)))
  (map-get? name-to-address { name: name })
)


;; Retrieves the total tips received for a name , returns (ok uint) with the total tips in microstacks, or 0 if none
(define-read-only (get-total-tips (name (string-utf8 48)))
  (ok (default-to u0 (map-get? tips-received { name: name })))
)









