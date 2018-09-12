;;https://github.com/markcol/emacs.d/blob/4db26ca764c41bf9944ee9e9730c6543b4fff15a/init.el
(use-package cc-mode
  :ensure t
  :defer t
  :bind (:map c-mode-map
         ("C-c C-O" . ff-find-other-file)
         :map c++-mode-map
         ("C-c C-O" . ff-find-other-file))
  :preface
  (defun my/c-mode-hook ()
    (setq c-default-style '((java-mode . "java")
                            (awk-mode  . "awk")
                            (other     . "k&r")))
    ;; (c-set-offset 'statement-case-open 0)
    (setq indent-tabs-mode nil)
    (setq c-basic-offset   2)
    (setq comment-column   40)
    (c-set-style "k&r")
    (c-toggle-auto-hungry-state 1)
    (c-toggle-auto-newline 1)
  :config
  (progn
    (add-hook 'c-mode-common-hook #'my/c-mode-hook)) ) )

