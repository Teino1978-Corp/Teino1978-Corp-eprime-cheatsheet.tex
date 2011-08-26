;; eprime-mode.el -- Derived mode for writing Essence'
;; Copyright (C) 2011 by Jan de Muijnck-Hughes
;; Author: Jan de Muijnck-Hughes
;;
;;; DESCRIPTION
;;
;; A derived mode to highlight Essence' code. Currently this
;; mode only provides syntax highlighting, and comment support.
;; Future work will seek to add support for smart indentation.
;;
;;; INSTALLATION
;;
;; 1. Place eprime-mode.el in your .emacs.d directory
;; 2. Ensure that .emacs.d is on your load path.
;; 3. Add the following to your emacs init file:
;;    (add-to-list 'auto-mode-alist (quote ("\\.eprime$" . eprime-mode)))
;; -------------------------------------------------------------------
;;; CODE
;; ------------------------------------------------------ [ Keywords ]
(defvar eprime-keywords '(
    "letting" "be"
    "indexed" "by" "of"
    "given"
    "find"
    "maximising" "minimising"
    "such" "that"
    "max" "min"
    "sum"
    "forall" "exists" "alldifferent" "table"
))
;; --------------------------------------------------------- [ Types ]
(defvar eprime-types '(
    "int" "bool" "matrix" "domain"
))
;; ----------------------------------------------------- [ Constants ]
(defvar eprime-preprocessor '(
    "language" "ESSENCE"
))
;; -------------------------------------------------- [ Assign Faces ]
(defvar eprime-font-lock-defaults
  ;; Need to fix operators
  `((
    (":\\|\\.\\|\\\\\\|\\/\\|=\\|<\\|>\\|!\\|+\\|-\\|*\\|%"
     . font-lock-constant-face)
    ( ,(regexp-opt eprime-keywords     'words) . font-lock-function-name-face)
    ( ,(regexp-opt eprime-types        'words) . font-lock-type-face)
    ( ,(regexp-opt eprime-preprocessor 'words) . font-lock-preprocessor-face)
)))
;; --------------------------------------------------- [ Clear memory ]
(setq eprime-keywords     nil
      eprime-types        nil
      eprime-preprocessor nil
)

;; -------------------------------------------------------------------
;; Essence' Definition
;; -------------------------------------------------------------------
(define-derived-mode eprime-mode fundamental-mode "Essence'"
  "Major mode for editing Essence' files."
  (defgroup eprime-mode nil
    "Derived mode for Essance' Files" :group 'languages)
  (defvar eprime-mode-hook nil "Hook for eprime-mode")
  (modify-syntax-entry ?$ "<" eprime-mode-syntax-table)
  (modify-syntax-entry ?\n ">" eprime-mode-syntax-table)

  (make-local-variable 'eprime-font-lock-defaults)
  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
  (make-local-variable 'comment-start-skip)
  (make-local-variable 'comment-column)
  (make-local-variable 'comment-multi-line)
  (make-local-variable 'comment-indent-function)

  (setq font-lock-defaults eprime-font-lock-defaults
        comment-start           "$ "
        comment-end             ""
        comment-start-skip      "+ $+ \n"
        comment-column          60
        comment-multi-line      nil
        comment-indent-function 'java-comment-indent
        indent-tabs-mode        t
  )
 (run-hooks 'eprime-mode-hook)
)
(provide 'eprime-mode)
