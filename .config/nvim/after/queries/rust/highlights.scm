;; extends

;; Highlight & reference operator differently from other operators
;; This captures & in reference types like &str, &mut T, etc.
(reference_type
  "&" @operator.reference)

;; Capture & in reference expressions like &x, &mut x
(reference_expression
  "&" @operator.reference)

;; Capture & in self parameters like &self, &mut self
(self_parameter
  "&" @operator.reference)

;; Highlight * dereference operator differently from multiplication
;; This captures * in pointer types like *const T, *mut T
(pointer_type
  "*" @operator.dereference)

;; Capture * in dereference expressions like *ptr
(unary_expression
  "*" @operator.dereference)
