(use-package indium)

(use-package js2-mode
  :init
  (setq js-indent-level 2)
  :mode (("\\.js" . js2-mode)
         ("\\.sjs" . js2-mode))
  :config
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)) ;; Better imenu
(use-package xref-js2)

(use-package json-mode
  :mode (("\\.json\\'" . json-mode)
         ("\\manifest.webapp\\'" . json-mode )
         ("\\.tern-project\\'" . json-mode)))
