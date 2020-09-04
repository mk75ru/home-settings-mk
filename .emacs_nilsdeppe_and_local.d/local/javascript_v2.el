;; javascript
(use-package rjsx-mode
  :ensure t
  ;; setup files ending in “.js” to open in rjsx-mode
  :mode ("\\.js\\'" . rjsx-mode)
  :init
  (setq tab-width 2
        create-lockfiles nil
        js-indent-level 2)
  :hook
  (rjsx-mode . tide-setup)
  (rjsx-mode
   . (lambda()
       (set (make-local-variable 'compile-command)
            (format "node %s.js"
                    (tashfeen:filename-from-buffer :get-abs t)))))
  :bind (:map rjsx-mode-map
              ("C-c C-c" . compile)))

;; tide
(use-package tide
  :ensure t
  :init
  (setq tide-format-options
        '(:indentSize 2
          :tabSize 2))
  :after (rjsx-mode company)
  :hook
  (tide-mode . company-mode)
  :bind (:map tide-mode-map
	("C-e" . tide-format)))
