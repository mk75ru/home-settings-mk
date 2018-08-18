(defun my-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "\\s\(")
  (forward-list 1) (backward-char 1))
  ((looking-at "\\s\)")
  (forward-char 1) (backward-list 1))
  (t (self-insert-command (or arg1)))))

(global-set-key (kbd "A-q") 'my-match-paren)

;; подвсетка скобок
(show-paren-mode t)
