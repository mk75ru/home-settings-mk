;;https://github.com/neonsoftware/.dotfiles/blob/e6bb691e833f47893f35005faa920ac72a906602/home/.emacs.d/config-dev.org
(use-package rtags
  :ensure t
  :after (cc-mode)
  :bind (:map c-mode-map
         ("M-." . rtags-find-symbol-at-point)
         ("M-," . rtags-find-references-at-point)
         ("M-;" . rtags-find-file)
         ("C-." . rtags-find-symbol)
         ("C-," . rtags-find-references)
         ("M-s" . rtags-imenu)
         ("M-[" . rtags-location-stack-back)
         ("M-]" . rtags-location-stack-forward)
         ("M-n" . rtags-next-match)
         ("M-p" . rtags-previous-match)
         :map c++-mode-map
         ("M-." . rtags-find-symbol-at-point)
         ("M-," . rtags-find-references-at-point)
         ("M-;" . rtags-find-file)
         ("C-." . rtags-find-symbol)
         ("C-," . rtags-find-references)
         ("M-s" . rtags-imenu)
         ("M-[" . rtags-location-stack-back)
         ("M-]" . rtags-location-stack-forward)
         ("M-n" . rtags-next-match)
         ("M-p" . rtags-previous-match)
         :map rtags-mode-map
         ("n"   . rtags-next-match)
         ("p"   . rtags-previous-match))
  
 :config
  (rtags-start-process-unless-running)
;;  (define-key c-mode-base-map (kbd "M-.") ;; go to definition
;;     (function rtags-find-symbol-at-point))
;;  (define-key c-mode-base-map (kbd "M-,") ;; list references
;;     (function rtags-find-references-at-point))
;;  (define-key c-mode-base-map (kbd "M--") ;; back
;;     (function rtags-location-stack-back))
;;  (define-key c-mode-base-map (kbd "M-+") ;; forth
;;    (function rtags-location-stack-forward))  
;;  (rtags-enable-standard-keybindings)  ;; starting with "C-c r", listed down 
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  ;;(setq rtags-completions-enabled t)
)

(use-package company
 :ensure t
 :config
   (push 'company-rtags company-backends)
   (global-company-mode)
   (define-key c-mode-base-map (kbd "<M-tab>") (function company-complete))
)

