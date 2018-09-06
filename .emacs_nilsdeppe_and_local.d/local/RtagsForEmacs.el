;;https://github.com/markcol/emacs.d/blob/4db26ca764c41bf9944ee9e9730c6543b4fff15a/init.el

(use-package rtags
  :ensure t
  :if (file-exists-p "~/src/rtags")
  ;; A Clang-based completion and navigation database for C/C++
  :after (cc-mode)
  :load-path "~/src/rtags/src"
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
  :preface
  (defun my/rtags-find-file-hook ()
    (setq header-line-format
          (and (rtags-is-indexed)
	       '(:eval rtags-cached-current-container))))

  
  (defun my/rtags-c-mode-common-hook ()
    (message "fired!!!!!!!!!!!!!!!!")
    (rtags-start-process-unless-running)
    (add-hook 'find-file-hook #'my/rtags-find-file-hook)
    ;;(with-eval-after-load 'company
    ;;  (require 'company-rtags))
    ;;(with-eval-after-load 'flycheck
    ;;  (require 'flycheck-rtags))
    (which-function-mode t))
  :config
  (progn
    (add-hook 'c-mode-common-hook #'my/rtags-c-mode-common-hook))

;;  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
;;  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
;;  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
;;  (rtags-restart-process)

  

  )
