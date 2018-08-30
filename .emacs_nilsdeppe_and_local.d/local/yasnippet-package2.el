


;; Snippets
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode t)
)  

;; Autocomplete
(use-package company
  :defer 10
  :diminish company-mode
  :bind (:map company-active-map
              ("M-j" . company-select-next)
              ("M-k" . company-select-previous))
  :preface
  ;; enable yasnippet everywhere
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or 
         (not company-mode/enable-yas) 
         (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  :init (global-company-mode t)
  :config
  ;; no delay no autocomplete
  (setq
   company-idle-delay 0
   company-minimum-prefix-length 2
   company-tooltip-limit 20)

  (setq company-backends 
                 (mapcar #'company-mode/backend-with-yas company-backends)))


