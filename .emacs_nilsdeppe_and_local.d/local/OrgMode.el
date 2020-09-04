;;(require 'org-protocol)
;;(load-file "~/.emacs.d/org-protocol-capture-html.el")
;;(require 'org-protocol-capture-html)

;;(add-to-list 'org-capture-templates
;;             ("w" "Web site" entry (file "~/org/notes.org")
;;              "* %?\n%c\n%:initial"))


(require 'org-protocol)
;;(setq org-todo-keywords
;;       '((sequence "TODO(t)" "IN PROGRESS(p!)" "|" "DONE(d!)" "CANCELLED(c!)")))

;;(setq org-log-done 'time)

;;(setq org-capture-templates
;;      (quote (
;;	      ("t" "todo" entry (file "~/org/refile.org")
;;               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;	      )))



(setq org-capture-templates
       '(
	 ("p" "Web site" entry (file+headline (lambda () (concat org-directory "~/org")) "Inbox")
	  "* %a\nCaptured On: %U\nWebsite: %l\n\n%i\n%?")

	 ("m" "meetup" entry (file "~/org/bookmarks.org") "* %?%:description \n%i\n%l")
	 
	 ))


;; (setq org-capture-templates
;;       '("w" "Capture from web browser such as Conkeror" entry
;;         (file+headline "~/org/bookmarks.org" "Web capture")
;;         "* %c %?
;;  Sourced: %u
;;  %i" :prepend t :jump-to-captured t))

(global-set-key (kbd "C-c c") 'org-capture)
