(use-package js2-mode
  :config
  ((lambda ()
     (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
     (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2))))))

(use-package js2-refactor
  :config
  ((lambda ()
     (add-hook 'js2-mode-hook #'js2-refactor-mode)
     (js2r-add-keybindings-with-prefix "C-c C-r")
     (define-key js2-mode-map (kbd "C-k") #'js2r-kill))))

(use-package xref-js2
  :config
  ((lambda ()
     ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
     ;; unbind it.
     (define-key js-mode-map (kbd "M-.") nil)
     (add-hook 'js2-mode-hook
	       (lambda ()
		 (add-hook 'xref-backend-functions
			   #'xref-js2-xref-backend
			   nil t))))))

;; package removed, but I wasn't actually using it anyway. I'll revisit if I ever need to edit
;; Javascript (not Typescript) in Emacs again: 
;; https://github.com/melpa/melpa/pull/6925
;;
;; (use-package company-tern
;;   :config
;;   ((lambda ()
;;      (add-to-list 'company-backends 'company-tern)
;;      (add-hook 'js2-mode-hook
;; 	       (lambda ()
;; 		 (tern-mode)
;; 		 (company-mode)
;; 		 ;; Disable completion keybindings, as we use xref-js2 instead
;; 		 (define-key tern-mode-keymap (kbd "M-.") nil)
;; 		 (define-key tern-mode-keymap (kbd "M-,") nil))))))

;; (add-hook 'js2-mode-hook
;; 	       (lambda ()
;; 		 (tern-mode)
;; 		 (company-mode)
;; 		 ;; Disable completion keybindings, as we use xref-js2 instead
;; 		 (define-key tern-mode-keymap (kbd "M-.") nil)
;; 		 (define-key tern-mode-keymap (kbd "M-,") nil)))

(use-package tide)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (setq-local company-minimum-prefix-length 1)
  (setq-local company-tooltip-align-annotations t))

;; aligns annotation to the right hand side


;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)))

(use-package jsonnet-mode)

(defun setup-jsonnet-mode ()
  (rainbow-delimiters-mode 1))

(add-hook 'jsonnet-mode-hook #'setup-jsonnet-mode)

(defun jsonnet-after-save ()
  "Before save hook to format the buffer before each save."
  (when (eq 'jsonnet-mode (symbol-value 'major-mode))
    (jsonnet-format-buffer)))

(defun jsonnet-format-buffer ()
  "Reformat entire buffer using the Jsonnet format utility."
  (interactive)
  (call-process "jsonnetfmt" nil nil nil "--in-place" (buffer-file-name)))

(add-hook 'after-save-hook 'jsonnet-after-save)
