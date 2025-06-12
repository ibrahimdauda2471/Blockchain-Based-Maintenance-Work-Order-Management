;; Parts Coordination Contract
;; Manages maintenance parts inventory and coordination

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_PART_NOT_FOUND (err u401))
(define-constant ERR_INSUFFICIENT_STOCK (err u402))
(define-constant ERR_INVALID_QUANTITY (err u403))

;; Data structures
(define-map parts-inventory
  { part-id: (string-ascii 50) }
  {
    name: (string-ascii 100),
    description: (string-ascii 200),
    category: (string-ascii 50),
    stock-quantity: uint,
    unit-cost: uint,
    supplier: (string-ascii 100),
    last-updated: uint
  }
)

(define-map parts-reservations
  { order-id: uint, part-id: (string-ascii 50) }
  {
    quantity: uint,
    reserved-at: uint,
    status: uint
  }
)

(define-map order-parts-list
  { order-id: uint }
  {
    parts: (list 20 (string-ascii 50)),
    total-cost: uint,
    status: uint
  }
)

;; Add or update part in inventory
(define-public (add-part
  (part-id (string-ascii 50))
  (name (string-ascii 100))
  (description (string-ascii 200))
  (category (string-ascii 50))
  (stock-quantity uint)
  (unit-cost uint)
  (supplier (string-ascii 100))
)
  (begin
    (map-set parts-inventory
      { part-id: part-id }
      {
        name: name,
        description: description,
        category: category,
        stock-quantity: stock-quantity,
        unit-cost: unit-cost,
        supplier: supplier,
        last-updated: block-height
      }
    )
    (ok true)
  )
)

;; Reserve parts for a work order
(define-public (reserve-parts (order-id uint) (part-id (string-ascii 50)) (quantity uint))
  (let ((part (unwrap! (map-get? parts-inventory { part-id: part-id }) ERR_PART_NOT_FOUND)))
    (asserts! (> quantity u0) ERR_INVALID_QUANTITY)
    (asserts! (>= (get stock-quantity part) quantity) ERR_INSUFFICIENT_STOCK)

    ;; Update inventory
    (map-set parts-inventory
      { part-id: part-id }
      (merge part { stock-quantity: (- (get stock-quantity part) quantity) })
    )

    ;; Create reservation
    (map-set parts-reservations
      { order-id: order-id, part-id: part-id }
      {
        quantity: quantity,
        reserved-at: block-height,
        status: u1
      }
    )
    (ok true)
  )
)

;; Update stock quantity
(define-public (update-stock (part-id (string-ascii 50)) (new-quantity uint))
  (let ((part (unwrap! (map-get? parts-inventory { part-id: part-id }) ERR_PART_NOT_FOUND)))
    (map-set parts-inventory
      { part-id: part-id }
      (merge part {
        stock-quantity: new-quantity,
        last-updated: block-height
      })
    )
    (ok true)
  )
)

;; Get part information
(define-read-only (get-part (part-id (string-ascii 50)))
  (map-get? parts-inventory { part-id: part-id })
)

;; Check stock availability
(define-read-only (check-stock (part-id (string-ascii 50)))
  (match (map-get? parts-inventory { part-id: part-id })
    part (get stock-quantity part)
    u0
  )
)
